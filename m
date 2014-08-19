From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 12/18] gpg-interface: move parse_gpg_output() to where it should be
Date: Tue, 19 Aug 2014 15:06:21 -0700
Message-ID: <1408485987-3590-13-git-send-email-gitster@pobox.com>
References: <1408485987-3590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 20 00:08:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XJra7-0006OJ-TQ
	for gcvg-git-2@plane.gmane.org; Wed, 20 Aug 2014 00:08:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016AbaHSWIh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Aug 2014 18:08:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60478 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751951AbaHSWIg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Aug 2014 18:08:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9F05F33146;
	Tue, 19 Aug 2014 18:08:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1p1Q
	3SO46uKXuMNNM9jvLgAG894=; b=AErWxGMy/9rL7ceAdTUrwBVDNu2KX/uyK25e
	GobdP3n1rf3gNNDPYhpOi7rUWrqRpcpD+8FclE5wCejBMQEAgdgUyK3OaRAN0gnJ
	dwSbpgGgk6yNn+oCqmGp8v7AjLH1NSZdgvFwIkOue0EoyyhtumJXN7IekS5Y16v7
	bIhi9Wo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=ghdGgZ
	xmCOwKortuPQkyL/XP2wQZZUeW/lWPoY1uvyjQths+hg5k1LtRrrr+HJElfxHFEM
	QPbJ2C1HxBqbxaZcyRe6iqd66cuA6/7i7zOhmSnMOW+LHBxBo23ePiFG1jnLov0n
	olHX0JEoqOP8eY0K4PE0FzhFQVsebmh8Z1lqo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9659B33145;
	Tue, 19 Aug 2014 18:08:35 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C913C33134;
	Tue, 19 Aug 2014 18:08:25 -0400 (EDT)
X-Mailer: git-send-email 2.1.0-301-g54593e2
In-Reply-To: <1408485987-3590-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 5798E16A-27ED-11E4-AADB-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255531>

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
2.1.0-301-g54593e2
