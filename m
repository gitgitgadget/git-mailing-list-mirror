From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Introduce "reset type" flag to "git reset"
Date: Mon, 22 Aug 2005 18:07:30 -0700
Message-ID: <7vu0hhzcj1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Tue Aug 23 03:09:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7NGL-0006mY-JY
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 03:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751312AbVHWBHd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 21:07:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751315AbVHWBHd
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 21:07:33 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:45800 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751312AbVHWBHc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2005 21:07:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050823010730.EADG550.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 22 Aug 2005 21:07:30 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have been feeling that the current behaviour of "git reset" is
not quite optimal, but so far could not express exactly what I
felt was wrong with it.  This patch clarifies it.

There are at least two situations you may want to "reset" your
working tree.

1. You made a mess in your working tree.  You want to switch
   back to a known good state and start over.  This mess may be
   a result of your own editing, a merge that had too many
   conflicting changes that you do not feel like to resolve by
   hand at this moment, or a botched application of a patch you
   received from somewhere.

   In this case, you would want to have "git reset HEAD" reset
   the index file to the tree read from the HEAD commit and the
   files in the working tree to match index (i.e. "git status"
   should say "Nothing to commit", without any "unrecorded
   changes").

   The current behaviour leaves the files in the working tree
   intact, which requires you to run "git checkout -f".  Also
   you need to remember "rm -f" any files that the botched patch
   may have left in the working tree if the purpose of this
   "reset" is to attempt to apply it again; most likely the
   patch would fail if such a file is left behind.

2. You have discovered that commits you made earlier need to be
   reorganized.  The simplest example is to undo the last
   commit, re-edit some files, and redo the commit.  Another
   simple eample is to undo the last two commits, and commit the
   changes in those two commits as a single commit.

   In this case, you would want to have "git reset HEAD^" reset
   the $GIT_DIR/HEAD to the commit object name of the parent
   commit of the current commit (i.e. rewinding one commit),
   leave the index file and the files in the working tree in a
   state where you can easily make a commit that records a tree
   that resembles what you have in the current index file and
   the working tree.

   The current behaviour is almost OK for this purpose, except
   that you need to find which files you need to manually run
   "git add" yourself.  They are files that are in the original
   HEAD commit and not in the commit you are resetting to.

The default without the type flag is to do "--mixed", which is
the current behaviour.

    $ git reset [ --hard | --soft | --mixed ] [ <commit-ish> ]

A hard reset would be used for 1 and works in this way:

    (1) remember the set of paths that appear in the current
        index file (which may even have unmerged entries) and
	the current $GIT_DIR/HEAD commit.

    (2) "read-tree --reset" the specified <commit-ish> (default
        to HEAD), followed by "checkout-cache -f -u -a".

    (3) remove any files that appear in (1) but not in
        <commit-ish> from the working tree.

    (4) backup $GIT_DIR/HEAD to $GIT_DIR/ORIG_HEAD and update
        $GIT_DIR/HEAD with the specified <commit-ish>.

    (5) remove leftover $GIT_DIR/MERGE_HEAD

A soft reset would be used for 2 and works in this way:

    (1) Make sure that the index file is merged and we do not
        have MERGE_HEAD; otherwise it does not make sense to do
        soft reset.

    (2) backup $GIT_DIR/HEAD to $GIT_DIR/ORIG_HEAD and update
        $GIT_DIR/HEAD with the specified <commit-ish>.

Note that with the current behaviour, "git diff" is the way to
see what could be committed immediately after "git reset".  With
the "soft reset" described here you would need to say "git diff
HEAD" to find that out.

I am not sure what mixed reset (the current behaviour) is good
for.  If nobody comes up with a good use case it may not be a
bad idea to remove it.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 git-reset-script |   96 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 90 insertions(+), 6 deletions(-)

c0e136c6ab8481fb4927f033bb7da105b7417207
diff --git a/git-reset-script b/git-reset-script
--- a/git-reset-script
+++ b/git-reset-script
@@ -1,13 +1,97 @@
 #!/bin/sh
 . git-sh-setup-script || die "Not a git archive"
+
+tmp=/var/tmp/reset.$$
+trap 'rm -f $tmp-*' 0 1 2 3 15
+
+reset_type=--mixed
+case "$1" in
+--mixed | --soft | --hard)
+	reset_type="$1"
+	shift
+	;;
+esac
+
 rev=$(git-rev-parse --verify --default HEAD "$@") || exit
 rev=$(git-rev-parse --verify $rev^0) || exit
-git-read-tree --reset "$rev" && {
-	if orig=$(git-rev-parse --verify HEAD 2>/dev/null)
+
+# We need to remember the set of paths that _could_ be left
+# behind before a hard reset, so that we can remove them.
+if test "$reset_type" = "--hard"
+then
+	{
+		git-ls-files --stage -z
+		git-rev-parse --verify HEAD 2>/dev/null &&
+		git-ls-tree -r -z HEAD
+	} | perl -e '
+	    use strict;
+	    my %seen;
+	    $/ = "\0";
+	    while (<>) {
+		chomp;
+		my ($info, $path) = split(/\t/, $_);
+		next if ($info =~ / tree /);
+		if (!$seen{$path}) {
+			$seen{$path} = 1;
+			print "$path\0";
+		}
+	    }
+	' >$tmp-exists
+fi
+
+# Soft reset does not touch the index file nor the working tree
+# at all, but requires them in a good order.  Other resets reset
+# the index file to the tree object we are switching to.
+if test "$reset_type" = "--soft"
+then
+	if test -f "$GIT_DIR/MERGE_HEAD" ||
+	   test "" != "$(git-ls-files --unmerged)"
 	then
-		echo "$orig" >"$GIT_DIR/ORIG_HEAD"
+		die "Cannot do a soft reset in the middle of a merge."
 	fi
-	echo "$rev" > "$GIT_DIR/HEAD"
-}
-git-update-cache --refresh
+else
+	git-read-tree --reset "$rev" || exit
+fi
+
+# Any resets update HEAD to the head being switched to.
+if orig=$(git-rev-parse --verify HEAD 2>/dev/null)
+then
+	echo "$orig" >"$GIT_DIR/ORIG_HEAD"
+else
+	rm -f "$GIT_DIR/ORIG_HEAD"
+fi
+echo "$rev" >"$GIT_DIR/HEAD"
+
+case "$reset_type" in
+--hard )
+	# Hard reset matches the working tree to that of the tree
+	# being switched to.
+	git-checkout-cache -f -u -q -a
+	git-ls-files --cached -z |
+	perl -e '
+		use strict;
+		my (%keep, $fh);
+		$/ = "\0";
+		while (<STDIN>) {
+			chomp;
+			$keep{$_} = 1;
+		}
+		open $fh, "<", $ARGV[0]
+			or die "cannot open $ARGV[0]";
+		while (<$fh>) {
+			chomp;
+			if (! exists $keep{$_}) {
+				print "$_\0";
+			}
+		}
+	' $tmp-exists | xargs -0 rm -v -f --
+	;;
+--soft )
+	;; # Nothing else to do
+--mixed )
+	# Report what has not been updated.
+	git-update-cache --refresh
+	;;
+esac
+
 rm -f "$GIT_DIR/MERGE_HEAD"
