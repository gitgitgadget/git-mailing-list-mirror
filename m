From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 8/8] gitk: show modified files with separate work tree
Date: Mon,  4 Apr 2011 22:14:19 -0400
Message-ID: <1301969659-19703-9-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:17:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6vpZ-0002JM-00
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 04:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049Ab1DECRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 22:17:11 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42634 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942Ab1DECRA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 22:17:00 -0400
Received: by mail-qw0-f46.google.com with SMTP id 3so3719792qwk.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 19:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=JtfJTCxrmiiyjhFj10wRJJev2EHDFILmpyQQxE1KnMc=;
        b=K04SHXzG9J9u8o89t7eVJ+4W2SUg8CY14uiZyqF+0yAmK0nZc+bHxvKPyMKGo5VXWd
         G/6z1W5sbPN8J8cDy34UBevlUchl5oKnCMkh0/9NWCns3H5RLfhXBF842leEoOMJykAi
         UuEDFI+jgrOI4Ic4L9UqCqd0K+6kROOro4tZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ZS/cpOcF8lDs7wi/w7j1vi6h5WFTq+jBwJg4pg6So2MBWQ2YZeDKjq0glJD+IZtX9Y
         aSLw8Ue69KLxnaUAynEcsdhPshtglGsGE3dfihmDu1PXIVHTAHjvSsR8BdS1Cnv3Hsza
         UuvPYTSTZBGTEgUmaGzMgR03t6oSWnbhYfrAE=
Received: by 10.229.197.11 with SMTP id ei11mr6477708qcb.87.1301969820535;
        Mon, 04 Apr 2011 19:17:00 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s16sm3902340qco.13.2011.04.04.19.16.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 19:16:59 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.79.gcbe20
In-Reply-To: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170855>

"git rev-parse --is-inside-work-tree" is currently used to determine
whether to show modified files in gitk (the red and green fake
commits). This does not work if the current directory is not inside
the work tree, as can be the case e.g. if GIT_WORK_TREE is
set. Instead, check if the repository is not bare and that we are not
inside the .git directory.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>

---
Is the test in proc hasworktree good?

Why do git commands that need a work tree not work under .git? Why
don't they show the same output as if they had been run from the work
tree? (Btw, the check for valid work tree does not work for aliases,
so e.g. 'git st', with 'st' as alias for 'status' will show all files
as deleted.)

How do I simplify the Tcl code to just return the boolean right away?

Why is the hasworktree variable reset in updatecommits? The only reason
I can think of is when 'core.worktree' is set/changed, but I don't
think that case worked very well before this series anyway. Should
gitdir also be recalculated?

 gitk-git/gitk |   21 +++++++++++++++------
 1 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 232ea6e..914de8d 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -9,6 +9,15 @@ exec wish "$0" -- "$@"
 
 package require Tk
 
+proc hasworktree {} {
+    if {[expr {[exec git rev-parse --is-bare-repository] == "false"}] &&
+	[expr {[exec git rev-parse --is-inside-git-dir] == "false"}]} {
+	return 1
+    } else {
+	return 0
+    }
+}
+
 # A simple scheduler for compute-intensive stuff.
 # The aim is to make sure that event handlers for GUI actions can
 # run at least every 50-100 ms.  Unfortunately fileevent handlers are
@@ -459,11 +468,11 @@ proc updatecommits {} {
     global viewactive viewcomplete tclencoding
     global startmsecs showneartags showlocalchanges
     global mainheadid viewmainheadid viewmainheadid_orig pending_select
-    global isworktree
+    global hasworktree
     global varcid vposids vnegids vflags vrevs
     global show_notes
 
-    set isworktree [expr {[exec git rev-parse --is-inside-work-tree] == "true"}]
+    set hasworktree [hasworktree]
     rereadrefs
     set view $curview
     if {$mainheadid ne $viewmainheadid_orig($view)} {
@@ -5025,9 +5034,9 @@ proc dohidelocalchanges {} {
 # spawn off a process to do git diff-index --cached HEAD
 proc dodiffindex {} {
     global lserial showlocalchanges vfilelimit curview
-    global isworktree
+    global hasworktree
 
-    if {!$showlocalchanges || !$isworktree} return
+    if {!$showlocalchanges || !$hasworktree} return
     incr lserial
     set cmd "|git diff-index --cached HEAD"
     if {$vfilelimit($curview) ne {}} {
@@ -11617,9 +11626,9 @@ set stopped 0
 set stuffsaved 0
 set patchnum 0
 set lserial 0
-set isworktree [expr {[exec git rev-parse --is-inside-work-tree] == "true"}]
+set hasworktree [hasworktree]
 set cdup {}
-if {$isworktree} {
+if {[expr {[exec git rev-parse --is-inside-work-tree] == "true"}]} {
     set cdup [exec git rev-parse --show-cdup]
 }
 set worktree [exec git rev-parse --show-toplevel]
-- 
1.7.4.79.gcbe20
