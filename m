From: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
Subject: [PATCH 6/9] Rewrite launch_editor, create_tag and stripspace to use strbufs.
Date: Wed,  5 Sep 2007 20:23:35 -0400
Message-ID: <1189038225525-git-send-email-krh@redhat.com>
References: <11890382183913-git-send-email-krh@redhat.com>
 <11890382242333-git-send-email-krh@redhat.com>
 <11890382243290-git-send-email-krh@redhat.com>
 <11890382253220-git-send-email-krh@redhat.com>
 <11890382252522-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Kristian=20H=C3=B8gsberg?= <krh@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 06 02:36:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT5MZ-0001tF-E5
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 02:36:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932096AbXIFAfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 5 Sep 2007 20:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757228AbXIFAfy
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 20:35:54 -0400
Received: from mx1.redhat.com ([66.187.233.31]:43776 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756945AbXIFAfr (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 20:35:47 -0400
Received: from int-mx1.corp.redhat.com (int-mx1.corp.redhat.com [172.16.52.254])
	by mx1.redhat.com (8.13.1/8.13.1) with ESMTP id l860ZkhL005444
	for <git@vger.kernel.org>; Wed, 5 Sep 2007 20:35:46 -0400
Received: from pobox.corp.redhat.com (pobox.corp.redhat.com [10.11.255.20])
	by int-mx1.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860ZjZB032619;
	Wed, 5 Sep 2007 20:35:45 -0400
Received: from localhost.localdomain (dhcp83-9.boston.redhat.com [172.16.83.9])
	by pobox.corp.redhat.com (8.13.1/8.13.1) with ESMTP id l860Zhba016503;
	Wed, 5 Sep 2007 20:35:45 -0400
X-Mailer: git-send-email 1.5.3.rc5.852.gc119
In-Reply-To: <11890382252522-git-send-email-krh@redhat.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57788>

Signed-off-by: Kristian H=C3=B8gsberg <krh@redhat.com>
---
 builtin-stripspace.c |   45 +++++++++++++-------------
 builtin-tag.c        |   84 +++++++++++++++++++++---------------------=
--------
 builtin.h            |    1 -
 strbuf.c             |   43 +++++---------------------
 strbuf.h             |    2 +
 5 files changed, 68 insertions(+), 107 deletions(-)

diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index 916355c..f0264a8 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "strbuf.h"
=20
 /*
  * Returns the length of a line, without trailing spaces.
@@ -34,34 +35,34 @@ static size_t cleanup(char *line, size_t len)
  * If the input has only empty lines and spaces,
  * no output will be produced.
  *
- * If last line has a newline at the end, it will be removed.
+ * If the last line does not have a newline, one will be added.
  *
  * Enable skip_comments to skip every line starting with "#".
  */
-size_t stripspace(char *buffer, size_t length, int skip_comments)
+size_t stripspace(struct strbuf *sb, int skip_comments)
 {
 	int empties =3D -1;
 	size_t i, j, len, newlen;
 	char *eol;
=20
-	for (i =3D j =3D 0; i < length; i +=3D len, j +=3D newlen) {
-		eol =3D memchr(buffer + i, '\n', length - i);
-		len =3D eol ? eol - (buffer + i) + 1 : length - i;
+	for (i =3D j =3D 0; i < sb->len; i +=3D len, j +=3D newlen) {
+		eol =3D memchr(sb->buf + i, '\n', sb->len - i);
+		len =3D eol ? eol - (sb->buf + i) + 1 : sb->len - i;
=20
-		if (skip_comments && len && buffer[i] =3D=3D '#') {
+		if (skip_comments && len && sb->buf[i] =3D=3D '#') {
 			newlen =3D 0;
 			continue;
 		}
-		newlen =3D cleanup(buffer + i, len);
+		newlen =3D cleanup(sb->buf + i, len);
=20
 		/* Not just an empty line? */
 		if (newlen) {
 			if (empties !=3D -1)
-				buffer[j++] =3D '\n';
+				sb->buf[j++] =3D '\n';
 			if (empties > 0)
-				buffer[j++] =3D '\n';
+				sb->buf[j++] =3D '\n';
 			empties =3D 0;
-			memmove(buffer + j, buffer + i, newlen);
+			memmove(sb->buf + j, sb->buf + i, newlen);
 			continue;
 		}
 		if (empties < 0)
@@ -69,31 +70,31 @@ size_t stripspace(char *buffer, size_t length, int =
skip_comments)
 		empties++;
 	}
=20
-	return j;
+	sb->len =3D j;
+	if (j > 0)
+		strbuf_add_char(sb, '\n');
+
+	return sb->len;
 }
=20
 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
-	char *buffer;
-	unsigned long size;
+	struct strbuf sb;
 	int strip_comments =3D 0;
=20
 	if (argc > 1 && (!strcmp(argv[1], "-s") ||
 				!strcmp(argv[1], "--strip-comments")))
 		strip_comments =3D 1;
=20
-	size =3D 1024;
-	buffer =3D xmalloc(size);
-	if (read_fd(0, &buffer, &size)) {
-		free(buffer);
+	strbuf_init(&sb);
+	if (strbuf_read_fd(&sb, 0) < 0) {
+		strbuf_release(&sb);
 		die("could not read the input");
 	}
=20
-	size =3D stripspace(buffer, size, strip_comments);
-	write_or_die(1, buffer, size);
-	if (size)
-		putc('\n', stdout);
+	stripspace(&sb, strip_comments);
+	write_or_die(1, sb.buf, sb.len);
+	strbuf_release(&sb);
=20
-	free(buffer);
 	return 0;
 }
diff --git a/builtin-tag.c b/builtin-tag.c
index d6d38ad..1aff952 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -11,13 +11,14 @@
 #include "refs.h"
 #include "tag.h"
 #include "run-command.h"
+#include "strbuf.h"
=20
 static const char builtin_tag_usage[] =3D
   "git-tag [-n [<num>]] -l [<pattern>] | [-a | -s | -u <key-id>] [-f |=
 -d | -v] [-m <msg> | -F <file>] <tagname> [<head>]";
=20
 static char signingkey[1000];
=20
-static void launch_editor(const char *path, char **buffer, unsigned lo=
ng *len)
+static void launch_editor(const char *path, struct strbuf *sb)
 {
 	const char *editor, *terminal;
 	struct child_process child;
@@ -55,10 +56,9 @@ static void launch_editor(const char *path, char **b=
uffer, unsigned long *len)
 	fd =3D open(path, O_RDONLY);
 	if (fd < 0)
 		die("could not open '%s': %s", path, strerror(errno));
-	if (read_fd(fd, buffer, len)) {
-		free(*buffer);
+	if (strbuf_read_fd(sb, fd) < 0) {
 		die("could not read message file '%s': %s",
-						path, strerror(errno));
+		    path, strerror(errno));
 	}
 	close(fd);
 }
@@ -191,7 +191,7 @@ static int verify_tag(const char *name, const char =
*ref,
 	return 0;
 }
=20
-static ssize_t do_sign(char *buffer, size_t size, size_t max)
+static int do_sign(struct strbuf *sb)
 {
 	struct child_process gpg;
 	const char *args[4];
@@ -219,17 +219,13 @@ static ssize_t do_sign(char *buffer, size_t size,=
 size_t max)
 	if (start_command(&gpg))
 		return error("could not run gpg.");
=20
-	write_or_die(gpg.in, buffer, size);
+	write_or_die(gpg.in, sb->buf, sb->len);
 	close(gpg.in);
 	gpg.close_in =3D 0;
-	len =3D read_in_full(gpg.out, buffer + size, max - size);
-
+	len =3D strbuf_read_fd(sb, gpg.out);
 	finish_command(&gpg);
=20
-	if (len =3D=3D max - size)
-		return error("could not read the entire signature from gpg.");
-
-	return size + len;
+	return len;
 }
=20
 static const char tag_template[] =3D
@@ -258,26 +254,24 @@ static void create_tag(const unsigned char *objec=
t, const char *tag,
 		       char *message, int sign, unsigned char *result)
 {
 	enum object_type type;
-	char header_buf[1024], *buffer =3D NULL;
-	int header_len, max_size;
-	unsigned long size =3D 0;
+	struct strbuf sb;
+	int header_len;
=20
 	type =3D sha1_object_info(object, NULL);
 	if (type <=3D OBJ_NONE)
 	    die("bad object type.");
=20
-	header_len =3D snprintf(header_buf, sizeof(header_buf),
-			  "object %s\n"
-			  "type %s\n"
-			  "tag %s\n"
-			  "tagger %s\n\n",
-			  sha1_to_hex(object),
-			  typename(type),
-			  tag,
-			  git_committer_info(1));
-
-	if (header_len > sizeof(header_buf) - 1)
-		die("tag header too big.");
+	strbuf_init(&sb);
+	strbuf_printf(&sb,
+		      "object %s\n"
+		      "type %s\n"
+		      "tag %s\n"
+		      "tagger %s\n\n",
+		      sha1_to_hex(object),
+		      typename(type),
+		      tag,
+		      git_committer_info(1));
+	header_len =3D sb.len;
=20
 	if (!message) {
 		char *path;
@@ -292,39 +286,31 @@ static void create_tag(const unsigned char *objec=
t, const char *tag,
 		write_or_die(fd, tag_template, strlen(tag_template));
 		close(fd);
=20
-		launch_editor(path, &buffer, &size);
+		launch_editor(path, &sb);
=20
 		unlink(path);
 		free(path);
 	}
 	else {
-		buffer =3D message;
-		size =3D strlen(message);
+		strbuf_add(&sb, message, strlen(message));
 	}
=20
-	size =3D stripspace(buffer, size, 1);
-
-	if (!message && !size)
+	if (stripspace(&sb, 1) <=3D header_len && !message)
 		die("no tag message?");
=20
-	/* insert the header and add the '\n' if needed: */
-	max_size =3D header_len + size + (sign ? MAX_SIGNATURE_LENGTH : 0) + =
1;
-	buffer =3D xrealloc(buffer, max_size);
-	if (size)
-		buffer[size++] =3D '\n';
-	memmove(buffer + header_len, buffer, size);
-	memcpy(buffer, header_buf, header_len);
-	size +=3D header_len;
-
-	if (sign) {
-		size =3D do_sign(buffer, size, max_size);
-		if (size < 0)
-			die("unable to sign the tag");
-	}
+	/* Debatable, but makes t7401-tag.sh pass.  Creates an extra
+	 * blank line after the header block for tags with empty
+	 * messages. */
+	if (sb.len < header_len)
+		strbuf_add_char(&sb, '\n');
=20
-	if (write_sha1_file(buffer, size, tag_type, result) < 0)
+	if (sign && do_sign(&sb) < 0)
+		die("unable to sign the tag");
+
+	if (write_sha1_file(sb.buf, sb.len, tag_type, result) < 0)
 		die("unable to write tag file");
-	free(buffer);
+
+	strbuf_release(&sb);
 }
=20
 int cmd_tag(int argc, const char **argv, const char *prefix)
diff --git a/builtin.h b/builtin.h
index bb72000..91bc595 100644
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
diff --git a/strbuf.c b/strbuf.c
index fcfc05e..ed2afea 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -6,7 +6,8 @@ void strbuf_init(struct strbuf *sb) {
 	sb->eof =3D sb->alloc =3D sb->len =3D 0;
 }
=20
-static void strbuf_begin(struct strbuf *sb) {
+void strbuf_release(struct strbuf *sb)
+{
 	free(sb->buf);
 	strbuf_init(sb);
 }
@@ -35,7 +36,7 @@ static void strbuf_end(struct strbuf *sb) {
=20
 void read_line(struct strbuf *sb, FILE *fp, int term) {
 	int ch;
-	strbuf_begin(sb);
+	strbuf_release(sb);
 	if (feof(fp)) {
 		sb->eof =3D 1;
 		return;
@@ -73,43 +74,15 @@ void strbuf_printf(struct strbuf *sb, const char *f=
mt, ...)
 {
 	char buffer[2048];
 	va_list args;
-	int len, size =3D 2 * sizeof buffer;
+	int len;
=20
 	va_start(args, fmt);
 	len =3D vsnprintf(buffer, sizeof(buffer), fmt, args);
 	va_end(args);
=20
-	if (len > sizeof(buffer)) {
-		/*
-		 * Didn't fit in the buffer, but this vsnprintf at
-		 * least gives us the required length back.  Grow the
-		 * buffer acccordingly and try again.
-		 */
-		strbuf_grow(sb, len);
-		va_start(args, fmt);
-		len =3D vsnprintf(sb->buf + sb->len,
-				sb->alloc - sb->len, fmt, args);
-		va_end(args);
-	} else if (len >=3D 0) {
-		/*
-		 * The initial vsnprintf fit in the temp buffer, just
-		 * copy it to the strbuf.
-		 */
-		strbuf_add(sb, buffer, len);
-	} else {
-		/*
-		 * This vnsprintf sucks and just returns -1 when the
-		 * buffer is too small.  Keep doubling the size until
-		 * it fits.
-		 */
-		while (len < 0) {
-			strbuf_grow(sb, size);
-			va_start(args, fmt);
-			len =3D vsnprintf(sb->buf + sb->len,
-					sb->alloc - sb->len, fmt, args);
-			va_end(args);
-			size *=3D 2;
-		}
-	}
+	if (len > sizeof(buffer) || len < 0)
+		die("out of buffer space\n");
+
+	strbuf_add(sb, buffer, len);
 }
=20
diff --git a/strbuf.h b/strbuf.h
index 6e630ea..a93b9e1 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -8,10 +8,12 @@ struct strbuf {
 };
=20
 extern void strbuf_init(struct strbuf *);
+extern void strbuf_release(struct strbuf *);
 extern void read_line(struct strbuf *, FILE *, int);
 extern void strbuf_add(struct strbuf *sb, const char *data, size_t len=
);
 extern void strbuf_add_char(struct strbuf *sb, int ch);
 extern void strbuf_printf(struct strbuf *sb, const char *fmt, ...);
 extern int strbuf_read_fd(struct strbuf *sb, int fd);
+extern size_t stripspace(struct strbuf *sb, int skip_comments);
=20
 #endif /* STRBUF_H */
--=20
1.5.2.GIT
