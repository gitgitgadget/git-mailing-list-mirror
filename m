From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK BUGFIX)] gitk: Allow safely calling nukefile from a run queue handler.
Date: Sat, 9 Aug 2008 14:41:50 +0400
Organization: TEPKOM
Message-ID: <200808091441.50444.angavrilov@gmail.com>
References: <42d19ab224653b2e6988d7209a8d3e87e19858f8.1218207346.git.christian@jaeger.mine.nu> <200808091313.52528.angavrilov@gmail.com> <217ad8e755d8d51e2ec0f06b4bffa0864976f7e4.1218277122.git.christian@jaeger.mine.nu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Christian Jaeger <christian@jaeger.mine.nu>
X-From: git-owner@vger.kernel.org Sat Aug 09 12:43:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRluw-0008Ob-Cf
	for gcvg-git-2@gmane.org; Sat, 09 Aug 2008 12:43:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbYHIKmH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Aug 2008 06:42:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751314AbYHIKmG
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Aug 2008 06:42:06 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:33414 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751181AbYHIKmD (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Aug 2008 06:42:03 -0400
Received: by fg-out-1718.google.com with SMTP id 19so723455fgg.17
        for <git@vger.kernel.org>; Sat, 09 Aug 2008 03:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=bwMHlUplsAcNq9aFYg5e7izZZoenM2cCR1YDP+GZA0g=;
        b=D2Bberwbe1PastdjUxIj1NhY+FMn5VM5iqGFiO3PmMVJslizYnSgWkriyCPr/NbwYG
         ywHluAlLtErjiFqt02KN+1BbN6CKrB6/MfjYnROCIRGaEXhiysjsoyCAAms2Hwa3mySN
         R5z/N9rg8khKDxg1KMPGoA10VMQk2QFpl7kKk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=fRn1P0xQllD3Oobg1D6uZ9JM4Mdu2rD10OAhf/c385UdC45wum30lnnH+H/TMfUV1z
         Em6gUP21vbgmhQlrsdy82MFcZsmljG91A09rv1C1yIOJHY2bPU03ncv3CVNMAwXZjBz5
         MObA3vh/JNNAyA9eZwgKiEoAx5mg1R7QQVgu8=
Received: by 10.86.28.2 with SMTP id b2mr4474761fgb.31.1218278521468;
        Sat, 09 Aug 2008 03:42:01 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id l19sm3721674fgb.7.2008.08.09.03.41.59
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 09 Aug 2008 03:42:00 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <217ad8e755d8d51e2ec0f06b4bffa0864976f7e4.1218277122.git.christian@jaeger.mine.nu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91763>

Originally dorunq assumed that the queue entry remained first
in the queue after the script eval, and blindly removed it.
However, if the handler calls nukefile, it may not be the
case anymore, and a random queue entry gets dropped instead.

This patch makes dorunq remove the entry before calling the
script, and adds a global variable to allow other functions
to determine if they are called from within a dorunq handler.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---

	On Saturday 09 August 2008 14:04:43 Christian Jaeger wrote:
	> gitk would not show diffs (or trees when choosing tree view) about
	> half of the times it is started, it would only show the commit
	> messages. Sometimes it took dozens of times to get it to show a diff
	> again, then show it again the next 3 starts, then the next 2 starts
	> not, then the next 2 starts would show it again, and so on.
	
	I think I guessed the cause of this bug: if two or more files
	become ready for reading at once, and the first one in the queue
	calls nukefile on itself, the next one will get silently dropped from
	the queue. If the second one was a diff pipe, the diff system gets
	wedged until gitk is restarted.
 
	Please test if this patch fixes it.

	-- Alexander


 gitk |   14 ++++++++------
 1 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/gitk b/gitk
index b523c98..18d000c 100755
--- a/gitk
+++ b/gitk
@@ -22,11 +22,11 @@ proc gitdir {} {
 # run before X event handlers, so reading from a fast source can
 # make the GUI completely unresponsive.
 proc run args {
-    global isonrunq runq
+    global isonrunq runq currunq
 
     set script $args
     if {[info exists isonrunq($script)]} return
-    if {$runq eq {}} {
+    if {$runq eq {} && ![info exists currunq]} {
 	after idle dorunq
     }
     lappend runq [list {} $script]
@@ -38,10 +38,10 @@ proc filerun {fd script} {
 }
 
 proc filereadable {fd script} {
-    global runq
+    global runq currunq
 
     fileevent $fd readable {}
-    if {$runq eq {}} {
+    if {$runq eq {} && ![info exists currunq]} {
 	after idle dorunq
     }
     lappend runq [list $fd $script]
@@ -60,17 +60,19 @@ proc nukefile {fd} {
 }
 
 proc dorunq {} {
-    global isonrunq runq
+    global isonrunq runq currunq
 
     set tstart [clock clicks -milliseconds]
     set t0 $tstart
     while {[llength $runq] > 0} {
 	set fd [lindex $runq 0 0]
 	set script [lindex $runq 0 1]
+	set currunq [lindex $runq 0]
+	set runq [lrange $runq 1 end]
 	set repeat [eval $script]
+	unset currunq
 	set t1 [clock clicks -milliseconds]
 	set t [expr {$t1 - $t0}]
-	set runq [lrange $runq 1 end]
 	if {$repeat ne {} && $repeat} {
 	    if {$fd eq {} || $repeat == 2} {
 		# script returns 1 if it wants to be readded
-- 
1.6.0.rc2
