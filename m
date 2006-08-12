From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Better error message when we are unable to lock the index file
Date: Sat, 12 Aug 2006 01:03:47 -0700
Message-ID: <7v8xluqt24.fsf@assigned-by-dhcp.cox.net>
References: <20060812073756.5442.5498.stgit@c165>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 12 10:04:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GBoTx-0007Gj-UL
	for gcvg-git@gmane.org; Sat, 12 Aug 2006 10:04:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWHLIET (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Aug 2006 04:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbWHLIDt
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Aug 2006 04:03:49 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:14731 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750984AbWHLIDs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Aug 2006 04:03:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060812080348.SKLN6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Aug 2006 04:03:48 -0400
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20060812073756.5442.5498.stgit@c165> (Fredrik Kuivinen's message
	of "Sat, 12 Aug 2006 09:37:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25254>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> diff --git a/builtin-update-index.c b/builtin-update-index.c
> index 24dca47..f8f5e10 100644
> --- a/builtin-update-index.c
> +++ b/builtin-update-index.c
> @@ -493,7 +493,7 @@ int cmd_update_index(int argc, const cha
>  
>  	newfd = hold_lock_file_for_update(lock_file, get_index_file());
>  	if (newfd < 0)
> -		die("unable to create new cachefile");
> +		die("unable to lock index file: %s", strerror(errno));

Looking at output from:

	$ git grep -A 3 hold_lock_file_for_update

I wonder if it might be more consistent to do something like
this instead.  It removes more lines than it adds ;-).

Most of the callers except the one in refs.c use the function to
update the index file.  Among the index writers, everybody
except write-tree dies if they cannot open it for writing.

---

 builtin-add.c          |    4 +---
 builtin-apply.c        |    7 ++-----
 builtin-mv.c           |    5 +----
 builtin-read-tree.c    |    4 +---
 builtin-rm.c           |    4 +---
 builtin-update-index.c |    4 +---
 builtin-write-tree.c   |    2 +-
 cache.h                |    2 +-
 lockfile.c             |   10 +++++++++-
 refs.c                 |    2 +-
 10 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/builtin-add.c b/builtin-add.c
index 096b611..0cb9c81 100644
--- a/builtin-add.c
+++ b/builtin-add.c
@@ -93,9 +93,7 @@ int cmd_add(int argc, const char **argv,
 
 	git_config(git_default_config);
 
-	newfd = hold_lock_file_for_update(&lock_file, get_index_file());
-	if (newfd < 0)
-		die("unable to create new index file");
+	newfd = hold_lock_file_for_update(&lock_file, get_index_file(), 1);
 
 	if (read_cache() < 0)
 		die("index file corrupt");
diff --git a/builtin-apply.c b/builtin-apply.c
index be2c715..9cf477c 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2234,12 +2234,9 @@ static int apply_patch(int fd, const cha
 		apply = 0;
 
 	write_index = check_index && apply;
-	if (write_index && newfd < 0) {
+	if (write_index && newfd < 0)
 		newfd = hold_lock_file_for_update(&lock_file,
-						  get_index_file());
-		if (newfd < 0)
-			die("unable to create new index file");
-	}
+						  get_index_file(), 1);
 	if (check_index) {
 		if (read_cache() < 0)
 			die("unable to read index file");
diff --git a/builtin-mv.c b/builtin-mv.c
index ce8187c..a731f8d 100644
--- a/builtin-mv.c
+++ b/builtin-mv.c
@@ -72,10 +72,7 @@ int cmd_mv(int argc, const char **argv, 
 
 	git_config(git_default_config);
 
-	newfd = hold_lock_file_for_update(&lock_file, get_index_file());
-	if (newfd < 0)
-		die("unable to create new index file");
-
+	newfd = hold_lock_file_for_update(&lock_file, get_index_file(), 1);
 	if (read_cache() < 0)
 		die("index file corrupt");
 
diff --git a/builtin-read-tree.c b/builtin-read-tree.c
index b30160a..71a7026 100644
--- a/builtin-read-tree.c
+++ b/builtin-read-tree.c
@@ -884,9 +884,7 @@ int cmd_read_tree(int argc, const char *
 
 	git_config(git_default_config);
 
-	newfd = hold_lock_file_for_update(&lock_file, get_index_file());
-	if (newfd < 0)
-		die("unable to create new index file");
+	newfd = hold_lock_file_for_update(&lock_file, get_index_file(), 1);
 
 	git_config(git_default_config);
 
diff --git a/builtin-rm.c b/builtin-rm.c
index 8af3d7e..593d867 100644
--- a/builtin-rm.c
+++ b/builtin-rm.c
@@ -52,9 +52,7 @@ int cmd_rm(int argc, const char **argv, 
 
 	git_config(git_default_config);
 
-	newfd = hold_lock_file_for_update(&lock_file, get_index_file());
-	if (newfd < 0)
-		die("unable to create new index file");
+	newfd = hold_lock_file_for_update(&lock_file, get_index_file(), 1);
 
 	if (read_cache() < 0)
 		die("index file corrupt");
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 24dca47..d2556f3 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -491,9 +491,7 @@ int cmd_update_index(int argc, const cha
 	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
 	lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	newfd = hold_lock_file_for_update(lock_file, get_index_file());
-	if (newfd < 0)
-		die("unable to create new cachefile");
+	newfd = hold_lock_file_for_update(lock_file, get_index_file(), 1);
 
 	entries = read_cache();
 	if (entries < 0)
diff --git a/builtin-write-tree.c b/builtin-write-tree.c
index 6b62d7d..ca06149 100644
--- a/builtin-write-tree.c
+++ b/builtin-write-tree.c
@@ -18,7 +18,7 @@ int write_tree(unsigned char *sha1, int 
 	/* We can't free this memory, it becomes part of a linked list parsed atexit() */
 	struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 
-	newfd = hold_lock_file_for_update(lock_file, get_index_file());
+	newfd = hold_lock_file_for_update(lock_file, get_index_file(), 0);
 
 	entries = read_cache();
 	if (entries < 0)
diff --git a/cache.h b/cache.h
index b8c21e0..b2ab208 100644
--- a/cache.h
+++ b/cache.h
@@ -175,7 +175,7 @@ struct lock_file {
 	struct lock_file *next;
 	char filename[PATH_MAX];
 };
-extern int hold_lock_file_for_update(struct lock_file *, const char *path);
+extern int hold_lock_file_for_update(struct lock_file *, const char *path, int);
 extern int commit_lock_file(struct lock_file *);
 extern void rollback_lock_file(struct lock_file *);
 
diff --git a/lockfile.c b/lockfile.c
index 2346e0e..a5ea49b 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -22,7 +22,7 @@ static void remove_lock_file_on_signal(i
 	raise(signo);
 }
 
-int hold_lock_file_for_update(struct lock_file *lk, const char *path)
+static int lock_file(struct lock_file *lk, const char *path)
 {
 	int fd;
 	sprintf(lk->filename, "%s.lock", path);
@@ -41,6 +41,14 @@ int hold_lock_file_for_update(struct loc
 	return fd;
 }
 
+int hold_lock_file_for_update(struct lock_file *lk, const char *path, int die_on_error)
+{
+	int fd = lock_file(lk, path);
+	if (fd < 0 && die_on_error)
+		die("unable to create new index file");
+	return fd;
+}
+
 int commit_lock_file(struct lock_file *lk)
 {
 	char result_file[PATH_MAX];
diff --git a/refs.c b/refs.c
index 28a9394..564f8a7 100644
--- a/refs.c
+++ b/refs.c
@@ -319,7 +319,7 @@ static struct ref_lock *lock_ref_sha1_ba
 
 	if (safe_create_leading_directories(lock->ref_file))
 		die("unable to create directory for %s", lock->ref_file);
-	lock->lock_fd = hold_lock_file_for_update(lock->lk, lock->ref_file);
+	lock->lock_fd = hold_lock_file_for_update(lock->lk, lock->ref_file, 0);
 	if (lock->lock_fd < 0) {
 		error("Couldn't open lock file %s: %s",
 		      lock->lk->filename, strerror(errno));
