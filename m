From: Thomas Rast <trast@student.ethz.ch>
Subject: [TOY PATCH] git-resurrect: find traces of a branch name and resurrect it
Date: Sun, 18 Jan 2009 02:38:23 +0100
Message-ID: <1232242703-19086-1-git-send-email-trast@student.ethz.ch>
References: <alpine.DEB.1.00.0901161213370.3586@pacific.mpi-cbg.de>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 18 02:39:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LOMda-0001dD-Fs
	for gcvg-git-2@gmane.org; Sun, 18 Jan 2009 02:39:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656AbZARBiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Jan 2009 20:38:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754344AbZARBiT
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jan 2009 20:38:19 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:51988 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752671AbZARBiS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Jan 2009 20:38:18 -0500
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 18 Jan 2009 02:38:16 +0100
Received: from localhost.localdomain ([84.75.148.62]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sun, 18 Jan 2009 02:38:16 +0100
X-Mailer: git-send-email 1.6.1.320.gd5dca.dirty
In-Reply-To: <alpine.DEB.1.00.0901161213370.3586@pacific.mpi-cbg.de>
X-OriginalArrivalTime: 18 Jan 2009 01:38:16.0934 (UTC) FILETIME=[6F85B860:01C9790D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/106129>

Add a tool 'git resurrect <branch>...' that tries to find traces of
each <branch> in the HEAD reflog and, optionally, all merge commits in
the repository.  It can then resurrect the branch, pointing it at the
most recent of all candidate commits found.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

So here's a slightly more polished version so gmane can keep it
forever.  Thanks for the sed trick!  I was too lazy to add more
options, but at least there's a "fast" and a "complete" mode.



 Makefile         |    1 +
 git-resurrect.sh |  109 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+), 0 deletions(-)
 create mode 100755 git-resurrect.sh

diff --git a/Makefile b/Makefile
index 2b873fa..87cb539 100644
--- a/Makefile
+++ b/Makefile
@@ -260,6 +260,7 @@ SCRIPT_SH += git-merge-resolve.sh
 SCRIPT_SH += git-mergetool.sh
 SCRIPT_SH += git-parse-remote.sh
 SCRIPT_SH += git-pull.sh
+SCRIPT_SH += git-resurrect.sh
 SCRIPT_SH += git-quiltimport.sh
 SCRIPT_SH += git-rebase--interactive.sh
 SCRIPT_SH += git-rebase.sh
diff --git a/git-resurrect.sh b/git-resurrect.sh
new file mode 100755
index 0000000..6d5a0c7
--- /dev/null
+++ b/git-resurrect.sh
@@ -0,0 +1,109 @@
+#!/bin/sh
+
+USAGE="git resurrect [-m | --merges] [-n | --dry-run] <name>..."
+LONG_USAGE="git-resurrect attempts to find traces of a branch tip called <name>,
+and tries to resurrect it.  Currently, the reflog is searched for
+checkout and merge messages.  With --merges, the history of all refs
+is scanned for merge commit subjects, which is rather slow but allows
+you to resurrect other people's topic branches."
+
+. git-sh-setup
+cd_to_toplevel
+
+OPTIONS_SPEC="\
+git resurrect [-m | --merges] [-n | --dry-run] <name>...
+--
+m,merges             also scan merges (slow)
+n,dry-run            don't recreate the branch"
+
+test "$#" = 0 && usage
+
+eval "$(echo "$OPTIONS_SPEC" | git rev-parse --parseopt -- "$@" || echo exit $?)"
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
+scan_merges=
+
+while test "$#" != 0; do
+	case "$1" in
+	    -n|--dry-run)
+		dry_run=t
+		;;
+	    -m|--merges)
+		scan_merges=t
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
+for branch in "$@"; do
+	candidates="$(search_reflog $1; search_reflog_merges $1)"
+	if test ! -z "$scan_merges"; then
+		candidates="$candidates $(search_merges $1; search_merge_targets $1)"
+	fi
+
+	candidates="$(git rev-parse $candidates | sort -u)"
+
+	if test -z "$candidates"; then
+		echo "** No candidates for $branch found **"
+		test -z "$scan_merges" && echo "(maybe try again with -m)"
+	else
+		echo "** Candidates for $branch **"
+		for cmt in $candidates; do
+			git --no-pager log --pretty=oneline --abbrev-commit -1 $cmt
+		done
+
+		newest="$(git rev-list -1 $candidates)"
+		if test ! -z "$dry_run"; then
+			printf "Most recent: "
+			git --no-pager log -1 --pretty=tformat:"%h %s" $newest
+		elif ! git rev-parse --verify --quiet $branch >/dev/null; then
+			printf "** Restoring $branch to "
+			git --no-pager log -1 --pretty=tformat:"%h %s" $newest
+			git branch $branch $newest
+		else
+			printf "Most recent: "
+			git --no-pager log -1 --pretty=tformat:"%h %s" $newest
+			echo "** $branch already exists, doing nothing"
+		fi
+	fi
+done
-- 
1.6.1.320.gd5dca.dirty
