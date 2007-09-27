From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] strbuf_read_file enhancement, and use it.
Date: Thu, 27 Sep 2007 15:36:09 +0200
Message-ID: <20070927133609.GJ10289@artemis.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Sep 27 15:36:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IatXR-0001A0-Lg
	for gcvg-git-2@gmane.org; Thu, 27 Sep 2007 15:36:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755151AbXI0NgN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2007 09:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755128AbXI0NgN
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Sep 2007 09:36:13 -0400
Received: from pan.madism.org ([88.191.52.104]:32988 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755141AbXI0NgM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2007 09:36:12 -0400
Received: from madism.org (beacon-free1.intersec.com [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id B060321144;
	Thu, 27 Sep 2007 15:36:09 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 66690DB5C; Thu, 27 Sep 2007 15:36:09 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>,
	Kristian =?utf-8?B?SMO4Z3NiZXJn?= <krh@redhat.com>,
	git@vger.kernel.org
Content-Disposition: inline
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59298>

* make strbuf_read_file take a size hint (works like strbuf_read)
* use it in a couple of places.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---

I just noticed someone introduced a nice strbuf_read_file API, so here is
a patch that diverts this nice idea to simplify git further.

 builtin-apply.c |   12 ++----------
 builtin-blame.c |    8 ++------
 builtin-tag.c   |   19 +++++++------------
 strbuf.c        |    4 ++--
 strbuf.h        |    2 +-
 5 files changed, 14 insertions(+), 31 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 1f0a672..047a60d 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1421,8 +1421,6 @@ static void show_stats(struct patch *patch)
 
 static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 {
-	int fd;
-
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
 		strbuf_grow(buf, st->st_size);
@@ -1431,14 +1429,8 @@ static int read_old_data(struct stat *st, const char *path, struct strbuf *buf)
 		strbuf_setlen(buf, st->st_size);
 		return 0;
 	case S_IFREG:
-		fd = open(path, O_RDONLY);
-		if (fd < 0)
-			return error("unable to open %s", path);
-		if (strbuf_read(buf, fd, st->st_size) < 0) {
-			close(fd);
-			return -1;
-		}
-		close(fd);
+		if (strbuf_read_file(buf, path, st->st_size) != st->st_size)
+			return error("unable to open or read %s", path);
 		convert_to_git(path, buf->buf, buf->len, buf);
 		return 0;
 	default:
diff --git a/builtin-blame.c b/builtin-blame.c
index 16c0ca8..e3112a2 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -2002,7 +2002,6 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 	unsigned char head_sha1[20];
 	struct strbuf buf;
 	const char *ident;
-	int fd;
 	time_t now;
 	int size, len;
 	struct cache_entry *ce;
@@ -2041,11 +2040,8 @@ static struct commit *fake_working_tree_commit(const char *path, const char *con
 		mode = canon_mode(st.st_mode);
 		switch (st.st_mode & S_IFMT) {
 		case S_IFREG:
-			fd = open(read_from, O_RDONLY);
-			if (fd < 0)
-				die("cannot open %s", read_from);
-			if (strbuf_read(&buf, fd, 0) != xsize_t(st.st_size))
-				die("cannot read %s", read_from);
+			if (strbuf_read_file(&buf, read_from, st.st_size) != st.st_size)
+				die("cannot open or read %s", read_from);
 			break;
 		case S_IFLNK:
 			if (readlink(read_from, buf.buf, buf.alloc) != fin_size)
diff --git a/builtin-tag.c b/builtin-tag.c
index 6132cac..66e5a58 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -51,7 +51,7 @@ static void launch_editor(const char *path, struct strbuf *buffer)
 	if (run_command(&child))
 		die("There was a problem with the editor %s.", editor);
 
-	if (strbuf_read_file(buffer, path) < 0)
+	if (strbuf_read_file(buffer, path, 0) < 0)
 		die("could not read message file '%s': %s",
 		    path, strerror(errno));
 }
@@ -356,8 +356,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp(arg, "-F")) {
-			int fd;
-
 			annotate = 1;
 			i++;
 			if (i == argc)
@@ -365,17 +363,14 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 			if (message)
 				die("only one -F or -m option is allowed.");
 
-			if (!strcmp(argv[i], "-"))
-				fd = 0;
-			else {
-				fd = open(argv[i], O_RDONLY);
-				if (fd < 0)
-					die("could not open '%s': %s",
+			if (!strcmp(argv[i], "-")) {
+				if (strbuf_read(&buf, 0, 1024) < 0)
+					die("cannot read %s", argv[i]);
+			} else {
+				if (strbuf_read_file(&buf, argv[i], 1024) < 0)
+					die("could not open or read '%s': %s",
 						argv[i], strerror(errno));
 			}
-			if (strbuf_read(&buf, fd, 1024) < 0) {
-				die("cannot read %s", argv[i]);
-			}
 			message = 1;
 			continue;
 		}
diff --git a/strbuf.c b/strbuf.c
index 910acd0..5cac01e 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -183,14 +183,14 @@ int strbuf_getline(struct strbuf *sb, FILE *fp, int term)
 	return 0;
 }
 
-int strbuf_read_file(struct strbuf *sb, const char *path)
+int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 {
 	int fd, len;
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		return -1;
-	len = strbuf_read(sb, fd, 0);
+	len = strbuf_read(sb, fd, hint);
 	close(fd);
 	if (len < 0)
 		return -1;
diff --git a/strbuf.h b/strbuf.h
index 6deec78..9b9e861 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -108,7 +108,7 @@ extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
 extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
-extern int strbuf_read_file(struct strbuf *sb, const char *path);
+extern int strbuf_read_file(struct strbuf *sb, const char *path, size_t hint);
 
 extern int strbuf_getline(struct strbuf *, FILE *, int);
 
-- 
1.5.3.2.1110.gba7d6
