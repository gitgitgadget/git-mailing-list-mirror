From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: gitk: bug comparing marked commits
Date: 17 Apr 2009 23:52:02 +0100
Message-ID: <87r5zqao6l.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: paulus@samba.org
X-From: git-owner@vger.kernel.org Sat Apr 18 00:54:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuwwU-0001RV-Ad
	for gcvg-git-2@gmane.org; Sat, 18 Apr 2009 00:53:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757709AbZDQWwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Apr 2009 18:52:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758548AbZDQWwH
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Apr 2009 18:52:07 -0400
Received: from smtp-out2.blueyonder.co.uk ([195.188.213.5]:56041 "EHLO
	smtp-out2.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755518AbZDQWwG (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Apr 2009 18:52:06 -0400
Received: from [172.23.170.140] (helo=anti-virus02-07)
	by smtp-out2.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Luwui-0003OX-5r; Fri, 17 Apr 2009 23:52:04 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1Luwuh-00033p-OF; Fri, 17 Apr 2009 23:52:03 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 5968151836; Fri, 17 Apr 2009 23:52:03 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116802>


I just pulled from gitk and noticed the new 'mark commit' menu
items. While testing to see what they do I get a Tk error when
comparing two dissimilar patches on the same branch which is caused by
a missing parameter to appendwithlinks as fixed by the following
patch.

I also get an error comparing two identical patches (one on my working
branch and one that has been applied to master). For this when marking
the master (476afad) and then calling the 'compare with marked commit'
menu item against my original (f58f01e5) I get:

fatal: bad object 0000000000000000000000000000000000000000
fatal: bad object 0000000000000000000000000000000000000000
    while executing
"exec git diff-tree -p --root $id | git patch-id"
    (procedure "getpatchid" line 5)
    invoked from within
"getpatchid $a"
    (procedure "do_cmp_commits" line 16)
    invoked from within
"do_cmp_commits $markedid $rowmenuid"
    (procedure "compare_commits" line 7)
    invoked from within

although the text widget contains text that says:

Commit 478afad6  gitk: Avoid crash if closed while reading references
 is the same patch as
       f58f01e5  gitk: avoid crash if closed while reading references


The fix for problem 1 is:

diff --git a/gitk b/gitk
index dca1741..d9f4828 100755
--- a/gitk
+++ b/gitk
@@ -8175,7 +8175,7 @@ proc do_cmp_commits {a b} {
 		appendwithlinks [mc "Commit %s  %s\n" $shorta $heada] {}
 		appendwithlinks [mc " differs from\n"] {}
 		appendwithlinks [mc "       %s  %s\n" $shortb $headb] {}
-		appendwithlinks [mc "- stopping\n"]
+		appendwithlinks [mc "- stopping\n"] {}
 		break
 	    }
 	}
