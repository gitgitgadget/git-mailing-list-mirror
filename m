From: Jonas Fonseca <fonseca@diku.dk>
Subject: Re: cg-log patches
Date: Mon, 9 May 2005 13:39:07 +0200
Message-ID: <20050509113907.GA22830@diku.dk>
References: <1742.10.10.10.24.1115573750.squirrel@linux1> <20050508234936.GA26624@diku.dk> <4302.10.10.10.24.1115610350.squirrel@linux1>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Cc: Petr Baudis <pasky@ucw.cz>, GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 09 13:34:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DV6V4-00009t-6b
	for gcvg-git@gmane.org; Mon, 09 May 2005 13:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVEILjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 07:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261264AbVEILjg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 07:39:36 -0400
Received: from nhugin.diku.dk ([130.225.96.140]:35778 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S261254AbVEILjJ (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 07:39:09 -0400
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id 4A6BC6E2454; Mon,  9 May 2005 13:39:07 +0200 (CEST)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id E81A56E225B; Mon,  9 May 2005 13:39:06 +0200 (CEST)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id E173961FDE; Mon,  9 May 2005 13:39:07 +0200 (CEST)
To: Sean <seanlkml@sympatico.ca>
Content-Disposition: inline
In-Reply-To: <4302.10.10.10.24.1115610350.squirrel@linux1>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Sean <seanlkml@sympatico.ca> wrote Sun, May 08, 2005:
> On Sun, May 8, 2005 7:49 pm, Jonas Fonseca said:
> Hey Jonas,

Hi Sean,

> >>     Fix cg-log -f option so that a complete list of files is
> >>     displayed when a commit has more than one parent.
> >
> > This sounds great.
> 
> You might want to rip it out and submit it, because it's not likely to see
> the light of day otherwise.

I ripped it out and made a patch only with the fix.

Pasky, I also updated the line-wrapping patch if you want it.

> > The reason I put it at the top was to make it more similar to GNU-style
> > changelogs (if there is such a style).
> 
> Yeah, I felt a bit guilty sliding that shift in, really I had no rationale
> other than it looked better _to me_.

I don't feel strong about it. I guess I have just gotten used to it that
way.

-- 
Jonas Fonseca

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="fix-cg-log.patch"

Fix cg-log -f option so that a complete list of files is
displayed when a commit has more than one parent.

Signed-off-by: Sean Estabrooks <seanlkml@sympatico.ca>
Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 06a6b40f8e52eff0e34706c7024b54df50abb6b9
tree 95bc73fd188347aa294991d1c5c7cffd60422098
parent 4ed293bc0a5ffca9683e139cad499b69a4c4d569
author jonas <fonseca@diku.dk> Mon, 09 May 2005 13:23:20 +0200
committer jonas <fonseca@diku.dk> Mon, 09 May 2005 13:23:20 +0200

 cg-log |   34 +++++++++++++++-------------------
 1 files changed, 15 insertions(+), 19 deletions(-)

Index: cg-log
===================================================================
--- 00b94eea5b99d5dd1d1bbe9c9ca3502d11aec581/cg-log  (mode:100755)
+++ 95bc73fd188347aa294991d1c5c7cffd60422098/cg-log  (mode:100755)
@@ -53,17 +53,20 @@
 
 list_commit_files()
 {
-	tree1="$1"
-	tree2="$2"
+	tree="$1"
 	sep="    * $colfiles"
-	# List all files for for the initial commit
-	if [ -z $tree2 ]; then
-		list_cmd="git-ls-tree $tree1"
-	else
-		list_cmd="git-diff-tree -r $tree1 $tree2"
-	fi
 	echo
-	$list_cmd | while read modes type sha1s file; do
+	if [ -z $2 ]; then
+		# List all files for the initial commit
+		git-ls-tree $tree
+	else
+		shift
+		# List changes from each parent
+		for parent; do
+			git-diff-tree -r $tree $parent
+		done
+	fi | sort -u | \
+	while read modes type sha1s file; do
 		echo -n "$sep$file"
 		sep=", "
 	done
@@ -102,8 +105,7 @@
 
 $revls | $revsort | while read time commit parents; do
 	trap exit SIGPIPE
-	tree1=
-	tree2=
+	trees=
 	[ "$revfmt" = "git-rev-list" ] && commit="$time"
 	if [ $# -ne 0 ]; then
 		parent=$(git-cat-file commit $commit | sed -n '2s/parent //p;2Q')
@@ -131,17 +133,11 @@
 				fi
 				;;
 			"tree"|"parent")
-				if [ -z $tree1 ]; then
-					tree1=$rest
-				elif [ -z $tree2 ]; then
-					tree2=$rest
-				fi
+				trees="$trees $rest"
 				echo $colheader$key $rest $coldefault
 				;;
 			"")
-				if [ -n "$list_files" ]; then
-					list_commit_files "$tree1" "$tree2"
-				fi
+				[ -n "$list_files" ] && list_commit_files $trees
 				echo; sed -re '
 					/ *Signed-off-by:.*/Is//'$colsignoff'&'$coldefault'/
 					/ *Acked-by:.*/Is//'$colsignoff'&'$coldefault'/

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="wrap-file-listing-lines.patch"

Wrap file listing lines near the 80th column.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---
commit 9d86f44f7d1eee525ed4c45731ad07b95f62dbb6
tree ddf82a0140bdc1440eb93bcbe01e14e90e44a3e8
parent 06a6b40f8e52eff0e34706c7024b54df50abb6b9
author jonas <fonseca@diku.dk> Mon, 09 May 2005 13:27:20 +0200
committer jonas <fonseca@diku.dk> Mon, 09 May 2005 13:27:20 +0200

 cg-log |   10 +++++++++-
 1 files changed, 9 insertions(+), 1 deletion(-)

Index: cg-log
===================================================================
--- 95bc73fd188347aa294991d1c5c7cffd60422098/cg-log  (mode:100755)
+++ ddf82a0140bdc1440eb93bcbe01e14e90e44a3e8/cg-log  (mode:100755)
@@ -67,8 +67,16 @@
 		done
 	fi | sort -u | \
 	while read modes type sha1s file; do
-		echo -n "$sep$file"
+		echo -n "$sep"
 		sep=", "
+ 		if [ $(echo "$line$sep$file" | wc -c) -lt 75 ]; then
+ 			line="$line$sep$file"
+ 			echo -n "$file"
+ 		else
+ 			line="$file"
+ 			echo "$coldefault"
+ 			echo -n "    $colfiles$file"
+ 		fi
 	done
 	echo "$coldefault:"
 }

--wRRV7LY7NUeQGEoC--
