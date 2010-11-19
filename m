From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH 2/2] git-gui: support for diff3 conflict style
Date: Fri, 19 Nov 2010 11:41:57 +0000
Message-ID: <87fwuxh75m.fsf@fox.patthoyts.tk>
References: <1289899312-2732-1-git-send-email-bert.wesarg@googlemail.com>
	<1289899618-2845-1-git-send-email-bert.wesarg@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O . Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Nov 19 12:53:47 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PJPXF-00083k-9c
	for gcvg-git-2@lo.gmane.org; Fri, 19 Nov 2010 12:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484Ab0KSLxk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Nov 2010 06:53:40 -0500
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:58698 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751846Ab0KSLxk (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Nov 2010 06:53:40 -0500
Received: from [172.23.144.246] (helo=asmtp-out2.blueyonder.co.uk)
	by smtp-out5.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1PJPWy-0001aJ-DB; Fri, 19 Nov 2010 11:53:29 +0000
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1PJPLp-00046r-Rh; Fri, 19 Nov 2010 11:41:57 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 72B5D200C5; Fri, 19 Nov 2010 11:41:57 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <1289899618-2845-1-git-send-email-bert.wesarg@googlemail.com>
	(Bert Wesarg's message of "Tue, 16 Nov 2010 10:26:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161739>

Bert Wesarg <bert.wesarg@googlemail.com> writes:

>This adds highlight support for the diff3 conflict style.
>
>The common pre-image will be reversed to --, because it has been removed
>and either replaced with our or their side.
>
>Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>
>---
> git-gui/git-gui.sh   |    3 +++
> git-gui/lib/diff.tcl |   10 ++++++++++
> 2 files changed, 13 insertions(+), 0 deletions(-)
>
>diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
>index 38362fa..0134438 100755
>--- a/git-gui/git-gui.sh
>+++ b/git-gui/git-gui.sh
>@@ -3354,6 +3354,9 @@ $ui_diff tag conf d_s- \
> $ui_diff tag conf d< \
> 	-foreground orange \
> 	-font font_diffbold
>+$ui_diff tag conf d| \
>+	-foreground orange \
>+	-font font_diffbold
> $ui_diff tag conf d= \
> 	-foreground orange \
> 	-font font_diffbold
>diff --git a/git-gui/lib/diff.tcl b/git-gui/lib/diff.tcl
>index d4e2ce3..ccd4c70 100644
>--- a/git-gui/lib/diff.tcl
>+++ b/git-gui/lib/diff.tcl
>@@ -339,6 +339,7 @@ proc start_show_diff {cont_info {add_opts {}}} {
> 	}
> 
> 	set ::current_diff_inheader 1
>+	set ::in_conflict_pre_image 0
> 	fconfigure $fd \
> 		-blocking 0 \
> 		-encoding [get_path_encoding $path] \
>@@ -420,6 +421,15 @@ proc read_diff {fd conflict_size cont_info} {
> 					set is_conflict_diff 1
> 					set line [string replace $line 0 1 {  }]
> 					set tags d$op
>+					set ::in_conflict_pre_image 0
>+				} elseif {[regexp {^\+\+\|{$conflict_size}(?: |$)} $line]} {
>+					set is_conflict_diff 1
>+					set line [string replace $line 0 1 {  }]
>+					set tags d|
>+					set ::in_conflict_pre_image 1
>+				} elseif ($::in_conflict_pre_image) {
>+					set line [string replace $line 0 1 {--}]
>+					set tags d_--
> 				} else {
> 					set tags d_++
> 				}

This has the same issue as the last patch with variable substitution
into the regexp. Replaced the regexp expression with
   [regexp "^\\+\\+\\|{$conflict_size}(?: |\$)" $line]

I configured a test repository with
'merge.conflictstyle diff3' and could test this. Looks fine.
-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
