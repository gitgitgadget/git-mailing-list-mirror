From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH v2 8/8] gitk: show modified files with separate work tree
Date: Mon, 23 May 2011 22:44:08 -0400
Message-ID: <1306205048-9747-1-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1301969659-19703-9-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue May 24 04:44:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QOhbb-00044P-IG
	for gcvg-git-2@lo.gmane.org; Tue, 24 May 2011 04:44:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753334Ab1EXCoS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 May 2011 22:44:18 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47452 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752824Ab1EXCoR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 May 2011 22:44:17 -0400
Received: by vws1 with SMTP id 1so4619375vws.19
        for <git@vger.kernel.org>; Mon, 23 May 2011 19:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=zsWsSMbvv2BON3iGdHWz7yOI+3psNcTwbPVNm/u7BeA=;
        b=AeI+Hp5KtiMaj9L/yYs/G/TOcLac7MBBwqN0yCy07UmJ4Fn+oOi2aZBLsC/dFCHdqj
         VOXmcHHqqO/C6PK5AqKyIZg3UyW+DLgQVzGwyKYAwtw37dA1UYOcXMZepP6k02unGTwi
         G1Kwr8IlWy+leV1TMuEXIr5aRoNwRsnJ7fIOo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=fjDZ+WnhMMdq2606pBpiMGdGLnu+NohEeZJrNqFfFuMJXCof00arEo1N6mchAva9Zm
         7Ux266/cikyoWdhalGxgo1RiRVTgzeuD6QCYo0hRGMu5Z4WomizOVyUNbXHdLhqbr2wb
         RyGoXoMy1KcSbAgM4LveGl1x0/MZVJ4RXPfsc=
Received: by 10.52.97.167 with SMTP id eb7mr2060678vdb.221.1306205056924;
        Mon, 23 May 2011 19:44:16 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id e3sm1236085vcn.3.2011.05.23.19.44.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 May 2011 19:44:15 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.79.gcbe20
In-Reply-To: <1301969659-19703-9-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174311>

"git rev-parse --is-inside-work-tree" is currently used to determine
whether to show modified files in gitk (the red and green fake
commits). This does not work if the current directory is not inside
the work tree, as can be the case e.g. if GIT_WORK_TREE is
set. Instead, check if the repository is not bare and that we are not
inside the .git directory.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

The only change since v1 is that the hasworktree procedure has been
simplified. I was conservative and left the recalculatation of
hasworktree in updatecommits(). There are no changes to any of the
other patches, so I didn't bother resending them. Sorry about the long
delay for such a trivial fixup.


 gitk-git/gitk |   17 +++++++++++------
 1 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 10b2bca..01b63e5 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -9,6 +9,11 @@ exec wish "$0" -- "$@"
 
 package require Tk
 
+proc hasworktree {} {
+    return [expr {[exec git rev-parse --is-bare-repository] == "false" &&
+		  [exec git rev-parse --is-inside-git-dir] == "false"}]
+}
+
 # A simple scheduler for compute-intensive stuff.
 # The aim is to make sure that event handlers for GUI actions can
 # run at least every 50-100 ms.  Unfortunately fileevent handlers are
@@ -459,11 +464,11 @@ proc updatecommits {} {
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
@@ -5026,9 +5031,9 @@ proc dohidelocalchanges {} {
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
@@ -11621,9 +11626,9 @@ set stopped 0
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
