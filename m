From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 1/4] git-gui: search and linenumber input are mutual exclusive in the blame view
Date: Thu, 13 Oct 2011 15:48:12 +0200
Message-ID: <1d1c91fdaa0bfd31067fd2e06f3f1ecf5597b8d3.1318513492.git.bert.wesarg@googlemail.com>
Cc: David Fries <David@Fries.net>, git@vger.kernel.org,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Thu Oct 13 15:48:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RELeB-0002Hq-FF
	for gcvg-git-2@lo.gmane.org; Thu, 13 Oct 2011 15:48:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755297Ab1JMNsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Oct 2011 09:48:21 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:33264 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755264Ab1JMNsT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Oct 2011 09:48:19 -0400
Received: by bkbzt4 with SMTP id zt4so1464856bkb.19
        for <git@vger.kernel.org>; Thu, 13 Oct 2011 06:48:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=jKSnPfVIQ+TOlax13P1MfjAoC300KBvs3Ke58PHeEGo=;
        b=BiShBRRWsi+rStpVAHNCu8va0k7syGOtJGfkOSbms6q3bT5hepJSJ+ZFfr4yVrZTlH
         XjSJRV89Tzdx13CuENXcOpw50dWqxKqkqYGxGFhu9bwJETu45yBb89oRBBn3LZuIIsHN
         3S4IiNdRAZEPAOOFIIA4zuH1/oEfIRL3fVtjI=
Received: by 10.204.144.204 with SMTP id a12mr2907386bkv.5.1318513698526;
        Thu, 13 Oct 2011 06:48:18 -0700 (PDT)
Received: from localhost (m111.zih.tu-dresden.de. [141.30.68.111])
        by mx.google.com with ESMTPS id k6sm3729016bkv.8.2011.10.13.06.48.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 13 Oct 2011 06:48:17 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.789.gb4599
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183483>

It was possible to open the search input (Ctrl+S) and the goto-line input
(Ctrl+G) at the same time. Prevent this.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 lib/blame.tcl |   22 ++++++++++++++++------
 1 files changed, 16 insertions(+), 6 deletions(-)

diff --git a/lib/blame.tcl b/lib/blame.tcl
index 2099776..691941e 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -280,11 +280,11 @@ constructor new {i_commit i_path i_jump} {
 	$w.ctxm add command \
 		-label [mc "Find Text..."] \
 		-accelerator F7 \
-		-command [list searchbar::show $finder]
+		-command [cb _show_finder]
 	$w.ctxm add command \
 		-label [mc "Goto Line..."] \
 		-accelerator "Ctrl-G" \
-		-command [list linebar::show $gotoline]
+		-command [cb _show_linebar]
 	menu $w.ctxm.enc
 	build_encoding_menu $w.ctxm.enc [cb _setencoding]
 	$w.ctxm add cascade \
@@ -351,13 +351,13 @@ constructor new {i_commit i_path i_jump} {
 	bind $w_cviewer <Tab>       "[list focus $w_file];break"
 	bind $w_cviewer <Button-1>   [list focus $w_cviewer]
 	bind $w_file    <Visibility> [cb _focus_search $w_file]
-	bind $top       <F7>         [list searchbar::show $finder]
-	bind $top       <Key-slash>  [list searchbar::show $finder]
-	bind $top    <Control-Key-s> [list searchbar::show $finder]
+	bind $top       <F7>         [cb _show_finder]
+	bind $top       <Key-slash>  [cb _show_finder]
+	bind $top    <Control-Key-s> [cb _show_finder]
 	bind $top       <Escape>     [list searchbar::hide $finder]
 	bind $top       <F3>         [list searchbar::find_next $finder]
 	bind $top       <Shift-F3>   [list searchbar::find_prev $finder]
-	bind $top    <Control-Key-g> [list linebar::show $gotoline]
+	bind $top    <Control-Key-g> [cb _show_linebar]
 	catch { bind $top <Shift-Key-XF86_Switch_VT_3> [list searchbar::find_prev $finder] }
 
 	grid configure $w.header -sticky ew
@@ -1349,4 +1349,14 @@ method _resize {new_height} {
 	set old_height $new_height
 }
 
+method _show_finder {} {
+	linebar::hide $gotoline
+	searchbar::show $finder
+}
+
+method _show_linebar {} {
+	searchbar::hide $finder
+	linebar::show $gotoline
+}
+
 }
-- 
1.7.6.789.gb4599
