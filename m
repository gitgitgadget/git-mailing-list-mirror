From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [RFC PATCH 5/8] git gui: do fetch from a default remote on startup
Date: Mon, 21 Sep 2009 15:06:52 +0200
Message-ID: <0f2d6dac74105f84defebf23dd74c40846d304a3.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
 <f52bb968bf977dbbed78ce48856cd41d0add708f.1253481338.git.hvoigt@hvoigt.net>
 <711bc3257266372b0a0f01ac335fa95be7def077.1253481338.git.hvoigt@hvoigt.net>
 <3ee2f1d36ed3c4b716f9bdb2a8f7fcde9a5f9357.1253481338.git.hvoigt@hvoigt.net>
 <1e2889356b0992c64fe0d5efefa4c9c47af2513f.1253481338.git.hvoigt@hvoigt.net>
Cc: spearce@spearce.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 21 15:07:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpicF-0002uk-5V
	for gcvg-git-2@lo.gmane.org; Mon, 21 Sep 2009 15:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109AbZIUNHF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 09:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756107AbZIUNHD
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 09:07:03 -0400
Received: from darksea.de ([83.133.111.250]:35694 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754073AbZIUNGy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Sep 2009 09:06:54 -0400
Received: (qmail 28829 invoked from network); 21 Sep 2009 15:06:57 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 21 Sep 2009 15:06:57 +0200
X-Mailer: git-send-email 1.6.5.rc1.12.gc72fe
In-Reply-To: <1e2889356b0992c64fe0d5efefa4c9c47af2513f.1253481338.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1253481338.git.hvoigt@hvoigt.net>
References: <cover.1253481338.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128880>

In many situations the very first thing you do after starting git gui is
to fetch the newest changes from your main remote. Lets have git gui do
the work automatically and save us some clicking.

We add two configuration variables (one to enable the feature and one
specifying the default remote) so the remote can be reused in another
patch which adds a "Review Topic" merge item later in this series.
---
 git-gui/git-gui.sh     |    8 ++++++++
 git-gui/lib/option.tcl |    2 ++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index b32b8e7..2a2bd38 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -740,6 +740,8 @@ set default_config(gui.fastcopyblame) false
 set default_config(gui.emailafterpush) false
 set default_config(gui.deleteafterpush) false
 set default_config(gui.upstreambranch) {master}
+set default_config(gui.defaultremote) {origin}
+set default_config(gui.fetchonstartup) false
 set default_config(gui.copyblamethreshold) 40
 set default_config(gui.blamehistoryctx) 7
 set default_config(gui.diffcontext) 5
@@ -3495,6 +3497,12 @@ after 1 {
 		$ui_comm configure -state disabled -background gray
 	}
 }
+
+set defaultremote $repo_config(gui.defaultremote)
+if {[is_config_true gui.fetchonstartup] && $defaultremote ne {}} {
+	after 500 {fetch_from $defaultremote {close_on_success}}
+}
+
 if {[is_enabled multicommit]} {
 	after 1000 hint_gc
 }
diff --git a/git-gui/lib/option.tcl b/git-gui/lib/option.tcl
index 6bfe343..defeb54 100644
--- a/git-gui/lib/option.tcl
+++ b/git-gui/lib/option.tcl
@@ -149,7 +149,9 @@ proc do_options {} {
 		{b gui.fastcopyblame {mc "Blame Copy Only On Changed Files"}}
 		{b gui.emailafterpush {mc "Open Email Composer after Push of Feature Branch"}}
 		{b gui.deleteafterpush {mc "Open Remote Delete Dialog On Push of Upstream Branch"}}
+		{b gui.fetchonstartup {mc "Fetch default remote on startup"}}
 		{t gui.upstreambranch {mc "Upstream branch"}}
+		{t gui.defaultremote {mc "Default remote repository"}}
 		{i-20..200 gui.copyblamethreshold {mc "Minimum Letters To Blame Copy On"}}
 		{i-0..300 gui.blamehistoryctx {mc "Blame History Context Radius (days)"}}
 		{i-1..99 gui.diffcontext {mc "Number of Diff Context Lines"}}
-- 
1.6.5.rc1.12.gc72fe
