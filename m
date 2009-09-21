From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH 4/8] git gui: teach fetch operation to close dialog on successful completion
Date: Mon, 21 Sep 2009 15:06:51 +0200
Message-ID: <1e2889356b0992c64fe0d5efefa4c9c47af2513f.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
 <f52bb968bf977dbbed78ce48856cd41d0add708f.1253481338.git.hvoigt@hvoigt.net>
 <711bc3257266372b0a0f01ac335fa95be7def077.1253481338.git.hvoigt@hvoigt.net>
 <3ee2f1d36ed3c4b716f9bdb2a8f7fcde9a5f9357.1253481338.git.hvoigt@hvoigt.net>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 15:07:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpicE-0002uk-Jg
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 15:07:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756110AbZIUNHD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 09:07:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756082AbZIUNHB
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 09:07:01 -0400
Received: from darksea.de ([83.133.111.250]:35691 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756094AbZIUNGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 09:06:54 -0400
Received: (qmail 28825 invoked from network); 21 Sep 2009 15:06:57 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 21 Sep 2009 15:06:57 +0200
X-Mailer: git-send-email 1.6.5.rc1.12.gc72fe
In-Reply-To: <3ee2f1d36ed3c4b716f9bdb2a8f7fcde9a5f9357.1253481338.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128879>

---
 git-gui/lib/console.tcl   |    6 ++++++
 git-gui/lib/transport.tcl |   12 ++++++++++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/console.tcl b/git-gui/lib/console.tcl
index c112464..84eef13 100644
--- a/git-gui/lib/console.tcl
+++ b/git-gui/lib/console.tcl
@@ -168,6 +168,7 @@ method chain {cmdlist {ok 1}} {
 	} else {
 		done $this $ok
 	}
+	return $ok
 }
 
 method insert {txt} {
@@ -178,6 +179,11 @@ method insert {txt} {
 	$w_t conf -state disabled
 }
 
+method close_window {} {
+	wm protocol $w WM_DELETE_WINDOW {}
+	destroy $w
+}
+
 method done {ok} {
 	if {$ok} {
 		if {[winfo exists $w.m.s]} {
diff --git a/git-gui/lib/transport.tcl b/git-gui/lib/transport.tcl
index d717468..39443ab 100644
--- a/git-gui/lib/transport.tcl
+++ b/git-gui/lib/transport.tcl
@@ -1,7 +1,7 @@
 # git-gui transport (fetch/push) support
 # Copyright (C) 2006, 2007 Shawn Pearce
 
-proc fetch_from {remote} {
+proc fetch_from {remote {close_after {}}} {
 	set w [console::new \
 		[mc "fetch %s" $remote] \
 		[mc "Fetching new changes from %s" $remote]]
@@ -10,7 +10,15 @@ proc fetch_from {remote} {
 	if {[is_config_true gui.pruneduringfetch]} {
 		lappend cmds [list exec git remote prune $remote]
 	}
-	console::chain $w $cmds
+	set ok [console::chain $w $cmds]
+
+	if {$ok} {
+		if {$close_after ne {}} {
+			console::close_window $w
+		}
+		return 1
+	}
+	return 0
 }
 
 proc prune_from {remote} {
-- 
1.6.5.rc1.12.gc72fe
