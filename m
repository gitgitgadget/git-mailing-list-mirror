From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 13/22] gpg-interface: move parse_gpg_output() to where it should be
Date: Fri,  5 Sep 2014 13:55:01 -0700
Message-ID: <1409950510-10209-14-git-send-email-gitster@pobox.com>
References: <1409950510-10209-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 05 22:56:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQ0Xy-0005bR-FJ
	for gcvg-git-2@plane.gmane.org; Fri, 05 Sep 2014 22:55:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752580AbaIEUzr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Sep 2014 16:55:47 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64172 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752554AbaIEUzp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Sep 2014 16:55:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 0C8BF366B0;
	Fri,  5 Sep 2014 16:55:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=bhMK
	JztfdziwFDkeO+SLAegI6rA=; b=yhs3eJ9Y8JrU7xAApWVKJbnUzO+pmhV9wpmL
	0hg81MIebTyIvM8bURHJ6ItDdYUKLzDgsAJn6Sxh6hS/cEQuqW7aD1FqQJvJ7sBJ
	YhhXidZDj3I467+8e6kEO9LlOax/XWq1sUur/hzAcv6NqutTtxp1m9EnQo7cOyBW
	pgXxnLo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=jjcPEA
	6nU/tATY+U2oeqBl/+YXGGp2avq9OyMl3qZHqq5WYDEaw4KqJ7V8lGPUAqPf0GrG
	jyiTMoNDSVIPS0WD7WQqdSODfch8wu6YUrAmQl77oa4q5EFPMKyzrkLHbMLZNQS9
	op4ZMIurKCA9TqvL5GO31RsTw1U6nRShrwMSs=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 014D2366AF;
	Fri,  5 Sep 2014 16:55:45 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 127D6366A9;
	Fri,  5 Sep 2014 16:55:43 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-404-gcacb207
In-Reply-To: <1409950510-10209-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 0037CE54-353F-11E4-930B-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256530>

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
2.1.0-399-g2df620b
