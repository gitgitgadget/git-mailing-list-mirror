From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH] git-gui: Fix the blame window shape.
Date: Fri,  3 Oct 2008 11:36:52 +0400
Message-ID: <1223019414-24643-1-git-send-email-angavrilov@gmail.com>
Cc: "Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 03 09:39:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KlfGP-0008FF-Gh
	for gcvg-git-2@gmane.org; Fri, 03 Oct 2008 09:39:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754248AbYJCHic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2008 03:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754161AbYJCHic
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Oct 2008 03:38:32 -0400
Received: from fk-out-0910.google.com ([209.85.128.187]:35367 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754185AbYJCHia (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2008 03:38:30 -0400
Received: by fk-out-0910.google.com with SMTP id 18so982302fkq.5
        for <git@vger.kernel.org>; Fri, 03 Oct 2008 00:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=RRRhLZ5lJMQ2M3WI8X+CNR40nYyO9hVKDyALL6Y3ItA=;
        b=oTVTukSIAqcXRLb6JMb/IbcOz3I2ysygkMkMW+E2cVf+DIu1NbXxppL44Hm2GAstje
         ul/9g21JJCycMZUwe31jG3pU7LSb7ZzJaiI+/M6MLicyxFOF95nqOOu3LLcKgatfIHvZ
         22aBaiolBr/3hU+TJ6A95LJavN8RN+SVjWoVY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=RUqyNP7nt8ZGojZaxZV7CGY/UThPfua6rF8QeFI4e9ODv/go6j0+P9VVTWPZdB6zNo
         qmOqhhD7v7/kkihd5Mzi/ciBRh6t5VxowgJ1rY/aYSEXKK471G1Ry0W/RhYSmRZyGyoM
         PYfivmlvsq450Ciht7MKSNFRwtcyhfD2cNqCI=
Received: by 10.180.246.10 with SMTP id t10mr264158bkh.104.1223019507698;
        Fri, 03 Oct 2008 00:38:27 -0700 (PDT)
Received: from localhost.localdomain ([92.255.85.78])
        by mx.google.com with ESMTPS id 31sm3873133fkt.3.2008.10.03.00.38.26
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 03 Oct 2008 00:38:27 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.20.g6148bc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97403>

On modern high-resolution monitors the blame viewer
window is very high, yet too narrow. This patch
makes it gravitate to a more sane resolution, which
takes the font size into account.

It also changes the default text view size to 80% of
the window, and slightly modifies the border decorations
for better appearance.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 lib/blame.tcl |   19 +++++++++++++------
 1 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index eb61374..221313c 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -69,6 +69,8 @@ constructor new {i_commit i_path i_jump} {
 	make_toplevel top w
 	wm title $top [append "[appname] ([reponame]): " [mc "File Viewer"]]
 
+	set font_w [font measure font_diff "0"]
+
 	frame $w.header -background gold
 	label $w.header.commit_l \
 		-text [mc "Commit:"] \
@@ -114,9 +116,9 @@ constructor new {i_commit i_path i_jump} {
 	pack $w_path -fill x -side right
 	pack $w.header.path_l -side right
 
-	panedwindow $w.file_pane -orient vertical
-	frame $w.file_pane.out
-	frame $w.file_pane.cm
+	panedwindow $w.file_pane -orient vertical -borderwidth 0 -sashwidth 3
+	frame $w.file_pane.out -relief flat -borderwidth 1
+	frame $w.file_pane.cm -relief sunken -borderwidth 1
 	$w.file_pane add $w.file_pane.out \
 		-sticky nsew \
 		-minsize 100 \
@@ -328,9 +330,14 @@ constructor new {i_commit i_path i_jump} {
 
 	set req_w [winfo reqwidth  $top]
 	set req_h [winfo reqheight $top]
-	set scr_h [expr {[winfo screenheight $top] - 100}]
-	if {$req_w < 600} {set req_w 600}
+	set scr_w [expr {[winfo screenwidth $top] - 40}]
+	set scr_h [expr {[winfo screenheight $top] - 120}]
+	set opt_w [expr {$font_w * (80 + 5*3 + 3)}]
+	if {$req_w < $opt_w} {set req_w $opt_w}
+	if {$req_w > $scr_w} {set req_w $scr_w}
+	set opt_h [expr {$req_w*4/3}]
 	if {$req_h < $scr_h} {set req_h $scr_h}
+	if {$req_h > $opt_h} {set req_h $opt_h}
 	set g "${req_w}x${req_h}"
 	wm geometry $top $g
 	update
@@ -338,7 +345,7 @@ constructor new {i_commit i_path i_jump} {
 	set old_height [winfo height $w.file_pane]
 	$w.file_pane sash place 0 \
 		[lindex [$w.file_pane sash coord 0] 0] \
-		[expr {int($old_height * 0.70)}]
+		[expr {int($old_height * 0.80)}]
 	bind $w.file_pane <Configure> \
 	"if {{$w.file_pane} eq {%W}} {[cb _resize %h]}"
 
-- 
1.6.0.20.g6148bc
