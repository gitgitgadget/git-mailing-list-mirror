From: Theodore Tso <tytso@mit.edu>
Subject: Re: [PATCH] mergetool: Add support for vimdiff.
Date: Sun, 18 Mar 2007 22:18:27 -0400
Message-ID: <20070319021827.GB11371@thunk.org>
References: <11742569263141-git-send-email-jbowes@dangerouslyinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, junkio@cox.net
To: James Bowes <jbowes@dangerouslyinc.com>
X-From: git-owner@vger.kernel.org Mon Mar 19 03:18:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT7SE-0006Ca-2Y
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 03:18:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933652AbXCSCSd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 22:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933660AbXCSCSd
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 22:18:33 -0400
Received: from THUNK.ORG ([69.25.196.29]:49497 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933652AbXCSCSc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 22:18:32 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HT7Xy-0001L5-65; Sun, 18 Mar 2007 22:24:30 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HT7S7-00046o-JF; Sun, 18 Mar 2007 22:18:27 -0400
Content-Disposition: inline
In-Reply-To: <11742569263141-git-send-email-jbowes@dangerouslyinc.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42561>

Hi James,

	Thanks for adding vimdiff support!  One minor nit, which I
fixed before applying to my tree:  You didn't update git-mergetool.txt
and config.txt in the Documentation directory to add "vimdiff" to the
list of possible merge resolution tools.

Junio, please pull from:

	git://repo.or.cz/git/mergetool.git

						- Ted

commit 9cec65399d3575774910b21c1cfd762a5e88a245
Author: James Bowes <jbowes@dangerouslyinc.com>
Date:   Sun Mar 18 22:11:54 2007 -0400

    mergetool: Add support for vimdiff.
    
    Signed-off-by: James Bowes <jbowes@dangerouslyinc.com>
    Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 953acae..6688642 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -460,7 +460,7 @@ merge.summary::
 merge.tool::
 	Controls which merge resolution program is used by
 	gitlink:git-mergetool[l].  Valid values are: "kdiff3", "tkdiff",
-	"meld", "xxdiff", "emerge"
+	"meld", "xxdiff", "emerge", "vimdiff"
 
 merge.verbosity::
 	Controls the amount of output shown by the recursive merge
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index ae69a0e..5baaaca 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -25,7 +25,7 @@ OPTIONS
 -t or --tool=<tool>::
 	Use the merge resolution program specified by <tool>.
 	Valid merge tools are:
-	kdiff3, tkdiff, meld, xxdiff, and emerge.
+	kdiff3, tkdiff, meld, xxdiff, emerge, and vimdiff.
 
 	If a merge resolution program is not specified, 'git mergetool'
 	will use the configuration variable merge.tool.  If the
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 52386a5..563c5c0 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -185,9 +185,9 @@ merge_file () {
 		mv -- "$BACKUP" "$path.orig"
 	    fi
 	    ;;
-	meld)
+	meld|vimdiff)
 	    touch "$BACKUP"
-	    meld -- "$LOCAL" "$path" "$REMOTE"
+	    $merge_tool -- "$LOCAL" "$path" "$REMOTE"
 	    if test "$path" -nt "$BACKUP" ; then
 		status=0;
 	    else
@@ -305,6 +305,8 @@ if test -z "$merge_tool" ; then
 	merge_tool=meld
     elif type emacs >/dev/null 2>&1; then
 	merge_tool=emerge
+    elif type vimdiff >/dev/null 2>&1; then
+	merge_tool=vimdiff
     else
 	echo "No available merge resolution programs available."
 	exit 1
@@ -312,7 +314,7 @@ if test -z "$merge_tool" ; then
 fi
 
 case "$merge_tool" in
-    kdiff3|tkdiff|meld|xxdiff)
+    kdiff3|tkdiff|meld|xxdiff|vimdiff)
 	if ! type "$merge_tool" > /dev/null 2>&1; then
 	    echo "The merge tool $merge_tool is not available"
 	    exit 1
