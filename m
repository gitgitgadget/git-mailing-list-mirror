From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] format-patch: --mbox and --check.
Date: Wed, 20 Jul 2005 15:37:19 -0700
Message-ID: <7v4qapf6jk.fsf@assigned-by-dhcp.cox.net>
References: <7vpstdf6rr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 21 00:39:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DvNDZ-0003OX-4l
	for gcvg-git@gmane.org; Thu, 21 Jul 2005 00:39:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbVGTWix (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jul 2005 18:38:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261522AbVGTWix
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jul 2005 18:38:53 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:27011 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261521AbVGTWhV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2005 18:37:21 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050720223720.HOQJ17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 20 Jul 2005 18:37:20 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vpstdf6rr.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Wed, 20 Jul 2005 15:32:24 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Add --mbox option to export patches in a format resembling UNIX
mbox, so that later they can be concatenated and fed to
applymbox.

Add --check to look for lines that introduce bogus whitespaces.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 git-format-patch-script |   49 +++++++++++++++++++++++++++++++++++++++++------
 1 files changed, 43 insertions(+), 6 deletions(-)

b9d503a8a5e3d83059836c939a09d5f6abdf5406
diff --git a/git-format-patch-script b/git-format-patch-script
--- a/git-format-patch-script
+++ b/git-format-patch-script
@@ -4,7 +4,7 @@
 #
 
 usage () {
-    echo >&2 "usage: $0"' [-n] [-o dir] [-<diff options>...] upstream [ our-head ]
+    echo >&2 "usage: $0"' [-n] [-o dir] [--mbox] [--check] [-<diff options>...] upstream [ our-head ]
 
 Prepare each commit with its patch since our-head forked from upstream,
 one file per patch, for e-mail submission.  Each output file is
@@ -16,6 +16,10 @@ the current working directory.
 
 When -n is specified, instead of "[PATCH] Subject", the first line is formatted
 as "[PATCH N/M] Subject", unless you have only one patch.
+
+When --mbox is specified, the output is formatted to resemble
+UNIX mailbox format, and can be concatenated together for processing
+with applymbox.
 '
     exit 1
 }
@@ -25,13 +29,19 @@ IFS='
 '
 LF='
 '
-outdir=./
 
+outdir=./
 while case "$#" in 0) break;; esac
 do
     case "$1" in
+    -a|--a|--au|--aut|--auth|--autho|--author)
+    author=t ;;
+    -c|--c|--ch|--che|--chec|--check)
+    check=t ;;
     -d|--d|--da|--dat|--date)
     date=t ;;
+    -m|--m|--mb|--mbo|--mbox)
+    date=t author=t mbox=t ;;
     -n|--n|--nu|--num|--numb|--numbe|--number|--numbere|--numbered)
     numbered=t ;;
     -o=*|--o=*|--ou=*|--out=*|--outp=*|--outpu=*|--output=*|--output-=*|\
@@ -71,6 +81,7 @@ trap 'rm -f $tmp-*' 0 1 2 3 15
 
 series=$tmp-series
 commsg=$tmp-commsg
+filelist=$tmp-files
 
 titleScript='
 	/./d
@@ -115,16 +126,27 @@ do
 
     file=`printf '%04d-%stxt' $i "$title"`
     i=`expr "$i" - 1`
-    echo "$file"
+    echo >&2 "* $file"
     {
 	mailScript='
 	/./d
 	/^$/n
-	s|^\[PATCH[^]]*\] *||
-	s|^|[PATCH'"$num"'] |'
+	s|^\[PATCH[^]]*\] *||'
+
+	case "$mbox" in
+	t)
+	    echo 'From nobody Mon Sep 17 00:00:00 2001' ;# UNIX "From" line
+	    mailScript="$mailScript"'
+	    s|^|Subject: [PATCH'"$num"'] |'
+	    ;;
+	*)
+	    mailScript="$mailScript"'
+	    s|^|[PATCH'"$num"'] |'
+	    ;;
+	esac
 
 	eval "$(sed -ne "$whosepatchScript" $commsg)"
-	test "$au" = "$me" || {
+	test "$author,$au" = ",$me" || {
 		mailScript="$mailScript"'
 	a\
 From: '"$au"
@@ -147,5 +169,20 @@ Date: '"$ad"
 	git-diff-tree -p $diff_opts "$commit" | git-apply --stat --summary
 	echo
 	git-diff-tree -p $diff_opts "$commit" | sed -e "$stripCommitHead"
+
+	case "$mbox" in
+	t)
+		echo
+		;;
+	esac
     } >"$outdir$file"
+    case "$check" in
+    t)
+	# This is slightly modified from Andrew Morton's Perfect Patch.
+	# Lines you introduce should not have trailing whitespace.
+	# Also check for an indentation that has SP before a TAB.
+        grep -n '^+\([ 	]* 	.*\|.*[ 	]\)$' "$outdir$file"
+
+	: do not exit with non-zero because we saw no problem in the last one.
+    esac
 done <$series
