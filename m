From: Pierre Habouzit <madcoder@debian.org>
Subject: [PATCH] Remove last bashisms from remaining commands.
Date: Thu, 14 Jun 2007 14:51:02 +0200
Message-ID: <11818254623724-git-send-email-madcoder@debian.org>
References: <11818254621527-git-send-email-madcoder@debian.org>
Cc: git@vger.kernel.org, Pierre Habouzit <madcoder@debian.org>
To: Josef Jeff Sipek <jsipek@cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Thu Jun 14 14:51:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyonU-0003Jt-GX
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 14:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751302AbXFNMvS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 08:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751093AbXFNMvS
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 08:51:18 -0400
Received: from pan.madism.org ([88.191.52.104]:60901 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751142AbXFNMvF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 08:51:05 -0400
Received: from madism.org (beacon-free1.intersec.eu [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id EB694DA6A;
	Thu, 14 Jun 2007 14:51:03 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id 8C02B929BB; Thu, 14 Jun 2007 14:51:02 +0200 (CEST)
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11818254621527-git-send-email-madcoder@debian.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50196>

  Especially also simplify the (quite sloppy) loops to extract ranges of
lines, use sed -n -e '<min>,<max>p' for that.

Signed-off-by: Pierre Habouzit <madcoder@debian.org>
---
 guilt-add           |    7 +++----
 guilt-export        |    6 +++---
 guilt-files         |    6 +++---
 guilt-fork          |    6 +++---
 guilt-graph         |   13 +++++++------
 guilt-help          |    6 +++---
 guilt-import        |    6 +++---
 guilt-import-commit |    6 +++---
 guilt-new           |   15 ++++++++-------
 guilt-next          |    6 +++---
 guilt-patchbomb     |   10 +++++-----
 guilt-push          |   16 ++++++----------
 guilt-series        |    6 +++---
 guilt-unapplied     |   12 +++---------
 uninstall           |    7 ++-----
 15 files changed, 58 insertions(+), 70 deletions(-)

diff --git a/guilt-add b/guilt-add
index fd1e716..ebf41e4 100755
--- a/guilt-add
+++ b/guilt-add
@@ -1,14 +1,13 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE="<file>..."
-. guilt
+. `dirname $0`/guilt
 
 if [ $# -lt 1 ]; then
 	usage
 fi
 
-git-add -- "$@"
-
+exec git-add -- "$@"
diff --git a/guilt-export b/guilt-export
index 444ccdf..2c0a9fd 100755
--- a/guilt-export
+++ b/guilt-export
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Pierre Habouzit, 2007
 #
 
 USAGE="[<target_dir>]"
-. guilt
+. `dirname $0`/guilt
 
 if [ $# -gt 1 ]; then
 	usage
@@ -19,7 +19,7 @@ trap "rm -rf \"$target_dir\"" 0
 mkdir -p "$target_dir"
 
 get_series | tee "$target_dir/series" | while read p; do
-	mkdir -p "`dirname $target_dir/$p`" 2> /dev/null || true
+	silent mkdir -p "`dirname $target_dir/$p`" || true
 	cp "$GUILT_DIR/$branch/$p" "$target_dir/$p"
 done
 
diff --git a/guilt-files b/guilt-files
index bc06f39..3428be4 100755
--- a/guilt-files
+++ b/guilt-files
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (C) 2007 Yasushi SHOJI <yashi@atmark-techno.com>
 #
 
 USAGE="[-v] [-a] [-l]"
-. guilt
+. `dirname $0`/guilt
 
 opt_verbose=
 opt_all=
@@ -26,7 +26,7 @@ do
 done
 
 IFS=:
-if [ $opt_all ]; then
+if [ -n "$opt_all" ]; then
 	cat $applied
 else
 	tail -1 $applied
diff --git a/guilt-fork b/guilt-fork
index 426a7e7..32b31dc 100755
--- a/guilt-fork
+++ b/guilt-fork
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2007
 #
 
 USAGE="[<new_name>]"
-. guilt
+. `dirname $0`/guilt
 
 if [ $# -gt 1 ]; then
 	usage
@@ -28,7 +28,7 @@ else
 		| sed -r -e 's:(\.diff?|\.patch)$::')
 	num=$(echo "$base" | sed -nre 's:.*-([0-9]+)$:\1:'p)
 	[ -n "$num" ] || num=1
-	newpatch="${base%-$num}-$((num+1))${patch#$base}"
+	newpatch="${base%-$num}-$(($num+1))${patch#$base}"
 fi
 
 if [ -e "$GUILT_DIR/$branch/$newpatch" ]; then
diff --git a/guilt-graph b/guilt-graph
index 5d67040..0c6b890 100755
--- a/guilt-graph
+++ b/guilt-graph
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2007
 #
 
 USAGE="[<patchname>]"
-. guilt
+. `dirname $0`/guilt
 
 if [ $# -gt 1 ]; then
 	usage
@@ -24,13 +24,14 @@ else
 	fi
 fi
 
-function getfiles
+getfiles()
 {
 	git-diff-tree -r "$1^" "$1" | tr '\t' ' ' | cut -d' ' -f6
 }
 
 cache="$GUILT_DIR/$branch/.graphcache.$$"
 mkdir "$cache"
+trap "rm -rf \"$cache\"" 0
 
 echo "digraph G {"
 
@@ -39,7 +40,7 @@ current="$top"
 while [ "$current" != "$base" ]; do
 	echo "# checking rev $current"
 
-	echo -n '' > "$cache/dep"
+	touch "$cache/dep"
 
 	getfiles $current | while read f; do
 		# hash the filename
@@ -51,7 +52,7 @@ while [ "$current" != "$base" ]; do
 		echo "$current" > "$cache/$fh"
 	done
 
-	cat "$cache/dep" | sort | uniq | while read h; do
+	sort -u "$cache/dep" | while read h; do
 		echo "	\"${h:0:8}\" -> \"${current:0:8}\"; // ?"
 	done
 
@@ -60,4 +61,4 @@ done
 
 echo "}"
 
-rm -rf "$cache"
+trap - 0
diff --git a/guilt-help b/guilt-help
index 5f867b4..274246b 100755
--- a/guilt-help
+++ b/guilt-help
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2007
 #
@@ -6,7 +6,7 @@
 DO_NOT_CHECK_BRANCH_EXISTENCE=1
 
 USAGE="[<command> | <topic>]"
-. guilt
+. `dirname $0`/guilt
 
 case $# in
 	0)
@@ -24,4 +24,4 @@ case $# in
 		;;
 esac
 
-man "$page"
+exec man "$page"
diff --git a/guilt-import b/guilt-import
index 0e4e037..da3ece8 100755
--- a/guilt-import
+++ b/guilt-import
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2007
 #
 
 USAGE="[-P <patch> ] <patch_file>"
-. guilt
+. `dirname $0`/guilt
 
 case "$1" in
 	-P)
@@ -17,7 +17,7 @@ case "$1" in
 		;;
 esac
 
-if [ $# -lt 1 -o $# -gt 3 -o -z "$newname" -o -z "$oldname" ]; then
+if [ $# -lt 1 ] || [ $# -gt 3 ] || [ -z "$newname" ] || [ -z "$oldname" ]; then
 	usage
 fi
 
diff --git a/guilt-import-commit b/guilt-import-commit
index 47f0dc0..6aa65e5 100755
--- a/guilt-import-commit
+++ b/guilt-import-commit
@@ -1,12 +1,12 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2007
 #
 
 USAGE="[<hash> | <since>..[<until>] | ..<until>]"
-. guilt
+. `dirname $0`/guilt
 
-if [ $# -ne 1 -o -z "$1" ]; then
+if [ $# -ne 1 ] || [ -z "$1" ]; then
 	die "You must specify a range of commits"
 fi
 
diff --git a/guilt-new b/guilt-new
index 7a89b42..5c7eb39 100755
--- a/guilt-new
+++ b/guilt-new
@@ -1,12 +1,12 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE="[-f] [-s] [-e|-m message] <patchname>"
-. guilt
+. `dirname $0`/guilt
 
-if [ $# -lt 1 -o $# -gt 4 ]; then
+if [ $# -lt 1 ] || [ $# -gt 4 ]; then
 	usage
 fi
 
@@ -80,10 +80,11 @@ mkdir_dir=`dirname "$GUILT_DIR/$branch/$patch"`
 [ "$edit" = "t" ] && $editor "$GUILT_DIR/$branch/$patch"
 
 if [ ! -z "$force" ]; then
-	cd "$TOP_DIR"
-	git-diff HEAD >> "$GUILT_DIR/$branch/$patch"
-	git-reset --hard HEAD > /dev/null
-	cd -
+	(
+		cd "$TOP_DIR"
+		git-diff HEAD >> "$GUILT_DIR/$branch/$patch"
+		git-reset --hard HEAD > /dev/null
+	)
 fi
 
 # insert the patch name into the series file
diff --git a/guilt-next b/guilt-next
index b25c761..f38f1cc 100755
--- a/guilt-next
+++ b/guilt-next
@@ -1,17 +1,17 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE=""
-. guilt
+. `dirname $0`/guilt
 
 if [ $# -ne 0 ]; then
 	usage
 fi
 
 n=`wc -l < $applied`
-n=`expr $n + 1`
+n=$(($n + 1))
 
 get_series | awk "{ if (NR == $n) print \$0}"
 
diff --git a/guilt-patchbomb b/guilt-patchbomb
index c1c3ea0..5001d47 100755
--- a/guilt-patchbomb
+++ b/guilt-patchbomb
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2007
 #
@@ -6,7 +6,7 @@
 DO_NOT_CHECK_BRANCH_EXISTENCE=1
 
 USAGE="[-n] [--in-reply-to <msgid>] [<hash> | <since>..[<until>] | ..<until>]"
-. guilt
+. `dirname $0`/guilt
 
 while [ $# -gt 0 ]; do
 	case "$1" in
@@ -34,7 +34,7 @@ git-log --pretty=oneline "$r" | cut -c 1-8,41- | $pager
 
 echo -n "Are these what you want to send? [Y/n] "
 read n
-if [ "$n" = "n" -o "$n" = "N" ]; then
+if [ "$n" = "n" ] || [ "$n" = "N" ]; then
 	die "Aborting..."
 fi
 
@@ -72,7 +72,7 @@ opts="$opts $to_opts"
 # last possible point to abort!
 echo -n "Proceed with patchbomb (this is the last chance to abort)? [y/N] "
 read n
-if [ "$n" != "y" -a "$n" != "Y" ]; then
+if [ "$n" != "y" ] && [ "$n" != "Y" ]; then
 	die "Aborting..."
 fi
 
@@ -93,5 +93,5 @@ fi
 echo -n "Delete temporary directory? [Y/n] "
 read n
 
-[ "$n" = "n" -o "$n" = "N" ] && exit 0
+[ "$n" = "n" ] || [ "$n" = "N" ] && exit 0
 rm -rf $dir
diff --git a/guilt-push b/guilt-push
index c7d8355..ad3616b 100755
--- a/guilt-push
+++ b/guilt-push
@@ -1,15 +1,15 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE="[ -f ] [-a | --all | <patchname>]"
-. guilt
+. `dirname $0`/guilt
 
 abort_flag="abort"
 
 
-if [ "$1" == "-f" ]; then
+if [ "$1" = "-f" ]; then
 	abort_flag=""
 	shift
 fi
@@ -20,7 +20,7 @@ fi
 
 patch="$1"
 
-if [ "$patch" = "--all" -o "$patch" = "-a" ]; then
+if [ "$patch" = "--all" ] || [ "$patch" = "-a" ]; then
 	# we are supposed to push all patches, get the last one out of
 	# series
 
@@ -52,12 +52,8 @@ fi
 sidx=`wc -l < $applied`
 sidx=`expr $sidx + 1`
 
-idx=0
-for p in `get_series`; do
-	idx=`expr $idx + 1`
-	[ $idx -lt $sidx ] && continue
-	[ $idx -gt $eidx ] && break
-
+get_series | sed -n -e "${sidx},${eidx}p" | while read p
+do
 	echo "Applying patch..$p"
 	if [ ! -f "$GUILT_DIR/$branch/$p" ]; then
 		die "Patch $patch does not exist. Aborting."
diff --git a/guilt-series b/guilt-series
index af1c8f2..efb11c2 100755
--- a/guilt-series
+++ b/guilt-series
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE="[-v]"
-. guilt
+. `dirname $0`/guilt
 
 while case "$#" in 0) break ;; esac
 do
@@ -17,7 +17,7 @@ do
 	shift
 done
 
-if ! [ $verbose ]; then
+if ! [ -n "$verbose" ]; then
 	get_series
 else
 	prefix="+"
diff --git a/guilt-unapplied b/guilt-unapplied
index 5bbe4d8..192a7e5 100755
--- a/guilt-unapplied
+++ b/guilt-unapplied
@@ -1,10 +1,10 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) Josef "Jeff" Sipek, 2006, 2007
 #
 
 USAGE=""
-. guilt
+. `dirname $0`/guilt
 
 if [ $# -ne 0 ]; then
 	usage
@@ -13,10 +13,4 @@ fi
 n=`wc -l < $applied`
 n=`expr $n + 1`
 
-idx=0
-for p in `get_series`; do
-	idx=`expr $idx + 1`
-	[ $idx -lt $n ] && continue
-
-	echo $p
-done
+get_series | sed -n -e "$n,\$p"
diff --git a/uninstall b/uninstall
index 54c6d26..9c8a3b7 100755
--- a/uninstall
+++ b/uninstall
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/bin/sh
 #
 # Copyright (c) 2007 Nur Hussein <hussein@cs.usm.my>
 #
@@ -12,7 +12,4 @@ PRE=$1
 
 shift
 
-for x in "$@"
-do
-	rm "$PRE/$x"
-done
+(cd $PRE; rm "$@")
-- 
1.5.2.1
