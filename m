From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK) 2/3] gitk: Register diff-files & diff-index in commfd, to ensure kill.
Date: Fri, 18 Jul 2008 09:46:43 +0400
Organization: TEPKOM
Message-ID: <200807180946.43560.angavrilov@gmail.com>
References: <200807180944.48570.angavrilov@gmail.com> <200807180945.43504.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 18 07:47:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJiop-0002CR-Kr
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 07:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbYGRFqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 01:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751998AbYGRFqx
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 01:46:53 -0400
Received: from ik-out-1112.google.com ([66.249.90.182]:49585 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751995AbYGRFqv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 01:46:51 -0400
Received: by ik-out-1112.google.com with SMTP id c28so110636ika.5
        for <git@vger.kernel.org>; Thu, 17 Jul 2008 22:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=/JYIfX/O20odl8p+EWnOYPZt3/khRPX236l6zPuL+Xk=;
        b=QlwB2X+72lX6zyqsFJtuxR5jT1+g8OCSkTPJtXcE/hLWdNKxnqI12Foqr0TOD8YSc9
         RClqfCO8Unt5QT4Am4NGIxXptKZUmsUfHJ1yV6D+3IVEt3Yr9wuvbqa4vMfJMVhK8Rkd
         SnF/iAxQHVydz7c8OqaCzDZXI4S8POFOGY/zI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HNkxsXq4s4NfITGuKIUOtY6L4cQYUB4m4DC9PBRWbW26k4gpGM/FrSoA62DMI5aSYJ
         KqPvva+4A3GXukpe/5XBMV0jKN+a9dFLThaG+HLLHa360fTPLU2l8yIbtvGfkJVSY3bt
         wBrJirZLU+THpnfp+/raEikMc+98dQvOBLa0I=
Received: by 10.210.52.9 with SMTP id z9mr1900253ebz.12.1216360010377;
        Thu, 17 Jul 2008 22:46:50 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id y34sm1134948iky.10.2008.07.17.22.46.49
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 17 Jul 2008 22:46:49 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200807180945.43504.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88989>

Local change analysis can take a noticeable amount of time on large
file sets, and produce no output if there are no changes. Register
the back-ends in commfd, so that they get properly killed on window
close.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   39 +++++++++++++++++++++++----------------
 1 files changed, 23 insertions(+), 16 deletions(-)

diff --git a/gitk b/gitk
index 29d79d6..b523c98 100755
--- a/gitk
+++ b/gitk
@@ -90,6 +90,15 @@ proc dorunq {} {
     }
 }
 
+proc reg_instance {fd} {
+    global commfd leftover loginstance
+
+    set i [incr loginstance]
+    set commfd($i) $fd
+    set leftover($i) {}
+    return $i
+}
+
 proc unmerged_files {files} {
     global nr_unmerged
 
@@ -294,10 +303,10 @@ proc parseviewrevs {view revs} {
 # Start off a git log process and arrange to read its output
 proc start_rev_list {view} {
     global startmsecs commitidx viewcomplete curview
-    global commfd leftover tclencoding
+    global tclencoding
     global viewargs viewargscmd viewfiles vfilelimit
     global showlocalchanges commitinterest
-    global viewactive loginstance viewinstances vmergeonly
+    global viewactive viewinstances vmergeonly
     global pending_select mainheadid
     global vcanopt vflags vrevs vorigargs
 
@@ -354,10 +363,8 @@ proc start_rev_list {view} {
 	error_popup "[mc "Error executing git log:"] $err"
 	return 0
     }
-    set i [incr loginstance]
+    set i [reg_instance $fd]
     set viewinstances($view) [list $i]
-    set commfd($i) $fd
-    set leftover($i) {}
     if {$showlocalchanges && $mainheadid ne {}} {
 	lappend commitinterest($mainheadid) {dodiffindex}
     }
@@ -420,8 +427,8 @@ proc getcommits {} {
 
 proc updatecommits {} {
     global curview vcanopt vorigargs vfilelimit viewinstances
-    global viewactive viewcomplete loginstance tclencoding
-    global startmsecs commfd showneartags showlocalchanges leftover
+    global viewactive viewcomplete tclencoding
+    global startmsecs showneartags showlocalchanges
     global mainheadid pending_select
     global isworktree
     global varcid vposids vnegids vflags vrevs
@@ -482,10 +489,8 @@ proc updatecommits {} {
     if {$viewactive($view) == 0} {
 	set startmsecs [clock clicks -milliseconds]
     }
-    set i [incr loginstance]
+    set i [reg_instance $fd]
     lappend viewinstances($view) $i
-    set commfd($i) $fd
-    set leftover($i) {}
     fconfigure $fd -blocking 0 -translation lf -eofchar {}
     if {$tclencoding != {}} {
 	fconfigure $fd -encoding $tclencoding
@@ -4063,10 +4068,11 @@ proc dodiffindex {} {
     incr lserial
     set fd [open "|git diff-index --cached HEAD" r]
     fconfigure $fd -blocking 0
-    filerun $fd [list readdiffindex $fd $lserial]
+    set i [reg_instance $fd]
+    filerun $fd [list readdiffindex $fd $lserial $i]
 }
 
-proc readdiffindex {fd serial} {
+proc readdiffindex {fd serial inst} {
     global mainheadid nullid nullid2 curview commitinfo commitdata lserial
 
     set isdiff 1
@@ -4077,7 +4083,7 @@ proc readdiffindex {fd serial} {
 	set isdiff 0
     }
     # we only need to see one line and we don't really care what it says...
-    close $fd
+    stop_instance $inst
 
     if {$serial != $lserial} {
 	return 0
@@ -4086,7 +4092,8 @@ proc readdiffindex {fd serial} {
     # now see if there are any local changes not checked in to the index
     set fd [open "|git diff-files" r]
     fconfigure $fd -blocking 0
-    filerun $fd [list readdifffiles $fd $serial]
+    set i [reg_instance $fd]
+    filerun $fd [list readdifffiles $fd $serial $i]
 
     if {$isdiff && ![commitinview $nullid2 $curview]} {
 	# add the line for the changes in the index to the graph
@@ -4103,7 +4110,7 @@ proc readdiffindex {fd serial} {
     return 0
 }
 
-proc readdifffiles {fd serial} {
+proc readdifffiles {fd serial inst} {
     global mainheadid nullid nullid2 curview
     global commitinfo commitdata lserial
 
@@ -4115,7 +4122,7 @@ proc readdifffiles {fd serial} {
 	set isdiff 0
     }
     # we only need to see one line and we don't really care what it says...
-    close $fd
+    stop_instance $inst
 
     if {$serial != $lserial} {
 	return 0
-- 
1.5.6.2.39.gd084
