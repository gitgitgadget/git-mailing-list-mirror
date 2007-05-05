From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: FFmpeg considering GIT
Date: Sat, 5 May 2007 15:30:24 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705051524300.17381@woody.linux-foundation.org>
References: <loom.20070502T111026-882@post.gmane.org>
 <20070503180016.GB21333@informatik.uni-freiburg.de> <20070503200013.GG4489@pasky.or.cz>
 <loom.20070504T143538-533@post.gmane.org> <87y7k4lahq.wl%cworth@cworth.org>
 <20070505133543.GC3379@diana.vm.bytemark.co.uk>
 <alpine.LFD.0.98.0705051019580.3819@woody.linux-foundation.org>
 <alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>,
	Michael Niedermayer <michaelni@gmx.at>,
	Git Mailing List <git@vger.kernel.org>
To: Karl Hasselstr?m <kha@treskal.com>,
	Paul Mackerras <paulus@samba.org>,
	Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 06 00:30:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkSm9-00088c-Lp
	for gcvg-git@gmane.org; Sun, 06 May 2007 00:30:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754349AbXEEWap (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 18:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754512AbXEEWap
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 18:30:45 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:45481 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754349AbXEEWao (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2007 18:30:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l45MUWiB016100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 5 May 2007 15:30:33 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l45MUOLx030946;
	Sat, 5 May 2007 15:30:28 -0700
In-Reply-To: <alpine.LFD.0.98.0705051511020.17381@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.981 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46289>



On Sat, 5 May 2007, Linus Torvalds wrote:
> 
> (It also shows that my "gitk" patch was incorrectly getting the commit 
> name from character 6 onward, even though it should have been 7, but I'll 
> also try to make gitk understand the "<" and ">" markers, and make it 
> possible to say
> 
> 	gitk --left-right a...b
> 
> and have the commits colored appropriately. That would be cool, but it 
> might need more tcl/tk knowledge than I actually possess).

Ok, that turned out to be the case.

Here's an updated patch to gitk, which at least *parses* the 
"--left-right" data properly, it just doesn't use it. But with the fix to 
"git log" I just posted, and this, you at least have the same capabilities 
gitk used to have, and it should be fairly easy for somebody who knows 
tcltk to squirrel away the "leftright" data per commit and use that to 
color the commit lines in the top-most pane.

I'm also sure the "if first character is one of '-'/'<'/'>'" test can be 
written more prettily, rather than have three if-statements on it. 

Finally, it realy _should_ check that the first 7 characters of the commit 
log (the ones it ignores by just asking for substring 7..) are actually 
the exact characters "commit ", but I'll blame my lack of comfort with the 
language again.

Somebody? Please? It really should be pretty cool. Do

	gitk --left-right commit^1...commit^2

for an appropriate 'commit' that is a merge, and the two sides getting 
merged should show up with different colors!

		Linus

----
 gitk |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/gitk b/gitk
index b1c65d7..0bf00ee 100755
--- a/gitk
+++ b/gitk
@@ -33,8 +33,8 @@ proc start_rev_list {view} {
 	set order "--date-order"
     }
     if {[catch {
-	set fd [open [concat | git rev-list --header $order \
-			  --parents --boundary --default HEAD $args] r]
+	set fd [open [concat | git log -z --pretty=raw $order \
+			  --parents --boundary $args] r]
     } err]} {
 	puts stderr "Error executing git rev-list: $err"
 	exit 1
@@ -127,13 +127,23 @@ proc getcommitlines {fd view}  {
 	set start [expr {$i + 1}]
 	set j [string first "\n" $cmit]
 	set ok 0
+	set leftright 0
 	set listed 1
 	if {$j >= 0} {
-	    set ids [string range $cmit 0 [expr {$j - 1}]]
+	    # start with 'commit '
+	    set ids [string range $cmit 7 [expr {$j - 1}]]
 	    if {[string range $ids 0 0] == "-"} {
 		set listed 0
 		set ids [string range $ids 1 end]
 	    }
+	    if {[string range $ids 0 0] == "<"} {
+		set leftright -1
+		set ids [string range $ids 1 end]
+	    }
+	    if {[string range $ids 0 0] == ">"} {
+		set leftright 1
+		set ids [string range $ids 1 end]
+	    }
 	    set ok 1
 	    foreach id $ids {
 		if {[string length $id] != 40} {
@@ -147,7 +157,7 @@ proc getcommitlines {fd view}  {
 	    if {[string length $shortcmit] > 80} {
 		set shortcmit "[string range $shortcmit 0 80]..."
 	    }
-	    error_popup "Can't parse git rev-list output: {$shortcmit}"
+	    error_popup "Can't parse git git log output: {$shortcmit}"
 	    exit 1
 	}
 	set id [lindex $ids 0]
