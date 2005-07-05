From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Add script for patch submission via e-mail.
Date: Tue, 05 Jul 2005 13:19:05 -0700
Message-ID: <7v7jg5dn0m.fsf@assigned-by-dhcp.cox.net>
References: <7vll5h7k5t.fsf@assigned-by-dhcp.cox.net>
	<20050705093441.GD6191@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 05 22:20:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DpttV-0002vS-1N
	for gcvg-git@gmane.org; Tue, 05 Jul 2005 22:19:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261739AbVGEUTl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Jul 2005 16:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261895AbVGEUTl
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jul 2005 16:19:41 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:19150 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S261739AbVGEUTP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jul 2005 16:19:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050705201909.KBBZ18672.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 5 Jul 2005 16:19:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20050705093441.GD6191@pasky.ji.cz> (Petr Baudis's message of "Tue, 5 Jul 2005 11:34:41 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

[PATCH] git-format-patch: Prepare patches for e-mail submission.

This is the script I use to prepare patches for e-mail submission.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** The latest incarnation.  Uses --merge-order while generating
*** the list of patches to number them better.

 Makefile                |    3 +
 git-format-patch-script |  121 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 1 deletions(-)
 create mode 100755 git-format-patch-script

1a3c4d6335860c7bfd09b997b19c850620c6fb50
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -31,7 +31,8 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-fetch-script git-status-script git-commit-script \
 	git-log-script git-shortlog git-cvsimport-script git-diff-script \
 	git-reset-script git-add-script git-checkout-script git-clone-script \
-	gitk git-cherry git-rebase-script git-relink-script git-repack-script
+	gitk git-cherry git-rebase-script git-relink-script git-repack-script \
+	git-format-patch-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-format-patch-script b/git-format-patch-script
new file mode 100755
--- /dev/null
+++ b/git-format-patch-script
@@ -0,0 +1,121 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+
+usage () {
+    echo >&2 "usage: $0"' [-n] [-o dir] [-<diff options>...] upstream [ our-head ]
+
+Prepare each commit with its patch since our-head forked from upstream,
+one file per patch, for e-mail submission.  Each output file is
+numbered sequentially from 1, and uses the first line of the commit
+message (massaged for pathname safety) as the filename.
+
+When -o is specified, output files are created in that directory; otherwise in
+the current working directory.
+
+When -n is specified, instead of "[PATCH] Subject", the first line is formatted
+as "[PATCH N/M] Subject", unless you have only one patch.
+'
+    exit 1
+}
+
+diff_opts=
+IFS='
+'
+LF='
+'
+outdir=./
+
+while case "$#" in 0) break;; esac
+do
+    case "$1" in
+    -n|--n|--nu|--num|--numb|--numbe|--number|--numbere|--numbered)
+    numbered=t ;;
+    -o=*|--o=*|--ou=*|--out=*|--outp=*|--outpu=*|--output=*|--output-=*|\
+    --output-d=*|--output-di=*|--output-dir=*|--output-dire=*|\
+    --output-direc=*|--output-direct=*|--output-directo=*|\
+    --output-director=*|--output-directory=*)
+    outdir=`expr "$1" : '-[^=]*=\(.*\)'` ;;
+    -o|--o|--ou|--out|--outp|--outpu|--output|--output-|--output-d|\
+    --output-di|--output-dir|--output-dire|--output-direc|--output-direct|\
+    --output-directo|--output-director|--output-directory)
+    case "$#" in 1) usage ;; esac; shift
+    outdir="$1" ;;
+    -*)	diff_opts="$diff_opts$LF$1" ;;
+    *) break ;;
+    esac
+    shift
+done
+
+case "$#" in
+2)    linus="$1" junio="$2" ;;
+1)    linus="$1" junio=HEAD ;;
+*)    usage ;;
+esac
+
+case "$outdir" in
+*/) ;;
+*) outdir="$outdir/" ;;
+esac
+test -d "$outdir" || mkdir -p "$outdir" || exit
+
+tmp=.tmp-series$$
+trap 'rm -f $tmp-*' 0 1 2 3 15
+
+series=$tmp-series
+
+titleScript='
+	1,/^$/d
+	: loop
+	/^$/b loop
+	s/[^-a-z.A-Z_0-9]/-/g
+        s/\.\.\.*/\./g
+	s/\.*$//
+	s/--*/-/g
+	s/^-//
+	s/-$//
+	s/$/./
+	q
+'
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+stripCommitHead='/^'"$_x40"' (from '"$_x40"')$/d'
+
+git-rev-list --merge-order "$junio" "^$linus" >$series
+total=`wc -l <$series`
+i=$total
+while read commit
+do
+    title=`git-cat-file commit "$commit" | sed -e "$titleScript"`
+    case "$numbered" in
+    '') num= ;;
+    *)
+	case $total in
+	1) num= ;;
+	*) num=' '`printf "%d/%d" $i $total` ;;
+	esac
+    esac
+    file=`printf '%04d-%stxt' $i "$title"`
+    i=`expr "$i" - 1`
+    echo "$file"
+    {
+	mailScript='
+	1,/^$/d
+	: loop
+	/^$/b loop
+	s|^|[PATCH'"$num"'] |
+	: body
+	p
+	n
+	b body'
+
+	git-cat-file commit "$commit" | sed -ne "$mailScript"
+	echo '---'
+	echo
+	git-diff-tree -p $diff_opts "$commit" | git-apply --stat --summary
+	echo
+	git-diff-tree -p $diff_opts "$commit" | sed -e "$stripCommitHead"
+    } >"$outdir$file"
+done <$series
