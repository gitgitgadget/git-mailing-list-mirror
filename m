From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/5] verify-tag: factor out signature detection
Date: Sat,  6 Nov 2010 12:04:07 +0100
Message-ID: <970e9c2c52aea06c330c330f12b95750d9e9dabd.1289041051.git.git@drmicha.warpmail.net>
References: <4CAB90EC.1080302@drmicha.warpmail.net>
Cc: Stephan Hugel <urschrei@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 06 12:10:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PEgfF-0004FV-GZ
	for gcvg-git-2@lo.gmane.org; Sat, 06 Nov 2010 12:10:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755379Ab0KFLJ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Nov 2010 07:09:57 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34482 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755318Ab0KFLJ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Nov 2010 07:09:56 -0400
X-Greylist: delayed 371 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Nov 2010 07:09:56 EDT
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 4EC1B654;
	Sat,  6 Nov 2010 07:03:50 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Sat, 06 Nov 2010 07:03:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=from:to:cc:subject:date:message-id:in-reply-to:references:in-reply-to:references; s=smtpout; bh=i6ER0uG6cFIfCd6jYs0r/GwWs4U=; b=LDkrMh8yTi+NjiK4df65laJnuDEYO1f7liqLj1crHfBm/wyZndNYzd7t0iLccuwprl1WuET7HYPDWGgGnY5DuNxGAW068+RJnmOHjAA6suIbJn0pQAAzwyXjkSPpAQywuoAoHfPlDuNPLhd1Lidvm3BLTNLOjnRhvXJnD4mYqKc=
X-Sasl-enc: E+cwT2Gf5NI74ou52gSl6vKgiAt0niNzplnLFpQ8S/Iw 1289041429
Received: from localhost (p548596E8.dip0.t-ipconnect.de [84.133.150.232])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 6F2E740244A;
	Sat,  6 Nov 2010 07:03:49 -0400 (EDT)
X-Mailer: git-send-email 1.7.3.2.193.g78bbb
In-Reply-To: <4CAB90EC.1080302@drmicha.warpmail.net>
In-Reply-To: <cover.1289041051.git.git@drmicha.warpmail.net>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160837>

into tag.h/c for later reuse and modification.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/verify-tag.c |   10 ++--------
 tag.c                |   11 +++++++++++
 tag.h                |    3 +++
 3 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/builtin/verify-tag.c b/builtin/verify-tag.c
index 9f482c2..86cac6d 100644
--- a/builtin/verify-tag.c
+++ b/builtin/verify-tag.c
@@ -17,13 +17,11 @@ static const char * const verify_tag_usage[] = {
 		NULL
 };
 
-#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
-
 static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 {
 	struct child_process gpg;
 	const char *args_gpg[] = {"gpg", "--verify", "FILE", "-", NULL};
-	char path[PATH_MAX], *eol;
+	char path[PATH_MAX];
 	size_t len;
 	int fd, ret;
 
@@ -37,11 +35,7 @@ static int run_gpg_verify(const char *buf, unsigned long size, int verbose)
 	close(fd);
 
 	/* find the length without signature */
-	len = 0;
-	while (len < size && prefixcmp(buf + len, PGP_SIGNATURE)) {
-		eol = memchr(buf + len, '\n', size - len);
-		len += eol ? eol - (buf + len) + 1 : size - len;
-	}
+	len = parse_signature(buf, size);
 	if (verbose)
 		write_in_full(1, buf, len);
 
diff --git a/tag.c b/tag.c
index 28641cf..5f9626c 100644
--- a/tag.c
+++ b/tag.c
@@ -133,3 +133,14 @@ int parse_tag(struct tag *item)
 	free(data);
 	return ret;
 }
+
+size_t parse_signature(const char *buf, unsigned long size)
+{
+	char *eol;
+	size_t len = 0;
+	while (len < size && prefixcmp(buf + len, PGP_SIGNATURE)) {
+		eol = memchr(buf + len, '\n', size - len);
+		len += eol ? eol - (buf + len) + 1 : size - len;
+	}
+	return len;
+}
diff --git a/tag.h b/tag.h
index 4766272..4ba2a42 100644
--- a/tag.h
+++ b/tag.h
@@ -3,6 +3,8 @@
 
 #include "object.h"
 
+#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
+
 extern const char *tag_type;
 
 struct tag {
@@ -16,5 +18,6 @@ extern struct tag *lookup_tag(const unsigned char *sha1);
 extern int parse_tag_buffer(struct tag *item, void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
+extern size_t parse_signature(const char *buf, unsigned long size);
 
 #endif /* TAG_H */
-- 
1.7.3.2.193.g78bbb
