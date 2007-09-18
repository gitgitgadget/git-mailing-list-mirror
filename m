From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 4/7] Clean up stripspace a bit, use strbuf even more.
Date: Mon, 17 Sep 2007 20:06:45 -0400
Message-ID: <11900740153845-git-send-email-krh@redhat.com>
References: <1190074008617-git-send-email-krh@redhat.com>
 <1190074014548-git-send-email-krh@redhat.com>
 <11900740142347-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 18 02:07:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXQco-0002Qo-G8
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 02:07:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757095AbXIRAHF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 17 Sep 2007 20:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757014AbXIRAHD
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 20:07:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:56222 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756907AbXIRAG5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 20:06:57 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06uBh012102
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Mon, 17 Sep 2007 20:06:56 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06tTQ022181;
	Mon, 17 Sep 2007 20:06:55 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l8I06scx021539;
	Mon, 17 Sep 2007 20:06:55 -0400
X-Mailer: git-send-email 1.5.3.1.993.gbf388-dirty
In-Reply-To: <11900740142347-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58504>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-stripspace.c |   56 ++++++++++++++++++++++--------------------=
-------
 builtin-tag.c        |    5 +---
 builtin.h            |    1 -
 strbuf.h             |    2 +
 4 files changed, 28 insertions(+), 36 deletions(-)

diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index c4cf2f0..a5e7518 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -9,17 +9,13 @@
  */
 static size_t cleanup(char *line, size_t len)
 {
-	if (len) {
-		if (line[len - 1] =3D=3D '\n')
-			len--;
-
-		while (len) {
-			unsigned char c =3D line[len - 1];
-			if (!isspace(c))
-				break;
-			len--;
-		}
+	while (len) {
+		unsigned char c =3D line[len - 1];
+		if (!isspace(c))
+			break;
+		len--;
 	}
+
 	return len;
 }
=20
@@ -35,42 +31,42 @@ static size_t cleanup(char *line, size_t len)
  * If the input has only empty lines and spaces,
  * no output will be produced.
  *
- * If last line has a newline at the end, it will be removed.
+ * If last line does not have a newline at the end, one is added.
  *
  * Enable skip_comments to skip every line starting with "#".
  */
-size_t stripspace(char *buffer, size_t length, int skip_comments)
+void stripspace(struct strbuf *sb, int skip_comments)
 {
-	int empties =3D -1;
+	int empties =3D 0;
 	size_t i, j, len, newlen;
 	char *eol;
=20
-	for (i =3D j =3D 0; i < length; i +=3D len, j +=3D newlen) {
-		eol =3D memchr(buffer + i, '\n', length - i);
-		len =3D eol ? eol - (buffer + i) + 1 : length - i;
+	/* We may have to add a newline. */
+	strbuf_grow(sb, 1);
=20
-		if (skip_comments && len && buffer[i] =3D=3D '#') {
+	for (i =3D j =3D 0; i < sb->len; i +=3D len, j +=3D newlen) {
+		eol =3D memchr(sb->buf + i, '\n', sb->len - i);
+		len =3D eol ? eol - (sb->buf + i) + 1 : sb->len - i;
+
+		if (skip_comments && len && sb->buf[i] =3D=3D '#') {
 			newlen =3D 0;
 			continue;
 		}
-		newlen =3D cleanup(buffer + i, len);
+		newlen =3D cleanup(sb->buf + i, len);
=20
 		/* Not just an empty line? */
 		if (newlen) {
-			if (empties !=3D -1)
-				buffer[j++] =3D '\n';
-			if (empties > 0)
-				buffer[j++] =3D '\n';
+			if (empties > 0 && j > 0)
+				sb->buf[j++] =3D '\n';
 			empties =3D 0;
-			memmove(buffer + j, buffer + i, newlen);
-			continue;
+			memmove(sb->buf + j, sb->buf + i, newlen);
+			sb->buf[newlen + j++] =3D '\n';
+		} else {
+			empties++;
 		}
-		if (empties < 0)
-			continue;
-		empties++;
 	}
=20
-	return j;
+	strbuf_setlen(sb, j);
 }
=20
 int cmd_stripspace(int argc, const char **argv, const char *prefix)
@@ -86,9 +82,7 @@ int cmd_stripspace(int argc, const char **argv, const=
 char *prefix)
 	if (strbuf_read(&buf, 0, 1024) < 0)
 		die("could not read the input");
=20
-	strbuf_setlen(&buf, stripspace(buf.buf, buf.len, strip_comments));
-	if (buf.len)
-		strbuf_addch(&buf, '\n');
+	stripspace(&buf, strip_comments);
=20
 	write_or_die(1, buf.buf, buf.len);
 	strbuf_release(&buf);
diff --git a/builtin-tag.c b/builtin-tag.c
index 9f29342..68c9a20 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -297,14 +297,11 @@ static void create_tag(const unsigned char *objec=
t, const char *tag,
 		free(path);
 	}
=20
-	strbuf_setlen(buf, stripspace(buf->buf, buf->len, 1));
+	stripspace(buf, 1);
=20
 	if (!message && !buf->len)
 		die("no tag message?");
=20
-	/* insert the header and add the '\n' if needed: */
-	if (buf->len)
-		strbuf_addch(buf, '\n');
 	strbuf_insert(buf, 0, header_buf, header_len);
=20
 	if (sign && do_sign(buf) < 0)
diff --git a/builtin.h b/builtin.h
index 03ee7bf..d6f2c76 100644
--- a/builtin.h
+++ b/builtin.h
@@ -7,7 +7,6 @@ extern const char git_version_string[];
 extern const char git_usage_string[];
=20
 extern void help_unknown_cmd(const char *cmd);
-extern size_t stripspace(char *buffer, size_t length, int skip_comment=
s);
 extern int write_tree(unsigned char *sha1, int missing_ok, const char =
*prefix);
 extern void prune_packed_objects(int);
=20
diff --git a/strbuf.h b/strbuf.h
index 21fc111..5960637 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -98,4 +98,6 @@ extern ssize_t strbuf_read(struct strbuf *, int fd, s=
ize_t hint);
=20
 extern void read_line(struct strbuf *, FILE *, int);
=20
+extern void stripspace(struct strbuf *buf, int skip_comments);
+
 #endif /* STRBUF_H */
--=20
1.5.3.1.993.gbf388-dirty
