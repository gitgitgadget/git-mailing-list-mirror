From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] git-format-patch: Prepare patches for e-mail submission.
Date: Thu, 30 Jun 2005 00:36:40 -0700
Message-ID: <7vll4s47p3.fsf_-_@assigned-by-dhcp.cox.net>
References: <20050630055821.1329.qmail@blackcubes.dyndns.org>
	<7v1x6k5oau.fsf@assigned-by-dhcp.cox.net>
	<2cfc403205063000009d149f5@mail.gmail.com>
	<7vwtoc48rh.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jon@blackcubes.dyndns.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 30 09:29:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DntUK-0006wU-Qw
	for gcvg-git@gmane.org; Thu, 30 Jun 2005 09:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262537AbVF3Hgw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 03:36:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262600AbVF3Hgw
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 03:36:52 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:56787 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S262537AbVF3Hgn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Jun 2005 03:36:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050630073641.BYJK8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 30 Jun 2005 03:36:41 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vwtoc48rh.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's message of "Thu, 30 Jun 2005 00:13:38 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This is the script I use to prepare patches for e-mail submission.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

*** Jon, I made it by default not to say [PATCH N/M] for any M,
*** and you can turn it on with --numbered flag.   Even with
*** --numbered, " N/M" is not shown if M==1.

 Makefile                |    3 +
 git-format-patch-script |  122 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 124 insertions(+), 1 deletions(-)
 create mode 100755 git-format-patch-script

16daa73282d5aa1cc7d227945aea193553fdfaad
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -25,7 +25,8 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-fetch-script git-status-script git-commit-script \
 	git-log-script git-shortlog git-cvsimport-script git-diff-script \
 	git-reset-script git-add-script git-checkout-script git-clone-script \
-	gitk git-cherry git-rebase-script git-relink-script
+	gitk git-cherry git-rebase-script git-relink-script \
+	git-format-patch-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-format-patch-script b/git-format-patch-script
new file mode 100755
--- /dev/null
+++ b/git-format-patch-script
@@ -0,0 +1,122 @@
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
+git-rev-list "$junio" "^$linus" >$series
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
+	echo '------------'
+    } >"$outdir$file"
+done <$series
------------
