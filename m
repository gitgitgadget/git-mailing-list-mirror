From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH v2 2/7] verify-tag: share code with verify-commit
Date: Sun, 21 Jun 2015 23:14:38 +0000
Message-ID: <1434928483-105916-3-git-send-email-sandals@crustytoothpaste.net>
References: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>, Alex Zepeda <alex@inferiorhumanorgans.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 22 01:15:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6oS9-00066b-E3
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 01:15:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbbFUXPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 19:15:03 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51183 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752392AbbFUXOz (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 21 Jun 2015 19:14:55 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3645928095;
	Sun, 21 Jun 2015 23:14:54 +0000 (UTC)
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1434928483-105916-1-git-send-email-sandals@crustytoothpaste.net>
X-Spam-Score: -2.5 ALL_TRUSTED,BAYES_00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272299>

verify-tag was executing an entirely different codepath than
verify-commit, except for the underlying verify_signed_buffer.  Move
much of the code from check_commit_signature to a generic
check_signature function and adjust both codepaths to call it.

Update verify-tag to explicitly output the signature text, as we now
call verify_signed_buffer with strbufs to catch the output, which
prevents it from being printed automatically.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 builtin/verify-tag.c |  9 ++++++++-
 commit.c             | 15 +--------------
 gpg-interface.c      | 23 +++++++++++++++++++++++
 gpg-interface.h      |  2 ++
 4 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 53c68fc..e1eb341 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -20,8 +20,11 @@ static const char * const verify_tag_usage[] = {
 
 static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 {
+	struct signature_check sigc;
 	int len;
 
+	memset(&sigc, 0, sizeof(sigc));
+
 	len = parse_signature(buf, size);
 	if (verbose)
 		write_in_full(1, buf, len);
@@ -29,7 +32,11 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	if (size == len)
 		return error("no signature found");
 
-	return verify_signed_buffer(buf, len, buf + len, size - len, NULL, NULL);
+	check_signature(buf, len, buf + len, size - len, &sigc);
+	fputs(sigc.gpg_output, stderr);
+
+	signature_check_clear(&sigc);
+	return sigc.result != 'G' && sigc.result != 'U';
 }
 
 static int verify_tag(const char *name, int verbose)
diff --git a/commit.c b/commit.c
index 6e2103c..1e2e144 100644
--- a/commit.c
+++ b/commit.c
@@ -1236,27 +1236,14 @@ void check_commit_signature(const struct commit *commit, struct signature_check
 {
 	struct strbuf payload = STRBUF_INIT;
 	struct strbuf signature = STRBUF_INIT;
-	struct strbuf gpg_output = STRBUF_INIT;
-	struct strbuf gpg_status = STRBUF_INIT;
-	int status;
 
 	sigc->result = 'N';
 
 	if (parse_signed_commit(commit, &payload, &signature) <= 0)
 		goto out;
-	status = verify_signed_buffer(payload.buf, payload.len,
-				      signature.buf, signature.len,
-				      &gpg_output, &gpg_status);
-	if (status && !gpg_output.len)
-		goto out;
-	sigc->payload = strbuf_detach(&payload, NULL);
-	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
-	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
-	parse_gpg_output(sigc);
+	check_signature(payload.buf, payload.len, signature.buf, signature.len, sigc);
 
  out:
-	strbuf_release(&gpg_status);
-	strbuf_release(&gpg_output);
 	strbuf_release(&payload);
 	strbuf_release(&signature);
 }
diff --git a/gpg-interface.c b/gpg-interface.c
index 68b0c81..66dbee2 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -60,6 +60,29 @@ void parse_gpg_output(struct signature_check *sigc)
 	}
 }
 
+void check_signature(const char *payload, size_t plen, const char *signature,
+	size_t slen, struct signature_check *sigc)
+{
+	struct strbuf gpg_output = STRBUF_INIT;
+	struct strbuf gpg_status = STRBUF_INIT;
+	int status;
+
+	sigc->result = 'N';
+
+	status = verify_signed_buffer(payload, plen, signature, slen,
+				      &gpg_output, &gpg_status);
+	if (status && !gpg_output.len)
+		goto out;
+	sigc->payload = xmemdupz(payload, plen);
+	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
+	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
+	parse_gpg_output(sigc);
+
+ out:
+	strbuf_release(&gpg_status);
+	strbuf_release(&gpg_output);
+}
+
 /*
  * Look at GPG signed content (e.g. a signed tag object), whose
  * payload is followed by a detached signature on it.  Return the
diff --git a/gpg-interface.h b/gpg-interface.h
index 87a4f2e..043bcaa 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -27,5 +27,7 @@ extern int verify_signed_buffer(const char *payload, size_t payload_size, const
 extern int git_gpg_config(const char *, const char *, void *);
 extern void set_signing_key(const char *);
 extern const char *get_signing_key(void);
+extern void check_signature(const char *payload, size_t plen,
+	const char *signature, size_t slen, struct signature_check *sigc);
 
 #endif
-- 
2.4.0
