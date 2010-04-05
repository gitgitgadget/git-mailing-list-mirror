From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] git-gui: Fast staging/unstaging of hunks/lines
Date: Mon,  5 Apr 2010 11:01:24 +0200
Message-ID: <7ed246d74b2ea872a4af3b99d519590ab17ffefc.1270457921.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Apr 05 11:01:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NyiBp-0007QI-JS
	for gcvg-git-2@lo.gmane.org; Mon, 05 Apr 2010 11:01:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564Ab0DEJBd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Apr 2010 05:01:33 -0400
Received: from mail-gx0-f217.google.com ([209.85.217.217]:44046 "EHLO
	mail-gx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954Ab0DEJBc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Apr 2010 05:01:32 -0400
Received: by gxk9 with SMTP id 9so2849805gxk.8
        for <git@vger.kernel.org>; Mon, 05 Apr 2010 02:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=qiHpc5V2xOJgPtmP+uvNw6/dyTn6yWE91qBMGwoP3bE=;
        b=wlXowWwGZYUFcjUqXY0qy/6LD1on3ZbMyG6wG6wDuLp/okscb6os+1XNU01xyqp0Ha
         5LHEhmy21GwBBg8Y04BAXPTnZ+tlLAYrjx3dQLsVPc86GGnClLh6nwJ6iCpP9h+wVvzL
         YrMK51L15DVo0/bz7jtR6Sj2ncYbp/37d4HFs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=lfsNrhKIcZGlbSfVWRjCOFJOmszo2zRjCRfv/PT7ZPh+yab2KuyhI5Kt42XVPXScXH
         CYRtr4IyWYXdjSw/rdyHqkXNq/S+pLVVFj5Ms4MOWp98Fd/sUYYomK/A03ev16A9ggVW
         DQHGdHwQPeQ14pLDLgJM97lV449BzJmAhVV78=
Received: by 10.101.134.13 with SMTP id l13mr12530096ann.160.1270458090219;
        Mon, 05 Apr 2010 02:01:30 -0700 (PDT)
Received: from localhost ([72.14.241.36])
        by mx.google.com with ESMTPS id 4sm2873463yxd.34.2010.04.05.02.01.27
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 05 Apr 2010 02:01:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.3.418.gf56ac.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143974>

This adds a shortcut to stage/unstage hunks or a range of lines. Which is done
on a mouse button 1 release event and holding the control key in the diff view.
If there is currently a selection only the selected lines will be staged/unstaged.
Otherwise the hunk will be staged/unstaged.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui/git-gui.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 7d54511..e65a0e6 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3452,6 +3452,22 @@ proc popup_diff_menu {ctxm ctxmmg ctxmsm x y X Y} {
 }
 bind_button3 $ui_diff [list popup_diff_menu $ctxm $ctxmmg $ctxmsm %x %y %X %Y]
 
+# applies/reverses hunks or lines on button-1 release
+proc immediate_apply_hunk_or_lines {x y} {
+	global current_diff_path file_states
+	set ::cursorX $x
+	set ::cursorY $y
+
+	set has_range [expr {[$::ui_diff tag nextrange sel 0.0] != {}}]
+	if {$has_range} {
+		apply_range_or_line $::cursorX $:cursorY
+		do_rescan
+	} else {
+		apply_hunk $::cursorX $::cursorY
+	}
+}
+bind $ui_diff <$M1B-ButtonRelease-1> {immediate_apply_hunk_or_lines %x %y}
+
 # -- Status Bar
 #
 set main_status [::status_bar::new .status]
-- 
1.7.0.3.418.gf56ac.dirty
