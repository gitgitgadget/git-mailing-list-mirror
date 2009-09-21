From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH 8/8] git gui: make gc hint and fetch on startup sequential
Date: Mon, 21 Sep 2009 15:06:55 +0200
Message-ID: <1ccb418e07a6d7ce4b8f47e5f9a8d68ac376eed4.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
 <f52bb968bf977dbbed78ce48856cd41d0add708f.1253481338.git.hvoigt@hvoigt.net>
 <711bc3257266372b0a0f01ac335fa95be7def077.1253481338.git.hvoigt@hvoigt.net>
 <3ee2f1d36ed3c4b716f9bdb2a8f7fcde9a5f9357.1253481338.git.hvoigt@hvoigt.net>
 <1e2889356b0992c64fe0d5efefa4c9c47af2513f.1253481338.git.hvoigt@hvoigt.net>
 <0f2d6dac74105f84defebf23dd74c40846d304a3.1253481338.git.hvoigt@hvoigt.net>
 <48c17b5cc7f2e143187a11c4e146649721bb2b0f.1253481338.git.hvoigt@hvoigt.net>
 <bbe878f82f987a36fd1edf77ff6921f2717ad092.1253481338.git.hvoigt@hvoigt.net>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 15:07:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpicF-0002uk-Np
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 15:07:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756114AbZIUNHI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 09:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756113AbZIUNHG
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 09:07:06 -0400
Received: from darksea.de ([83.133.111.250]:35703 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756100AbZIUNGz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 09:06:55 -0400
Received: (qmail 28841 invoked from network); 21 Sep 2009 15:06:58 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 21 Sep 2009 15:06:58 +0200
X-Mailer: git-send-email 1.6.5.rc1.12.gc72fe
In-Reply-To: <bbe878f82f987a36fd1edf77ff6921f2717ad092.1253481338.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128882>

On large repositories (especially on Windows) doing any harddrive usage
during the initial status scan slows the whole process down. So this
postpones the question for compressing loose objects and fetching of the
default remote until after that.
---
 git-gui/git-gui.sh |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 3e3c7cd..19b1ad6 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2031,8 +2031,22 @@ proc do_quit {{rc {1}}} {
 	destroy .
 }
 
+proc ui_finalize_startup {} {
+	global repo_config
+
+	set defaultremote $repo_config(gui.defaultremote)
+	if {[is_config_true gui.fetchonstartup] && $defaultremote ne {}} {
+		fetch_from $defaultremote {close_on_success}
+	}
+
+	if {[is_enabled multicommit]} {
+		hint_gc
+	}
+	ui_ready
+}
+
 proc do_rescan {} {
-	rescan ui_ready
+	rescan ui_finalize_startup
 }
 
 proc ui_do_rescan {} {
@@ -3502,14 +3516,6 @@ after 1 {
 	}
 }
 
-set defaultremote $repo_config(gui.defaultremote)
-if {[is_config_true gui.fetchonstartup] && $defaultremote ne {}} {
-	after 500 {fetch_from $defaultremote {close_on_success}}
-}
-
-if {[is_enabled multicommit]} {
-	after 1000 hint_gc
-}
 if {[is_enabled retcode]} {
 	bind . <Destroy> {+terminate_me %W}
 }
-- 
1.6.5.rc1.12.gc72fe
