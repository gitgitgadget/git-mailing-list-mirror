From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: gitk: Turn short SHA1 names into links too
Date: Thu, 25 Sep 2008 17:11:42 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0809251657080.3265@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Fri Sep 26 02:13:03 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kj0x8-0005R7-5J
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 02:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751786AbYIZALr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Sep 2008 20:11:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752699AbYIZALq
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Sep 2008 20:11:46 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42550 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750938AbYIZALq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Sep 2008 20:11:46 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8Q0BgHe000516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 25 Sep 2008 17:11:43 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m8Q0BgEp015550;
	Thu, 25 Sep 2008 17:11:42 -0700
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.432 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96820>


Ok, so I'm a newbie when it comes to tcl/tk, but I can do copy-paste and 
make things work. 

And the thing I wanted to work was to have the abbreviated SHA1's that 
have started to get more common in the kernel commit logs work as links in 
gitk too, just the way a full 40-character SHA1 link works.

This patch does seem to work, but it's also buggy in exactly the same ways 
the regular 40-character links are buggy, and while I find those bugs 
very irritating _too_, I can't cut-and-paste myself to a solution for 
that.

The pre-existing bugs that this shares with the long links are:

 - since gitk started doing incremental showing of the graph, the whole 
   "check if it exists" doesn't work right if the target hasn't been 
   loaded yet. And when it _does_ end up being loaded one second later, 
   nothing re-does the scanning.

   This is just a small irritation, but it's quite common when the first 
   commit that is displayed has a link. You can fix it by moving to the 
   next commit and moving right back (cursor-down + cursor-up), which will 
   re-display the commit and now find the link that wasn't available 
   initially, but it's still irritating.

   I think gitk could re-display the commit it is on when the whole list 
   of commits has been parsed, and at least then show the links it missed 
   initially after a few seconds.

 - slightly related to the above: when we _do_ find a link, we create it 
   to be a link to line so-and-so, but since we now don't just 
   incrementally parse the commits that come in, but gitk _also_ actually 
   reflows the commits to be in topological order, the link we just 
   created may actually no longer point to the right line by the time the 
   link is then clicked on, so clicking on a link can actually take you to 
   the wrong commit!

   Again, re-displaying the current commit after we have gotten and 
   parsed all commits will fix it, but this is a more fundamental problem: 
   if we redisplay at the end, there is still a window when the link may 
   simply be wrong, because we've redone the topo sort, but we haven't 
   seen _all_ commits yet.

   But again, you can work around it by going back and retrying, and at 
   some time it will stabilize. But this one is _really_ irritating when 
   it triggers, because it can make you look at the wrong commit without 
   necessarily realizing it was wrong!

I suspect that the correct fix is to always do the link, whether we 
actually see it or not, and not make it point to a line number, but simply 
keep it as a SHA1, and then do the equivalent of "gotocommit" when 
clicking it. But I don't know how links workin tcl/tk, so I'm not going to 
be able to do that.

In the meantime, this patch introduces no new bugs, and the workarounds 
are the same for abbreviated SHA1's as they are for the full ones.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

I'm sure it could have been done better. In particular, I think the 
"short->long" translation could/should probably be a function of its own. 
But I'm so uncomfortable with wish programming that I'm not starting to 
write any new functions..

Comments? Paul?

			Linus

 gitk-git/gitk |   15 +++++++++++++--
 1 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 2eaa2ae..f79643a 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -5759,7 +5759,7 @@ proc appendwithlinks {text tags} {
 
     set start [$ctext index "end - 1c"]
     $ctext insert end $text $tags
-    set links [regexp -indices -all -inline {[0-9a-f]{40}} $text]
+    set links [regexp -indices -all -inline {[0-9a-f]{6,40}} $text]
     foreach l $links {
 	set s [lindex $l 0]
 	set e [lindex $l 1]
@@ -5773,7 +5773,18 @@ proc appendwithlinks {text tags} {
 }
 
 proc setlink {id lk} {
-    global curview ctext pendinglinks commitinterest
+    global curview ctext pendinglinks commitinterest varcid
+
+    # Turn a short ID into a full one
+    if {[regexp {^[0-9a-f]{4,39}$} $id]} {
+        set matches [array names varcid "$curview,$id*"]
+        if {$matches ne {}} {
+            if {[llength $matches] > 1} {
+                return
+            }
+            set id [lindex [split [lindex $matches 0] ","] 1]
+        }
+    }
 
     if {[commitinview $id $curview]} {
 	$ctext tag conf $lk -foreground blue -underline 1
