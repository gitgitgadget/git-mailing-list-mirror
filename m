From: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
Subject: [PATCH v2] gitk: add -C <path> commandline parameter to change path
Date: Thu,  5 Nov 2015 11:19:24 +0200
Message-ID: <1446715164-19165-1-git-send-email-juhapekka.heikkila@gmail.com>
References: <CAPig+cSs0v88AiQwSrqm-wK7rY4RdykaVf5Axh5jFyij25rfvg@mail.gmail.com>
Cc: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 05 10:19:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuGhk-0005Ky-Ls
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 10:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756474AbbKEJTb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 04:19:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:56535 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754977AbbKEJT2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 04:19:28 -0500
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP; 05 Nov 2015 01:19:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,247,1444719600"; 
   d="scan'208";a="812301589"
Received: from jheikkil-mobl2.fi.intel.com ([10.237.66.161])
  by orsmga001.jf.intel.com with ESMTP; 05 Nov 2015 01:19:26 -0800
X-Mailer: git-send-email 1.9.1
In-Reply-To: <CAPig+cSs0v88AiQwSrqm-wK7rY4RdykaVf5Axh5jFyij25rfvg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280917>

This patch adds -C (change working directory) parameter to
gitk. With this parameter, instead of need to cd to directory
with .git folder, one can point the correct folder from
commandline.

v2: Adjusted the parameter as per Eric's suggestion. I think
    it now work in similar manner as in many GNU tools as well
    as git itself.

Signed-off-by: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
---
 Documentation/gitk.txt |  7 +++++++
 gitk-git/gitk          | 26 +++++++++++++++++---------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 6ade002..d194d9b 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -146,6 +146,13 @@ gitk-specific options
 	Select the specified commit after loading the graph.
 	Default behavior is equivalent to specifying '--select-commit=HEAD'.
 
+-C <path>::
+
+	Run as if gitk was started in '<path>' instead of the current
+	working directory. When multiple `-C` options are given, each
+	subsequent non-absolute `-C <path>` is interpreted relative to
+	the preceding `-C <path>`.
+
 Examples
 --------
 gitk v2.6.12.. include/scsi drivers/scsi::
diff --git a/gitk-git/gitk b/gitk-git/gitk
index fcc606e..606474a 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -12279,20 +12279,14 @@ setui $uicolor
 
 setoptions
 
-# check that we can find a .git directory somewhere...
-if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
-    show_error {} . [mc "Cannot find a git repository here."]
-    exit 1
-}
-
 set selecthead {}
 set selectheadid {}
 
 set revtreeargs {}
 set cmdline_files {}
-set i 0
 set revtreeargscmd {}
-foreach arg $argv {
+for {set i 0} {$i < [llength $argv]} {incr i} {
+	set arg [lindex $argv [expr {$i}]]
     switch -glob -- $arg {
 	"" { }
 	"--" {
@@ -12305,11 +12299,25 @@ foreach arg $argv {
 	"--argscmd=*" {
 	    set revtreeargscmd [string range $arg 10 end]
 	}
+	"-C*" {
+		if {[string length $arg] < 3} {
+			incr i
+			cd [lindex $argv [expr {$i}]]
+			continue
+		} else {
+			cd [string range $arg 2 end]
+		}
+	}
 	default {
 	    lappend revtreeargs $arg
 	}
     }
-    incr i
+}
+
+# check that we can find a .git directory somewhere...
+if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
+    show_error {} . [mc "Cannot find a git repository here."]
+    exit 1
 }
 
 if {$selecthead eq "HEAD"} {
-- 
1.9.1
