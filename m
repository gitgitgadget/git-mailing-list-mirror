From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 13/21] gpg-interface: move parse_gpg_output() to where it should be
Date: Thu,  4 Sep 2014 13:04:49 -0700
Message-ID: <1409861097-19151-14-git-send-email-gitster@pobox.com>
References: <1409861097-19151-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 04 22:07:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XPdJ1-0001FP-MY
	for gcvg-git-2@plane.gmane.org; Thu, 04 Sep 2014 22:06:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755413AbaIDUFy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Sep 2014 16:05:54 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65074 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755329AbaIDUFw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Sep 2014 16:05:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 58DCE381DA;
	Thu,  4 Sep 2014 16:05:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=R789
	ylst1eHXSQpmFIrS0EoKPLU=; b=YOWVX/T0fZ9hXskGTAAnQxYt43A77+CokP3a
	rsneGrfK7kx24kgGC7H2yNeJAKcspEVRO44KJ5eEs3QAALRCRMQBjEGg2iVBiQc7
	WjpRHoepXa2KQElOJH+cC9ylYyrWrxkSPvbyhtvJvbWZ+wkfEOEv8OcM1dt7FrmX
	e7E8DkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=xHUd/f
	90SyI5nP0M6DbXCbge8S1lxTI4kWu+RDOUw+rkEUYZa5awnm43JEaqaIuGrBUE5J
	rphcJwBumdNDHAqszFAlgbulojJ3qjCSrM6Os/4an3OTOvgtMxohqA7IwWMPXn2E
	PKnsDZx+6NHeIheb1dZf5DjmjkPf/qOP90bxs=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2D270381D9;
	Thu,  4 Sep 2014 16:05:51 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id B61E9381C7;
	Thu,  4 Sep 2014 16:05:43 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-399-g1364b4d
In-Reply-To: <1409861097-19151-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: DA10CF94-346E-11E4-AA06-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256474>

Earlier, ffb6d7d5 (Move commit GPG signature verification to
commit.c, 2013-03-31) moved this helper that used to be in pretty.c
(i.e. the output code path) to commit.c for better reusability.

It was a good first step in the right direction, but still suffers a
myopic view that commits will be the only thing we would ever want
to sign---we would actually want to be able to reuse it even wider.

The function interprets what GPG said; gpg-interface is obviously a
better place.  Move it there.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 commit.c        | 36 ------------------------------------
 gpg-interface.c | 36 ++++++++++++++++++++++++++++++++++++
 gpg-interface.h | 17 ++++++++++++-----
 3 files changed, 48 insertions(+), 41 deletions(-)

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
index 37c23da..8d677cc 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -5,16 +5,23 @@ struct signature_check {
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
+
 extern int sign_buffer(struct strbuf *buffer, struct strbuf *signature, const char *signing_key);
 extern int verify_signed_buffer(const char *payload, size_t payload_size, const char *signature, size_t signature_size, struct strbuf *gpg_output, struct strbuf *gpg_status);
 extern int git_gpg_config(const char *, const char *, void *);
-- 
2.1.0-399-g1364b4d
