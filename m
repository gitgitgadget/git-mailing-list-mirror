From: Alexander Gavrilov <angavrilov@gmail.com>
Subject: [PATCH (GIT-GUI FIX)] git-gui: Restore ability to Stage Working Copy for conflicts.
Date: Mon, 8 Sep 2008 20:37:11 +0400
Organization: HOME
Message-ID: <200809082037.12173.angavrilov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 08 18:42:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kcjop-0006yq-NC
	for gcvg-git-2@gmane.org; Mon, 08 Sep 2008 18:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172AbYIHQlU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2008 12:41:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751584AbYIHQlU
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Sep 2008 12:41:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.157]:8399 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752008AbYIHQlT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2008 12:41:19 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1535025fgg.17
        for <git@vger.kernel.org>; Mon, 08 Sep 2008 09:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:organization:to:subject
         :date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=i3s/3UvvkXuukImzrPEZ2EpJI3BDuQDnNGC4bDSOZNU=;
        b=jhLcIMpDokA3KVM2OK9LjUUILNyGrgJ8CzPii3CNKlB9OvQFF87WZoLGHG695XMhzc
         2Ulxvqs69ZFzgcjSUsVMMZsnJx7pzPTRQHfPlbLuAcQLJS4mjHvDCV5bvfDNSRi59Bov
         haWhvmix247i5QpPFNgwm4WBOutyDElT7fKUQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:organization:to:subject:date:user-agent:cc:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :message-id;
        b=fXV1arhnd5w8sXsqMx4t9727zzxd3+H9TUw5xa5wH6xJm0S39ofEFM24l3Jh5ofkFc
         9GSFjiDAqQlHGcL/EUENuHPf8E3PpLoqIfPOVBS+srPZap0k0cG3uD1NALd5vm+iB4tj
         Tc+c7WsONlBJqpMF+VdNkcope71ck+Z+EUHHM=
Received: by 10.86.80.5 with SMTP id d5mr11497806fgb.19.1220891908291;
        Mon, 08 Sep 2008 09:38:28 -0700 (PDT)
Received: from ?192.168.100.3? ( [92.255.85.78])
        by mx.google.com with ESMTPS id l19sm4716757fgb.7.2008.09.08.09.38.26
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 08 Sep 2008 09:38:27 -0700 (PDT)
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95272>

Tools like rerere leave files marked as conflicts in the index,
while actually resolving them in the working copy. Also, some
people like to use an external editor to resolve conflicts.

This patch restores functionality previously removed in
commit 617ceee653 by adding a new context menu item.
It still ensures that the user does not stage conflicting files
accidentally by clicking on the icon instead of the name.

Signed-off-by: Alexander Gavrilov <angavrilov@gmail.com>
---
 git-gui.sh        |    5 +++++
 lib/mergetool.tcl |    6 ++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index d227eca..a732ef1 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -2984,6 +2984,11 @@ $ctxmmg add command \
 	-command {merge_resolve_one 1}
 lappend diff_actions [list $ctxmmg entryconf [$ctxmmg index last] -state]
 $ctxmmg add separator
+$ctxmmg add command \
+	-label [mc "Stage Working Copy"] \
+	-command {merge_resolve_one 0}
+lappend diff_actions [list $ctxmmg entryconf [$ctxmmg index last] -state]
+$ctxmmg add separator
 create_common_diff_popup $ctxmmg
 
 proc popup_diff_menu {ctxm ctxmmg x y X Y} {
diff --git a/lib/mergetool.tcl b/lib/mergetool.tcl
index 79c58bc..dd2315b 100644
--- a/lib/mergetool.tcl
+++ b/lib/mergetool.tcl
@@ -5,6 +5,12 @@ proc merge_resolve_one {stage} {
 	global current_diff_path
 
 	switch -- $stage {
+		0 {	# Stage without confirmation, to minimize
+			# disruption of the rerere workflow
+			merge_add_resolution $current_diff_path
+			return
+		}
+
 		1 { set target [mc "the base version"] }
 		2 { set target [mc "this branch"] }
 		3 { set target [mc "the other branch"] }
-- 
1.6.0.20.g6148bc
