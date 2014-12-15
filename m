From: Csaba Kiraly <kiraly@disi.unitn.it>
Subject: [PATCH v2] git-gui: fix problem with gui.maxfilesdisplayed
Date: Mon, 15 Dec 2014 16:38:00 +0100
Message-ID: <548F0058.9090701@disi.unitn.it>
References: <54490495.2010200@disi.unitn.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Dan Zwell <dzwell@zwell.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Csaba Kiraly <kiraly@fbk.eu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 15 16:43:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y0XoM-0000Y4-3d
	for gcvg-git-2@plane.gmane.org; Mon, 15 Dec 2014 16:43:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752664AbaLOPnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Dec 2014 10:43:46 -0500
Received: from mail3.unitn.it ([193.205.206.24]:63002 "EHLO mail3.unitn.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752298AbaLOPnp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Dec 2014 10:43:45 -0500
X-Greylist: delayed 339 seconds by postgrey-1.27 at vger.kernel.org; Mon, 15 Dec 2014 10:43:45 EST
Received: from mail3.unitn.it (localhost.localdomain [127.0.0.1])
	by localhost (Email Security Appliance) with SMTP id BD016C0535_48F0059B;
	Mon, 15 Dec 2014 15:38:01 +0000 (GMT)
Received: from mailhub2.unitn.it (mailhub2.unitn.it [192.168.206.47])
	by mail3.unitn.it (Sophos Email Appliance) with ESMTP id 7FC19E6F1E_48F0059F;
	Mon, 15 Dec 2014 15:38:01 +0000 (GMT)
Received: from disi.unitn.it (disi.unitn.it [193.205.194.4])
	by mailhub2.unitn.it (Postfix) with ESMTP id 70A6EB0D3D3;
	Mon, 15 Dec 2014 16:38:01 +0100 (CET)
Received: by disi.unitn.it  with ESMTP id sBFFc0bk015536;Mon, 15 Dec 2014 16:38:00 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
In-Reply-To: <54490495.2010200@disi.unitn.it>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261408>

gui.maxfilesdisplayed (added in dd6451f9c7c5a36d3006231b618ac6da06c7c7b4)
was applied brute force on the file list in alphabetic order. As a result,
files that had modifications might not be displayed by git-gui. Even
worse, files that are already in the index might not be displayed, which
makes git-gui hard to use in some workflows.

This fix changes the meaning of gui.maxfilesdisplayed, making it a soft
limit that only applies to "_O" files, i.e. files that are "Untracked,
not staged".

Signed-off-by: Csaba Kiraly <kiraly@disi.unitn.it>
---
 git-gui.sh | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 27ce0e3..0e4b05a 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -1965,20 +1965,22 @@ proc display_all_files {} {
 
 	set to_display [lsort [array names file_states]]
 	set display_limit [get_config gui.maxfilesdisplayed]
-	if {[llength $to_display] > $display_limit} {
-		if {!$files_warning} {
-			# do not repeatedly warn:
-			set files_warning 1
-			info_popup [mc "Displaying only %s of %s files." \
-				$display_limit [llength $to_display]]
-		}
-		set to_display [lrange $to_display 0 [expr {$display_limit-1}]]
-	}
+	set displayed 0
 	foreach path $to_display {
 		set s $file_states($path)
 		set m [lindex $s 0]
 		set icon_name [lindex $s 1]
 
+		if {$displayed > $display_limit && [string index $m 1] eq {O} } {
+			if {!$files_warning} {
+				# do not repeatedly warn:
+				set files_warning 1
+				info_popup [mc "Display limit (gui.maxfilesdisplayed = %s) reached, not showing all %s files." \
+					$display_limit [llength $to_display]]
+			}
+			continue
+		}
+
 		set s [string index $m 0]
 		if {$s ne {U} && $s ne {_}} {
 			display_all_files_helper $ui_index $path \
@@ -1993,6 +1995,7 @@ proc display_all_files {} {
 		if {$s ne {_}} {
 			display_all_files_helper $ui_workdir $path \
 				$icon_name $s
+			incr displayed
 		}
 	}
 
-- 
1.9.1
