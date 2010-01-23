From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv4 4/5] git-gui: set GIT_DIR and GIT_WORK_TREE after setup
Date: Sat, 23 Jan 2010 11:03:37 +0100
Message-ID: <1264241018-6616-5-git-send-email-giuseppe.bilotta@gmail.com>
References: <1264241018-6616-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Markus Heidelberg <markus.heidelberg@web.de>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 23 11:04:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYcrB-0000WZ-QT
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 11:04:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754750Ab0AWKES (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 05:04:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754733Ab0AWKEP
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 05:04:15 -0500
Received: from mail-fx0-f221.google.com ([209.85.220.221]:64393 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751590Ab0AWKEL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 05:04:11 -0500
Received: by mail-fx0-f221.google.com with SMTP id 21so155449fxm.29
        for <git@vger.kernel.org>; Sat, 23 Jan 2010 02:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=56qOqByXqALSd6j7IalnspXFT2yn7KIkcdo7EGwXaSs=;
        b=gW5ozJ2yw67zjBz8kJkpKxjVg22QKaGBe2MqYTjPBxNoj5Uh2aIM/O120XlNTiJhYo
         z8GMZ/P7R5zm5+mNH2HYsGR0M9OV3n211obBPksr+YMgH1D01ClsgqJHn80pT/J1FOJz
         PD2Q8OT0TZseUiYRHPGqsIiPc+mBx86cWu8y4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=j6kk/VmCTt2D6C7q8HS9/BjevWn/sFpWZbysBuAk5B0Fg0whJPdxeheFTuOb2S24/k
         YHUwBeeZopvj2nSyW4QNcMF1TWULu8shXsrkruDDAjdgdNoTMImYjvR2rHA/bKR1uktv
         Wqbx9KF9nv3mPFNkmE7NiRpsUHm3Ew84NRtoc=
Received: by 10.223.144.71 with SMTP id y7mr2816973fau.54.1264241050880;
        Sat, 23 Jan 2010 02:04:10 -0800 (PST)
Received: from localhost ([151.60.177.52])
        by mx.google.com with ESMTPS id 15sm1740167fxm.2.2010.01.23.02.04.09
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 23 Jan 2010 02:04:10 -0800 (PST)
X-Mailer: git-send-email 1.6.6.rc1.295.g3a4e71
In-Reply-To: <1264241018-6616-1-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137829>

Rather than juggling $GIT_DIR around the invocation of gitk, set it
(and $GIT_WORK_TREE) after finishing setup, ensuring that any external
tool works with the setup we're running with.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 git-gui/git-gui.sh |   15 +++------------
 1 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index c5c787d..aff0644 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -1171,6 +1171,9 @@ if {[lindex $_reponame end] eq {.git}} {
 	set _reponame [lindex $_reponame end]
 }
 
+set env(GIT_DIR) $_gitdir
+set env(GIT_WORK_TREE) $_gitworktree
+
 ######################################################################
 ##
 ## global init
@@ -1986,25 +1989,13 @@ proc do_gitk {revs} {
 	} else {
 		global env
 
-		if {[info exists env(GIT_DIR)]} {
-			set old_GIT_DIR $env(GIT_DIR)
-		} else {
-			set old_GIT_DIR {}
-		}
-
 		set pwd [pwd]
 		if { ![is_bare] } {
 			cd $_gitworktree
 		}
-		set env(GIT_DIR) [file normalize [gitdir]]
 
 		eval exec $cmd $revs &
 
-		if {$old_GIT_DIR eq {}} {
-			unset env(GIT_DIR)
-		} else {
-			set env(GIT_DIR) $old_GIT_DIR
-		}
 		cd $pwd
 
 		ui_status $::starting_gitk_msg
-- 
1.6.6.rc1.295.g3a4e71
