From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 2/2] Make Repository.isValidRefName compatible
	with Git 1.6.3
Date: Thu, 7 May 2009 17:47:41 -0700
Message-ID: <20090508004741.GU30527@spearce.org>
References: <1241708714-20326-1-git-send-email-spearce@spearce.org> <1241708714-20326-2-git-send-email-spearce@spearce.org> <200905080102.44053.robin.rosenberg@dewire.com> <alpine.LFD.2.01.0905071620240.4983@localhost.localdomain> <7vprekbfik.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 08 02:48:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2EG3-00059E-K5
	for gcvg-git-2@gmane.org; Fri, 08 May 2009 02:48:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752278AbZEHArp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 20:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbZEHAro
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 20:47:44 -0400
Received: from george.spearce.org ([209.20.77.23]:39181 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752223AbZEHArl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 20:47:41 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id BD9D1381D0; Fri,  8 May 2009 00:47:41 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <7vprekbfik.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118550>

Junio C Hamano <gitster@pobox.com> wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
> >> 
> >> In 3e262b95c509 I taught C Git to disallow refs whose names end in
> >> ".lock".
> >
> > Btw, I think we should revert that, and instead change our naming for 
> > lock-files.
> 
> '..lck' may be a good name to use here.

I agree.  So much so that I wrote a patch for you.

--8<--
Change .lock suffix to ..lck

In 3e262b95c509 I taught Git to deny creation of refs whose name
ends in ".lock", as the loose ref scanner skips over these under
the assumption that they are refs being modified by a concurrent
process operating on the same repository.

Linus pointed out that the name "fix.vm.lock" is an otherwise
perfectly valid branch name, except the ".lock" suffix conflicts
with the internal implementation detail of how Git manages doing
an atomic update.

Instead, change the name to "..lck", as suggested by Junio.

This uses the same storage space in memory as ".lock", so we can do
a fairly dumb search-replace to make the change, but the ".." prefix
has been forbidden in a ref name for ages, to prevent "a..b" from
being ambiguous as a single ref name, or as the pair "^a b".

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 Documentation/git-check-ref-format.txt   |    2 --
 Documentation/technical/api-lockfile.txt |    4 ++--
 builtin-reflog.c                         |    2 +-
 config.c                                 |    2 +-
 lockfile.c                               |   10 +++++-----
 refs.c                                   |   11 ++++-------
 t/t3505-cherry-pick-empty.sh             |    2 +-
 t/t3600-rm.sh                            |    4 ++--
 t/t4123-apply-shrink.sh                  |    2 +-
 t/t7001-mv.sh                            |    4 ++--
 t/t7502-commit.sh                        |    2 +-
 t/test-lib.sh                            |    6 +++---
 12 files changed, 23 insertions(+), 28 deletions(-)

diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index c1ce268..7c0f0ea 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -34,8 +34,6 @@ imposes the following rules on how references are named:
 
 . They cannot end with a slash `/` nor a dot `.`.
 
-. They cannot end with the sequence `.lock`.
-
 . They cannot contain a sequence `@{`.
 
 These rules make it easy for shell script based tools to parse
diff --git a/Documentation/technical/api-lockfile.txt b/Documentation/technical/api-lockfile.txt
index dd89404..982984f 100644
--- a/Documentation/technical/api-lockfile.txt
+++ b/Documentation/technical/api-lockfile.txt
@@ -4,9 +4,9 @@ lockfile API
 The lockfile API serves two purposes:
 
 * Mutual exclusion.  When we write out a new index file, first
-  we create a new file `$GIT_DIR/index.lock`, write the new
+  we create a new file `$GIT_DIR/index..lck`, write the new
   contents into it, and rename it to the final destination
-  `$GIT_DIR/index`.  We try to create the `$GIT_DIR/index.lock`
+  `$GIT_DIR/index`.  We try to create the `$GIT_DIR/index..lck`
   file with O_EXCL so that we can notice and fail when somebody
   else is already trying to update the index file.
 
diff --git a/builtin-reflog.c b/builtin-reflog.c
index ddfdf5a..19baf07 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -341,7 +341,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
 	if (!file_exists(log_file))
 		goto finish;
 	if (!cmd->dry_run) {
-		newlog_path = git_pathdup("logs/%s.lock", ref);
+		newlog_path = git_pathdup("logs/%s..lck", ref);
 		cb.newlog = fopen(newlog_path, "w");
 	}
 
diff --git a/config.c b/config.c
index 1682273..50ecc1e 100644
--- a/config.c
+++ b/config.c
@@ -925,7 +925,7 @@ int git_config_set(const char *key, const char *value)
  *
  * This function does this:
  *
- * - it locks the config file by creating ".git/config.lock"
+ * - it locks the config file by creating ".git/config..lck"
  *
  * - it then parses the config using store_aux() as validator to find
  *   the position on the key/value pair to replace. If it is to be unset,
diff --git a/lockfile.c b/lockfile.c
index 828d19f..61ff5cb 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -129,11 +129,11 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 	strcpy(lk->filename, path);
 	/*
 	 * subtract 5 from size to make sure there's room for adding
-	 * ".lock" for the lock file name
+	 * "..lck" for the lock file name
 	 */
 	if (!(flags & LOCK_NODEREF))
 		resolve_symlink(lk->filename, sizeof(lk->filename)-5);
-	strcat(lk->filename, ".lock");
+	strcat(lk->filename, "..lck");
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
 	if (0 <= lk->fd) {
 		if (!lock_file_list) {
@@ -159,13 +159,13 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 NORETURN void unable_to_lock_index_die(const char *path, int err)
 {
 	if (err == EEXIST) {
-		die("Unable to create '%s.lock': %s.\n\n"
+		die("Unable to create '%s..lck': %s.\n\n"
 		    "If no other git process is currently running, this probably means a\n"
 		    "git process crashed in this repository earlier. Make sure no other git\n"
 		    "process is running and remove the file manually to continue.",
 		    path, strerror(err));
 	} else {
-		die("Unable to create '%s.lock': %s", path, strerror(err));
+		die("Unable to create '%s..lck': %s", path, strerror(err));
 	}
 }
 
@@ -219,7 +219,7 @@ int commit_lock_file(struct lock_file *lk)
 	if (lk->fd >= 0 && close_lock_file(lk))
 		return -1;
 	strcpy(result_file, lk->filename);
-	i = strlen(result_file) - 5; /* .lock */
+	i = strlen(result_file) - 5; /* ..lck */
 	result_file[i] = 0;
 	if (rename(lk->filename, result_file))
 		return -1;
diff --git a/refs.c b/refs.c
index e65a3b4..b4ca305 100644
--- a/refs.c
+++ b/refs.c
@@ -266,7 +266,7 @@ static struct ref_list *get_ref_dir(const char *base, struct ref_list *list)
 			namelen = strlen(de->d_name);
 			if (namelen > 255)
 				continue;
-			if (has_extension(de->d_name, ".lock"))
+			if (has_extension(de->d_name, "..lck"))
 				continue;
 			memcpy(ref + baselen, de->d_name, namelen+1);
 			if (stat(git_path("%s", ref), &st) < 0)
@@ -681,7 +681,6 @@ int for_each_rawref(each_ref_fn fn, void *cb_data)
  * - it has double dots "..", or
  * - it has ASCII control character, "~", "^", ":" or SP, anywhere, or
  * - it ends with a "/".
- * - it ends with ".lock"
  */
 
 static inline int bad_ref_char(int ch)
@@ -743,8 +742,6 @@ int check_ref_format(const char *ref)
 				return CHECK_REF_FORMAT_ERROR;
 			if (level < 2)
 				return CHECK_REF_FORMAT_ONELEVEL;
-			if (has_extension(ref, ".lock"))
-				return CHECK_REF_FORMAT_ERROR;
 			return ret;
 		}
 	}
@@ -996,7 +993,7 @@ int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
 		const char *path;
 
 		if (!(delopt & REF_NODEREF)) {
-			i = strlen(lock->lk->filename) - 5; /* .lock */
+			i = strlen(lock->lk->filename) - 5; /* ..lck */
 			lock->lk->filename[i] = 0;
 			path = lock->lk->filename;
 		} else {
@@ -1363,7 +1360,7 @@ int create_symref(const char *ref_target, const char *refs_heads_master,
 		error("refname too long: %s", refs_heads_master);
 		goto error_free_return;
 	}
-	lockpath = mkpath("%s.lock", git_HEAD);
+	lockpath = mkpath("%s..lck", git_HEAD);
 	fd = open(lockpath, O_CREAT | O_EXCL | O_WRONLY, 0666);
 	if (fd < 0) {
 		error("Unable to open %s for writing", lockpath);
@@ -1593,7 +1590,7 @@ static int do_for_each_reflog(const char *base, each_ref_fn fn, void *cb_data)
 			namelen = strlen(de->d_name);
 			if (namelen > 255)
 				continue;
-			if (has_extension(de->d_name, ".lock"))
+			if (has_extension(de->d_name, "..lck"))
 				continue;
 			memcpy(log + baselen, de->d_name, namelen+1);
 			if (stat(git_path("logs/%s", log), &st) < 0)
diff --git a/t/t3505-cherry-pick-empty.sh b/t/t3505-cherry-pick-empty.sh
index 9aaeabd..3b7aa6d 100755
--- a/t/t3505-cherry-pick-empty.sh
+++ b/t/t3505-cherry-pick-empty.sh
@@ -26,7 +26,7 @@ test_expect_code 1 'cherry-pick an empty commit' '
 
 test_expect_success 'index lockfile was removed' '
 
-	test ! -f .git/index.lock
+	test ! -f .git/index..lck
 
 '
 
diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 76b1bb4..e437cf7 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -264,9 +264,9 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
 	    i=$(( $i + 1 ))
 	done | git update-index --index-info &&
 	git rm -n "some-file-*" | :;
-	test -f .git/index.lock
+	test -f .git/index..lck
 	status=$?
-	rm -f .git/index.lock
+	rm -f .git/index..lck
 	git reset -q --hard
 	test "$status" != 0
 '
diff --git a/t/t4123-apply-shrink.sh b/t/t4123-apply-shrink.sh
index 984157f..fcd6a67 100755
--- a/t/t4123-apply-shrink.sh
+++ b/t/t4123-apply-shrink.sh
@@ -47,7 +47,7 @@ test_expect_success 'apply should fail gracefully' '
 	else
 		status=$?
 		echo "Status was $status"
-		if test -f .git/index.lock
+		if test -f .git/index..lck
 		then
 			echo Oops, should not have crashed
 			false
diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 10b8f8c..afe8240 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -62,14 +62,14 @@ test_expect_success \
     'checking -f on untracked file with existing target' \
     'touch path0/untracked1 &&
      git mv -f untracked1 path0
-     test ! -f .git/index.lock &&
+     test ! -f .git/index..lck &&
      test -f untracked1 &&
      test -f path0/untracked1'
 
 # clean up the mess in case bad things happen
 rm -f idontexist untracked1 untracked2 \
      path0/idontexist path0/untracked1 path0/untracked2 \
-     .git/index.lock
+     .git/index..lck
 
 test_expect_success \
     'adding another file' \
diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index 56cd866..100da27 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -241,7 +241,7 @@ test_expect_success EXECKEEPSPID 'a SIGTERM should break locks' '
 	  GIT_EDITOR=.git/FAKE_EDITOR
 	  export GIT_EDITOR
 	  exec git commit -a'\'' &&
-	test ! -f .git/index.lock
+	test ! -f .git/index..lck
 '
 
 rm -f .git/MERGE_MSG .git/COMMIT_EDITMSG
diff --git a/t/test-lib.sh b/t/test-lib.sh
index dad1437..ecce338 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -558,13 +558,13 @@ else
 		test -h "$2" &&
 		test "$1" = "$(readlink "$2")" || {
 			# be super paranoid
-			if mkdir "$2".lock
+			if mkdir "$2"..lck
 			then
 				rm -f "$2" &&
 				ln -s "$1" "$2" &&
-				rm -r "$2".lock
+				rm -r "$2"..lck
 			else
-				while test -d "$2".lock
+				while test -d "$2"..lck
 				do
 					say "Waiting for lock on $2."
 					sleep 1
-- 
1.6.3.195.gad81


-- 
Shawn.
