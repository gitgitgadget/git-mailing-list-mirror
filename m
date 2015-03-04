From: Max Kirillov <max@max630.net>
Subject: [PATCH v5 3/3] gitk: synchronize config write
Date: Wed,  4 Mar 2015 05:58:18 +0200
Message-ID: <1425441498-29416-4-git-send-email-max@max630.net>
References: <1425441498-29416-1-git-send-email-max@max630.net>
Cc: git@vger.kernel.org, Max Kirillov <max@max630.net>
To: Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Wed Mar 04 04:58:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YT0SB-0000uj-Uz
	for gcvg-git-2@plane.gmane.org; Wed, 04 Mar 2015 04:58:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758002AbbCDD6b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Mar 2015 22:58:31 -0500
Received: from p3plsmtpa09-10.prod.phx3.secureserver.net ([173.201.193.239]:53358
	"EHLO p3plsmtpa09-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757698AbbCDD62 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Mar 2015 22:58:28 -0500
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa09-10.prod.phx3.secureserver.net with 
	id zFyH1p00U5B68XE01FyT2w; Tue, 03 Mar 2015 20:58:28 -0700
X-Mailer: git-send-email 2.1.1.391.g7a54a76
In-Reply-To: <1425441498-29416-1-git-send-email-max@max630.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264717>

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
If such file is detected at saving, just report it abort the saving, as
other saving error does.

Signed-off-by: Max Kirillov <max@max630.net>
---
 gitk | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/gitk b/gitk
index 9404d5d..b2cfd47 100755
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
     if {[catch {
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
@@ -2877,9 +2895,13 @@ proc savestuff {w} {
 	puts $f "}"
 	close $f
 	file rename -force $config_file_tmp $config_file
+	set remove_tmp 0
     } err]} {
         puts "Error saving config: $err"
     }
+    if {$remove_tmp} {
+	file delete -force $config_file_tmp
+    }
     set stuffsaved 1
 }
 
@@ -12170,6 +12192,7 @@ catch {
     }
     source $config_file
 }
+config_check_tmp_exists 50
 
 set config_variables {
     mainfont textfont uifont tabstop findmergefiles maxgraphpct maxwidth
-- 
2.1.1.391.g7a54a76
