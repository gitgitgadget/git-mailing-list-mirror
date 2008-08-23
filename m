From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GITK,GIT-GUI,DOCS) 2/7] gitk: Support calling git gui blame from gitk.
Date: Sat, 23 Aug 2008 12:29:08 +0400
Organization: TEPKOM
Message-ID: <200808231229.09191.angavrilov@gmail.com>
References: <200808231225.12596.angavrilov@gmail.com> <200808231227.45013.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Paul Mackerras <paulus@samba.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 23 10:30:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KWoWL-0003eL-Ji
	for gcvg-git-2@gmane.org; Sat, 23 Aug 2008 10:30:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbYHWI3Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Aug 2008 04:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751716AbYHWI3Z
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Aug 2008 04:29:25 -0400
Received: from fk-out-0910.google.com ([209.85.128.189]:7483 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbYHWI3X (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Aug 2008 04:29:23 -0400
Received: by fk-out-0910.google.com with SMTP id 18so488104fkq.5
        for <git@vger.kernel.org>; Sat, 23 Aug 2008 01:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hmaswfxu27wQ7E43TEzZQhv5DvBrb2s/rgHG6Io03O0=;
        b=gJGzU9r167rZloCeMwZ87hyahyjSSSdOpKChdy/Qs8ZxiQufJk1JfCwydsLCv+BKkM
         mzKxOvCFR4/gO0QpcuT2d2JiLxIoSS8pxWhGZfTuBt2qacX0FHVWHgBil5io56S70pFA
         021rJfmX/KXnk1nPbAyCjQO9NgPKV8VLdL4BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=jktMJsOwVQS+CbLXbhVz8trvK6ORyJ3nQSmsALqKRCs2Ek8EgmdGvKIRI+oFyQFQvL
         QnR4/or18MBNEsxf8p3hslI5RxahTnBte9rnowhtK5AtGWb6SKJCAVXqz65hR3PXfl2o
         UhgRjgOq7itKBtH9X0sbDUiRbpHm6STQO1ucw=
Received: by 10.181.13.19 with SMTP id q19mr1116848bki.102.1219480161444;
        Sat, 23 Aug 2008 01:29:21 -0700 (PDT)
Received: from desktop2 ( [92.255.85.78])
        by mx.google.com with ESMTPS id p9sm2018934fkb.5.2008.08.23.01.29.20
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 23 Aug 2008 01:29:20 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200808231227.45013.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93435>

Add a new item to the file list popup menu, that
calls git gui blame for the selected file, starting
with the first parent of the current commit.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 gitk |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/gitk b/gitk
index 7698b70..2eaa2ae 100755
--- a/gitk
+++ b/gitk
@@ -2214,6 +2214,8 @@ proc makewindow {} {
 	-command {flist_hl 1}
     $flist_menu add command -label [mc "External diff"] \
         -command {external_diff}
+    $flist_menu add command -label [mc "Blame parent commit"] \
+        -command {external_blame 1}
 }
 
 # Windows sends all mouse wheel events to the current focused window, not
@@ -3021,6 +3023,27 @@ proc external_diff {} {
     }
 }
 
+proc external_blame {parent_idx} {
+    global flist_menu_file
+    global nullid nullid2
+    global parentlist selectedline currentid
+
+    if {$parent_idx > 0} {
+	set base_commit [lindex $parentlist $selectedline [expr {$parent_idx-1}]]
+    } else {
+	set base_commit $currentid
+    }
+
+    if {$base_commit eq {} || $base_commit eq $nullid || $base_commit eq $nullid2} {
+	error_popup [mc "No such commit"]
+	return
+    }
+
+    if {[catch {exec git gui blame $base_commit $flist_menu_file &} err]} {
+	error_popup [mc "git gui blame: command failed: $err"]
+    }
+}
+
 # delete $dir when we see eof on $f (presumably because the child has exited)
 proc delete_at_eof {f dir} {
     while {[gets $f line] >= 0} {}
-- 
1.6.0.rc2
