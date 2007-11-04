From: Mike Hommey <mh@glandium.org>
Subject: [PATCH 1/2] Reuse previous annotation when overwriting a tag
Date: Sun,  4 Nov 2007 01:11:14 +0100
Message-ID: <1194135075-28706-1-git-send-email-mh@glandium.org>
References: <7vlk9fxj1r.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 04 01:12:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IoT6H-0005R1-QC
	for gcvg-git-2@gmane.org; Sun, 04 Nov 2007 01:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758139AbXKDAMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Nov 2007 20:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757575AbXKDAML
	(ORCPT <rfc822;git-outgoing>); Sat, 3 Nov 2007 20:12:11 -0400
Received: from vawad.err.no ([85.19.200.177]:41834 "EHLO vawad.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757103AbXKDAMJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Nov 2007 20:12:09 -0400
Received: from aputeaux-153-1-38-67.w82-124.abo.wanadoo.fr ([82.124.130.67] helo=namakemono.glandium.org)
	by vawad.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.62)
	(envelope-from <mh@glandium.org>)
	id 1IoT5v-0007mb-My; Sun, 04 Nov 2007 01:12:06 +0100
Received: from mh by namakemono.glandium.org with local (Exim 4.68)
	(envelope-from <mh@glandium.org>)
	id 1IoT59-0007Ts-88; Sun, 04 Nov 2007 01:11:15 +0100
X-Mailer: git-send-email 1.5.3.5
In-Reply-To: <7vlk9fxj1r.fsf@gitster.siamese.dyndns.org>
X-Spam-Status: (score 2.0): Status=No hits=2.0 required=5.0 tests=RCVD_IN_SORBS_DUL version=3.1.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63326>

When forcing to overwrite an annotated tag, there are good chances one
wants to keep the old annotation, or modify it, not start from scratch.

This is obviously only triggered for annotated tagging (-a or -s).

Signed-off-by: Mike Hommey <mh@glandium.org>
---

You are free to remove the else that makes the tag template not show up
in the editor, but I'm not convinced it is any useful. Maybe a new
template for this annotation reuse would be sensible.

 builtin-tag.c |   38 +++++++++++++++++++++++++++++++++++---
 1 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/builtin-tag.c b/builtin-tag.c
index 66e5a58..566d123 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -247,9 +247,37 @@ static int git_tag_config(const char *var, const char *value)
 	return git_default_config(var, value);
 }
 
+static void write_tag_body(int fd, const unsigned char *sha1)
+{
+	unsigned long size;
+	enum object_type type;
+	char *buf, *sp, *eob;
+	size_t len;
+
+	buf = read_sha1_file(sha1, &type, &size);
+	if (!buf)
+		return;
+	/* skip header */
+	sp = strstr(buf, "\n\n");
+
+	if (!sp || !size || type != OBJ_TAG) {
+		free(buf);
+		return;
+	}
+	sp += 2; /* skip the 2 LFs */
+	eob = strstr(sp, "\n" PGP_SIGNATURE "\n");
+	if (eob)
+		len = eob - sp;
+	else
+		len = buf + size - sp;
+	write_or_die(fd, sp, len);
+
+	free(buf);
+}
+
 static void create_tag(const unsigned char *object, const char *tag,
 		       struct strbuf *buf, int message, int sign,
-			   unsigned char *result)
+			   unsigned char *prev, unsigned char *result)
 {
 	enum object_type type;
 	char header_buf[1024];
@@ -282,7 +310,11 @@ static void create_tag(const unsigned char *object, const char *tag,
 		if (fd < 0)
 			die("could not create file '%s': %s",
 						path, strerror(errno));
-		write_or_die(fd, tag_template, strlen(tag_template));
+
+		if (!is_null_sha1(prev))
+			write_tag_body(fd, prev);
+		else
+			write_or_die(fd, tag_template, strlen(tag_template));
 		close(fd);
 
 		launch_editor(path, buf);
@@ -419,7 +451,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die("tag '%s' already exists", tag);
 
 	if (annotate)
-		create_tag(object, tag, &buf, message, sign, object);
+		create_tag(object, tag, &buf, message, sign, prev, object);
 
 	lock = lock_any_ref_for_update(ref, prev, 0);
 	if (!lock)
-- 
1.5.3.5
