From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] GIT commit statistics.
Date: Fri, 11 Nov 2005 23:44:20 -0800
Message-ID: <7v7jbeia3v.fsf_-_@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
	<20051107225807.GA10937@c165.ib.student.liu.se>
	<7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
	<7v4q6ilt3m.fsf@assigned-by-dhcp.cox.net>
	<43758D21.3060107@michonline.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 08:45:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eaq3m-0000r6-DF
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 08:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932198AbVKLHoX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 02:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbVKLHoX
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 02:44:23 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:8852 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932198AbVKLHoW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Nov 2005 02:44:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051112074355.YCME4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 12 Nov 2005 02:43:55 -0500
To: Ryan Anderson <ryan@michonline.com>
In-Reply-To: <43758D21.3060107@michonline.com> (Ryan Anderson's message of
	"Sat, 12 Nov 2005 01:35:13 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11661>

Ryan Anderson <ryan@michonline.com> writes:

> Junio C Hamano wrote:
>
>> Just for fun, I randomly picked two heads/master commits from
>> linux-2.6 repository ... and fed the commits
>> between the two to a little script that looks at commits and
>> tries to stat what they did (the script ignores renames so they
>> appear as deletes and adds).
>
> Mind sharing the script?
>
> It'be nice to know if these stats are typical, or unusual when you get
> numbers from a variety of other trees.

Very unpolished but here they are.

I misread the trivial count in my original message.  Trivial and
Merge are counted separately, so among 3957 commits, merges were
297 (72 trivials and 225 others).

-- >8 -- cut here -- >8 --
Subject: [PATCH] GIT commit statistics

A set of scripts that read the existing commit history, and
show various stats.

Sample usage:

    # Arguments are given to git-rev-list; defaults to ORIG..
    # if not given, to retrace what was just pulled.
    $ ./contrib/jc-git-stat-1.sh v0.99.9g..maint |
      ./contrib/jc-git-stat-1-log.perl
    Total commit objects: 43
    Trivial Merges: 1 (2.33%)
    Merges: 1 (2.33%)
    Number of paths touched by non-merge commits:
	    average 3.00, median 2, min 2, max 18
    Number of merge parents:
	    average 2.50, median 3, min 2, max 3
    Number of merge bases:
	    average 1.00, median 1, min 1, max 1
    File level merges:
	    average 0.50, median 1, min 0, max 1
    Number of changed paths from the first parent:
	    average 28.00, median 52, min 4, max 52
    File level 3-ways:
	    average 1.00, median 1, min 1, max 1

 * "Trivial Merges" are the ones done by read-tree --trivial;
 * "Merges" are other merges;
 * "File level merges" are paths not collapsed by read-tree 3-way (i.e.
   given to merge-one-file);
 * "File level 3-ways" are paths merge-one-file would have run 'merge';

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 contrib/jc-git-stat-1-log.perl |   87 ++++++++++++++++++++++++++++++++++++++++
 contrib/jc-git-stat-1-mof.sh   |   59 +++++++++++++++++++++++++++
 contrib/jc-git-stat-1.sh       |   74 ++++++++++++++++++++++++++++++++++
 3 files changed, 220 insertions(+), 0 deletions(-)
 create mode 100755 contrib/jc-git-stat-1-log.perl
 create mode 100755 contrib/jc-git-stat-1-mof.sh
 create mode 100755 contrib/jc-git-stat-1.sh

applies-to: 9a0f0c748316751fbf593a21f2b16bcdd975095a
2cb3da4b260ed82dc379a11d91f55fe774a2ea49
diff --git a/contrib/jc-git-stat-1-log.perl b/contrib/jc-git-stat-1-log.perl
new file mode 100755
index 0000000..b70af2b
--- /dev/null
+++ b/contrib/jc-git-stat-1-log.perl
@@ -0,0 +1,87 @@
+#!/usr/bin/perl
+
+my ($patches, $failures, $merges, $trivials) = (0, 0, 0, 0);
+my (@patch_paths,
+    @parent_counts,
+    @base_counts,
+    @merge_counts,
+    @path_counts,
+    @res_counts,
+    @merge_m, 
+    @merge_a,
+    @merge_d, 
+    @merge_c, 
+    @merge_u);
+
+sub avg_median {
+    my ($ary) = shift;
+    my ($msg) = shift;
+    my @a = sort { $a <=> $b } @$ary;
+    my $sum = 0;
+    for (@a) { $sum += $_ }
+    return unless (@a && $sum);
+    my ($avg, $med) = ($sum/@a, $a[(@a/2)]);
+    my ($min, $max) = ($a[0], $a[$#a]);
+    printf "%s:\n\taverage %.2f, median %d, min %d, max %d\n",
+    	$msg, $avg, $med, $min, $max;
+}
+
+while (<>) {
+    next unless (s/^([MCFT]) [0-9a-f]{40} //);
+    chomp;
+    my $type = $1;
+    if ($type eq 'F') {
+	$failures++;
+	next;
+    }
+    if ($type eq 'C') {
+	$patches++;
+	push @patch_paths, $_;
+	next;
+    }
+    if ($type eq 'M') {
+	$merges++;
+    }
+    elsif ($type eq 'T') {
+	$trivials++;
+    }
+    else {
+	die "?? $type";
+    }
+    s/^(\d+) (\d+) (\d+) (\d+) (\d+) *//;
+    push @parent_counts, $1;
+    push @base_counts, $2;
+    push @merge_counts, $3;
+    push @path_counts, $4;
+    push @res_counts, $5;
+    if ($type eq 'M') {
+	/M=(\d+) A=(\d+) D=(\d+) C=(\d+) U=(\d+)/ or die;
+	push @merge_m, $1;
+	push @merge_a, $2;
+	push @merge_d, $3;
+	push @merge_c, $4;
+	push @merge_u, $5;
+    }
+}
+
+my $total = ($failures+$patches+$merges+$trivials);
+print "Total commit objects: $total\n";
+printf "Trivial Merges: $trivials (%.2f%%)\n", ($trivials * 100.0/$total);
+printf "Merges: $merges (%.2f%%)\n", ($merges * 100.0/$total);
+if ($failures) {
+    print "Failures: $failures\n";
+}
+
+avg_median(\@patch_paths, "Number of paths touched by non-merge commits");
+avg_median(\@parent_counts, "Number of merge parents");
+avg_median(\@base_counts, "Number of merge bases");
+avg_median(\@merge_counts, "File level merges");
+avg_median(\@path_counts, "Number of changed paths from the first parent");
+#avg_median(\@res_counts, "");
+avg_median(\@merge_m, "File level 3-ways");
+avg_median(\@merge_a, "Paths added");
+avg_median(\@merge_d, "Paths deleted");
+avg_median(\@merge_c, "Paths identically added with wrong permission");
+avg_median(\@merge_u, "Paths added differently");
+
+
diff --git a/contrib/jc-git-stat-1-mof.sh b/contrib/jc-git-stat-1-mof.sh
new file mode 100755
index 0000000..2be6d8b
--- /dev/null
+++ b/contrib/jc-git-stat-1-mof.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+#
+# Copyright (c) Linus Torvalds, 2005
+# Copyright (c) Junio C Hamano, 2005
+#
+# This is modified from the git per-file merge script, called with
+#
+#   $1 - original file SHA1 (or empty)
+#   $2 - file in branch1 SHA1 (or empty)
+#   $3 - file in branch2 SHA1 (or empty)
+#   $4 - pathname in repository
+#   $5 - orignal file mode (or empty)
+#   $6 - file in branch1 mode (or empty)
+#   $7 - file in branch2 mode (or empty)
+#
+# Handle some trivial cases.. The _really_ trivial cases have
+# been handled already by git-read-tree, but that one doesn't
+# do any merges that might change the tree layout.
+
+case "${1:-.}${2:-.}${3:-.}" in
+#
+# Deleted in both or deleted in one and unchanged in the other
+#
+"$1.." | "$1.$1" | "$1$1.")
+	echo D
+	;;
+
+#
+# Added in one.
+#
+".$2." | "..$3" )
+	echo A
+	;;
+
+#
+# Added in both (check for same permissions).
+#
+".$3$2")
+	if [ "$6" != "$7" ]; then
+		echo C
+	else
+		echo A
+	fi
+	;;
+
+#
+# Modified in both, but differently.
+#
+"$1$2$3")
+	echo M
+	;;
+
+".$2$3")
+	echo U
+	;;
+*)
+	echo C
+	;;
+esac
diff --git a/contrib/jc-git-stat-1.sh b/contrib/jc-git-stat-1.sh
new file mode 100755
index 0000000..b03c69d
--- /dev/null
+++ b/contrib/jc-git-stat-1.sh
@@ -0,0 +1,74 @@
+#!/bin/sh
+
+MOF=`dirname "$0"`/jc-git-stat-1-mof.sh
+
+GIT_INDEX_FILE=.tmp-index
+export GIT_INDEX_FILE
+LF='
+'
+
+check_merge () {
+	rm -f $GIT_INDEX_FILE
+	commit=$1
+	shift
+
+	case "$#" in
+	2)
+		MB=$(git-merge-base --all "$@")
+		;;
+	*)
+		MB=$(git-show-branch --merge-base "$@")
+		;;
+	esac
+	basecnt=$(echo $MB | wc -l)
+
+	if git-read-tree --trivial -m $MB "$@" 2>/dev/null
+	then
+		type=T
+		pathcnt=$(git-diff-index --cached --name-status "$1" | wc -l)
+		rescnt=$(git-diff-index --cached --name-status "$commit" | wc -l)
+		echo "T $commit $# $basecnt 0 $pathcnt $rescnt"
+	elif git-read-tree -m $MB "$@" 2>/dev/null
+	then
+	        script='s/^ *\([0-9]*\) *\([A-Z]\)/\2=\1/'
+		type=M
+		mergecnt=$(git-ls-files --unmerged | sort -k 4,4 -u | wc -l)
+		pathcnt=$(git-diff-index --cached --name-status "$1" | wc -l)
+
+		C=0 A=0 M=0 U=0 D=0
+		eval `git-merge-index -o "$MOF" -a |
+			sort |
+			uniq -c |
+			sed -e "$script"`
+		rescnt=$(git-diff-index --cached --name-status "$commit" | wc -l)
+		echo "M $commit $# $basecnt $mergecnt $pathcnt $rescnt M=$M A=$A D=$D C=$C U=$U"
+	else
+		echo "F $commit $# $basecnt"
+	fi
+}
+
+check_patch () {
+	pathcnt=$(git-diff-tree --name-status -r "$1" | wc -l)
+	echo "C $1 $pathcnt"
+}
+
+case "$#" in
+0)
+	set ORIG_HEAD.. ;;
+esac
+
+git-rev-list --parents "$@" |
+while read commit parents
+do
+	case "$parents" in
+	?*' '?*)
+		# Merge
+		check_merge $commit $parents
+		;;
+	*)
+		# Change
+		check_patch $commit $parents
+		;;
+	esac
+done
+
---
0.99.9.GIT
