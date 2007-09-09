From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH 6/6] Replace all read_fd use with strbuf_read, and get rid of it.
Date: Sun,  9 Sep 2007 02:04:36 +0200
Message-ID: <11892962771797-git-send-email-madcoder@debian.org>
References: <11892962763548-git-send-email-madcoder@debian.org>
 <11892962761617-git-send-email-madcoder@debian.org>
 <11892962764194-git-send-email-madcoder@debian.org>
 <1189296276114-git-send-email-madcoder@debian.org>
 <11892962771947-git-send-email-madcoder@debian.org>
 <11892962771756-git-send-email-madcoder@debian.org>
Cc: Pierre Habouzit <madcoder@debian.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 09 10:55:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from mail-forward.uio.no ([129.240.10.42])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1IUIOZ-00040f-Ct
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 10:43:55 +0200
Received: from mail-mx8.uio.no ([129.240.10.38])
	by pat.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAN5-0006hQ-1X
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:09:51 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx8.uio.no with esmtp (Exim 4.67)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1IUAMv-0003zs-BV
	for gcvg-git@gmane.org; Sun, 09 Sep 2007 02:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321AbXIIAEu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Sep 2007 20:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755235AbXIIAEt
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Sep 2007 20:04:49 -0400
Received: from pan.madism.org ([88.191.52.104]:46636 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755274AbXIIAEk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Sep 2007 20:04:40 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 324FD1EB1E;
	Sun,  9 Sep 2007 02:04:38 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 116C463FA; Sun,  9 Sep 2007 02:04:37 +0200 (CEST)
X-Mailer: git-send-email 1.5.3.1
In-Reply-To: <11892962771756-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.2, required=12.0, autolearn=disabled, AWL=0.750,UIO_VGER=-3)
X-UiO-Scanned: 269C3E6BFD0D9A9145352CA1F36AB4D5D7F04FC1
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -21 maxlevel 200 minaction 2 bait 0 mail/h: 8 total 517794 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58154>

  This brings builtin-stripspace, builtin-tag and mktag to use strbufs.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 builtin-stripspace.c |   21 ++++++--------
 builtin-tag.c        |   78 ++++++++++++++++++++------------------------------
 cache.h              |    1 -
 mktag.c              |   15 ++++-----
 sha1_file.c          |   60 ++++++--------------------------------
 5 files changed, 56 insertions(+), 119 deletions(-)

diff --git a/builtin-stripspace.c b/builtin-stripspace.c
index 916355c..4815f8a 100644
--- a/builtin-stripspace.c
+++ b/builtin-stripspace.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "strbuf.h"
 
 /*
  * Returns the length of a line, without trailing spaces.
@@ -74,26 +75,22 @@ size_t stripspace(char *buffer, size_t length, int skip_comments)
 
 int cmd_stripspace(int argc, const char **argv, const char *prefix)
 {
-	char *buffer;
-	unsigned long size;
+	struct strbuf buf;
 	int strip_comments = 0;
 
 	if (argc > 1 && (!strcmp(argv[1], "-s") ||
 				!strcmp(argv[1], "--strip-comments")))
 		strip_comments = 1;
 
-	size = 1024;
-	buffer = xmalloc(size);
-	if (read_fd(0, &buffer, &size)) {
-		free(buffer);
+	strbuf_init(&buf);
+	if (strbuf_read(&buf, 0) < 0)
 		die("could not read the input");
-	}
 
-	size = stripspace(buffer, size, strip_comments);
-	write_or_die(1, buffer, size);
-	if (size)
-		putc('\n', stdout);
+	strbuf_setlen(&buf, stripspace(buf.buf, buf.len, strip_comments));
+	if (buf.len)
+		strbuf_addch(&buf, '\n');
 
-	free(buffer);
+	write_or_die(1, buf.buf, buf.len);
+	strbuf_release(&buf);
 	return 0;
 }
diff --git a/builtin-tag.c b/builtin-tag.c
index 348919c..1a93037 100644
--- a/builtin-tag.c
+++ b/builtin-tag.c
@@ -8,6 +8,7 @@
 
 #include "cache.h"
 #include "builtin.h"
+#include "strbuf.h"
 #include "refs.h"
 #include "tag.h"
 #include "run-command.h"
@@ -17,7 +18,7 @@ static const char builtin_tag_usage[] =
 
 static char signingkey[1000];
 
-static void launch_editor(const char *path, char **buffer, unsigned long *len)
+static void launch_editor(const char *path, struct strbuf *buffer)
 {
 	const char *editor, *terminal;
 	struct child_process child;
@@ -55,10 +56,8 @@ static void launch_editor(const char *path, char **buffer, unsigned long *len)
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		die("could not open '%s': %s", path, strerror(errno));
-	if (read_fd(fd, buffer, len)) {
-		free(*buffer);
-		die("could not read message file '%s': %s",
-						path, strerror(errno));
+	if (strbuf_read(buffer, fd) < 0) {
+		die("could not read message file '%s': %s", path, strerror(errno));
 	}
 	close(fd);
 }
@@ -184,7 +183,7 @@ static int verify_tag(const char *name, const char *ref,
 	return 0;
 }
 
-static ssize_t do_sign(char *buffer, size_t size, size_t max)
+static int do_sign(struct strbuf *buffer)
 {
 	struct child_process gpg;
 	const char *args[4];
@@ -212,17 +211,17 @@ static ssize_t do_sign(char *buffer, size_t size, size_t max)
 	if (start_command(&gpg))
 		return error("could not run gpg.");
 
-	write_or_die(gpg.in, buffer, size);
+	write_or_die(gpg.in, buffer->buf, buffer->len);
 	close(gpg.in);
 	gpg.close_in = 0;
-	len = read_in_full(gpg.out, buffer + size, max - size);
+	len = strbuf_read(buffer, gpg.out);
 
 	finish_command(&gpg);
 
-	if (len == max - size)
+	if (len < 0)
 		return error("could not read the entire signature from gpg.");
 
-	return size + len;
+	return 0;
 }
 
 static const char tag_template[] =
@@ -245,15 +244,13 @@ static int git_tag_config(const char *var, const char *value)
 	return git_default_config(var, value);
 }
 
-#define MAX_SIGNATURE_LENGTH 1024
-/* message must be NULL or allocated, it will be reallocated and freed */
 static void create_tag(const unsigned char *object, const char *tag,
-		       char *message, int sign, unsigned char *result)
+		       struct strbuf *buf, int message, int sign,
+			   unsigned char *result)
 {
 	enum object_type type;
-	char header_buf[1024], *buffer = NULL;
-	int header_len, max_size;
-	unsigned long size = 0;
+	char header_buf[1024];
+	int header_len;
 
 	type = sha1_object_info(object, NULL);
 	if (type <= OBJ_NONE)
@@ -285,52 +282,40 @@ static void create_tag(const unsigned char *object, const char *tag,
 		write_or_die(fd, tag_template, strlen(tag_template));
 		close(fd);
 
-		launch_editor(path, &buffer, &size);
+		launch_editor(path, buf);
 
 		unlink(path);
 		free(path);
 	}
-	else {
-		buffer = message;
-		size = strlen(message);
-	}
 
-	size = stripspace(buffer, size, 1);
+	strbuf_setlen(buf, stripspace(buf->buf, buf->len, 1));
 
-	if (!message && !size)
+	if (!message && !buf->len)
 		die("no tag message?");
 
 	/* insert the header and add the '\n' if needed: */
-	max_size = header_len + size + (sign ? MAX_SIGNATURE_LENGTH : 0) + 1;
-	buffer = xrealloc(buffer, max_size);
-	if (size)
-		buffer[size++] = '\n';
-	memmove(buffer + header_len, buffer, size);
-	memcpy(buffer, header_buf, header_len);
-	size += header_len;
-
-	if (sign) {
-		size = do_sign(buffer, size, max_size);
-		if (size < 0)
-			die("unable to sign the tag");
-	}
+	if (buf->len)
+		strbuf_addch(buf, '\n');
+	strbuf_insert(buf, 0, header_buf, header_len);
 
-	if (write_sha1_file(buffer, size, tag_type, result) < 0)
+	if (sign && do_sign(buf) < 0)
+		die("unable to sign the tag");
+	if (write_sha1_file(buf->buf, buf->len, tag_type, result) < 0)
 		die("unable to write tag file");
-	free(buffer);
 }
 
 int cmd_tag(int argc, const char **argv, const char *prefix)
 {
+	struct strbuf buf;
 	unsigned char object[20], prev[20];
-	int annotate = 0, sign = 0, force = 0, lines = 0;
-	char *message = NULL;
+	int annotate = 0, sign = 0, force = 0, lines = 0, message = 0;
 	char ref[PATH_MAX];
 	const char *object_ref, *tag;
 	int i;
 	struct ref_lock *lock;
 
 	git_config(git_tag_config);
+	strbuf_init(&buf);
 
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
@@ -366,11 +351,11 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 				die("option -m needs an argument.");
 			if (message)
 				die("only one -F or -m option is allowed.");
-			message = xstrdup(argv[i]);
+			strbuf_addstr(&buf, argv[i]);
+			message = 1;
 			continue;
 		}
 		if (!strcmp(arg, "-F")) {
-			unsigned long len;
 			int fd;
 
 			annotate = 1;
@@ -388,12 +373,10 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 					die("could not open '%s': %s",
 						argv[i], strerror(errno));
 			}
-			len = 1024;
-			message = xmalloc(len);
-			if (read_fd(fd, &message, &len)) {
-				free(message);
+			if (strbuf_read(&buf, fd) < 0) {
 				die("cannot read %s", argv[i]);
 			}
+			message = 1;
 			continue;
 		}
 		if (!strcmp(arg, "-u")) {
@@ -441,7 +424,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		die("tag '%s' already exists", tag);
 
 	if (annotate)
-		create_tag(object, tag, message, sign, object);
+		create_tag(object, tag, &buf, message, sign, object);
 
 	lock = lock_any_ref_for_update(ref, prev, 0);
 	if (!lock)
@@ -449,5 +432,6 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 	if (write_ref_sha1(lock, object, NULL) < 0)
 		die("%s: cannot update the ref", ref);
 
+	strbuf_release(&buf);
 	return 0;
 }
diff --git a/cache.h b/cache.h
index 493983c..231f81d 100644
--- a/cache.h
+++ b/cache.h
@@ -269,7 +269,6 @@ extern int ie_match_stat(struct index_state *, struct cache_entry *, struct stat
 extern int ie_modified(struct index_state *, struct cache_entry *, struct stat *, int);
 extern int ce_path_match(const struct cache_entry *ce, const char **pathspec);
 extern int index_fd(unsigned char *sha1, int fd, struct stat *st, int write_object, enum object_type type, const char *path);
-extern int read_fd(int fd, char **return_buf, unsigned long *return_size);
 extern int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object);
 extern int index_path(unsigned char *sha1, const char *path, struct stat *st, int write_object);
 extern void fill_stat_cache_info(struct cache_entry *ce, struct stat *st);
diff --git a/mktag.c b/mktag.c
index 38acd5a..0c29a2b 100644
--- a/mktag.c
+++ b/mktag.c
@@ -1,4 +1,5 @@
 #include "cache.h"
+#include "strbuf.h"
 #include "tag.h"
 
 /*
@@ -111,8 +112,7 @@ static int verify_tag(char *buffer, unsigned long size)
 
 int main(int argc, char **argv)
 {
-	unsigned long size = 4096;
-	char *buffer = xmalloc(size);
+	struct strbuf buf;
 	unsigned char result_sha1[20];
 
 	if (argc != 1)
@@ -120,21 +120,20 @@ int main(int argc, char **argv)
 
 	setup_git_directory();
 
-	if (read_fd(0, &buffer, &size)) {
-		free(buffer);
+	strbuf_init(&buf);
+	if (strbuf_read(&buf, 0) < 0) {
 		die("could not read from stdin");
 	}
 
 	/* Verify it for some basic sanity: it needs to start with
 	   "object <sha1>\ntype\ntagger " */
-	if (verify_tag(buffer, size) < 0)
+	if (verify_tag(buf.buf, buf.len) < 0)
 		die("invalid tag signature file");
 
-	if (write_sha1_file(buffer, size, tag_type, result_sha1) < 0)
+	if (write_sha1_file(buf.buf, buf.len, tag_type, result_sha1) < 0)
 		die("unable to write tag file");
 
-	free(buffer);
-
+	strbuf_release(&buf);
 	printf("%s\n", sha1_to_hex(result_sha1));
 	return 0;
 }
diff --git a/sha1_file.c b/sha1_file.c
index 9978a58..d011056 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -14,6 +14,7 @@
 #include "tag.h"
 #include "tree.h"
 #include "refs.h"
+#include "strbuf.h"
 
 #ifndef O_NOATIME
 #if defined(__linux__) && (defined(__i386__) || defined(__PPC__))
@@ -2302,68 +2303,25 @@ int has_sha1_file(const unsigned char *sha1)
 	return find_sha1_file(sha1, &st) ? 1 : 0;
 }
 
-/*
- * reads from fd as long as possible into a supplied buffer of size bytes.
- * If necessary the buffer's size is increased using realloc()
- *
- * returns 0 if anything went fine and -1 otherwise
- *
- * The buffer is always NUL-terminated, not including it in returned size.
- *
- * NOTE: both buf and size may change, but even when -1 is returned
- * you still have to free() it yourself.
- */
-int read_fd(int fd, char **return_buf, unsigned long *return_size)
-{
-	char *buf = *return_buf;
-	unsigned long size = *return_size;
-	ssize_t iret;
-	unsigned long off = 0;
-
-	if (!buf || size <= 1) {
-		size = 1024;
-		buf = xrealloc(buf, size);
-	}
-
-	do {
-		iret = xread(fd, buf + off, (size - 1) - off);
-		if (iret > 0) {
-			off += iret;
-			if (off == size - 1) {
-				size = alloc_nr(size);
-				buf = xrealloc(buf, size);
-			}
-		}
-	} while (iret > 0);
-
-	buf[off] = '\0';
-
-	*return_buf = buf;
-	*return_size = off;
-
-	if (iret < 0)
-		return -1;
-	return 0;
-}
-
 int index_pipe(unsigned char *sha1, int fd, const char *type, int write_object)
 {
-	unsigned long size = 4096;
-	char *buf = xmalloc(size);
+	struct strbuf buf;
 	int ret;
 
-	if (read_fd(fd, &buf, &size)) {
-		free(buf);
+	strbuf_init(&buf);
+	if (strbuf_read(&buf, fd) < 0) {
+		strbuf_release(&buf);
 		return -1;
 	}
 
 	if (!type)
 		type = blob_type;
 	if (write_object)
-		ret = write_sha1_file(buf, size, type, sha1);
+		ret = write_sha1_file(buf.buf, buf.len, type, sha1);
 	else
-		ret = hash_sha1_file(buf, size, type, sha1);
-	free(buf);
+		ret = hash_sha1_file(buf.buf, buf.len, type, sha1);
+	strbuf_release(&buf);
+
 	return ret;
 }
 
-- 
1.5.3.1
