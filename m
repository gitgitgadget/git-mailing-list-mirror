From: Paul Jackson <pj@sgi.com>
Subject: [PATCH] optimize gitdiff-do script
Date: Sat, 16 Apr 2005 16:28:04 -0700 (PDT)
Message-ID: <20050416232810.23430.78712.sendpatchset@sam.engr.sgi.com>
References: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
Cc: Petr Baudis <pasky@ucw.cz>, Paul Jackson <pj@sgi.com>
X-From: git-owner@vger.kernel.org Sun Apr 17 01:24:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMwem-0004EI-E4
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 01:24:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVDPX21 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 19:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261195AbVDPX21
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 19:28:27 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:25301 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261194AbVDPX2J (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 16 Apr 2005 19:28:09 -0400
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2])
	by omx3.sgi.com (8.12.11/8.12.9/linux-outbound_gateway-1.1) with ESMTP id j3GNpaQu011267;
	Sat, 16 Apr 2005 16:51:36 -0700
Received: from sam.engr.sgi.com (sam.engr.sgi.com [163.154.6.103])
	by cthulhu.engr.sgi.com (SGI-8.12.5/8.12.5) with ESMTP id j3GNS4lU15237165;
	Sat, 16 Apr 2005 16:28:07 -0700 (PDT)
To: git@vger.kernel.org
In-Reply-To: <20050416232749.23430.93360.sendpatchset@sam.engr.sgi.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Rewrite gitdiff-do so that it works with arbitrary
whitespace (space, tab, newline, ...) in filenames.

Reduce number of subcommands execv'd by a
third, by only calling 'rm' once, at end, not each
loop.

Avoid using shell arrays; perhaps more portable.

Avoid 'echo -e' when displaying names; dont expand escape
  sequences in names.

Use shell noglob (-f) to minimize getdents() calls.

Simplify argument parsing and tmp file management.

Comment the nastier shell patterns.

This reduces the time by about 1/3 of what it was.

Signed-off-by: Paul Jackson <pj@sgi.com>

Index: git-pasky-0.4/gitdiff-do
===================================================================
--- git-pasky-0.4.orig/gitdiff-do	2005-04-16 13:19:07.000000000 -0700
+++ git-pasky-0.4/gitdiff-do	2005-04-16 15:33:28.000000000 -0700
@@ -2,19 +2,22 @@
 #
 # Make a diff between two GIT trees.
 # Copyright (c) Petr Baudis, 2005
+# Copyright (c) Paul Jackson, 2005
 #
 # Takes two parameters identifying the two trees/commits to compare.
 # Empty string will be substitued to HEAD revision.
 #
 # Note that this is probably the most performance critical shell script
-# in the whole GIT suite. That's also why I resorted to bash builtin
-# features and stuff. -- pasky@ucw.cz
+# in the whole GIT suite.
 #
 # Outputs a diff converting the first tree to the second one.
 
+set -f   # keep shell from scanning "." to expand wildcards
 
-id1=$1; shift
-id2=$1; shift
+t=${TMPDIR:-/usr/tmp}/gitdiff.$$
+trap 'set +f; rm -fr $t.?; trap 0; exit 0' 0 1 2 3 15
+
+id1=$1; id2=$2; shift 2
 
 # Leaves the result in $label.
 mkbanner () {
@@ -32,58 +35,55 @@ mkbanner () {
 	[ "$labelapp" ] && label="$label  ($labelapp)"
 }
 
-t=${TMPDIR:-/usr/tmp}/gitdiff.$$
-trap 'rm -fr $t.?; trap 0; exit 0' 0 1 2 3 15
-diffdir=$t.1
-diffdir1="$diffdir/$id1"
-diffdir2="$diffdir/$id2"
-mkdir -p "$diffdir1" "$diffdir2"
-
-while [ "$1" ]; do
-	declare -a param
-	param=($1);
-	op=${param[0]:0:1}
-	mode=${param[0]:1}
-	type=${param[1]}
-	sha=${param[2]}
-	name=${param[3]}
-
-	echo -e "Index: $name\n==================================================================="
-
-	if [ "$type" = "tree" ]; then
-		# diff-tree will kindly diff the subdirs for us
-		# XXX: What about modes?
-		shift; continue
-	fi
-
-	loc1="$diffdir1/$name"; dir1="${loc1%/*}"
-	loc2="$diffdir2/$name"; dir2="${loc2%/*}"
-	([ -d "$dir1" ] && [ -d "$dir2" ]) || mkdir -p "$dir1" "$dir2"
-
-	case $op in
-	"+")
-		mkbanner "$loc2" $id2 "$name" $mode $sha
-		diff -L "/dev/null  (tree:$id1)" -L "$label" -u /dev/null "$loc2"
-		;;
-	"-")
-		mkbanner "$loc1" $id1 "$name" $mode $sha
-		diff -L "$label" -L "/dev/null  (tree:$id2)" -u "$loc1" /dev/null
-		;;
-	"*")
-		modes=(${mode/->/ });
-		mode1=${modes[0]}; mode2=${modes[1]}
-		shas=(${sha/->/ });
-		sha1=${shas[0]}; sha2=${shas[1]}
-		mkbanner "$loc1" $id1 "$name" $mode1 $sha1; label1=$label
-		mkbanner "$loc2" $id2 "$name" $mode2 $sha2; label2=$label
-		diff -L "$label1" -L "$label2" -u "$loc1" "$loc2"
-		;;
-	*)
-		echo "Unknown operator $op, ignoring delta: $1";;
-	esac
-
-	rm -f "$loc1" "$loc2"
-	shift
+for arg
+do
+  IFS='	'
+  set X$arg     	# X: don't let shell set see leading '+' in $arg
+  op="$1"
+  mode=${op#X?} 	# trim leading X? 1st two chars
+  type="$2"
+  sha="$3"
+  # if 4+ tabs, trim 1st 3 fields on 1st line with sed
+  case "$arg" in
+  *\	*\	*\	*\	*)
+    name=$(echo "$arg" |
+      /bin/sed '1s/[^	]*	[^	]*	[^	]*	//')
+    ;;
+  *)
+    name="$4"
+    ;;
+  esac
+
+  echo "Index: $name"
+  echo ===================================================================
+
+  test "$type" = "tree" && continue
+
+  loc1=$t.1
+  loc2=$t.2
+
+  case $op in
+  X+*)
+    mkbanner $loc2 $id2 "$name" $mode $sha
+    diff -L "/dev/null  (tree:$id1)" -L "$label" -u /dev/null $loc2
+    ;;
+  X-*)
+    mkbanner $loc1 $id1 "$name" $mode $sha
+    diff -L "$label" -L "/dev/null  (tree:$id2)" -u $loc1 /dev/null
+    ;;
+  X\**)
+    mode1=${mode%->*}	# trim '->' and after
+    mode2=${mode#*->}	# trim up to and including '->'
+    sha1=${sha%->*}	# trim '->' and after
+    sha2=${sha#*->}	# trim up to and including '->'
+
+    mkbanner $loc1 $id1 "$name" $mode1 $sha1; label1=$label
+    mkbanner $loc2 $id2 "$name" $mode2 $sha2; label2=$label
+    diff -L "$label1" -L "$label2" -u $loc1 $loc2
+    ;;
+  *)
+    badop=$(echo $op | sed 's/.\(.\).*/\1/')
+    echo "Unknown operator $badop, ignoring delta: $1"
+    ;;
+  esac
 done
-
-rm -rf "$diffdir"

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.650.933.1373, 1.925.600.0401
