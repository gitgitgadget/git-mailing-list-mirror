From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] gpg-interface: move parse_gpg_output() to where it should be
Date: Thu, 14 Aug 2014 16:16:15 -0700
Message-ID: <xmqqtx5e1x34.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 01:16:47 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XI4GD-0003WR-8c
	for gcvg-git-2@plane.gmane.org; Fri, 15 Aug 2014 01:16:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932278AbaHNXQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2014 19:16:36 -0400
Received: from smtp.pobox.com ([208.72.237.35]:61091 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932180AbaHNXQa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2014 19:16:30 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BAA5B314FE;
	Thu, 14 Aug 2014 19:16:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=u
	oLku1IKP6+gkrH/YKv3HZ4DqH8=; b=pt63CS3eFcCwFJrhbpzRcBAPz4f7iScLP
	90ISYImBGwv1s+oSjMJ1uf1bRn4ihMXIHNtX4aS5Prw8wljQgRAPVgb2hXlF7IGZ
	FI3VsMdqZFKv7k4B6mD1yaYkaXqX+rhvU+Qypl2UC7zb9dNqqf1X/B1CPhypl7Ix
	lke47KTEpc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=Hk5
	f1CObK1FISrn95kntIXqRQSnrru9ocyXmbKdPHvHlcx9peqd6T5LaGqWr/lXWKiY
	wPQHBLElmD3fWYhYm9EI0mGjw+EqmYd9B9327PcHKHjZS9JO5CTqnkrmY6zceMi8
	EHUWyscC5aXA6FRXYBodOX4HJIwvgi2RFdWdw008=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id B116B314FD;
	Thu, 14 Aug 2014 19:16:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 80897314F0;
	Thu, 14 Aug 2014 19:16:17 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FE747172-2408-11E4-A9F0-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255277>

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
2.1.0-rc2-279-g73a3fff
