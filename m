From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 4/5] Make builtin-commit-tree use a strbuf instead of hand-rolled realloc buffer.
Date: Mon, 30 Jul 2007 17:28:45 -0400
Message-ID: <11858309322915-git-send-email-krh@redhat.com>
References: <11858309261111-git-send-email-krh@redhat.com>
 <11858309311728-git-send-email-krh@redhat.com>
 <11858309322006-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 30 23:34:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFcss-0003em-Lm
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 23:34:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968320AbXG3VeH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 30 Jul 2007 17:34:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968243AbXG3VeG
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 17:34:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:51445 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967980AbXG3Vd5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 17:33:57 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULXuoT015572
	for <git@vger.kernel.org>; Mon, 30 Jul 2007 17:33:56 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULXuTZ026644;
	Mon, 30 Jul 2007 17:33:56 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l6ULXsA0018718;
	Mon, 30 Jul 2007 17:33:55 -0400
X-Mailer: git-send-email 1.5.3.rc3.848.g198b7-dirty
In-Reply-To: <11858309322006-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54273>

=46rom: Kristian H=C3=B8gsberg <krh@redhat.com>

With the new strbuf_printf() function we can now just a strbuf for
building up the commit object.

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-commit-tree.c |   57 +++++++++++------------------------------=
-------
 1 files changed, 13 insertions(+), 44 deletions(-)

diff --git a/builtin-commit-tree.c b/builtin-commit-tree.c
index ccbcbe3..72884eb 100644
--- a/builtin-commit-tree.c
+++ b/builtin-commit-tree.c
@@ -8,42 +8,13 @@
 #include "tree.h"
 #include "builtin.h"
 #include "utf8.h"
+#include "strbuf.h"
=20
 #define BLOCKING (1ul << 14)
=20
 /*
  * FIXME! Share the code with "write-tree.c"
  */
-static void init_buffer(char **bufp, unsigned int *sizep)
-{
-	*bufp =3D xmalloc(BLOCKING);
-	*sizep =3D 0;
-}
-
-static void add_buffer(char **bufp, unsigned int *sizep, const char *f=
mt, ...)
-{
-	char one_line[2048];
-	va_list args;
-	int len;
-	unsigned long alloc, size, newsize;
-	char *buf;
-
-	va_start(args, fmt);
-	len =3D vsnprintf(one_line, sizeof(one_line), fmt, args);
-	va_end(args);
-	size =3D *sizep;
-	newsize =3D size + len + 1;
-	alloc =3D (size + 32767) & ~32767;
-	buf =3D *bufp;
-	if (newsize > alloc) {
-		alloc =3D (newsize + 32767) & ~32767;
-		buf =3D xrealloc(buf, alloc);
-		*bufp =3D buf;
-	}
-	*sizep =3D newsize - 1;
-	memcpy(buf + size, one_line, len);
-}
-
 static void check_valid(unsigned char *sha1, enum object_type expect)
 {
 	enum object_type type =3D sha1_object_info(sha1, NULL);
@@ -88,8 +59,7 @@ int cmd_commit_tree(int argc, const char **argv, cons=
t char *prefix)
 	unsigned char tree_sha1[20];
 	unsigned char commit_sha1[20];
 	char comment[1000];
-	char *buffer;
-	unsigned int size;
+	struct strbuf sb;
 	int encoding_is_utf8;
=20
 	git_config(git_default_config);
@@ -118,8 +88,8 @@ int cmd_commit_tree(int argc, const char **argv, con=
st char *prefix)
 	/* Not having i18n.commitencoding is the same as having utf-8 */
 	encoding_is_utf8 =3D is_encoding_utf8(git_commit_encoding);
=20
-	init_buffer(&buffer, &size);
-	add_buffer(&buffer, &size, "tree %s\n", sha1_to_hex(tree_sha1));
+	strbuf_init(&sb);
+	strbuf_printf(&sb, "tree %s\n", sha1_to_hex(tree_sha1));
=20
 	/*
 	 * NOTE! This ordering means that the same exact tree merged with a
@@ -127,26 +97,25 @@ int cmd_commit_tree(int argc, const char **argv, c=
onst char *prefix)
 	 * if everything else stays the same.
 	 */
 	for (i =3D 0; i < parents; i++)
-		add_buffer(&buffer, &size, "parent %s\n", sha1_to_hex(parent_sha1[i]=
));
+		strbuf_printf(&sb, "parent %s\n", sha1_to_hex(parent_sha1[i]));
=20
 	/* Person/date information */
-	add_buffer(&buffer, &size, "author %s\n", git_author_info(1));
-	add_buffer(&buffer, &size, "committer %s\n", git_committer_info(1));
+	strbuf_printf(&sb, "author %s\n", git_author_info(1));
+	strbuf_printf(&sb, "committer %s\n", git_committer_info(1));
 	if (!encoding_is_utf8)
-		add_buffer(&buffer, &size,
-				"encoding %s\n", git_commit_encoding);
-	add_buffer(&buffer, &size, "\n");
+		strbuf_printf(&sb, "encoding %s\n", git_commit_encoding);
+	strbuf_printf(&sb, "\n");
=20
 	/* And add the comment */
 	while (fgets(comment, sizeof(comment), stdin) !=3D NULL)
-		add_buffer(&buffer, &size, "%s", comment);
+		strbuf_printf(&sb, "%s", comment);
=20
 	/* And check the encoding */
-	buffer[size] =3D '\0';
-	if (encoding_is_utf8 && !is_utf8(buffer))
+	strbuf_add_char(&sb, '\0');
+	if (encoding_is_utf8 && !is_utf8(sb.buf))
 		fprintf(stderr, commit_utf8_warn);
=20
-	if (!write_sha1_file(buffer, size, commit_type, commit_sha1)) {
+	if (!write_sha1_file(sb.buf, sb.len - 1, commit_type, commit_sha1)) {
 		printf("%s\n", sha1_to_hex(commit_sha1));
 		return 0;
 	}
--=20
1.5.2.GIT
