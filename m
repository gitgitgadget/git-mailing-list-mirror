From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: create intermediate directories of destination
	repo
Date: Wed, 25 Jun 2008 01:41:34 -0400
Message-ID: <20080625054134.GB2209@sigill.intra.peff.net>
References: <177e83dd0806231251u223717e4s2149f69313787ead@mail.gmail.com> <alpine.LNX.1.00.0806231554380.19665@iabervon.org> <20080623203835.GA8105@sigill.intra.peff.net> <0YbSdnKH0_SP30-YMV0Y1aH4SO46yc6x_2EA1VGwPtV_CltGk-7wdg@cipher.nrlssc.navy.mil> <20080624055022.GC19224@sigill.intra.peff.net> <7v3an3e0xv.fsf@gitster.siamese.dyndns.org> <20080624080437.GA2581@sigill.intra.peff.net> <alpine.LNX.1.00.0806241113360.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Brandon Casey <casey@nrlssc.navy.mil>, zuh@iki.fi,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jun 25 07:42:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBNm5-0007NY-S2
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 07:42:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbYFYFlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2008 01:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754148AbYFYFlh
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 01:41:37 -0400
Received: from peff.net ([208.65.91.99]:1433 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752333AbYFYFlg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 01:41:36 -0400
Received: (qmail 10482 invoked by uid 111); 25 Jun 2008 05:41:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 25 Jun 2008 01:41:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Jun 2008 01:41:34 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.00.0806241113360.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86235>

On Tue, Jun 24, 2008 at 11:20:07AM -0400, Daniel Barkalow wrote:

> > I am worried that it is too clever. I didn't see an obvious way for
> > work_tree and git_dir to not have that property, but I think it is still
> > worth somebody double-checking.
> 
> I think you can specify git_dir and work_tree on the command line, and set 
> them to whatever you want, although I now don't remember whether they're 
> actually both followed for clone (I tried to match the shell version, 
> whose behavior didn't make too much sense to me).

The git_dir variable is always set from the directory provided on the
command line. However, the work_tree can be overridden by the
environment. For some reason I missed the giant 'work_tree =
getenv("GIT_WORK_TREE")' when I looked before. But that means that they
are not necessarily related.

So my original patch was too clever. Here is the less clever patch, with
an extra test that would break with the clever version.

-- >8 --
clone: create intermediate directories of destination repo

The shell version used to use "mkdir -p" to create the repo
path, but the C version just calls "mkdir". Let's replicate
the old behavior. We have to create the git and worktree
leading dirs separately; while most of the time, the
worktree dir contains the git dir (as .git), the user can
override this using GIT_WORK_TREE.

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
 builtin-clone.c           |    5 +++++
 builtin-merge-recursive.c |   13 ++-----------
 cache.h                   |    1 +
 sha1_file.c               |    9 +++++++++
 t/t5601-clone.sh          |   22 ++++++++++++++++++++++
 5 files changed, 39 insertions(+), 11 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 7190952..b2dfe1a 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -400,6 +400,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	if (!option_bare) {
 		junk_work_tree = work_tree;
+		if (safe_create_leading_directories_const(work_tree) < 0)
+			die("could not create leading directories of '%s'",
+					work_tree);
 		if (mkdir(work_tree, 0755))
 			die("could not create work tree dir '%s'.", work_tree);
 		set_git_work_tree(work_tree);
@@ -410,6 +413,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	setenv(CONFIG_ENVIRONMENT, xstrdup(mkpath("%s/config", git_dir)), 1);
 
+	if (safe_create_leading_directories_const(git_dir) < 0)
+		die("could not create leading directories of '%s'", git_dir);
 	set_git_dir(make_absolute_path(git_dir));
 
 	fprintf(stderr, "Initialize %s\n", git_dir);
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
index a68866c..a9c14da 100644
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
index 9330bc4..0d52e59 100644
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
index 593d1a3..b642fb2 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -30,4 +30,26 @@ test_expect_success 'clone checks out files' '
 
 '
 
+test_expect_success 'clone respects GIT_WORK_TREE' '
+
+	GIT_WORK_TREE=worktree git clone src bare &&
+	test -f bare/config &&
+	test -f worktree/file
+
+'
+
+test_expect_success 'clone creates intermediate directories' '
+
+	git clone src long/path/to/dst &&
+	test -f long/path/to/dst/file
+
+'
+
+test_expect_success 'clone creates intermediate directories for bare repo' '
+
+	git clone --bare src long/path/to/bare/dst &&
+	test -f long/path/to/bare/dst/config
+
+'
+
 test_done
-- 
1.5.6.57.g56b3.dirty
