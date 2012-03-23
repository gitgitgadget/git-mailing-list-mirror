From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: [GIT GUI PATCH 2/2] git-gui: add "open in editor" diff context menu entry
Date: Fri, 23 Mar 2012 18:30:28 +0100
Message-ID: <f035d9318ecd77bba8942fc6879f6c43f3c48112.1332523097.git.hvoigt@hvoigt.net>
References: <cover.1332523097.git.hvoigt@hvoigt.net>
Cc: git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Fri Mar 23 18:38:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SB8RF-0004HI-Dy
	for gcvg-git-2@plane.gmane.org; Fri, 23 Mar 2012 18:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756777Ab2CWRh5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Mar 2012 13:37:57 -0400
Received: from darksea.de ([83.133.111.250]:59642 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755227Ab2CWRh4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Mar 2012 13:37:56 -0400
Received: (qmail 14368 invoked from network); 23 Mar 2012 18:31:14 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 23 Mar 2012 18:31:14 +0100
X-Mailer: git-send-email 1.7.10.rc1.29.gf035d
In-Reply-To: <cover.1332523097.git.hvoigt@hvoigt.net>
In-Reply-To: <cover.1332523097.git.hvoigt@hvoigt.net>
References: <cover.1332523097.git.hvoigt@hvoigt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193776>

When cleaning up changes it is helpful to start an editor on the file
viewed. Since we roughly know the line number it is also possible to
feed the editor with that. An example implementation for some popular
editors is contained in this patch.

Signed-off-by: Heiko Voigt <heiko.voigt@mahr.de>
---
 git-gui/git-gui.sh |   51 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 35cdee8..c80bbff 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -2237,6 +2237,49 @@ proc do_explore {} {
 	eval exec $explorer [list [file nativename $_gitworktree]] &
 }
 
+proc do_editor {file x y} {
+	global repo_config ui_diff
+
+	set filearg "$file"
+	set _e [string map {' \"} $repo_config(core.editor)]
+	set editor [lindex $_e 0]
+	lappend exe [_which $editor]
+	if {[llength $_e] > 1} {
+		lappend args [lrange $_e 1 end]
+	}
+
+	set line_no {}
+	catch {
+		set s_lno [lindex [split [$ui_diff index @$x,$y] .] 0]
+		set s_lno [$ui_diff search -backwards -regexp ^@@ $s_lno.0 0.0]
+		set hunk_header [$ui_diff get $s_lno "$s_lno lineend"]
+
+		regexp {^@@@? -([0-9]+),[0-9]+} $hunk_header -> line_no
+	}
+
+	if {$line_no ne {}} {
+		switch -glob -- $editor {
+			*notepad++* {
+				lappend args -n$line_no
+			}
+			*textpad* {
+				set filearg "$filearg\($line_no,0\)"
+			}
+			*emacs* -
+			*vim* {
+				lappend args +$line_no
+			}
+		}
+	}
+	lappend args $filearg
+
+	if {[lindex $exe 0] eq {}} {
+		error_popup [mc "Couldn't find %s in PATH" $repo_config(core.editor)]
+	} else {
+		eval exec $exe $args &
+	}
+}
+
 set is_quitting 0
 set ret_code    1
 
@@ -3516,6 +3559,14 @@ $ctxm add command \
 	-label [mc "Show More Context"] \
 	-command show_more_context
 lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+set editor ""
+catch {set editor $repo_config(core.editor)}
+if {$editor ne {}} {
+	$ctxm add command \
+		-label [mc "Open in Editor"] \
+		-command {do_editor $current_diff_path $cursorX $cursorY}
+	lappend diff_actions [list $ctxm entryconf [$ctxm index last] -state]
+}
 $ctxm add separator
 create_common_diff_popup $ctxm
 
-- 
1.7.10.rc1.29.gf035d
