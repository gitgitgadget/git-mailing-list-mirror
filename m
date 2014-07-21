From: David Turner <dturner@twopensource.com>
Subject: [PATCH v2] git-gui: Make git-gui lib dir configurable at runime
Date: Mon, 21 Jul 2014 16:41:38 -0400
Message-ID: <1405975298-16304-1-git-send-email-dturner@twitter.com>
Cc: David Turner <dturner@twitter.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 21 22:42:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9KPH-0005gh-1s
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 22:41:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754136AbaGUUlz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 16:41:55 -0400
Received: from mail-qg0-f46.google.com ([209.85.192.46]:34604 "EHLO
	mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752155AbaGUUly (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 16:41:54 -0400
Received: by mail-qg0-f46.google.com with SMTP id z60so6018205qgd.33
        for <git@vger.kernel.org>; Mon, 21 Jul 2014 13:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YM80lVaG5aMupPYPX0yDQ1JV2XSrXNhUuoSAPGMgJcA=;
        b=Y8n03z9F4/S2Ds0y5IyDJ9jOghnCP6oEoRvBUIYe7Maxrufqxk4sKhEr25msXGcavr
         ZK/nAjeKPtIoB1H5mzZfFU1jyZKa1Jw/GTaaVWshOVreZIRKWnMCMRVrlOEHrp76jV7z
         0B1Is/5ZtTe/+CKZwROxi38BiqDcrzQasaa3Ig0qTW/ZyMbSqvi6PE1w/qFRy5b0jVmJ
         Vonn+w+xeovPObFLCIDmQjTRUc2FeBSza0ZVcuqVnpsNYaDrxzF1gVpE7MTeS9jV6+u9
         WeduOQo7tCW5R+mR3+506jOW+TOfvB45hlqlGxMtmsIKu7JXkMkxAbIP8eJJvig//O3a
         MHQw==
X-Gm-Message-State: ALoCoQkcivBxrauP4rCU6x9ZYPIGK+E1jzjrMbvyw/QwIB1UzHHClfoaKRPQRd8ktMXdOFJsFKWx
X-Received: by 10.140.41.116 with SMTP id y107mr43524460qgy.78.1405975314072;
        Mon, 21 Jul 2014 13:41:54 -0700 (PDT)
Received: from leckie.office.twttr.net (ip-66-9-26-66.autorev.intellispace.net. [66.9.26.66])
        by mx.google.com with ESMTPSA id w9sm27598416qag.48.2014.07.21.13.41.52
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 21 Jul 2014 13:41:53 -0700 (PDT)
X-Google-Original-From: David Turner <dturner@twitter.com>
X-Mailer: git-send-email 1.9.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253994>

Introduce the GIT_GUI_LIB_DIR environment variable, to tell git-gui
where to look for TCL libs.  This allows a git-gui which has been
built with a prefix of /foo to be run out of directory /bar.  This is
the equivalent of GIT_EXEC_PATH or GITPERLLIB but for git-gui's TCL
libraries.

Signed-off-by: David Turner <dturner@twitter.com>
---
 git-gui/Makefile           | 3 ++-
 git-gui/git-gui.sh         | 6 +++++-
 git-gui/macosx/AppMain.tcl | 7 ++++++-
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index cde8b2e..4f00bdd 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -177,7 +177,8 @@ git-gui: GIT-VERSION-FILE GIT-GUI-VARS
 	echo then >>$@+ && \
 	echo '	'echo \'git-gui version '$(GITGUI_VERSION)'\' >>$@+ && \
 	echo else >>$@+ && \
-	echo '	'exec \''$(libdir_SQ)/Git Gui.app/Contents/MacOS/$(subst \,,$(TKEXECUTABLE))'\' \
+	echo '	libdir="$${GIT_GUI_LIB_DIR:-$(libdir_SQ)}"' >>$@+ && \
+	echo '	'exec \"'$$libdir/Git Gui.app/Contents/MacOS/$(subst \,,$(TKEXECUTABLE))'\" \
 		'"$$0" "$$@"' >>$@+ && \
 	echo fi >>$@+ && \
 	chmod +x $@+ && \
diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index b186329..6cbb36e 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -49,7 +49,11 @@ catch {rename send {}} ; # What an evil concept...
 ##
 ## locate our library
 
-set oguilib {@@GITGUI_LIBDIR@@}
+if { [info exists ::env(GIT_GUI_LIB_DIR) ] } {
+	set oguilib $::env(GIT_GUI_LIB_DIR)
+} else {
+	set oguilib {@@GITGUI_LIBDIR@@}
+}
 set oguirel {@@GITGUI_RELATIVE@@}
 if {$oguirel eq {1}} {
 	set oguilib [file dirname [file normalize $argv0]]
diff --git a/git-gui/macosx/AppMain.tcl b/git-gui/macosx/AppMain.tcl
index 738bdd0..b6c6dc3 100644
--- a/git-gui/macosx/AppMain.tcl
+++ b/git-gui/macosx/AppMain.tcl
@@ -1,5 +1,10 @@
 set gitexecdir {@@gitexecdir@@}
-set gitguilib  {@@GITGUI_LIBDIR@@}
+if { [info exists ::env(GIT_GUI_LIB_DIR) ] } {
+	set gitguilib $::env(GIT_GUI_LIB_DIR)
+} else {
+	set gitguilib {@@GITGUI_LIBDIR@@}
+}
+
 set env(PATH) "$gitexecdir:$env(PATH)"
 
 if {[string first -psn [lindex $argv 0]] == 0} {
-- 
1.9.1
