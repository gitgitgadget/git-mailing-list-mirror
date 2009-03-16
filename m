From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] gitk: Handle blobs containing a DOS end-of-file marker.
Date: 16 Mar 2009 10:24:40 +0000
Message-ID: <87y6v5ojdj.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Mackerras <paulus@samba.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 16 11:26:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjA1v-0005N2-N8
	for gcvg-git-2@gmane.org; Mon, 16 Mar 2009 11:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753759AbZCPKYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2009 06:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759073AbZCPKYq
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Mar 2009 06:24:46 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:46737 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754964AbZCPKYp (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Mar 2009 06:24:45 -0400
Received: from [172.23.170.143] (helo=anti-virus02-10)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Lj9zu-0002uv-Io; Mon, 16 Mar 2009 10:24:42 +0000
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out3.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1Lj9zu-0004xh-0c; Mon, 16 Mar 2009 10:24:42 +0000
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id 6FD3A51836; Mon, 16 Mar 2009 10:24:41 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113315>


  If a patchset contains an EOF marker (Ctrl-Z) the blob diff terminates
  at that point. This patch permits gitk to ignore the eof and continue to
  display any subsequent blobs and also displays a sensible representation
  of the eof char.

Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---
 gitk |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/gitk b/gitk
index 1773ae6..d7de27e 100755
--- a/gitk
+++ b/gitk
@@ -7216,7 +7216,7 @@ proc getblobdiffs {ids} {
     set diffnparents 0
     set diffinhdr 0
     set diffencoding [get_path_encoding {}]
-    fconfigure $bdf -blocking 0 -encoding binary
+    fconfigure $bdf -blocking 0 -encoding binary -eofchar {}
     set blobdifffd($ids) $bdf
     filerun $bdf [list getblobdiffline $bdf $diffids]
 }
@@ -7367,7 +7367,8 @@ proc getblobdiffline {bdf ids} {
 	    $ctext insert end "$line\n" filesep
 
 	} else {
-	    set line [encoding convertfrom $diffencoding $line]
+	    set line [string map {\x1A ^Z} \
+                          [encoding convertfrom $diffencoding $line]]
 	    # parse the prefix - one ' ', '-' or '+' for each parent
 	    set prefix [string range $line 0 [expr {$diffnparents - 1}]]
 	    set tag [expr {$diffnparents > 1? "m": "d"}]
-- 
1.6.2.1217.gd7bc3
