From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] cg-completion: improve options and command listing
Date: Sun, 11 Dec 2005 20:09:31 +0100
Message-ID: <20051211190931.GF2960@diku.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sun Dec 11 20:09:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElWZj-0007ah-T9
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 20:09:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750800AbVLKTJd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 14:09:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbVLKTJd
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 14:09:33 -0500
Received: from nhugin.diku.dk ([130.225.96.140]:8442 "EHLO nhugin.diku.dk")
	by vger.kernel.org with ESMTP id S1750800AbVLKTJd (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Dec 2005 14:09:33 -0500
Received: by nhugin.diku.dk (Postfix, from userid 754)
	id A192E6DFD14; Sun, 11 Dec 2005 20:08:32 +0100 (CET)
Received: from ask.diku.dk (ask.diku.dk [130.225.96.225])
	by nhugin.diku.dk (Postfix) with ESMTP
	id 4009C6DFD25; Sun, 11 Dec 2005 20:08:32 +0100 (CET)
Received: by ask.diku.dk (Postfix, from userid 3873)
	id A8634615B3; Sun, 11 Dec 2005 20:09:31 +0100 (CET)
To: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, hits=-4.9 required=5.0 tests=BAYES_00 autolearn=ham 
	version=2.60
X-Spam-Checker-Version: SpamAssassin 2.60 (1.212-2003-09-23-exp) on 
	nhugin.diku.dk
X-Spam-Level: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13504>

Complete help options and improve filtering for command name completion.

Signed-off-by: Jonas Fonseca <fonseca@diku.dk>

---

 The current filtering causes all sorts of garbage to be listed in the
 command listing.

commit f0535e9952f1cace89d03649e8238aca69a6df44
tree e05dfadb63bd92ead0dc29d326065b7a797e2109
parent 3c14cded46e110396127fc5b5e65883eb5cd60b9
author Jonas Fonseca <fonseca@diku.dk> Wed, 07 Dec 2005 20:58:50 +0100
committer Jonas Fonseca <fonseca@antimatter.localdomain> Wed, 07 Dec 2005 20:58:50 +0100

 contrib/cg-completion.bash |   25 ++++++++++++-------------
 1 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/contrib/cg-completion.bash b/contrib/cg-completion.bash
index 428f320..20b758f 100644
--- a/contrib/cg-completion.bash
+++ b/contrib/cg-completion.bash
@@ -23,8 +23,7 @@ __cg_branches()
 
 __cg_cmdlist()
 {
-	(cg help && cg help tag && cg help branch && cg help admin) | grep --regexp "cg-[^ ]* " | sed 's/^.*\cg-\([^ ]*\) .*$/\1/' | grep -v COMMAND
-
+	(cg help && cg help tag && cg help branch && cg help admin) | sed -n 's/.*cg-\([^ ]*\) .*/\1/p' | sort -u
 }
 
 _cg ()
@@ -33,17 +32,17 @@ _cg ()
     cur=${COMP_WORDS[COMP_CWORD]}
     COMPREPLY=()
     if [ $COMP_CWORD -eq 1 ]; then
-	COMPREPLY=( $(compgen -W "$(__cg_cmdlist)" -- $cur) )
+	COMPREPLY=( $(compgen -W "$(__cg_cmdlist) -h --help --version" -- $cur) )
     else
 	local cmd=${COMP_WORDS[1]}
 	local prev=${COMP_WORDS[COMP_CWORD-1]}
-	local o_help="-h --help"
+	local o_help="-h --help --long-help"
 	local o_branch="-b --branch"
 	case $cmd in
 	    add)
 	    # cg-add [-N] [-r] file...
 	    # XXX here could generate list of files and dirs excluding .git
-	    opts="-N -r"
+	    opts="-N -r $o_help"
 	    COMPREPLY=( $(compgen -d -f -W "${opts}" -- $cur ) )
 	    ;;
 
@@ -58,18 +57,18 @@ _cg ()
 
 	    clean)
 	    # Usage: cg-clean [-d] [-D] [-q] [-x]
-	    opts="-d -D -q -x"
+	    opts="-d -D -q -x $o_help"
 	    COMPREPLY=( $(compgen -W "${opts}" -- $cur ) )
 	    ;;
 
 	    help)
-	    opts="-c"
+	    opts="-c $o_help"
 	    COMPREPLY=( $(compgen -W "$(__cg_cmdlist) ${opts}" -- $cur) )
 	    ;;
 
 	    push)
 	    # cg-push [BRANCH_NAME] [-t TAG]
-	    opts="-t" 
+	    opts="-t $o_help" 
 	    if [ "$prev" = "-t" ]; then 
 	        COMPREPLY=( $(compgen -W "$(__git_tags)" -- $cur) )
 	    else
@@ -79,7 +78,7 @@ _cg ()
 
 	    merge)
 	    # cg-merge [-c] [-b BASE_COMMIT] [BRANCH_NAME]
-	    opts="-c -b" 
+	    opts="-c -b $o_help" 
 	    if [ "$prev" = "-b" ]; then 
 	        COMPREPLY=( $(compgen -W "$(__git_refs)" -- $cur) )
 	    else
@@ -89,7 +88,7 @@ _cg ()
 
 	    commit) 
             # cg-commit [-m MESSAGE]... [-C] [-e | -E] [-c COMMIT_ID] [FILE]
-	    opts="-m -C -e -E -c" 
+	    opts="-m -C -e -E -c $o_help" 
 	    if [ "$prev" = "-m" ]; then 
 		COMPREPLY="\"\""
 	    elif [ "$prev" = "-c" ]; then 
@@ -101,7 +100,7 @@ _cg ()
 
 	    diff)
             # cg-diff [-c] [-m] [-s] [-p] [-r FROM_ID[:TO_ID]] [FILE]...
-            opts="-c -m -s -p -r"
+            opts="-c -m -s -p -r $o_help"
 	    if [ "$prev" = "-r" ]; then 
             # TODO need some kinkiness to handle -r FROM:TO completion
 		COMPREPLY=( $(compgen -W "$(__git_refs)" -- $cur) )
@@ -111,7 +110,7 @@ _cg ()
 	    ;;
 
 	    log)
-            opts="-c -f -r -d -m -s -u --summary"
+            opts="-c -f -r -d -m -s -u --summary $o_help"
 	    if [ "$prev" = "-r" ]; then 
             # TODO need some kinkiness to handle -r FROM:TO completion
 		COMPREPLY=( $(compgen -W "$(__git_refs)" -- $cur) )
@@ -131,7 +130,7 @@ _cg ()
 	    ;;
 	    switch)
 	    # Usage: cg-switch [-f] [-n] [-r COMMIT_ID] BRANCH
-	    opts="-f -n -r"  # TODO -r 
+	    opts="-f -n -r $o_help"  # TODO -r 
 	    COMPREPLY=( $(compgen -W "${opts} $(__git_heads)" -- $cur) )
 	    ;;
 

-- 
Jonas Fonseca
