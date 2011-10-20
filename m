From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] git-gui: delegate selection from gutter columns to text output
Date: Thu, 20 Oct 2011 21:45:09 +0200
Message-ID: <5fc6f5d088e37508f1911f89b4d82932071045e0.1319139888.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 20 21:45:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGyYa-00046c-VW
	for gcvg-git-2@lo.gmane.org; Thu, 20 Oct 2011 21:45:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752137Ab1JTTpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Oct 2011 15:45:15 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:58172 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752056Ab1JTTpO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Oct 2011 15:45:14 -0400
Received: by bkbzt19 with SMTP id zt19so3933140bkb.19
        for <git@vger.kernel.org>; Thu, 20 Oct 2011 12:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=lCCOEtcVAxvkfXYK4SWNuPUGlbvQtMfgfUdbWxnJM5M=;
        b=mbOXCaUxTVGiKRhSR6T4DycqUNuNbV208kNkAwxuuqmG7H/mbMG5ZNyw//760bgYrM
         FhTgG1291gBDRUPjfH/abvOkRCBFZLOdTUetlqFUkgp7nW4alFCjwEGSx0PqGORwR1jQ
         H+3F9BZHChehf9Zlgvpyl5k23Kxjwo8Cntdho=
Received: by 10.204.29.8 with SMTP id o8mr8650104bkc.48.1319139913002;
        Thu, 20 Oct 2011 12:45:13 -0700 (PDT)
Received: from localhost (p5B2AD78D.dip.t-dialin.net. [91.42.215.141])
        by mx.google.com with ESMTPS id w8sm10924862bks.11.2011.10.20.12.45.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 20 Oct 2011 12:45:12 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.759.gfc8c6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184041>

Selecting in the gutter columns of the blame view should make no sense,
so delegate any selection action in these columns to the text output
by selecting whole lines there.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh    |   20 ++++++++++++++++++++
 lib/blame.tcl |    4 +++-
 2 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 21033cb..cf5ed79 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2077,6 +2077,26 @@ proc many2scrollbar {list mode sb top bottom} {
 	foreach w $list {$w $mode moveto $top}
 }
 
+proc delegate_sel_to {w from} {
+	set bind_list [list \
+		<Button-1> \
+		<B1-Motion> \
+		<Double-Button-1> \
+		<Triple-Button-1> \
+		<Shift-Button-1> \
+		<Double-Shift-Button-1> \
+		<Triple-Shift-Button-1> \
+	]
+
+	foreach seq $bind_list {
+		set script [bind Text $seq]
+		set new_script [string map [list %W $w %x 0 word line] $script]
+		foreach f $from {
+			bind $f $seq "$new_script; break"
+		}
+	}
+}
+
 proc incr_font_size {font {amt 1}} {
 	set sz [font configure $font -size]
 	incr sz $amt
diff --git a/lib/blame.tcl b/lib/blame.tcl
index 49eae19..9ab0da5 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -210,6 +210,8 @@ constructor new {i_commit i_path i_jump} {
 
 	set w_columns [list $w_amov $w_asim $w_line $w_file]
 
+	delegate_sel_to $w_file [list $w_amov $w_asim $w_line]
+
 	${NS}::scrollbar $w.file_pane.out.sbx \
 		-orient h \
 		-command [list $w_file xview]
@@ -315,7 +317,7 @@ constructor new {i_commit i_path i_jump} {
 		$i conf -yscrollcommand \
 			"[list ::searchbar::scrolled $finder]
 			 [list many2scrollbar $w_columns yview $w.file_pane.out.sby]"
-		bind $i <Button-1> "
+		bind $i <Button-1> "+
 			[cb _hide_tooltip]
 			[cb _click $i @%x,%y]
 			focus $i
-- 
1.7.7.759.gfc8c6
