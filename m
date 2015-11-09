From: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>
Subject: [PATCH v3] gitk: add -C <path> commandline parameter to change path
Date: Mon,  9 Nov 2015 13:45:22 +0200
Message-ID: <1447069522-19895-1-git-send-email-juhapekka.heikkila@gmail.com>
References: <563C85C5.80703@gmail.com>
Cc: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>,
	sunshine@sunshineco.com, paulus@samba.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 09 12:45:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZvktL-0007AW-Nt
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 12:45:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752818AbbKILpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 06:45:39 -0500
Received: from mga03.intel.com ([134.134.136.65]:22085 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750850AbbKILpi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 06:45:38 -0500
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 09 Nov 2015 03:45:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.20,265,1444719600"; 
   d="scan'208";a="846023561"
Received: from jheikkil-mobl2.fi.intel.com ([10.237.66.150])
  by orsmga002.jf.intel.com with ESMTP; 09 Nov 2015 03:45:36 -0800
X-Mailer: git-send-email 1.9.1
In-Reply-To: <563C85C5.80703@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281049>

This patch adds -C (change working directory) parameter to
gitk. With this parameter, instead of need to cd to directory
with .git folder, one can point the correct folder from
commandline.

Signed-off-by: Juha-Pekka Heikkila <juhapekka.heikkila@gmail.com>

---
v2: Adjusted the parameter as per Eric's suggestion. I think
    it now work in similar manner as in many GNU tools as well
    as git itself.

v3: catch error from cd and other small refinement.

 Documentation/gitk.txt |  7 +++++++
 gitk-git/gitk          | 30 +++++++++++++++++++++---------
 2 files changed, 28 insertions(+), 9 deletions(-)

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
index fcc606e..a7076f8 100755
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
@@ -12305,11 +12299,29 @@ foreach arg $argv {
 	"--argscmd=*" {
 	    set revtreeargscmd [string range $arg 10 end]
 	}
+	"-C*" {
+		if {[string length $arg] < 3} {
+			incr i
+			set cwd_path [lindex $argv [expr {$i}]]
+		} else {
+			set cwd_path [string range $arg 2 end]
+		}
+
+		if {[catch {cd $cwd_path}]} {
+			show_error {} . [mc "Cannot change directory to '%s'" $cwd_path]
+			exit 1
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
