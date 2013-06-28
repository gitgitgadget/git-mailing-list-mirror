From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] git stash: Avoid data loss when saving a stash
Date: Fri, 28 Jun 2013 17:05:32 +0200
Message-ID: <20130628150532.GD12252@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 28 17:05:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsaF5-0004gs-JT
	for gcvg-git-2@plane.gmane.org; Fri, 28 Jun 2013 17:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754017Ab3F1PFj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Jun 2013 11:05:39 -0400
Received: from pasky.or.cz ([84.242.80.195]:49241 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519Ab3F1PFi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Jun 2013 11:05:38 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id BE86A1700058; Fri, 28 Jun 2013 17:05:32 +0200 (CEST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229208>

I have been recently again bitten by git stash versus an uncommitted
file-to-directory change that happily threw away few gigabytes of my
data. This has been recently discussed in the past, e.g.

	http://thread.gmane.org/gmane.comp.version-control.git/202332/

and I implemented Junio's suggestion in this patch - if ls-files --killed
produced any output, the stash save is stopped and the user is required
to pass --force to really have the data removed.

A test case is included. I think that the (currently failing) tests
'stash file to directory' and 'stash directory to file' are related to
this, but I consider their expectation to be bogus - I would personally
be surprised by `git stash` suddenly importing the complete
never-meant-to-be-tracked contents of my directory to Git during a stash
save, and I think the approach of aborting in this situation is more
reasonable.

Other parts of Git also behave in a troublesome way in case of tracked
file being replaced by an untracked directory - I wouldn't expect `git
reset --hard` alone to remove the directory (i.e. touch untracked files)
either. However, this matter is much more complicated since `git reset
--hard` is assumed to "never fail in ordinary circumstances" (see e.g.
git-stash code ;-) and I'm unable to devote sufficient effort to seeing
such a change through.

Signed-off-by: Petr Baudis <pasky@ucw.cz>
---

Please Cc me, I'm currently not subscribed on the list.

 Documentation/git-stash.txt |   12 ++++++++++--
 git-stash.sh                |   10 ++++++++++
 t/t3903-stash.sh            |   16 ++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index db7e803..52d4def 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -14,7 +14,8 @@ SYNOPSIS
 'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
 'git stash' branch <branchname> [<stash>]
 'git stash' [save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
-	     [-u|--include-untracked] [-a|--all] [<message>]]
+	     [-u|--include-untracked] [-a|--all] [-f|--force]
+	     [<message>]]
 'git stash' clear
 'git stash' create [<message>]
 'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
@@ -44,7 +45,7 @@ is also possible).
 OPTIONS
 -------
 
-save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
+save [-p|--patch] [--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [-f|--force] [<message>]::
 
 	Save your local modifications to a new 'stash', and run `git reset
 	--hard` to revert them.  The <message> part is optional and gives
@@ -71,6 +72,13 @@ linkgit:git-add[1] to learn how to operate the `--patch` mode.
 +
 The `--patch` option implies `--keep-index`.  You can use
 `--no-keep-index` to override this.
++
+In some cases, saving a stash could mean irretrievably removing some
+data - if a directory with untracked files replaces a tracked file of
+the same name, the new untracked files are not saved (except in case
+of `--include-untracked`) but the original tracked file shall be restored.
+Normally, stash save will abort; `--force` will make it remove the
+untracked files.
 
 list [<options>]::
 
diff --git a/git-stash.sh b/git-stash.sh
index 1e541a2..3cb9b05 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -195,6 +195,7 @@ save_stash () {
 	keep_index=
 	patch_mode=
 	untracked=
+	force=
 	while test $# != 0
 	do
 		case "$1" in
@@ -215,6 +216,9 @@ save_stash () {
 		-u|--include-untracked)
 			untracked=untracked
 			;;
+		-f|--force)
+			force=t
+			;;
 		-a|--all)
 			untracked=all
 			;;
@@ -258,6 +262,12 @@ save_stash () {
 		say "$(gettext "No local changes to save")"
 		exit 0
 	fi
+	if test -z "$untracked$force" -a -n "$(git ls-files --killed | head -n 1)"; then
+		say "$(gettext "The following untracked files would NOT be saved but need to be removed by stash save:")"
+		test -n "$GIT_QUIET" || git ls-files --killed | sed 's/^/\t/'
+		say "$(gettext "Abording. Consider using either the --force or --include-untracked switches.")" >&2
+		exit 1
+	fi
 	test -f "$GIT_DIR/logs/$ref_stash" ||
 		clear_stash || die "$(gettext "Cannot initialize stash")"
 
diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index debda7a..4ac4ebe 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -673,4 +673,19 @@ test_expect_success 'store updates stash ref and reflog' '
 	grep quux bazzy
 '
 
+test_expect_success SYMLINKS 'stash symlink to non-empty directory' '
+	git reset --hard &&
+	ln -s file2 linkdir &&
+	git add linkdir &&
+	git commit -m"+linkdir as symlink" &&
+	rm linkdir && mkdir linkdir && touch linkdir/file &&
+	! git stash save "symlink to non-empty directory" &&
+	[ -e linkdir/file ]
+'
+
+test_expect_success SYMLINKS 'stash symlink to non-empty directory (forced)' '
+	git stash save --force "symlink to non-empty directory (forced)" &&
+	[ ! -e linkdir/file ] && [ -L linkdir ]
+'
+
 test_done
-- 
1.7.10.4
