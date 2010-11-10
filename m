From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCHv2 2/5] verify-tag: factor out signature detection
Date: Wed, 10 Nov 2010 12:17:27 +0100
Message-ID: <9dd97bd6e2b0443bff1083192b579320931432a7.1289387142.git.git@drmicha.warpmail.net>
References: <cover.1289041051.git.git@drmicha.warpmail.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 10 12:19:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PG8iV-00055t-AU
	for gcvg-git-2@lo.gmane.org; Wed, 10 Nov 2010 12:19:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755555Ab0KJLT1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Nov 2010 06:19:27 -0500
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:39180 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754088Ab0KJLT0 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Nov 2010 06:19:26 -0500
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 85A9F76F;
	Wed, 10 Nov 2010 06:19:25 -0500 (EST)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Wed, 10 Nov 2010 06:19:25 -0500
X-Sasl-enc: roHI17pMs/80FM6QsCImk0Q39cpWTsJEmWsoLqVFZWrp 1289387964
Received: from localhost (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id F09C7402929;
	Wed, 10 Nov 2010 06:19:24 -0500 (EST)
X-Mailer: git-send-email 1.7.3.2.193.g78bbb
In-Reply-To: <cover.1289041051.git.git@drmicha.warpmail.net>
In-Reply-To: <cover.1289387142.git.git@drmicha.warpmail.net>
References: <cover.1289387142.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161144>

into tag.h/c for later reuse and modification.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 builtin/verify-tag.c |   10 ++--------
 tag.c                |   13 +++++++++++++
 tag.h                |    1 +
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
index 28641cf..d4f3080 100644
--- a/tag.c
+++ b/tag.c
@@ -4,6 +4,8 @@
 #include "tree.h"
 #include "blob.h"
 
+#define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
+
 const char *tag_type = "tag";
 
 struct object *deref_tag(struct object *o, const char *warn, int warnlen)
@@ -133,3 +135,14 @@ int parse_tag(struct tag *item)
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
index 4766272..8522370 100644
--- a/tag.h
+++ b/tag.h
@@ -16,5 +16,6 @@ extern struct tag *lookup_tag(const unsigned char *sha1);
 extern int parse_tag_buffer(struct tag *item, void *data, unsigned long size);
 extern int parse_tag(struct tag *item);
 extern struct object *deref_tag(struct object *, const char *, int);
+extern size_t parse_signature(const char *buf, unsigned long size);
 
 #endif /* TAG_H */
-- 
1.7.3.2.193.g78bbb
