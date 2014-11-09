From: Max Kirillov <max@max630.net>
Subject: [PATCH v4 2/2] gitk: synchronize config write
Date: Mon, 10 Nov 2014 00:20:02 +0200
Message-ID: <1415571602-5858-3-git-send-email-max@max630.net>
References: <1415571602-5858-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Sun Nov 09 23:21:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XnarC-0006Fw-7L
	for gcvg-git-2@plane.gmane.org; Sun, 09 Nov 2014 23:21:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751652AbaKIWVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Nov 2014 17:21:05 -0500
Received: from p3plsmtpa11-01.prod.phx3.secureserver.net ([68.178.252.102]:36143
	"EHLO p3plsmtpa11-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751623AbaKIWVD (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Nov 2014 17:21:03 -0500
Received: from wheezy.pp.htv.fi ([82.181.81.240])
	by p3plsmtpa11-01.prod.phx3.secureserver.net with 
	id DaLs1p0095B68XE01aM19g; Sun, 09 Nov 2014 15:21:02 -0700
X-Mailer: git-send-email 2.0.1.1697.g73c6810
In-Reply-To: <1415571602-5858-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If several gitk instances are closed simultaneously, safestuff procedure
can run at the same time, resulting in a conflict which may cause losing
of some of the instance's changes, failing the saving operation or even
corrupting the configuration file. This can happen, for example, at user
session closing, or at group closing of all instances of an application
which is possible in some desktop environments.

To avoid this, make sure that only one saving operation is in progress.
It is guarded by existance of $config_file_tmp file. Both creating the
file and moving it to $config_file are atomic operations, so it should
be reliable.

Reading does not need to be syncronized, because moving is atomic
operation, and the $config_file always refers to full and correct file.
But, if there is a stale $config_file_tmp file, report it at gitk start.
If such file is detected at saving, just abort the saving, because this
is how gitk used to handle errors while saving.

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 33 ++++++++++++++++++++++++++++++---
 1 file changed, 30 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index ed4f71e..692d880 100755
--- a/gitk
+++ b/gitk
@@ -2776,6 +2776,19 @@ proc doprogupdate {} {
     }
 }
 
+proc config_check_tmp_exists {tries_left} {
+    global config_file_tmp
+
+    if {[file exists $config_file_tmp]} {
+	incr tries_left -1
+	if {$tries_left > 0} {
+	    after 100 [list config_check_tmp_exists $tries_left]
+	} else {
+	    error_popup "Probably there is stale $config_file_tmp file; config saving is going to fail. Check if it is being used by any existing gitk process and remove it otherwise"
+	}
+    }
+}
+
 proc config_init_trace {name} {
     global config_variable_changed config_variable_original
 
@@ -2811,11 +2824,16 @@ proc savestuff {w} {
 
     if {$stuffsaved} return
     if {![winfo viewable .]} return
+    set remove_tmp 0
     catch {
-	if {[file exists $config_file_tmp]} {
-	    file delete -force $config_file_tmp
+	set try_count 0
+	while {[catch {set f [open $config_file_tmp {WRONLY CREAT EXCL}]}]} {
+	    if {[incr try_count] > 50} {
+		error "Unable to write config file: $config_file_tmp exists"
+	    }
+	    after 100
 	}
-	set f [open $config_file_tmp w]
+	set remove_tmp 1
 	if {$::tcl_platform(platform) eq {windows}} {
 	    file attributes $config_file_tmp -hidden true
 	}
@@ -2878,6 +2896,14 @@ proc savestuff {w} {
 	puts $f "}"
 	close $f
 	file rename -force $config_file_tmp $config_file
+	set remove_tmp 0
+	return ""
+    } err
+    if {$err ne ""} {
+	puts "Error saving config: $err"
+    }
+    if {$remove_tmp} {
+	file delete -force $config_file_tmp
     }
     set stuffsaved 1
 }
@@ -12169,6 +12195,7 @@ catch {
     }
     source $config_file
 }
+config_check_tmp_exists 50
 
 set config_variables {
     mainfont textfont uifont tabstop findmergefiles maxgraphpct maxwidth
-- 
2.0.1.1697.g73c6810
