From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-gui: highlight trailing whitespace in diff view
Date: Tue, 19 Oct 2010 23:59:23 +0100
Message-ID: <87hbgh7paf.fsf@fox.patthoyts.tk>
References: <AANLkTikttRVeE+PVUJGiLERC=qdoxSH1oyXa5HLXoW0N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git mailing list <git@vger.kernel.org>
To: Tor Arvid Lund <torarvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 20 01:09:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8LJe-0002Uu-Fw
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 01:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756390Ab0JSXJx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Oct 2010 19:09:53 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:40720 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755559Ab0JSXJw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Oct 2010 19:09:52 -0400
Received: from [172.23.170.143] (helo=anti-virus02-10)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1P8LJW-0004bd-NJ; Wed, 20 Oct 2010 00:09:50 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1P8LJR-0001Nv-4u; Wed, 20 Oct 2010 00:09:45 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 876A626E7D; Wed, 20 Oct 2010 00:09:44 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <AANLkTikttRVeE+PVUJGiLERC=qdoxSH1oyXa5HLXoW0N@mail.gmail.com>
	(Tor Arvid Lund's message of "Tue, 19 Oct 2010 01:00:34 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159378>

Highlight any trailing whitespace in the diff view using a red background
as is done in the terminal when color is enabled.

Suggested-by: Tor Arvid Lund <torarvid@gmail.com>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---

Tor Arvid Lund <torarvid@gmail.com> writes:
>Hi, all! When doing "git diff", whitespaces before EOL, for instance,
>are marked with red background in my terminal.
>
>Is it possible to see this coloring in git gui too?
>
>-Tor Arvid-

This patch should do the job. It probably should get some configuration
item to control this though.

 git-gui.sh   |    1 +
 lib/diff.tcl |    9 ++++++++-
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/git-gui.sh b/git-gui.sh
index 25229a4..8d652f0 100755
--- a/git-gui.sh
+++ b/git-gui.sh
@@ -3314,6 +3314,7 @@ pack .vpane.lower.diff.header -side top -fill x
 pack .vpane.lower.diff.body -side bottom -fill both -expand 1
 
 $ui_diff tag conf d_cr -elide true
+$ui_diff tag conf ws -background red
 $ui_diff tag conf d_@ -foreground blue -font font_diffbold
 $ui_diff tag conf d_+ -foreground {#00a000}
 $ui_diff tag conf d_- -foreground red
diff --git a/lib/diff.tcl b/lib/diff.tcl
index c628750..83e3f6d 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -434,7 +434,14 @@ proc read_diff {fd cont_info} {
 			}
 			}
 		}
-		$ui_diff insert end $line $tags
+		if {[regexp -indices {^.*\S(\s+)$} $line -> ndx]} {
+		    set ndx [expr {[lindex $ndx 0] - 1}]
+			set nonws [string range $line 0 $ndx]
+			$ui_diff insert end $nonws $tags \
+				[string range $line [incr ndx] end] [concat $tags ws]
+		} else {
+			$ui_diff insert end $line $tags
+		}
 		if {[string index $line end] eq "\r"} {
 			$ui_diff tag add d_cr {end - 2c}
 		}
-- 
1.7.3.1.msysgit.0
