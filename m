From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v3] contrib git-resurrect: find traces of a branch name and resurrect it
Date: Sun,  1 Feb 2009 22:34:44 +0100
Message-ID: <1233524085-25342-1-git-send-email-trast@student.ethz.ch>
References: <7vwschz2dc.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
To: Junio C Hamano <junio@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 22:36:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTjzB-0006Ql-VW
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 22:36:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752612AbZBAVes (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 16:34:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752531AbZBAVes
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 16:34:48 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:21146 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752391AbZBAVer (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 16:34:47 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Feb 2009 22:34:45 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 1 Feb 2009 22:34:45 +0100
X-Mailer: git-send-email 1.6.1.2.495.g43b51
In-Reply-To: <7vwschz2dc.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 01 Feb 2009 21:34:45.0797 (UTC) FILETIME=[E6CD6550:01C984B4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108009>

Add a tool 'git-resurrect.sh <branch>' that tries to find traces of
the <branch> in the HEAD reflog and, optionally, all merge commits in
the repository.  It can then resurrect the branch, pointing it at the
most recent of all candidate commits found.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Junio C Hamano wrote:
> I hate to paint bikeshed, but -H "try-hard" looks somewhat unusual doesn't
> it?  It sounds more like --all (find from all possible sources).

Why not.  I had '-h' but then found out the hard way that it's
reserved...

> > +search_reflog_merges () {
> > +        sed -n 's~^[^ ]* \([^ ]*\) .*\tmerge '"$1"':~\1~p' \
> > +                < .git/logs/HEAD
> > +}
> 
> The two commits both point at the HEAD that merges the other branch into,
> so this finds a merge commit that has the tip of target branch as its
> second parent.  Is that really what you want?

Good point.  Furthermore the sed expression was broken, it would not
remove the remainder of the line.  Sadly it's not possible to insert
the reflog message and sha1 via --pretty=format, so I now use
rev-parse.

> Reading everything down to the root commit sounds like fun.  rev-list
> gives you the output from newer to older so you may want to break out once
> you have found enough candidates.
> 
> Anyway, if I were doing this script, I'd write this part like this without
> a shell loop:
> 
>         _x40="[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]"
>         _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
> 
> 	git rev-list --all --grep="Merge branch '$1'" \
>         	--pretty=tformat:"%H %P %s" |
> 	sed -ne "s/^$_x40 $_x40 \($_x40\) Merge .*/\1/p"

Nice trick.  The same also works for scan_merge_targets() and gives it
a nice speed boost too.  Unfortunately my sed-fu is not good enough to
figure out how to only print the first line (for resurrections from
pu, we expect there to be a single match).  All uses of 'q' I could
come up with resulted in an early exit independent of the
substitutions.  Appending '| head -n 1' does not seem to make any
difference either.

I also added the relative committer time to the candidate list, and
made it sort according to time; it seems somewhat more readable now.


 contrib/git-resurrect.sh |  172 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 172 insertions(+), 0 deletions(-)
 create mode 100755 contrib/git-resurrect.sh

diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
new file mode 100755
index 0000000..3a040ae
--- /dev/null
+++ b/contrib/git-resurrect.sh
@@ -0,0 +1,172 @@
+#!/bin/sh
+
+USAGE="[-a] [-r] [-m] [-t] [-n] [-b <newname>] <name>"
+LONG_USAGE="git-resurrect attempts to find traces of a branch tip
+called <name>, and tries to resurrect it.  Currently, the reflog is
+searched for checkout messages, and with -r also merge messages.  With
+-m and -t, the history of all refs is scanned for Merge <name> into
+other/Merge <other> into <name> (respectively) commit subjects, which
+is rather slow but allows you to resurrect other people's topic
+branches."
+
+OPTIONS_SPEC="\
+git resurrect $USAGE
+--
+b,branch=            save branch as <newname> instead of <name>
+a,all                same as -l -r -m -t
+l,reflog             scan reflog for checkouts (enabled by default)
+r,reflog-merges      scan for merges recorded in reflog
+m,merges             scan for merges into other branches (slow)
+t,merge-targets      scan for merges of other branches into <name>
+n,dry-run            don't recreate the branch"
+
+. git-sh-setup
+
+search_reflog () {
+        sed -ne 's~^\([^ ]*\) .*\tcheckout: moving from '"$1"' .*~\1~p' \
+                < "$GIT_DIR"/logs/HEAD
+}
+
+search_reflog_merges () {
+	git rev-parse $(
+		sed -ne 's~^[^ ]* \([^ ]*\) .*\tmerge '"$1"':.*~\1^2~p' \
+			< "$GIT_DIR"/logs/HEAD
+	)
+}
+
+_x40="[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]"
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+
+search_merges () {
+        git rev-list --all --grep="Merge branch '$1'" \
+                --pretty=tformat:"%P %s" |
+        sed -ne "s/^$_x40 \($_x40\) Merge .*/\1/p"
+}
+
+search_merge_targets () {
+	git rev-list --all --grep="Merge branch '[^']*' into $branch\$" \
+		--pretty=tformat:"%H %s" --all |
+	sed -ne "s/^\($_x40\) Merge .*/\1/p"
+}
+
+dry_run=
+scan_reflog=t
+scan_reflog_merges=
+scan_merges=
+scan_merge_targets=
+new_name=
+
+while test "$#" != 0; do
+	case "$1" in
+	    -b|--branch)
+		shift
+		new_name="$1"
+		;;
+	    -n|--dry-run)
+		dry_run=t
+		;;
+	    --no-dry-run)
+		dry_run=
+		;;
+	    -m|--merges)
+		scan_merges=t
+		;;
+	    --no-merges)
+		scan_merges=
+		;;
+	    -l|--reflog)
+		scan_reflog=t
+		;;
+	    --no-reflog)
+		scan_reflog=
+		;;
+	    -r|--reflog_merges)
+		scan_reflog_merges=t
+		;;
+	    --no-reflog_merges)
+		scan_reflog_merges=
+		;;
+	    -t|--merge-targets)
+		scan_merge_targets=t
+		;;
+	    --no-merge-targets)
+		scan_merge_targets=
+		;;
+	    -a|--all)
+		scan_reflog=t
+		scan_reflog_merges=t
+		scan_merges=t
+		scan_merge_targets=t
+		;;
+	    --)
+		shift
+		break
+		;;
+	    *)
+		usage
+		;;
+	esac
+	shift
+done
+
+test "$#" = 1 || usage
+
+all_strategies="$scan_reflog$scan_reflog_merges$scan_merges$scan_merge_targets"
+if test -z "$all_strategies"; then
+	die "must enable at least one of -lrmt"
+fi
+
+branch="$1"
+test -z "$new_name" && new_name="$branch"
+
+if test ! -z "$scan_reflog"; then
+	if test -r "$GIT_DIR"/logs/HEAD; then
+		candidates="$(search_reflog $branch)"
+	else
+		die 'reflog scanning requested, but' \
+			'$GIT_DIR/logs/HEAD not readable'
+	fi
+fi
+if test ! -z "$scan_reflog_merges"; then
+	if test -r "$GIT_DIR"/logs/HEAD; then
+		candidates="$candidates $(search_reflog_merges $branch)"
+	else
+		die 'reflog scanning requested, but' \
+			'$GIT_DIR/logs/HEAD not readable'
+	fi
+fi
+if test ! -z "$scan_merges"; then
+	candidates="$candidates $(search_merges $branch)"
+fi
+if test ! -z "$scan_merge_targets"; then
+	candidates="$candidates $(search_merge_targets $branch)"
+fi
+
+candidates="$(git rev-parse $candidates | sort -u)"
+
+if test -z "$candidates"; then
+	hint=
+	test "z$all_strategies" != "ztttt" \
+		&& hint=" (maybe try again with -a)"
+	die "no candidates for $branch found$hint"
+fi
+
+echo "** Candidates for $branch **"
+for cmt in $candidates; do
+	git --no-pager log --pretty=tformat:"%ct:%h [%cr] %s" --abbrev-commit -1 $cmt
+done \
+| sort -n | cut -d: -f2-
+
+newest="$(git rev-list -1 $candidates)"
+if test ! -z "$dry_run"; then
+	printf "** Most recent: "
+	git --no-pager log -1 --pretty=tformat:"%h %s" $newest
+elif ! git rev-parse --verify --quiet $new_name >/dev/null; then
+	printf "** Restoring $new_name to "
+	git --no-pager log -1 --pretty=tformat:"%h %s" $newest
+	git branch $new_name $newest
+else
+	printf "Most recent: "
+	git --no-pager log -1 --pretty=tformat:"%h %s" $newest
+	echo "** $new_name already exists, doing nothing"
+fi
-- 
1.6.1.2.495.gb8db2
