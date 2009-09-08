From: Alexey Borzenkov <snaury@gmail.com>
Subject: [PATCH] git-gui: store wm state and fix wm geometry
Date: Tue, 8 Sep 2009 22:39:33 +0400
Message-ID: <e2480c70909081139s6027cd91n6d32c2f845629ed1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 08 20:39:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ml5bT-0003Hb-Ub
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 20:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752151AbZIHSjc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 14:39:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752108AbZIHSjc
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 14:39:32 -0400
Received: from mail-bw0-f219.google.com ([209.85.218.219]:53377 "EHLO
	mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752080AbZIHSjc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 14:39:32 -0400
Received: by bwz19 with SMTP id 19so2438044bwz.37
        for <git@vger.kernel.org>; Tue, 08 Sep 2009 11:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=xts887sl7uvVebq4vRs5SrV4EsRhUI6vFkFw1mMkp9k=;
        b=U8IohIs1bcepQFr8/rizoksreZAEmyX38HFJDWWFe7Cf4b4Mk8utvEktOKL98rbZyD
         t+vSVHZVJs1JYqTSo2IWzR5f/Cb1AFhOORG27gcvzoACRfhbsWmzLuPJG4Htk/YgTD10
         hu1CBxcG6gN7jB+ibG5pCbMs8zvR9dfla6VBw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=kdtf2L4/R2Lq5ShtHmmrQaPSCq36/ro8QXKCyU31qLa8O5QRpc3IKwfwtfUUYTYLiW
         x+qZOBqxUXIld4VUe5UsowUEGs2G9R2O0fWX4gIIoME7F34s/0ImPrbtYrOxb90bbHlC
         BL0PPKfYKSuCyvt2RfOBy/tvdRxW1vwxr+yD8=
Received: by 10.223.132.204 with SMTP id c12mr5997988fat.32.1252435173890; 
	Tue, 08 Sep 2009 11:39:33 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128020>

I often close git gui window when it is maximized, and when I reopen
it next time the it would usually become out of place (e.g. a huge
window with a top-left corner somewhere close to the center of the
screen). Fix it by storing and restoring wm state in config, as well
as setting wm state to normal before retrieving wm geometry info.

Signed-off-by: Alexey Borzenkov <snaury@gmail.com>
---
 I've been using this patch for almost a year on Windows now.
 If you have any comments/questions please don't forget to cc me
 as I'm not subscribed to this list.

 git-gui.sh |   21 +++++++++++++++++++++
 1 files changed, 21 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index eae1f81..88d1025 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2025,6 +2025,19 @@ proc do_quit {{rc {1}}} {

 		# -- Stash our current window geometry into this repository.
 		#
+		set cfg_wmstate [wm state .]
+		if {[catch {set rc_wmstate $repo_config(gui.wmstate)}]} {
+			set rc_wmstate {}
+		}
+		if {$cfg_wmstate ne $rc_wmstate} {
+			catch {git config gui.wmstate $cfg_wmstate}
+		}
+		if {$cfg_wmstate eq {zoomed}} {
+			# on Windows wm geometry will lie about window
+			# position (but not size) when window is zoomed
+			# restore the window before querying wm geometry
+			wm state . normal
+		}
 		set cfg_geometry [list]
 		lappend cfg_geometry [wm geometry .]
 		lappend cfg_geometry [lindex [.vpane sash coord 0] 0]
@@ -3264,6 +3277,14 @@ wm geometry . [lindex $gm 0]
 unset gm
 }

+# -- Load window state
+#
+catch {
+set gws $repo_config(gui.wmstate)
+wm state . $gws
+unset gws
+}
+
 # -- Key Bindings
 #
 bind $ui_comm <$M1B-Key-Return> {do_commit;break}
-- 
1.6.4.2
