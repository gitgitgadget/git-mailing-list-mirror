From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 1/8] gitk: fix file highlight when run in subdirectory
Date: Mon,  4 Apr 2011 22:14:12 -0400
Message-ID: <1301969659-19703-2-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue Apr 05 04:17:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6vpV-0002JM-PM
	for gcvg-git-2@lo.gmane.org; Tue, 05 Apr 2011 04:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752068Ab1DECQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2011 22:16:55 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:57460 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751583Ab1DECQt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2011 22:16:49 -0400
Received: by qyg14 with SMTP id 14so4223854qyg.19
        for <git@vger.kernel.org>; Mon, 04 Apr 2011 19:16:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=KO/ArsTC1Zo8NRs26miCX9pJN1HHkDaFSCvymARmPT0=;
        b=eVM/6GAgTMRep6kM65r8C/cP4xT9CxgztKze7qfjSqqqu+WNiI18zZJiwajNA0sY3q
         hxPqN59kOmjPhAnD9QVdEjXFhgjM5E5e0rRpZ2S7G/sd95b6AwcWhYr647gmxJsIWYO8
         LgCtmeo0R8Xu1v33pMZzjAZZNdySHcrcbj7jA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=O7z8h7rwESpmx8UVUPdR/Uqfkq6/Fo92xPPPLxM5NHK2eRt9CAg7bvkeC2TELRzg6Y
         l0jc0FUPx/P9h9BRROeo8REURrN3P4l5zxmmP3/2ufhkwHRx3jxoIKHaRjEWGNjHK7dc
         yFbKTx55cIc4+jm+snnyYlyE6ys3j6LvWu8Ok=
Received: by 10.224.212.8 with SMTP id gq8mr483427qab.250.1301969808307;
        Mon, 04 Apr 2011 19:16:48 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s16sm3902340qco.13.2011.04.04.19.16.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 04 Apr 2011 19:16:47 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.79.gcbe20
In-Reply-To: <1301969659-19703-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170854>

The "highlight this only" and "highlight this too" commands in gitk
add the path relative to $GIT_WORK_TREE to the "Find" input box. When
the search (using git-diff-tree) is run, the paths are used
unmodified, except for some shell escaping. Since the search is run
from gitk's working directory, no commits matching the paths will be
found if gitk was started in a subdirectory.

Make the paths passed to git-diff-tree relative to gitk's working
directory instead of being relative to $GIT_WORK_TREE. If, however,
gitk is run outside of the working directory (e.g. with $GIT_WORK_TREE
set), we still need to use the path relative to $GIT_WORK_TREE.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

This could also have been fixed by cd-ing to the work tree
directory. That would also make the "Local changes checked in to index
but not committed" and "Local uncommitted changes, not checked in to
index" show up properly when running with GIT_WORK_TREE defined.

I wasn't sure if other parts of gitk depend on the working directory,
or if there are plans to make something depend on it, so I thought
changing it only for the specific case of file highlighting would be
safer. What do you think?


 gitk-git/gitk |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index e82c6bf..ce96294 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -4528,12 +4528,17 @@ proc makepatterns {l} {
 
 proc do_file_hl {serial} {
     global highlight_files filehighlight highlight_paths gdttype fhl_list
+    global cdup
 
     if {$gdttype eq [mc "touching paths:"]} {
 	if {[catch {set paths [shellsplit $highlight_files]}]} return
 	set highlight_paths [makepatterns $paths]
 	highlight_filelist
-	set gdtargs [concat -- $paths]
+	set relative_paths {}
+	foreach path $paths {
+	    lappend relative_paths [file join $cdup $path]
+	}
+	set gdtargs [concat -- $relative_paths]
     } elseif {$gdttype eq [mc "adding/removing string:"]} {
 	set gdtargs [list "-S$highlight_files"]
     } else {
@@ -11625,6 +11630,10 @@ set stuffsaved 0
 set patchnum 0
 set lserial 0
 set isworktree [expr {[exec git rev-parse --is-inside-work-tree] == "true"}]
+set cdup {}
+if {$isworktree} {
+    set cdup [exec git rev-parse --show-cdup]
+}
 setcoords
 makewindow
 catch {
-- 
1.7.4.79.gcbe20
