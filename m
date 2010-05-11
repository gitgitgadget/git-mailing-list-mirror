From: Kirill Smelkov <kirr@mns.spb.ru>
Subject: [PATCH] gitk: Show notes
Date: Tue, 11 May 2010 12:26:56 +0400
Message-ID: <1273566416-3512-1-git-send-email-kirr@mns.spb.ru>
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Tue May 11 10:25:59 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OBkmn-0001Rz-Rg
	for gcvg-git-2@lo.gmane.org; Tue, 11 May 2010 10:25:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757049Ab0EKIZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 May 2010 04:25:48 -0400
Received: from mail.mnsspb.ru ([84.204.75.2]:45719 "EHLO mail.mnsspb.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751074Ab0EKIZo (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 May 2010 04:25:44 -0400
Received: from [192.168.0.127] (helo=tugrik.mns.mnsspb.ru)
	by mail.mnsspb.ru with esmtps id 1OBkmP-0002NC-PO; Tue, 11 May 2010 12:25:29 +0400
Received: from kirr by tugrik.mns.mnsspb.ru with local (Exim 4.69)
	(envelope-from <kirr@tugrik.mns.mnsspb.ru>)
	id 1OBknx-0000v9-Qo; Tue, 11 May 2010 12:27:05 +0400
X-Mailer: git-send-email 1.7.1.90.g801e39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/146879>

If in git.git I do

    $ git notes add -m 'This makes status significantly slower with Dokko' \
        ee6fc514

then `git log` shows the note...

    $ git log -1 ee6fc514

    commit ee6fc514f2df821c2719cc49499a56ef2fb136b0
    Author: Jens Lehmann <Jens.Lehmann@web.de>
    Date:   Sat Jan 16 18:42:24 2010 +0100

        Show submodules as modified when they contain a dirty work tree

        Until now a submodule only then showed up as modified in the supermodule
        when the last commit in the submodule differed from the one in the index
        or the diffed against commit of the superproject. A dirty work tree
        containing new untracked or modified files in a submodule was
        undetectable when looking at it from the superproject.

        Now git status and git diff (against the work tree) in the superproject
        will also display submodules as modified when they contain untracked or
        modified files, even if the compared ref matches the HEAD of the
        submodule.

        Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
        Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
        Signed-off-by: Junio C Hamano <gitster@pobox.com>

    Notes:
        This makes status significantly slower with Dokko

... but unfortunately gitk does not.

Let's fix this and teach gitk to show notes.

Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 gitk |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/gitk b/gitk
index 1b0e09a..d537011 100755
--- a/gitk
+++ b/gitk
@@ -361,8 +361,8 @@ proc start_rev_list {view} {
     }
 
     if {[catch {
-	set fd [open [concat | git log --no-color -z --pretty=raw --parents \
-			 --boundary $args "--" $files] r]
+	set fd [open [concat | git log --no-color -z --pretty=raw --show-notes \
+			--parents --boundary $args "--" $files] r]
     } err]} {
 	error_popup "[mc "Error executing git log:"] $err"
 	return 0
@@ -508,8 +508,8 @@ proc updatecommits {} {
 	set args $vorigargs($view)
     }
     if {[catch {
-	set fd [open [concat | git log --no-color -z --pretty=raw --parents \
-			  --boundary $args "--" $vfilelimit($view)] r]
+	set fd [open [concat | git log --no-color -z --pretty=raw --show-notes \
+			--parents --boundary $args "--" $vfilelimit($view)] r]
     } err]} {
 	error_popup "[mc "Error executing git log:"] $err"
 	return
@@ -1586,7 +1586,8 @@ proc do_readcommit {id} {
     global tclencoding
 
     # Invoke git-log to handle automatic encoding conversion
-    set fd [open [concat | git log --no-color --pretty=raw -1 $id] r]
+    set fd [open [concat | git log --no-color --pretty=raw --show-notes \
+		     -1 $id] r]
     # Read the results using i18n.logoutputencoding
     fconfigure $fd -translation lf -eofchar {}
     if {$tclencoding != {}} {
-- 
1.7.1.89.g6b35c
