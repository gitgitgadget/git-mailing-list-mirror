From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] git-gui: fix ANSI-color parsing
Date: Mon, 15 Nov 2010 11:00:33 +0100
Message-ID: <1289815233-11391-1-git-send-email-bert.wesarg@googlemail.com>
Cc: Bert Wesarg <bert.wesarg@googlemail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Nov 15 11:00:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PHvrf-0005s0-JF
	for gcvg-git-2@lo.gmane.org; Mon, 15 Nov 2010 11:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755012Ab0KOKAi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Nov 2010 05:00:38 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61374 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754145Ab0KOKAh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Nov 2010 05:00:37 -0500
Received: by bwz15 with SMTP id 15so5016910bwz.19
        for <git@vger.kernel.org>; Mon, 15 Nov 2010 02:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=sumzYtZH6Q+egEMlTbmEI0hO63S0M9o9q/rzQuaqwd8=;
        b=Lj7mQsqxiS5nDMRdDMFzG70u/V5TrGbjSBR8i1xaABBBZZnrPkRufWXeB6k6yLeG5y
         9p+tebXbF+4vGZO8sRdl7gjF0g2ScCDsKthRTFTKzvzi8MmpE6AlA3XjLOviqoH/4wzj
         PeoI28MT/4PnRBz8dEjDB58ZUp3Wal7Ffivu8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=euIoSW5U8E5Tpk/loJv1qT/CvOTO4vT4CiboLTvKucvGOcHI0bZ1OZvSKDQ+9y+Z2C
         /H+kPouI31IVsC7AvspNiUKmYsUQNfk2jGPx8x3djR6sHStxVJOcbJQgLXPyht/93LU9
         /S/lqoJxKcjfv0GNwXx5ivPwmvNFzqBLin4Kg=
Received: by 10.204.62.17 with SMTP id v17mr5869313bkh.67.1289815236543;
        Mon, 15 Nov 2010 02:00:36 -0800 (PST)
Received: from localhost (p3E99037B.dip.t-dialin.net [62.153.3.123])
        by mx.google.com with ESMTPS id v25sm2923442bkt.18.2010.11.15.02.00.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 15 Nov 2010 02:00:35 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1149.g1f51c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161473>

git diff always outputs color reset commands, even when the color for the
current part is disabled (ie. normal). But the current ANSI-color parsing code
assumes that color start and reset commands appear in matching pairs.

Relax this assumption.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>

---
 git-gui/lib/diff.tcl |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
index dcf0711..0579fa6 100644
--- a/git-gui/lib/diff.tcl
+++ b/git-gui/lib/diff.tcl
@@ -337,12 +337,20 @@ proc parse_color_line {line} {
 	set result ""
 	set markup [list]
 	set regexp {\033\[((?:\d+;)*\d+)?m}
+	set need_reset 0
 	while {[regexp -indices -start $start $regexp $line match code]} {
 		foreach {begin end} $match break
 		append result [string range $line $start [expr {$begin - 1}]]
-		lappend markup [string length $result] \
-			[eval [linsert $code 0 string range $line]]
+		set pos [string length $result]
+		set col [eval [linsert $code 0 string range $line]]
 		set start [incr end]
+		if {$col eq "0" || $col eq ""} {
+			if {!$need_reset} continue
+			set need_reset 0
+		} else {
+			set need_reset 1
+		}
+		lappend markup $pos $col
 	}
 	append result [string range $line $start end]
 	if {[llength $markup] < 4} {set markup {}}
-- 
tg: (6f10c41..) bw/git-gui/fix-ansi-color-parsing (depends on: master)
