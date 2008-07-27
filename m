From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI) 2/2] git-gui: Preserve scroll position on reshow_diff.
Date: Sun, 27 Jul 2008 10:35:38 +0400
Organization: TEPKOM
Message-ID: <200807271035.38347.angavrilov@gmail.com>
References: <200807271034.21833.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 08:37:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMzsQ-0005b6-4C
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 08:37:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756095AbYG0Gft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 02:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752432AbYG0Gft
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 02:35:49 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:62207 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750753AbYG0Gfs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 02:35:48 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1894084fgg.17
        for <git@vger.kernel.org>; Sat, 26 Jul 2008 23:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=qJby9OaxovwQUlW9qmFKO+yOEp5Z3Wg+2BKzergtbeQ=;
        b=qpg4ENDySsT09yMhDof1fDI8/wAM4G7AB94xPh73IJ0Jr49RVXf9F+5WD4daOgV76R
         EwHs8GJJcoB+0UfuPPeHGHUhULh8D0sBSOSrZxeGEMZn9PoLe52PdrzamA90foz+tQcf
         +wS2sxvZT1bR8gty31vmdzqUnKx/MEsJwpylE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=CF8uheZ7gacKnLrJlLCPKlnbnICXZbJQNQuuGx3EFsgxUBwGnQ5ivPdU3dh3IwCbdL
         Paot5ZGf1ykz62mOpH5bRv+l6W7GGZoXQoVqz5qijGsbzwKRpNqJCP5x+RKuuYBR/CHn
         3VdGdgCT7FjpBdd0YIzWBwyOA7usKVg8HV+sQ=
Received: by 10.86.72.15 with SMTP id u15mr1421808fga.22.1217140546623;
        Sat, 26 Jul 2008 23:35:46 -0700 (PDT)
Received: from desktop2 ( [92.255.84.130])
        by mx.google.com with ESMTPS id l19sm10509589fgb.7.2008.07.26.23.35.45
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jul 2008 23:35:45 -0700 (PDT)
User-Agent: KMail/1.9.9
In-Reply-To: <200807271034.21833.angavrilov@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90322>

It is especially useful for Stage/Unstage Line, because
they invoke full state scan and diff reload, which originally
would reset the scroll position to the top of the file.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/diff.tcl |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index 96ba949..1c1aa56 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -19,6 +19,7 @@ proc clear_diff {} {
 proc reshow_diff {} {
 	global file_states file_lists
 	global current_diff_path current_diff_side
+	global ui_diff
 
 	set p $current_diff_path
 	if {$p eq {}} {
@@ -28,7 +29,8 @@ proc reshow_diff {} {
 		|| [lsearch -sorted -exact $file_lists($current_diff_side) $p] == -1} {
 		clear_diff
 	} else {
-		show_diff $p $current_diff_side
+		set save_pos [lindex [$ui_diff yview] 0]
+		show_diff $p $current_diff_side {} $save_pos
 	}
 }
 
@@ -52,7 +54,7 @@ A rescan will be automatically started to find other files which may have the sa
 	rescan ui_ready 0
 }
 
-proc show_diff {path w {lno {}}} {
+proc show_diff {path w {lno {}} {scroll_pos {}}} {
 	global file_states file_lists
 	global is_3way_diff diff_active repo_config
 	global ui_diff ui_index ui_workdir
@@ -151,6 +153,10 @@ proc show_diff {path w {lno {}}} {
 		$ui_diff conf -state disabled
 		set diff_active 0
 		unlock_index
+		if {$scroll_pos ne {}} {
+			update
+			$ui_diff yview moveto $scroll_pos
+		}
 		ui_ready
 		return
 	}
@@ -190,10 +196,10 @@ proc show_diff {path w {lno {}}} {
 		-blocking 0 \
 		-encoding binary \
 		-translation binary
-	fileevent $fd readable [list read_diff $fd]
+	fileevent $fd readable [list read_diff $fd $scroll_pos]
 }
 
-proc read_diff {fd} {
+proc read_diff {fd scroll_pos} {
 	global ui_diff diff_active
 	global is_3way_diff current_diff_header
 
@@ -282,6 +288,10 @@ proc read_diff {fd} {
 		close $fd
 		set diff_active 0
 		unlock_index
+		if {$scroll_pos ne {}} {
+			update
+			$ui_diff yview moveto $scroll_pos
+		}
 		ui_ready
 
 		if {[$ui_diff index end] eq {2.0}} {
-- 
1.5.6.3.18.gfe82
