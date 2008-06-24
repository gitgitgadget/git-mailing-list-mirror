From: Jeff King <peff@peff.net>
Subject: [PATCH] clone: create intermediate directories of destination repo
Date: Tue, 24 Jun 2008 01:50:22 -0400
Message-ID: <20080624055022.GC19224@sigill.intra.peff.net>
References: <177e83dd0806231251u223717e4s2149f69313787ead@mail.gmail.com> <alpine.LNX.1.00.0806231554380.19665@iabervon.org> <20080623203835.GA8105@sigill.intra.peff.net> <0YbSdnKH0_SP30-YMV0Y1aH4SO46yc6x_2EA1VGwPtV_CltGk-7wdg@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Daniel Barkalow <barkalow@iabervon.org>, zuh@iki.fi,
	git@vger.kernel.org
To: Brandon Casey <casey@nrlssc.navy.mil>
X-From: git-owner@vger.kernel.org Tue Jun 24 07:51:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB1RF-0005cm-Q6
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 07:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbYFXFu1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 01:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbYFXFu0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 01:50:26 -0400
Received: from peff.net ([208.65.91.99]:4301 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145AbYFXFuZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 01:50:25 -0400
Received: (qmail 32737 invoked by uid 111); 24 Jun 2008 05:50:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 01:50:23 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2008 01:50:22 -0400
Content-Disposition: inline
In-Reply-To: <0YbSdnKH0_SP30-YMV0Y1aH4SO46yc6x_2EA1VGwPtV_CltGk-7wdg@cipher.nrlssc.navy.mil>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85996>

The shell version used to use "mkdir -p" to create the repo
path, but the C version just calls "mkdir". Let's replicate
the old behavior. In this case we can simply create the
directories leading up to the git dir. If it's a bare repo,
then that is everything that init_db wants ahead of time. If
it isn't bare, then the worktree contains the git dir, so we
create the worktree.

We can reuse safe_create_leading_directories, but we need to
make a copy of our const buffer to do so. Since
merge-recursive uses the same pattern, we can factor this
out into a global function. This has two other cleanup
advantages for merge-recursive:

  1. mkdir_p wasn't a very good name. "mkdir -p foo/bar" actually
     creates bar, but this function just creates the leading
     directories.

  2. mkdir_p took a mode argument, but it was completely
     ignored.
---
On Mon, Jun 23, 2008 at 04:03:47PM -0500, Brandon Casey wrote:

> There is a mkdir_p() in builtin-merge-recursive.c which calls
> safe_create_leading_directories() in sha1_file.c
> 
> Can these functions be reused?

Thanks, I hadn't noticed those for some reason. This version uses the
existing code, and correctly handles both the bare and worktree cases.

The big difference is that safe_create_leading_directories will do an
adjust_shared_perm on the result. I don't think that should be a
problem, but it is a difference.

 builtin-clone.c           |    5 +++--
 builtin-merge-recursive.c |   13 ++-----------
 cache.h                   |    1 +
 sha1_file.c               |    9 +++++++++
 t/t5601-clone.sh          |   14 ++++++++++++++
 5 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 7190952..e951911 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -398,10 +398,11 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		git_dir = xstrdup(mkpath("%s/.git", dir));
 	}
 
+	if (safe_create_leading_directories_const(git_dir) < 0)
+		die("could not create leading directories of '%s'", git_dir);
+
 	if (!option_bare) {
 		junk_work_tree = work_tree;
-		if (mkdir(work_tree, 0755))
-			die("could not create work tree dir '%s'.", work_tree);
 		set_git_work_tree(work_tree);
 	}
 	junk_git_dir = git_dir;
diff --git a/builtin-merge-recursive.c b/builtin-merge-recursive.c
index 4aa28a1..43bf6aa 100644
--- a/builtin-merge-recursive.c
+++ b/builtin-merge-recursive.c
@@ -481,15 +481,6 @@ static char *unique_path(const char *path, const char *branch)
 	return newpath;
 }
 
-static int mkdir_p(const char *path, unsigned long mode)
-{
-	/* path points to cache entries, so xstrdup before messing with it */
-	char *buf = xstrdup(path);
-	int result = safe_create_leading_directories(buf);
-	free(buf);
-	return result;
-}
-
 static void flush_buffer(int fd, const char *buf, unsigned long size)
 {
 	while (size > 0) {
@@ -512,7 +503,7 @@ static int make_room_for_path(const char *path)
 	int status;
 	const char *msg = "failed to create path '%s'%s";
 
-	status = mkdir_p(path, 0777);
+	status = safe_create_leading_directories_const(path);
 	if (status) {
 		if (status == -3) {
 			/* something else exists */
@@ -583,7 +574,7 @@ static void update_file_flags(const unsigned char *sha,
 			close(fd);
 		} else if (S_ISLNK(mode)) {
 			char *lnk = xmemdupz(buf, size);
-			mkdir_p(path, 0777);
+			safe_create_leading_directories_const(path);
 			unlink(path);
 			symlink(lnk, path);
 			free(lnk);
diff --git a/cache.h b/cache.h
index d12ee7d..49f20dd 100644
--- a/cache.h
+++ b/cache.h
@@ -517,6 +517,7 @@ enum sharedrepo {
 int git_config_perm(const char *var, const char *value);
 int adjust_shared_perm(const char *path);
 int safe_create_leading_directories(char *path);
+int safe_create_leading_directories_const(const char *path);
 char *enter_repo(char *path, int strict);
 static inline int is_absolute_path(const char *path)
 {
diff --git a/sha1_file.c b/sha1_file.c
index 191f814..71be0c9 100644
--- a/sha1_file.c
+++ b/sha1_file.c
@@ -116,6 +116,15 @@ int safe_create_leading_directories(char *path)
 	return 0;
 }
 
+int safe_create_leading_directories_const(const char *path)
+{
+	/* path points to cache entries, so xstrdup before messing with it */
+	char *buf = xstrdup(path);
+	int result = safe_create_leading_directories(buf);
+	free(buf);
+	return result;
+}
+
 char *sha1_to_hex(const unsigned char *sha1)
 {
 	static int bufno;
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 593d1a3..c2c83f0 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -30,4 +30,18 @@ test_expect_success 'clone checks out files' '
 
 '
 
+test_expect_success 'clone creates intermediate directories (non-bare)' '
+
+	git clone src long/path/to/dst &&
+	test -f long/path/to/dst/file
+
+'
+
+test_expect_success 'clone creates intermediate directories (bare)' '
+
+	git clone --bare src long/path/to/bare/dst &&
+	test -f long/path/to/bare/dst/config
+
+'
+
 test_done
-- 
1.5.6.50.gae760.dirty
