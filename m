From: Johan Herland <johan@herland.net>
Subject: [PATCH 15/15] git-note: Add display of notes to gitk
Date: Sun, 27 May 2007 16:17:18 +0200
Message-ID: <200705271617.19097.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org>
 <alpine.LFD.0.98.0705101116480.3986@woody.linux-foundation.org>
 <200705271608.02122.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <junkio@cox.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 27 16:17:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsJZ8-0007hH-M7
	for gcvg-git@gmane.org; Sun, 27 May 2007 16:17:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752313AbXE0ORq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 May 2007 10:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752900AbXE0ORq
	(ORCPT <rfc822;git-outgoing>); Sun, 27 May 2007 10:17:46 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35330 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752313AbXE0ORp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 May 2007 10:17:45 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JIP00507EDKPU00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:17:44 +0200 (CEST)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP00G2BECVR350@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:17:19 +0200 (CEST)
Received: from alpha.herland ([84.210.6.167])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JIP000L0ECVJB60@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Sun, 27 May 2007 16:17:19 +0200 (CEST)
In-reply-to: <200705271608.02122.johan@herland.net>
Content-disposition: inline
User-Agent: KMail/1.9.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48555>

Teach gitk to display notes below the commit message similarly to how
notes are displayed when using --decorate with git-{log,show,whatchanged}.

Signed-off-by: Johan Herland <johan@herland.net>
---
 gitk |   38 +++++++++++++++++++++++++++++++++++---
 1 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index a57e84c..7bed56b 100755
--- a/gitk
+++ b/gitk
@@ -303,7 +303,7 @@ proc getcommit {id} {
 }
 
 proc readrefs {} {
-    global tagids idtags headids idheads tagcontents
+    global tagids idtags idnotes headids idheads tagcontents
     global otherrefids idotherrefs mainhead
 
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
@@ -318,7 +318,7 @@ proc readrefs {} {
 	if {[regexp {^remotes/.*/HEAD$} $path match]} {
 	    continue
 	}
-	if {![regexp {^(tags|heads)/(.*)$} $path match type name]} {
+	if {![regexp {^(tags|notes|heads)/(.*)$} $path match type name]} {
 	    set type others
 	    set name $path
 	}
@@ -341,6 +341,18 @@ proc readrefs {} {
 	    catch {
 	        set tagcontents($name) [exec git cat-file tag $id]
 	    }
+	} elseif { $type == "notes" } {
+	    puts stderr "note name = '$name', id = '$id'"
+	    lappend idnotes($id) $name
+	    set obj {}
+	    set type {}
+	    set tag {}
+	    catch {
+		set commit [exec git rev-parse "$id^0"]
+		if {$commit != $id} {
+		    lappend idnotes($commit) $id
+		}
+	    }
 	} elseif { $type == "heads" } {
 	    set headids($name) $id
 	    lappend idheads($id) $name
@@ -3864,7 +3876,7 @@ proc selectline {l isnew} {
     global displayorder linehtag linentag linedtag
     global canvy0 linespc parentlist childlist
     global currentid sha1entry
-    global commentend idtags linknum
+    global commentend idtags idnotes linknum
     global mergemax numcommits pending_select
     global cmitmode desc_tags anc_tags showneartags allcommits desc_heads
 
@@ -4009,6 +4021,26 @@ proc selectline {l isnew} {
     $ctext insert end "\n"
     appendwithlinks [lindex $info 5] {comment}
 
+    if {[info exists idnotes($id)]} {
+	$ctext insert end "\nNotes:\n"
+	set notes [exec git note -l "$id"]
+	# strip first line.
+	set firstLineEnd [string first "\n" $notes]
+	if {$firstLineEnd < 0} {
+	    # should never happen...
+	    set hdrend 0
+	}
+	set newnotes [string range $notes [expr {$firstLineEnd + 1}] end]
+	# Indent everything by 4 spaces
+	set notes {}
+	foreach line [split $newnotes "\n"] {
+	    append notes "    $line\n"
+	}
+	# Append to $ctext with auto-highlighting of SHA1 IDs.
+	appendwithlinks $notes {comment}
+	$ctext insert end "\n"
+    }
+
     $ctext tag delete Comments
     $ctext tag remove found 1.0 end
     $ctext conf -state disabled
-- 
1.5.2.101.gee49f
