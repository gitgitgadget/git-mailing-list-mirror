From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: [PATCH] Fix use of hunk tag for non-hunk content.
Date: Mon, 29 Nov 2010 12:41:52 +0100
Message-ID: <02730a5b5e904409da58c7f5ebe40e16e7adc1f1.1291019649.git.bert.wesarg@googlemail.com>
Cc: git@vger.kernel.org, Bert Wesarg <bert.wesarg@googlemail.com>
To: Pat Thoyts <patthoyts@users.sourceforge.net>
X-From: git-owner@vger.kernel.org Mon Nov 29 12:42:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PN27X-0005yD-ER
	for gcvg-git-2@lo.gmane.org; Mon, 29 Nov 2010 12:42:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753070Ab0K2LmA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Nov 2010 06:42:00 -0500
Received: from mail-ew0-f46.google.com ([209.85.215.46]:42737 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752935Ab0K2Ll7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Nov 2010 06:41:59 -0500
Received: by ewy5 with SMTP id 5so1835291ewy.19
        for <git@vger.kernel.org>; Mon, 29 Nov 2010 03:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=kWAek7BVZUV2bFFS9dk+yV7GT0H+zr4UKqNwYW5sahA=;
        b=Oxn9gGMPcU7Xugsu26g5b+YF+FzPPcoA9mv+aAoInT/JDNgmQG1T+6vwBLBaA6H/he
         k/gLmIAX9fOTU7X47CRSYCUmFgGXj0ZdJLrSWzu7fZl/kXNQLgiX7AElCGzZeWxki9Fr
         EEzhfr5i6V4GHlM2vsra/wj/vcYwB2h/56MLE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ViGCWHpYYYT9W/3d3OEUwlIz1UK1+a3unpsr46aAOr27YTaxczKoxhWEMXI0WpJj37
         Mk9STXZlBdoXh4786iQ1iPe/Uj0l27r18jtAwYrQkr8iZMXfHLnswYLA7NENTtnV/2Le
         8f8xfeb2pyxOaadb77rYJsfS3YH8Lq6rnGvK0=
Received: by 10.213.16.72 with SMTP id n8mr269318eba.38.1291030918089;
        Mon, 29 Nov 2010 03:41:58 -0800 (PST)
Received: from localhost ([92.116.141.185])
        by mx.google.com with ESMTPS id q58sm5046911eeh.21.2010.11.29.03.41.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 29 Nov 2010 03:41:57 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.1200.ge4bf6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162384>

The hunk tag d_@ lost its blue forground color in "apply color information
from git diff output" (2010-10-22, 8f85599). But this tag was also used
for non-hunk content like untracked file mime types or git submodules.

Introduce a new tag for this type of content which has the blue forground
again.

Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
---
 git-gui.sh   |    2 ++
 lib/diff.tcl |   14 +++++++-------
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 38362fa..c85a53c 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3331,6 +3331,8 @@ foreach {n c} {0 black 1 red4 2 green4 3 yellow4 4 blue4 5 magenta4 6 cyan4 7 gr
 }
 $ui_diff tag configure clr1 -font font_diffbold
 
+$ui_diff tag conf d_info -foreground blue -font font_diffbold
+
 $ui_diff tag conf d_cr -elide true
 $ui_diff tag conf d_@ -font font_diffbold
 $ui_diff tag conf d_+ -foreground {#00a000}
diff --git a/lib/diff.tcl b/lib/diff.tcl
index 8fea947..8435635 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -208,32 +208,32 @@ proc show_other_diff {path w m cont_info} {
 			$ui_diff insert end [append \
 				"* " \
 				[mc "Git Repository (subproject)"] \
-				"\n"] d_@
+				"\n"] d_info
 		} elseif {![catch {set type [exec file $path]}]} {
 			set n [string length $path]
 			if {[string equal -length $n $path $type]} {
 				set type [string range $type $n end]
 				regsub {^:?\s*} $type {} type
 			}
-			$ui_diff insert end "* $type\n" d_@
+			$ui_diff insert end "* $type\n" d_info
 		}
 		if {[string first "\0" $content] != -1} {
 			$ui_diff insert end \
 				[mc "* Binary file (not showing content)."] \
-				d_@
+				d_info
 		} else {
 			if {$sz > $max_sz} {
 				$ui_diff insert end [mc \
 "* Untracked file is %d bytes.
 * Showing only first %d bytes.
-" $sz $max_sz] d_@
+" $sz $max_sz] d_info
 			}
 			$ui_diff insert end $content
 			if {$sz > $max_sz} {
 				$ui_diff insert end [mc "
 * Untracked file clipped here by %s.
 * To see the entire file, use an external editor.
-" [appname]] d_@
+" [appname]] d_info
 			}
 		}
 		$ui_diff conf -state disabled
@@ -442,10 +442,10 @@ proc read_diff {fd conflict_size cont_info} {
 		} elseif {$is_submodule_diff} {
 			if {$line == ""} continue
 			if {[regexp {^Submodule } $line]} {
-				set tags d_@
+				set tags d_info
 			} elseif {[regexp {^\* } $line]} {
 				set line [string replace $line 0 1 {Submodule }]
-				set tags d_@
+				set tags d_info
 			} else {
 				set op [string range $line 0 2]
 				switch -- $op {
-- 
1.7.3.2.1200.ge4bf6
