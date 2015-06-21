From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 4/7] gpg: centralize signature check
Date: Sun, 21 Jun 2015 23:14:40 +0000
Message-ID: <1434928483-105916-5-git-send-email-sandals@crustytoothpaste.net>
References: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 01:15:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6oSG-0006Af-RP
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 01:15:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753321AbbFUXPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 19:15:08 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51195 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753337AbbFUXO4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jun 2015 19:14:56 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3E41E28097;
	Sun, 21 Jun 2015 23:14:55 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272301>

verify-commit and verify-tag both share a central codepath for verifying
commits: check_signature.  However, verify-tag exited successfully for
untrusted signature, while verify-commit exited unsuccessfully.
Centralize this signature check and make verify-commit adopt the older
verify-tag behavior.  This behavior is more logical anyway, as the
signature is in fact valid, whether or not there's a path of trust to
the author.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/verify-commit.c  | 5 +++--
 builtin/verify-tag.c     | 5 +++--
 commit.c                 | 8 ++++++--
 commit.h                 | 2 +-
 gpg-interface.c          | 4 +++-
 gpg-interface.h          | 2 +-
 t/t7510-signed-commit.sh | 2 +-
 7 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index ec0c4e3..e30f7cf 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -21,10 +21,11 @@ static const char * const verify_commit_usage[] = {
 static int run_gpg_verify(const unsigned char *sha1, const char *buf, unsigned long size, int verbose)
 {
 	struct signature_check signature_check;
+	int ret;
 
 	memset(&signature_check, 0, sizeof(signature_check));
 
-	check_commit_signature(lookup_commit(sha1), &signature_check);
+	ret = check_commit_signature(lookup_commit(sha1), &signature_check);
 
 	if (verbose && signature_check.payload)
 		fputs(signature_check.payload, stdout);
@@ -33,7 +34,7 @@ static int run_gpg_verify(const unsigned char *sha1, const char *buf, unsigned l
 		fputs(signature_check.gpg_output, stderr);
 
 	signature_check_clear(&signature_check);
-	return signature_check.result != 'G';
+	return ret;
 }
 
 static int verify_commit(const char *name, int verbose)
diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index e1eb341..8750bef 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -22,6 +22,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 {
 	struct signature_check sigc;
 	int len;
+	int ret;
 
 	memset(&sigc, 0, sizeof(sigc));
 
@@ -32,11 +33,11 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	if (size == len)
 		return error("no signature found");
 
-	check_signature(buf, len, buf + len, size - len, &sigc);
+	ret = check_signature(buf, len, buf + len, size - len, &sigc);
 	fputs(sigc.gpg_output, stderr);
 
 	signature_check_clear(&sigc);
-	return sigc.result != 'G' && sigc.result != 'U';
+	return ret;
 }
 
 static int verify_tag(const char *name, int verbose)
diff --git a/commit.c b/commit.c
index 1e2e144..62223a3 100644
--- a/commit.c
+++ b/commit.c
@@ -1232,20 +1232,24 @@ free_return:
 	free(buf);
 }
 
-void check_commit_signature(const struct commit *commit, struct signature_check *sigc)
+int check_commit_signature(const struct commit *commit, struct signature_check *sigc)
 {
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
+	int ret = 1;
 
 	sigc->result = 'N';
 
 	if (parse_signed_commit(commit, &payload, &signature) <= 0)
 		goto out;
-	check_signature(payload.buf, payload.len, signature.buf, signature.len, sigc);
+	ret = check_signature(payload.buf, payload.len, signature.buf,
+		signature.len, sigc);
 
  out:
 	strbuf_release(&payload);
 	strbuf_release(&signature);
+
+	return ret;
 }
 
 
diff --git a/commit.h b/commit.h
index 9a1fa96..4983bdd 100644
--- a/commit.h
+++ b/commit.h
@@ -379,7 +379,7 @@ extern void print_commit_list(struct commit_list *list,
  * at all.  This may allocate memory for sig->gpg_output, sig->gpg_status,
  * sig->signer and sig->key.
  */
-extern void check_commit_signature(const struct commit *commit, struct signature_check *sigc);
+extern int check_commit_signature(const struct commit *commit, struct signature_check *sigc);
 
 int compare_commits_by_commit_date(const void *a_, const void *b_, void *unused);
 
diff --git a/gpg-interface.c b/gpg-interface.c
index 66dbee2..77a4da6 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -60,7 +60,7 @@ void parse_gpg_output(struct signature_check *sigc)
 	}
 }
 
-void check_signature(const char *payload, size_t plen, const char *signature,
+int check_signature(const char *payload, size_t plen, const char *signature,
 	size_t slen, struct signature_check *sigc)
 {
 	struct strbuf gpg_output = STRBUF_INIT;
@@ -81,6 +81,8 @@ void check_signature(const char *payload, size_t plen, const char *signature,
  out:
 	strbuf_release(&gpg_status);
 	strbuf_release(&gpg_output);
+
+	return sigc->result != 'G' && sigc->result != 'U';
 }
 
 /*
diff --git a/gpg-interface.h b/gpg-interface.h
index 043bcaa..e2aabde 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -27,7 +27,7 @@ extern int verify_signed_buffer(const char *payload, size_t payload_size, const
 extern int git_gpg_config(const char *, const char *, void *);
 extern void set_signing_key(const char *);
 extern const char *get_signing_key(void);
-extern void check_signature(const char *payload, size_t plen,
+extern int check_signature(const char *payload, size_t plen,
 	const char *signature, size_t slen, struct signature_check *sigc);
 
 #endif
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index 4fc376e..796138f 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -81,7 +81,7 @@ test_expect_success GPG 'verify and show signatures' '
 	)
 '
 
-test_expect_failure GPG 'verify-commit exits success on untrusted signature' '
+test_expect_success GPG 'verify-commit exits success on untrusted signature' '
 	git verify-commit eighth-signed-alt 2>actual &&
 	grep "Good signature from" actual &&
 	! grep "BAD signature from" actual &&
-- 
2.4.0
