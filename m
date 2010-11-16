From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH 2/2] git-gui: support for diff3 conflict style
Date: Tue, 16 Nov 2010 10:26:58 +0100
Message-ID: <1289899618-2845-1-git-send-email-bert.wesarg@googlemail.com>
References: <1289899312-2732-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Tue Nov 16 10:27:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PIHok-0004P7-8w
	for gcvg-git-2@lo.gmane.org; Tue, 16 Nov 2010 10:27:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934080Ab0KPJ1D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Nov 2010 04:27:03 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:39945 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932447Ab0KPJ1B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Nov 2010 04:27:01 -0500
Received: by ewy8 with SMTP id 8so147527ewy.19
        for <git@vger.kernel.org>; Tue, 16 Nov 2010 01:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Ixx5/eIENGvcnQbj5b8r/waEa8GngvVq6+IMe0HiRBM=;
        b=LEslZ0fPMEV8os9eq+h27rl6LojmAdfrPi5yWI5s46MQnWSYRPRTESkRpUpNXr4B2q
         OQOEnxqOi1bfCHxiSqv/PSTutkE89z9Xalqg107n0bw55bIa9DGmYTvm9+7F7GvwkBTw
         EDVmfz+yazYkyZXUhyBU/QzgREJk+m/rjhV0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=E49cDFqQwsX+RCfzqwxm4Lq4ZePTvz4E3aMrxDxHWuTkc6ZEolqK8vy9PlI+WAiyRI
         qK1OjTtyzVmzgHf/Fn0oIdfGYQZIPS3v4STo1gARxki+2PZWmsJkPocGULOzFxM80PjF
         tBIIp725+PU5jCp3qQnVvmJ7MgKuv1nVUxahQ=
Received: by 10.213.14.148 with SMTP id g20mr5542381eba.66.1289899620202;
        Tue, 16 Nov 2010 01:27:00 -0800 (PST)
Received: from localhost ([141.76.90.249])
        by mx.google.com with ESMTPS id v51sm936778eeh.10.2010.11.16.01.26.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 16 Nov 2010 01:26:59 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1157.gd16c3
In-Reply-To: <1289899312-2732-1-git-send-email-bert.wesarg@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161551>

This adds highlight support for the diff3 conflict style.

The common pre-image will be reversed to --, because it has been removed
and either replaced with our or their side.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 git-gui/git-gui.sh   |    3 +++
 git-gui/lib/diff.tcl |   10 ++++++++++
 2 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index 38362fa..0134438 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -3354,6 +3354,9 @@ $ui_diff tag conf d_s- \
 $ui_diff tag conf d< \
 	-foreground orange \
 	-font font_diffbold
+$ui_diff tag conf d| \
+	-foreground orange \
+	-font font_diffbold
 $ui_diff tag conf d= \
 	-foreground orange \
 	-font font_diffbold
diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index d4e2ce3..ccd4c70 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -339,6 +339,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
 	}
 
 	set ::current_diff_inheader 1
+	set ::in_conflict_pre_image 0
 	fconfigure $fd \
 		-blocking 0 \
 		-encoding [get_path_encoding $path] \
@@ -420,6 +421,15 @@ proc read_diff {fd conflict_size cont_info} {
 					set is_conflict_diff 1
 					set line [string replace $line 0 1 {  }]
 					set tags d$op
+					set ::in_conflict_pre_image 0
+				} elseif {[regexp {^\+\+\|{$conflict_size}(?: |$)} $line]} {
+					set is_conflict_diff 1
+					set line [string replace $line 0 1 {  }]
+					set tags d|
+					set ::in_conflict_pre_image 1
+				} elseif ($::in_conflict_pre_image) {
+					set line [string replace $line 0 1 {--}]
+					set tags d_--
 				} else {
 					set tags d_++
 				}
-- 
tg: (fba7c96..) bw/git-gui/support-diff3 (depends on: master bw/git-gui/respect-conflict-marker-size)
