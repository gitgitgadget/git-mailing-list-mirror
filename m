From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "git revert" (Re: pci_update_resource() getting called on sparc64)
Date: Tue, 9 Aug 2005 02:03:46 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508090202140.3860@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <20050808.103304.55507512.davem@davemloft.net>
 <Pine.LNX.4.58.0508081131540.3258@g5.osdl.org> <20050808160846.GA7710@kroah.com>
 <20050808.123209.59463259.davem@davemloft.net> <20050808194249.GA6729@kroah.com>
 <Pine.LNX.4.58.0508081249110.3258@g5.osdl.org> <Pine.LNX.4.58.0508081257190.3258@g5.osdl.org>
 <7vd5oo40mq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508081357020.3258@g5.osdl.org>
 <7voe882kds.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0508081444040.3258@g5.osdl.org>
 <7vd5oo11wj.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 09 02:04:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Hax-0001nb-E8
	for gcvg-git@gmane.org; Tue, 09 Aug 2005 02:03:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932375AbVHIADt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 20:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932376AbVHIADt
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 20:03:49 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:4498 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S932375AbVHIADs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Aug 2005 20:03:48 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3B2CAE320D; Tue,  9 Aug 2005 02:03:47 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1F13EAC887; Tue,  9 Aug 2005 02:03:47 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id E3059A7D2B; Tue,  9 Aug 2005 02:03:46 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id D1791E320D; Tue,  9 Aug 2005 02:03:46 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd5oo11wj.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Mon, 8 Aug 2005, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Or if you want to be more CVS-like, use "-F", and accept "-" for stdin?
> 
> Yes my vote goes:
> 
> 	-m "message"
>         -c "from this commit, literally."
>         -C "from this commit, but let me edit the log further."
>         -F "from this file."
>         -F - <stdin

The royal penguin speaketh, and the little blue penguin gets a fish:

[PATCH] git commit usage is more like cvs's

Teach git-commit-script about different ways to provide a commit message,
including the famous -m flag from CVS.

---

 git-commit-script |   48 ++++++++++++++++++++++++++++++++++--------------
 1 files changed, 34 insertions(+), 14 deletions(-)

457d879496cb5f742ed6bccc9a435f414b0fd2a7
diff --git a/git-commit-script b/git-commit-script
--- a/git-commit-script
+++ b/git-commit-script
@@ -6,20 +6,41 @@
 . git-sh-setup-script || die "Not a git archive"
 
 usage () {
-	die 'git commit [--all] [-m existing-commit] [<path>...]'
+	die 'git commit [options] [<path>...]
+Options:
+	--all		automatically do a git-update-cache on all modified
+			files
+	-m <message>	use this message in the commit
+	-c <commit>	use the same message as in the given commit
+	-C <commit>	as -c, but let me edit it
+	-F <file>	take the message from file
+	-F -		take the message from stdin'
 }
 
 files=()
+call_editor=true
+rm -f .editmsg || die "Could not write edit message"
 while case "$#" in 0) break ;; esac
 do
     case "$1" in
+    -m|-c|-C|-F)
+	[ "$#" -ne 1 ] || usage;;
+    esac
+
+    case "$1" in
     -m) shift
-        case "$#" in
-	0) usage ;;
-	*) use_commit=`git-rev-parse --verify "$1"` ||
-	   exit ;;
-	esac
-	;;
+	call_editor=""
+	echo "$1" >> .editmsg;;
+    -c) shift
+	call_editor=""
+	use_commit=`git-rev-parse --verify "$1"` ||
+	exit ;;
+    -C) shift
+	use_commit=`git-rev-parse --verify "$1"` ||
+	exit ;;
+    -F) shift
+	call_editor=""
+	cat "$1" >> .editmsg;;
     --all)
 	files=($(git-diff-files --name-only))\
 	;;
@@ -42,7 +63,7 @@ if [ ! -r "$GIT_DIR/HEAD" ]; then
 		echo "#"
 		git-ls-files | sed 's/^/# New file: /'
 		echo "#"
-	) > .editmsg
+	) >> .editmsg
 	PARENTS=""
 else
 	if [ -f "$GIT_DIR/MERGE_HEAD" ]; then
@@ -83,7 +104,7 @@ else
 		export GIT_AUTHOR_DATE
 		git-cat-file commit "$use_commit" |
 		sed -e '1,/^$/d'
-	fi >.editmsg
+	fi >> .editmsg
 	git-status-script >>.editmsg
 fi
 if [ "$?" != "0" -a ! -f $GIT_DIR/MERGE_HEAD ]
@@ -92,11 +113,10 @@ then
 	rm .editmsg
 	exit 1
 fi
-case "$use_commit" in
-'')
-	${VISUAL:-${EDITOR:-vi}} .editmsg
-	;;
-esac
+
+[ -z "$use_commit" -o "$call_editor" = true ] &&
+${VISUAL:-${EDITOR:-vi}} .editmsg
+
 grep -v '^#' < .editmsg | git-stripspace > .cmitmsg
 [ -s .cmitmsg ] && 
 	tree=$(git-write-tree) &&
