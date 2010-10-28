From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: [PATCH] git-gui: handle symlink replaced by file
Date: Thu, 28 Oct 2010 13:27:09 +0100
Message-ID: <8739rqqb4m.fsf@fox.patthoyts.tk>
References: <AANLkTi=dA+mj1KDpAgGAtg1S5Gt5wXAJ4zLd-tLob=DH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Thu Oct 28 23:08:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PBZhp-00081E-KN
	for gcvg-git-2@lo.gmane.org; Thu, 28 Oct 2010 23:08:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760119Ab0J1VIJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Oct 2010 17:08:09 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:32935 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758684Ab0J1VIH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Oct 2010 17:08:07 -0400
Received: from [172.23.144.248] (helo=asmtp-out4.blueyonder.co.uk)
	by smtp-out3.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1PBZhT-0005FA-4H; Thu, 28 Oct 2010 22:07:55 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1PBZhS-0002m4-OS; Thu, 28 Oct 2010 22:07:54 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 10840250F2; Thu, 28 Oct 2010 22:07:54 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <AANLkTi=dA+mj1KDpAgGAtg1S5Gt5wXAJ4zLd-tLob=DH@mail.gmail.com>
	(Bert Wesarg's message of "Mon, 25 Oct 2010 14:59:00 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/160227>

If a symlink is replaced by a regular file an error message was emitted
on stdout. This patch adds recognition of this case.

Reported-by: Bert Wesarg <bert.wesarg@googlemail.com>
Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>
---

Bert Wesarg <bert.wesarg@googlemail.com> writes:
>Hi,
>
>I get this error from git gui after I changed a symlink to a file:
>
>error: Unhandled 2 way diff marker: {d}
>
>To reproduce:
>
>$ git init
>$ ln -s bar foo
>$ git add foo
>$ git commit -m "add foo link"
>$ rm foo
>$ echo bar >foo
>$ git gui
>error: Unhandled 2 way diff marker: {d}
>
>I may have a look into this by my self in the long term, but maybe
>someone is faster than me.

This patch just handles the second segment without generating the error
really. It doesn't attempt to do any pretty output.

 lib/diff.tcl |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/lib/diff.tcl b/lib/diff.tcl
index c628750..4d041fa 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -428,6 +428,14 @@ proc read_diff {fd cont_info} {
 					set tags d_+
 				}
 			}
+			{d} {
+				if {[string match {diff --git *} $line]} {
+					set ::current_diff_inheader 1
+					continue
+				} else {
+					puts "error: unrecognized operation: '$line'"
+				}
+			}
 			default {
 				puts "error: Unhandled 2 way diff marker: {$op}"
 				set tags {}
-- 
1.7.3.1.msysgit.0
