From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCHv2 1/2] git-gui: respect conflict marker size
Date: Tue, 16 Nov 2010 10:21:52 +0100
Message-ID: <1289899312-2732-1-git-send-email-bert.wesarg@googlemail.com>
References: <1289893762-28567-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Nov 16 10:22:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIHjo-00027n-Uw
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 10:22:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934079Ab0KPJV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 04:21:59 -0500
Received: from mail-ey0-f174.google.com ([209.85.215.174]:60731 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934044Ab0KPJV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 04:21:56 -0500
Received: by eye27 with SMTP id 27so143478eye.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 01:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=OnzvkT92064x5nejmWtvKQ77NpTBhwofcdzvYBgwp1M=;
        b=lpaZ0ntHEYvlxcGjxrSVx/R/4w4biXRlYKP4XSQXZAo0K2L3GGcvuC/go3F/VI5w+7
         5g5/7ArpOA+P295goBW1NNGAu5PZCgYR3preR43TLEWw30iSrtQJ9QwO8lJDHRqhmTPc
         L5lzWqduVhQt6NFpCAzPOgTGklU9J8T+3cLCE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=dWNxce6umOm86/sYHwiuLDDp+eQFlCLVg+Hl8CeQWa6e0fBqEOrqHTGdQBkbdCgNMQ
         HAlJ8PlFNA7tEmq3ojuXgr0wJuApIVlA1oj3ksO05vzywCJ6HBJNlXCHlHrDjnwRbHG0
         wPw9ES/ViGECGm8AmU3+moPh0vUga0fDv337I=
Received: by 10.213.105.143 with SMTP id t15mr155689ebo.13.1289899314695;
        Tue, 16 Nov 2010 01:21:54 -0800 (PST)
Received: from localhost ([141.76.90.249])
        by mx.google.com with ESMTPS id w20sm933732eeh.12.2010.11.16.01.21.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 01:21:53 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1157.gd16c3
In-Reply-To: <1289893762-28567-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161550>

Respect the conflict-marker-size attribute on paths when detecting merge
conflicts.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---

v2 fixes the tags selection and also the regexp to match always exactly the
desired number of markers.

Bert

 git-gui/git-gui.sh   |    6 +++---
 git-gui/lib/diff.tcl |   22 ++++++++++++++++++----
 2 files changed, 21 insertions(+), 7 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index d3acf0d..38362fa 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3351,13 +3351,13 @@ $ui_diff tag conf d_s- \
 	-foreground red \
 	-background ivory1
 
-$ui_diff tag conf d<<<<<<< \
+$ui_diff tag conf d< \
 	-foreground orange \
 	-font font_diffbold
-$ui_diff tag conf d======= \
+$ui_diff tag conf d= \
 	-foreground orange \
 	-font font_diffbold
-$ui_diff tag conf d>>>>>>> \
+$ui_diff tag conf d> \
 	-foreground orange \
 	-font font_diffbold
 
diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index dcf0711..d4e2ce3 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -253,6 +253,19 @@ proc show_other_diff {path w m cont_info} {
 	}
 }
 
+proc get_conflict_marker_size {path} {
+	set size 7
+	catch {
+		set fd_rc [eval [list git_read check-attr "conflict-marker-size" -- $path]]
+		set ret [gets $fd_rc line]
+		close $fd_rc
+		if {$ret > 0} {
+			regexp {.*: conflict-marker-size: (\d+)$} $line line size
+		}
+	}
+	return $size
+}
+
 proc start_show_diff {cont_info {add_opts {}}} {
 	global file_states file_lists
 	global is_3way_diff is_submodule_diff diff_active repo_config
@@ -268,6 +281,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	set is_submodule_diff 0
 	set diff_active 1
 	set current_diff_header {}
+	set conflict_size [get_conflict_marker_size $path]
 
 	set cmd [list]
 	if {$w eq $ui_index} {
@@ -329,7 +343,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 		-blocking 0 \
 		-encoding [get_path_encoding $path] \
 		-translation lf
-	fileevent $fd readable [list read_diff $fd $cont_info]
+	fileevent $fd readable [list read_diff $fd $conflict_size $cont_info]
 }
 
 proc parse_color_line {line} {
@@ -349,7 +363,7 @@ proc parse_color_line {line} {
 	return [list $result $markup]
 }
 
-proc read_diff {fd cont_info} {
+proc read_diff {fd conflict_size cont_info} {
 	global ui_diff diff_active is_submodule_diff
 	global is_3way_diff is_conflict_diff current_diff_header
 	global current_diff_queue
@@ -402,7 +416,7 @@ proc read_diff {fd cont_info} {
 			{- } {set tags d_-s}
 			{--} {set tags d_--}
 			{++} {
-				if {[regexp {^\+\+([<>]{7} |={7})} $line _g op]} {
+				if {[regexp {^\+\+([<>=]){$conflict_size}(?: |$)} $line _g op]} {
 					set is_conflict_diff 1
 					set line [string replace $line 0 1 {  }]
 					set tags d$op
@@ -441,7 +455,7 @@ proc read_diff {fd cont_info} {
 			{@} {set tags d_@}
 			{-} {set tags d_-}
 			{+} {
-				if {[regexp {^\+([<>]{7} |={7})} $line _g op]} {
+				if {[regexp {^\+([<>=]){$conflict_size}(?: |$)} $line _g op]} {
 					set is_conflict_diff 1
 					set tags d$op
 				} else {
-- 
tg: (6f10c41..) bw/git-gui/respect-conflict-marker-size (depends on: master)
