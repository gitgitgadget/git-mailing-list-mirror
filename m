From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: Use shell to launch textconv filter in "blame"
Date: Fri, 06 Aug 2010 00:10:31 +0100
Message-ID: <87aap0sljs.fsf@fox.patthoyts.tk>
References: <vpqlj8l2xd5.fsf@bauges.imag.fr>
	<1281002722-3042-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Kirill Smelkov <kirr@landau.phys.spbu.ru>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Aug 06 01:17:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh9gQ-0002oX-3B
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 01:17:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933152Ab0HEXQ6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 19:16:58 -0400
Received: from smtp-out5.blueyonder.co.uk ([195.188.213.8]:36588 "EHLO
	smtp-out5.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756769Ab0HEXQ4 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Aug 2010 19:16:56 -0400
Received: from [172.23.170.139] (helo=anti-virus01-10)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Oh9g9-0007Zk-V7; Fri, 06 Aug 2010 00:16:50 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1Oh9a4-0001Qr-QJ; Fri, 06 Aug 2010 00:10:32 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id 2030021EC3; Fri,  6 Aug 2010 00:10:32 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <1281002722-3042-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu
	Moy's message of "Thu, 5 Aug 2010 12:05:22 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152738>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

>This allows one to use textconv commands with arguments.
>
>Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>

>diff --git a/git-gui/lib/blame.tcl b/git-gui/lib/blame.tcl
>index 2137ec9..77656d3 100644
>--- a/git-gui/lib/blame.tcl
>+++ b/git-gui/lib/blame.tcl
>@@ -460,7 +460,9 @@ method _load {jump} {
> 	}
> 	if {$commit eq {}} {
> 		if {$do_textconv ne 0} {
>-			set fd [open |[list $textconv $path] r]
>+			# Run textconv with sh -c "..." to allow it to
>+			# contain command + arguments.
>+			set fd [open |[list [shellpath] -c "$textconv \"\$0\"" $path] r]
> 		} else {
> 			set fd [open $path r]
> 		}

I don't believe we need to put all this in to launch this via the
shell. We just have to pass a list where the first element is the
command-name.

The following works for me using your 'textconv = odf2txt --width=40'
test and also a 'textconv = od -t x1' that I tried for a hex dump
output. I couldn't make run-mailcap do anything useful for me.

diff --git a/lib/blame.tcl b/lib/blame.tcl
index 2137ec9..c06ef04 100644
--- a/lib/blame.tcl
+++ b/lib/blame.tcl
@@ -460,7 +460,7 @@ method _load {jump} {
        }
        if {$commit eq {}} {
                if {$do_textconv ne 0} {
-                       set fd [open |[list $textconv $path] r]
+                       set fd [open |[linsert $textconv end $path] r]
                } else {
                        set fd [open $path r]
                }

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
