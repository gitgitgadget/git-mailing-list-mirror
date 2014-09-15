From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v5 13/23] gpg-interface: move parse_gpg_output() to where it should be
Date: Mon, 15 Sep 2014 15:24:14 -0700
Message-ID: <1410819864-22967-14-git-send-email-gitster@pobox.com>
References: <1410819864-22967-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 00:24:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTehd-0006LV-M2
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 00:24:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758719AbaIOWYy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 18:24:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65047 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755836AbaIOWYw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 18:24:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4BBF93B1BC;
	Mon, 15 Sep 2014 18:24:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=OH5C
	NCseEcdW7DJcVvcBuIBUtow=; b=IK2/Qtp/YI7SjGHETbgcFEEtuxo9iR1uz+S7
	0YO/jwURirAh+kAFRxNvzrfrkhnoj7Qjr+t6tD8AOwfYN4buYG6nF4nAHSQXus2E
	vFMtJ5DTBFJg/ob+cgXus60HRSYO0ijbH6akZqTkf9kp244Z/cKtvoTYEwrRUDQc
	/PUO7Gk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=bCpiJW
	G+rt71iyl741yXARix2zBJ5SWBGnPVbUNNSLah9hFTTXZthHcki8NCcaZhC9NOoH
	7ZZUj/HJCZwEupa6RZJnKKhAT++B2pnm41/rQiqHWarvg3/itNrEQoDu78Eezbcd
	SW7zM34W0NtzeWHvf6mUduAlAPC1cEPOaKMqA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 4285B3B1BB;
	Mon, 15 Sep 2014 18:24:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id A55253B1B9;
	Mon, 15 Sep 2014 18:24:51 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-420-g23b5121
In-Reply-To: <1410819864-22967-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1C5D4790-3D27-11E4-A83E-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257097>

Earlier, ffb6d7d5 (Move commit GPG signature verification to
commit.c, 2013-03-31) moved this helper that used to be in pretty.c
(i.e. the output code path) to commit.c for better reusability.

It was a good first step in the right direction, but still suffers
from a myopic view that commits will be the only thing we would ever
want to sign---we would actually want to be able to reuse it even
wider.

The function interprets what GPG said; gpg-interface is obviously a
better place.  Move it there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c        | 36 ------------------------------------
 gpg-interface.c | 36 ++++++++++++++++++++++++++++++++++++
 gpg-interface.h | 16 +++++++++++-----
 3 files changed, 47 insertions(+), 41 deletions(-)

diff --git a/commit.c b/commit.c
index ae7f2b1..01cdad2 100644
--- a/commit.c
+++ b/commit.c
@@ -1220,42 +1220,6 @@ free_return:
 	free(buf);
 }
 
-static struct {
-	char result;
-	const char *check;
-} sigcheck_gpg_status[] = {
-	{ 'G', "\n[GNUPG:] GOODSIG " },
-	{ 'B', "\n[GNUPG:] BADSIG " },
-	{ 'U', "\n[GNUPG:] TRUST_NEVER" },
-	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED" },
-};
-
-static void parse_gpg_output(struct signature_check *sigc)
-{
-	const char *buf = sigc->gpg_status;
-	int i;
-
-	/* Iterate over all search strings */
-	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
-		const char *found, *next;
-
-		if (!skip_prefix(buf, sigcheck_gpg_status[i].check + 1, &found)) {
-			found = strstr(buf, sigcheck_gpg_status[i].check);
-			if (!found)
-				continue;
-			found += strlen(sigcheck_gpg_status[i].check);
-		}
-		sigc->result = sigcheck_gpg_status[i].result;
-		/* The trust messages are not followed by key/signer information */
-		if (sigc->result != 'U') {
-			sigc->key = xmemdupz(found, 16);
-			found += 17;
-			next = strchrnul(found, '\n');
-			sigc->signer = xmemdupz(found, next - found);
-		}
-	}
-}
-
 void check_commit_signature(const struct commit* commit, struct signature_check *sigc)
 {
 	struct strbuf payload = STRBUF_INIT;
diff --git a/gpg-interface.c b/gpg-interface.c
index ff07012..3c9624c 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -21,6 +21,42 @@ void signature_check_clear(struct signature_check *sigc)
 	sigc->key = NULL;
 }
 
+static struct {
+	char result;
+	const char *check;
+} sigcheck_gpg_status[] = {
+	{ 'G', "\n[GNUPG:] GOODSIG " },
+	{ 'B', "\n[GNUPG:] BADSIG " },
+	{ 'U', "\n[GNUPG:] TRUST_NEVER" },
+	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED" },
+};
+
+void parse_gpg_output(struct signature_check *sigc)
+{
+	const char *buf = sigc->gpg_status;
+	int i;
+
+	/* Iterate over all search strings */
+	for (i = 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
+		const char *found, *next;
+
+		if (!skip_prefix(buf, sigcheck_gpg_status[i].check + 1, &found)) {
+			found = strstr(buf, sigcheck_gpg_status[i].check);
+			if (!found)
+				continue;
+			found += strlen(sigcheck_gpg_status[i].check);
+		}
+		sigc->result = sigcheck_gpg_status[i].result;
+		/* The trust messages are not followed by key/signer information */
+		if (sigc->result != 'U') {
+			sigc->key = xmemdupz(found, 16);
+			found += 17;
+			next = strchrnul(found, '\n');
+			sigc->signer = xmemdupz(found, next - found);
+		}
+	}
+}
+
 void set_signing_key(const char *key)
 {
 	free(configured_signing_key);
diff --git a/gpg-interface.h b/gpg-interface.h
index 37c23da..82493b7 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -5,16 +5,22 @@ struct signature_check {
 	char *payload;
 	char *gpg_output;
 	char *gpg_status;
-	char result; /* 0 (not checked),
-		      * N (checked but no further result),
-		      * U (untrusted good),
-		      * G (good)
-		      * B (bad) */
+
+	/*
+	 * possible "result":
+	 * 0 (not checked)
+	 * N (checked but no further result)
+	 * U (untrusted good)
+	 * G (good)
+	 * B (bad)
+	 */
+	char result;
 	char *signer;
 	char *key;
 };
 
 extern void signature_check_clear(struct signature_check *sigc);
+extern void parse_gpg_output(struct signature_check *);
 extern int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key);
 extern int verify_signed_buffer(const char *payload, size_t payload_size, const char *signature, size_t signature_size, struct strbuf *gpg_output, struct strbuf *gpg_status);
 extern int git_gpg_config(const char *, const char *, void *);
-- 
2.1.0-410-gd72dacd
