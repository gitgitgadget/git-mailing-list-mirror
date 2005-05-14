From: Tejun Heo <htejun@gmail.com>
Subject: [ANNOUNCE] mtkdiff-20050514 (integrated w/ gitk)
Date: Sat, 14 May 2005 11:58:15 +0900
Message-ID: <20050514025815.GA5845@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 04:58:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWmrS-0005yx-Ta
	for gcvg-git@gmane.org; Sat, 14 May 2005 04:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262685AbVENC6a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 May 2005 22:58:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262686AbVENC6a
	(ORCPT <rfc822;git-outgoing>); Fri, 13 May 2005 22:58:30 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:58241 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262685AbVENC6U (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 13 May 2005 22:58:20 -0400
Received: by rproxy.gmail.com with SMTP id a41so483527rng
        for <git@vger.kernel.org>; Fri, 13 May 2005 19:58:20 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=iUedIfjuGcu7Shk4vj72VbI99C/uj1Shk1g6WSVz8XgBHV8xOt6rHg/yXc3xFH9/A+32TbhZY5HQVCCEn50/gHFGSzu7FsK5RmCpZJjmgnprdv2fciRzYSnX/wlApB0BJD15wNixJuvpBiPyfOVIlzu4pFU+ISRNWNBj2arg4Xk=
Received: by 10.38.90.9 with SMTP id n9mr1045485rnb;
        Fri, 13 May 2005 19:58:20 -0700 (PDT)
Received: from htj.dyndns.org ([222.97.233.103])
        by mx.gmail.com with ESMTP id h17sm906984rnb.2005.05.13.19.58.19;
        Fri, 13 May 2005 19:58:20 -0700 (PDT)
Received: by htj.dyndns.org (Postfix, from userid 1000)
	id 030131842A2; Sat, 14 May 2005 11:58:15 +0900 (KST)
To: paulus@samba.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

 Hello, guys.

 This is mtkdiff-20050514.  I've modified gitk to invoke gitkdiff on
double click and right click.  If you double click on a commit mtkdiff
will show the commit.  If you right click on a commit while another
one is selected, mtkdiff will show the difference between the two
commits (as in bk revtool).  Also, I've modified gitk & gitkdiff to
show commit SHA1 in the info text when a commit is selected.

 The tarball can be found at

 http://home-tj.org/mtkdiff/files/mtkdiff-20050514.tar.gz

 Patch of the gitk changes follow.  (gitk-0.9 vs. the modified version)

 Thanks.

--- gitk-0.9	2005-05-14 11:57:02.000000000 +0900
+++ gitk	2005-05-14 11:57:04.000000000 +0900
@@ -175,6 +175,8 @@ proc makewindow {} {
     pack .ctop -side top -fill both -expand 1
 
     bindall <1> {selcanvline %x %y}
+    bindall <Double-1> {canvdclick %x %y}
+    bindall <3> {canvrclick %x %y}
     bindall <B1-Motion> {selcanvline %x %y}
     bindall <ButtonRelease-4> "allcanvs yview scroll -5 u"
     bindall <ButtonRelease-5> "allcanvs yview scroll 5 u"
@@ -473,7 +475,7 @@ proc drawgraph {start} {
     }
 }
 
-proc selcanvline {x y} {
+proc coordtoline {x, y} {
     global canv canvy0 ctext linespc selectedline
     global lineid linehtag linentag linedtag
     set ymax [lindex [$canv cget -scrollregion] 3]
@@ -483,8 +485,38 @@ proc selcanvline {x y} {
     if {$l < 0} {
 	set l 0
     }
-    if {[info exists selectedline] && $selectedline == $l} return
-    selectline $l
+    if {[info exists selectedline] && $selectedline == $l} {
+	return -1
+    }
+    return $l
+}
+
+proc selcanvline {x y} {
+    set l [coordtoline $x, $y]
+    if {$l >= 0} {
+	selectline $l
+    }
+}
+
+proc canvdclick {x y} {
+    global lineid selectedline
+    selcanvline $x $y
+    if {[info exists selectedline]} {
+	exec gitkdiff -r $lineid($selectedline) &
+    }
+}
+
+proc canvrclick {x y} {
+    global selectedline lineid
+
+    if {[info exists selectedline]} {
+	set l [coordtoline $x, $y]
+	if {$selectedline != $l} {
+	    exec gitkdiff -r $lineid($selectedline) -r $lineid($l) &
+	}
+    } else {
+	selcanvline $x $y
+    }
 }
 
 proc selectline {l} {
@@ -521,6 +553,7 @@ proc selectline {l} {
     $ctext conf -state normal
     $ctext delete 0.0 end
     set info $commitinfo($id)
+    $ctext insert end "Commit: $id\n"
     $ctext insert end "Author: [lindex $info 1]  [lindex $info 2]\n"
     $ctext insert end "Committer: [lindex $info 3]  [lindex $info 4]\n"
     $ctext insert end "\n"
