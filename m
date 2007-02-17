From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Teach core.autocrlf to 'git apply'
Date: Sat, 17 Feb 2007 12:37:25 -0800
Message-ID: <7vlkiwsepm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 17 21:37:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIWJG-00011E-6D
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 21:37:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750952AbXBQUh1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 15:37:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750873AbXBQUh1
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 15:37:27 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51023 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750806AbXBQUh0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 15:37:26 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217203727.KCY21704.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 17 Feb 2007 15:37:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QkdR1W00J1kojtg0000000; Sat, 17 Feb 2007 15:37:25 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40012>

This teaches git-apply that the data read from and written to
the filesystem might need to get converted to adjust for local
line-ending convention.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * Comes on top of lt/crlf branch which is part of 'next'.

   One problem that hasn't been solved is that git-apply without
   --index nor --cached does not read the configuration even
   when in a git-controlled working tree.  This is not a new
   issue and needs to be addressed separately.  For now, just to
   make testing easier, I tentatively added GIT_AUTOCRLF
   environment variable as a hack, but it should be removed from
   the real version.

 builtin-apply.c |   37 +++++++++++++++++++++++++++++++------
 t/t0020-crlf.sh |   22 +++++++++++++++++-----
 2 files changed, 48 insertions(+), 11 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index 3fefdac..18f7307 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1393,28 +1393,39 @@ static void show_stats(struct patch *patch)
 	free(qname);
 }
 
-static int read_old_data(struct stat *st, const char *path, void *buf, unsigned long size)
+static int read_old_data(struct stat *st, const char *path, char **buf_p, unsigned long *alloc_p, unsigned long *size_p)
 {
 	int fd;
 	unsigned long got;
+	unsigned long nsize;
+	char *nbuf;
+	unsigned long size = *size_p;
+	char *buf = *buf_p;
 
 	switch (st->st_mode & S_IFMT) {
 	case S_IFLNK:
-		return readlink(path, buf, size);
+		return readlink(path, buf, size) != size;
 	case S_IFREG:
 		fd = open(path, O_RDONLY);
 		if (fd < 0)
 			return error("unable to open %s", path);
 		got = 0;
 		for (;;) {
-			int ret = xread(fd, (char *) buf + got, size - got);
+			int ret = xread(fd, buf + got, size - got);
 			if (ret <= 0)
 				break;
 			got += ret;
 		}
 		close(fd);
-		return got;
-
+		nsize = got;
+		nbuf = buf;
+		if (convert_to_git(path, &nbuf, &nsize)) {
+			free(buf);
+			*buf_p = nbuf;
+			*alloc_p = nsize;
+			*size_p = nsize;
+		}
+		return got != size;
 	default:
 		return -1;
 	}
@@ -1910,7 +1921,7 @@ static int apply_data(struct patch *patch, struct stat *st, struct cache_entry *
 		size = st->st_size;
 		alloc = size + 8192;
 		buf = xmalloc(alloc);
-		if (read_old_data(st, patch->old_name, buf, alloc) != size)
+		if (read_old_data(st, patch->old_name, &buf, &alloc, &size))
 			return error("read of %s failed", patch->old_name);
 	}
 
@@ -2282,12 +2293,22 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 static int try_create_file(const char *path, unsigned int mode, const char *buf, unsigned long size)
 {
 	int fd;
+	char *nbuf;
+	unsigned long nsize;
 
 	if (S_ISLNK(mode))
 		/* Although buf:size is counted string, it also is NUL
 		 * terminated.
 		 */
 		return symlink(buf, path);
+	nsize = size;
+	nbuf = (char *) buf;
+	if (convert_to_working_tree(path, &nbuf, &nsize)) {
+		free((char *) buf);
+		buf = nbuf;
+		size = nsize;
+	}
+
 	fd = open(path, O_CREAT | O_EXCL | O_WRONLY, (mode & 0100) ? 0777 : 0666);
 	if (fd < 0)
 		return -1;
@@ -2598,6 +2619,10 @@ int cmd_apply(int argc, const char **argv, const char *unused_prefix)
 
 	const char *whitespace_option = NULL;
 
+	/* This still is undesirable... */
+	if (getenv("GIT_AUTOCRLF"))
+		git_default_config("core.autocrlf", getenv("GIT_AUTOCRLF"));
+
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		char *end;
diff --git a/t/t0020-crlf.sh b/t/t0020-crlf.sh
index 58a4d86..c64d48c 100755
--- a/t/t0020-crlf.sh
+++ b/t/t0020-crlf.sh
@@ -180,11 +180,9 @@ test_expect_success 'apply patch (autocrlf=true)' '
 	git repo-config core.autocrlf true &&
 	git read-tree --reset -u HEAD &&
 
-	# Sore thumb
-	remove_cr one >tmp && mv -f tmp one &&
-
-	git apply patch.file &&
-	test "$patched" = "`git hash-object --stdin <one`" || {
+	# This is still undesirable...
+	GIT_AUTOCRLF=true git apply patch.file &&
+	test "$patched" = "`remove_cr one | git hash-object --stdin`" || {
 		echo "Eh?  apply without index"
 		false
 	}
@@ -203,4 +201,18 @@ test_expect_success 'apply patch --cached (autocrlf=true)' '
 	}
 '
 
+test_expect_success 'apply patch --index (autocrlf=true)' '
+
+	rm -f tmp one dir/two &&
+	git repo-config core.autocrlf true &&
+	git read-tree --reset -u HEAD &&
+
+	git apply --index patch.file &&
+	test "$patched" = `git rev-parse :one` &&
+	test "$patched" = "`remove_cr one | git hash-object --stdin`" || {
+		echo "Eh?  apply with --index"
+		false
+	}
+'
+
 test_done
