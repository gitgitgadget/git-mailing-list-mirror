From: Mike Hommey <mh@glandium.org>
Subject: [PATCH] Reuse previous annotation when overwriting a tag
Date: Sat,  3 Nov 2007 10:31:13 +0100
Message-ID: <1194082273-19486-1-git-send-email-mh@glandium.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 03 10:32:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoFMv-0007Hk-KK
	for gcvg-git-2@gmane.org; Sat, 03 Nov 2007 10:32:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752581AbXKCJcQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 05:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752431AbXKCJcQ
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 05:32:16 -0400
Received: from vawad.err.no ([85.19.200.177]:38912 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752556AbXKCJcP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 05:32:15 -0400
Received: from aputeaux-153-1-33-156.w82-124.abo.wanadoo.fr ([82.124.3.156] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoFMG-00086Y-Bz; Sat, 03 Nov 2007 10:32:02 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoFLV-00054Y-Li; Sat, 03 Nov 2007 10:31:14 +0100
X-Mailer: git-send-email 1.5.3.5
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63220>

When forcing to overwrite an annotated tag, there are good chances one
wants to keep the old annotation, or modify it, not start from scratch.

This is obviously only triggered for annotated tagging (-a or -s).

Signed-off-by: Mike Hommey <mh@glandium.org>
---
The write_annotation function could be made more generic and be used in
various different coming builtins such as git-commit. Also, it could be
used in show_reference() in builtin-tag.c.

 builtin-tag.c |   47 ++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 66e5a58..cfd8017 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -247,9 +247,42 @@ static int git_tag_config(const char *var, const char *value)
 	return git_default_config(var, value);
 }
 
+static void write_annotation(int fd, const unsigned char *sha1)
+{
+	int i;
+	unsigned long size;
+	enum object_type type;
+	char *buf, *sp, *eol;
+	size_t len;
+
+	sp = buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return;
+	if (!size || (type != OBJ_TAG)) {
+		free(buf);
+		return;
+	}
+	/* skip header */
+	while (sp + 1 < buf + size &&
+			!(sp[0] == '\n' && sp[1] == '\n'))
+		sp++;
+	/* strip the signature */
+	for (i = 0, sp += 2; sp < buf + size &&
+			prefixcmp(sp, PGP_SIGNATURE "\n");
+			i++) {
+		eol = memchr(sp, '\n', size - (sp - buf));
+		len = eol ? eol - sp : size - (sp - buf);
+		write_or_die(fd, sp, len + 1);
+		if (!eol)
+			break;
+		sp = eol + 1;
+	}
+	free(buf);
+}
+
 static void create_tag(const unsigned char *object, const char *tag,
 		       struct strbuf *buf, int message, int sign,
-			   unsigned char *result)
+			unsigned char *prev, unsigned char *result)
 {
 	enum object_type type;
 	char header_buf[1024];
@@ -282,6 +315,10 @@ static void create_tag(const unsigned char *object, const char *tag,
 		if (fd < 0)
 			die("could not create file '%s': %s",
 						path, strerror(errno));
+
+		if (prev)
+			write_annotation(fd, prev);
+
 		write_or_die(fd, tag_template, strlen(tag_template));
 		close(fd);
 
@@ -308,7 +345,8 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 {
 	struct strbuf buf;
 	unsigned char object[20], prev[20];
-	int annotate = 0, sign = 0, force = 0, lines = 0, message = 0;
+	int annotate = 0, sign = 0, force = 0, lines = 0,
+	    message = 0, existed = 0;
 	char ref[PATH_MAX];
 	const char *object_ref, *tag;
 	int i;
@@ -417,9 +455,12 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		hashclr(prev);
 	else if (!force)
 		die("tag '%s' already exists", tag);
+	else
+		existed = 1;
 
 	if (annotate)
-		create_tag(object, tag, &buf, message, sign, object);
+		create_tag(object, tag, &buf, message, sign,
+			   existed ? prev : NULL, object);
 
 	lock = lock_any_ref_for_update(ref, prev, 0);
 	if (!lock)
-- 
1.5.3.5
