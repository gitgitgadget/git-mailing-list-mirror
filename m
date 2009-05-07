From: "Yann Dirson" <ydirson@altern.org>
Subject: [RFC PATCH] gitk: showing onging merge as such
Date: Thu, 7 May 2009 14:37:49 +0200 (CEST)
Message-ID: <33880.10.0.0.1.1241699869.squirrel@intranet.linagora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 07 14:37:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M22rI-0005xI-KP
	for gcvg-git-2@gmane.org; Thu, 07 May 2009 14:37:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757272AbZEGMho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2009 08:37:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754428AbZEGMho
	(ORCPT <rfc822;git-outgoing>); Thu, 7 May 2009 08:37:44 -0400
Received: from alderaan.linagora.com ([84.14.148.74]:43329 "EHLO
	alderaan.linagora.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbZEGMhn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2009 08:37:43 -0400
Received: from 10.0.0.2 (unknown [10.75.192.3])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by alderaan.linagora.com (Postfix) with ESMTPSA id ADFEF429F2D
	for <git@vger.kernel.org>; Thu,  7 May 2009 14:37:43 +0200 (CEST)
Received: from 10.0.0.1 (proxying for 194.206.158.221)
        (SquirrelMail authenticated user ydirson)
        by intranet.linagora.com with HTTP;
        Thu, 7 May 2009 14:37:49 +0200 (CEST)
User-Agent: SquirrelMail/1.4.11
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118471>

>While resolving a conflicted merge, I wondered if there was any reason why
>gitk does not show that we are indeed doing a merge, by showing the staged
>contents as a merge commit if MERGE_HEAD is found.
>
>Is there any reason why we would not do this ?
>
>I had a quick try at how this could be done, here it is.  The diff is not
>yet displayed as combined.

I'm lucky I did not advertise the patch yet as being right below :)

>From e3f3d8e04a05dfc5961671ab36bbd0541a03433b Mon Sep 17 00:00:00 2001
From: Yann Dirson <ydirson@altern.org>
Date: Thu, 7 May 2009 13:44:54 +0200
Subject: [PATCH] gitk: crude addition of ongoing merge.

---
 gitk-git/gitk |   50 ++++++++++++++++++++++++++++++--------------------
 1 files changed, 30 insertions(+), 20 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 1a7887b..863dde2 100644
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -918,29 +918,31 @@ proc insertrow {id p v} {
     }
 }

-proc insertfakerow {id p} {
+proc insertfakerow {id pl} {
     global varcid varccommits parents children cmitlisted
     global commitidx varctok vtokmod targetid targetrow curview numcommits

     set v $curview
-    set a $varcid($v,$p)
-    set i [lsearch -exact $varccommits($v,$a) $p]
-    if {$i < 0} {
-	puts "oops: insertfakerow can't find [shortids $p] on arc $a"
-	return
-    }
     set children($v,$id) {}
-    set parents($v,$id) [list $p]
-    set varcid($v,$id) $a
-    lappend children($v,$p) $id
+    set parents($v,$id) $pl
     set cmitlisted($v,$id) 1
     set numcommits [incr commitidx($v)]
-    # note we deliberately don't update varcstart($v) even if $i == 0
-    set varccommits($v,$a) [linsert $varccommits($v,$a) $i $id]
-    modify_arc $v $a $i
-    if {[info exists targetid]} {
-	if {![comes_before $targetid $p]} {
-	    incr targetrow
+    foreach p $pl {
+	set a $varcid($v,$p)
+	set i [lsearch -exact $varccommits($v,$a) $p]
+	if {$i < 0} {
+	    puts "oops: insertfakerow can't find [shortids $p] on arc $a"
+	    return
+	}
+	set varcid($v,$id) $a
+	lappend children($v,$p) $id
+	# note we deliberately don't update varcstart($v) even if $i == 0
+	set varccommits($v,$a) [linsert $varccommits($v,$a) $i $id]
+	modify_arc $v $a $i
+	if {[info exists targetid]} {
+	    if {![comes_before $targetid $p]} {
+		incr targetrow
+	    }
 	}
     }
     setcanvscroll
@@ -4595,7 +4597,6 @@ proc ntimes {n o} {

 proc ordertoken {id} {
     global ordertok curview varcid varcstart varctok curview parents
children
-    global nullid nullid2

     if {[info exists ordertok($id)]} {
 	return $ordertok($id)
@@ -4811,7 +4812,7 @@ proc dodiffindex {} {

 proc readdiffindex {fd serial inst} {
     global viewmainheadid nullid nullid2 curview commitinfo commitdata
lserial
-    global vfilelimit
+    global vfilelimit gitdir

     set isdiff 1
     if {[gets $fd line] < 0} {
@@ -4838,14 +4839,23 @@ proc readdiffindex {fd serial inst} {
     filerun $fd [list readdifffiles $fd $serial $i]

     if {$isdiff && ![commitinview $nullid2 $curview]} {
+	set heads [list]
 	# add the line for the changes in the index to the graph
 	set hl [mc "Local changes checked in to index but not committed"]
+	if {[catch {
+	    # get the last line from .git/MERGE_HEAD
+	    set f [open [file join $gitdir MERGE_HEAD] r]
+	    set heads [lrange [split [read $f] "\n"] 0 end-1]
+	    close $f
+	} err]} {
+	    #error_popup "This is NO merge"
+	}
 	set commitinfo($nullid2) [list  $hl {} {} {} {} "    $hl\n"]
 	set commitdata($nullid2) "\n    $hl\n"
 	if {[commitinview $nullid $curview]} {
 	    removefakerow $nullid
 	}
-	insertfakerow $nullid2 $viewmainheadid($curview)
+	insertfakerow $nullid2 [concat $viewmainheadid($curview) $heads]
     } elseif {!$isdiff && [commitinview $nullid2 $curview]} {
 	if {[commitinview $nullid $curview]} {
 	    removefakerow $nullid
@@ -4883,7 +4893,7 @@ proc readdifffiles {fd serial inst} {
 	} else {
 	    set p $viewmainheadid($curview)
 	}
-	insertfakerow $nullid $p
+	insertfakerow $nullid [list $p]
     } elseif {!$isdiff && [commitinview $nullid $curview]} {
 	removefakerow $nullid
     }
-- 
1.6.3.rc3
