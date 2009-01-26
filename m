From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2] contrib git-resurrect: find traces of a branch name and resurrect it
Date: Mon, 26 Jan 2009 13:40:57 +0100
Message-ID: <1232973657-31444-1-git-send-email-trast@student.ethz.ch>
References: <200901261254.39360.trast@student.ethz.ch>
Cc: git@vger.kernel.org, Junio C Hamano <junio@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Mon Jan 26 13:42:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LRQnW-0008OM-CS
	for gcvg-git-2@gmane.org; Mon, 26 Jan 2009 13:42:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbZAZMlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Jan 2009 07:41:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbZAZMlK
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Jan 2009 07:41:10 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:12628 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190AbZAZMlI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Jan 2009 07:41:08 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 13:41:07 +0100
Received: from localhost.localdomain ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 26 Jan 2009 13:41:07 +0100
X-Mailer: git-send-email 1.6.1.469.gca696
In-Reply-To: <200901261254.39360.trast@student.ethz.ch>
X-OriginalArrivalTime: 26 Jan 2009 12:41:07.0267 (UTC) FILETIME=[5BCAF130:01C97FB3]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107207>

Add a tool 'git-resurrect.sh <branch>' that tries to find traces of
the <branch> in the HEAD reflog and, optionally, all merge commits in
the repository.  It can then resurrect the branch, pointing it at the
most recent of all candidate commits found.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Fixed the -h to upper-case in the short options summaries, and removed
a stray 'q' in the default assignment of new_name.


 contrib/git-resurrect.sh |  140 ++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 140 insertions(+), 0 deletions(-)
 create mode 100755 contrib/git-resurrect.sh

diff --git a/contrib/git-resurrect.sh b/contrib/git-resurrect.sh
new file mode 100755
index 0000000..3c1c946
--- /dev/null
+++ b/contrib/git-resurrect.sh
@@ -0,0 +1,140 @@
+#!/bin/sh
+
+USAGE="[-H] [-r] [-m] [-t] [-n] [-b <newname>] <name>"
+LONG_USAGE="git-resurrect attempts to find traces of a branch tip
+called <name>, and tries to resurrect it.  Currently, the reflog is
+searched for checkout messages, and with -r also merge messages.  With
+-m and -t, the history of all refs is scanned for Merge <name> into
+other/Merge <other> into <name> (respectively) commit subjects, which
+is rather slow but allows you to resurrect other people's topic
+branches."
+
+OPTIONS_SPEC="\
+git resurrect [-H] [-r] [-m] [-t] [-n] [-b <newname>] <name>
+--
+b,branch=            save branch as <newname> instead of <name>
+H,try-hard           same as -r -m -t
+r,reflog-merges      scan for merges recorded in reflog
+m,merges             scan for merges into other branches (slow)
+t,merge-targets      scan for merges of other branches into <name>
+n,dry-run            don't recreate the branch"
+
+. git-sh-setup
+cd_to_toplevel
+
+search_reflog () {
+        sed -n 's~^\([^ ]*\) .*\tcheckout: moving from '"$1"' .*~\1~p' \
+                < .git/logs/HEAD
+}
+
+search_reflog_merges () {
+        sed -n 's~^[^ ]* \([^ ]*\) .*\tmerge '"$1"':~\1~p' \
+                < .git/logs/HEAD
+}
+
+search_merges () {
+	git rev-list --pretty=tformat:"%h %p:%s" --all |
+	grep "Merge branch.*'$branch'.*into" |
+	while read sha rest; do
+		parents="$(echo "$rest" | cut -d: -f1)"
+		case "$parents" in
+		    *' '*' '*)
+			warn "$branch took part in octopus merge $sha"
+			warn "check manually!"
+			;;
+		    *' '*)
+			echo "$parents" | cut -d' ' -f2
+			;;
+		esac
+	done
+}
+
+search_merge_targets () {
+	git rev-list --pretty=tformat:"%h %s" --all |
+	grep "Merge branch '[^']*' into $branch$" |
+	cut -d' ' -f1
+}
+
+dry_run=
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
+	    -m|--merges)
+		scan_merges=t
+		;;
+	    -r|--reflog_merges)
+		scan_reflog_merges=t
+		;;
+	    -t|--merge-targets)
+		scan_merge_targets=t
+		;;
+	    -H|--try-hard)
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
+branch="$1"
+test -z "$new_name" && new_name="$branch"
+
+candidates="$(search_reflog $1)"
+if test ! -z "$scan_reflog_merges"; then
+	candidates="$candidates $(search_reflog_merges $1)"
+fi
+if test ! -z "$scan_merges"; then
+	candidates="$candidates $(search_merges $1)"
+fi
+if test ! -z "$scan_merge_targets"; then
+	candidates="$candidates $(search_merge_targets $1)"
+fi
+
+candidates="$(git rev-parse $candidates | sort -u)"
+
+if test -z "$candidates"; then
+	hint=
+	test "z$scan_merges$scan_reflog_merges$scan_merge_targets" != "zttt" \
+		&& hint="(maybe try again with -H)"
+	die "no candidates for $branch found" $hint
+fi
+
+echo "** Candidates for $branch **"
+for cmt in $candidates; do
+	git --no-pager log --pretty=oneline --abbrev-commit -1 $cmt
+done
+
+newest="$(git rev-list -1 $candidates)"
+if test ! -z "$dry_run"; then
+	printf "Most recent: "
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
1.6.1.469.g6f3d5
