From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] git-gui: respect conflict marker size
Date: Tue, 16 Nov 2010 08:49:22 +0100
Message-ID: <1289893762-28567-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Nov 16 08:50:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIGIs-0003Xr-DI
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 08:50:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759457Ab0KPHuC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 02:50:02 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:37388 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759454Ab0KPHuA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 02:50:00 -0500
Received: by mail-ew0-f46.google.com with SMTP id 8so127460ewy.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 23:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=RWtm0+FM4T0L7CotfDGu9Z0tUMsfexpwz7ujbviuNrg=;
        b=vU1NxDBecfSPL984hnxEXBLDiKUbph9HQEck368CdGQpJ4w4gfL3uXh1aCGY/OGkk+
         MOs106SwTDtTL6tT7PvKmGPBnxA740NleB42rutCgFs5IacSe6Y0DzeQd1pn9Tja9Iv4
         gneZCjNZYE2txKeanZG7qfN7+0TPq7vM/+xnw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NTlvaaRNVAK7IrO4udw9DuoFxhn3hJiaIuqdY+okY8N/g6RmAXwK2GWOjxj1oV+HBV
         /Sz0r4vL5pSCWrBoXdLT8VNd79U/6/PBpJ6oNq8QjUHtjJFnjwSOxjlgJ0DBTLOS2VWn
         /mJyDa9uLvxUW3anbfhQozYzJP7epQf4O79kU=
Received: by 10.213.28.9 with SMTP id k9mr5473565ebc.99.1289893800034;
        Mon, 15 Nov 2010 23:50:00 -0800 (PST)
Received: from localhost ([92.116.142.180])
        by mx.google.com with ESMTPS id b52sm866326eei.1.2010.11.15.23.49.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 23:49:59 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1157.gd16c3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161547>

Respect the conflict-marker-size attribute on paths when detecting merge
conflicts.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 git-gui/lib/diff.tcl |   22 ++++++++++++++++++----
 1 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index dcf0711..a753737 100644
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
+				if {[regexp {^\+\+([<>]{$conflict_size} |={$conflict_size})} $line _g op]} {
 					set is_conflict_diff 1
 					set line [string replace $line 0 1 {  }]
 					set tags d$op
@@ -441,7 +455,7 @@ proc read_diff {fd cont_info} {
 			{@} {set tags d_@}
 			{-} {set tags d_-}
 			{+} {
-				if {[regexp {^\+([<>]{7} |={7})} $line _g op]} {
+				if {[regexp {^\+([<>]{$conflict_size} |={$conflict_size})} $line _g op]} {
 					set is_conflict_diff 1
 					set tags d$op
 				} else {
-- 
tg: (6f10c41..) bw/git-gui/respect-conflict-marker-size (depends on: master)
