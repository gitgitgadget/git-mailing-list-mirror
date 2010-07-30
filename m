From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] git-gui: use textconv filter for diff and blame
Date: Fri, 30 Jul 2010 01:22:05 +0100
Message-ID: <871valstsi.fsf@fox.patthoyts.tk>
References: <1280319830-20483-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Clemens Buchacher <drizzd@aon.at>,
	=?iso-8859-1?Q?Cl=E9ment?= Poulain 
	<clement.poulain@ensimag.imag.fr>,
	Diane Gasselin <diane.gasselin@ensimag.imag.fr>,
	Axel Bonnet <axel.bonnet@ensimag.imag.fr>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jul 30 02:22:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OedND-00009L-5u
	for gcvg-git-2@lo.gmane.org; Fri, 30 Jul 2010 02:22:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758246Ab0G3AWZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 29 Jul 2010 20:22:25 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:48766 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758192Ab0G3AWO convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jul 2010 20:22:14 -0400
Received: from [172.23.170.146] (helo=anti-virus03-09)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1OedMY-0006C3-9h; Fri, 30 Jul 2010 01:22:10 +0100
Received: from [77.99.239.132] (helo=fox.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1OedMU-0004G9-Co; Fri, 30 Jul 2010 01:22:06 +0100
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id C9336208E4; Fri, 30 Jul 2010 01:22:05 +0100 (BST)
X-Url: http://www.patthoyts.tk/
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
In-Reply-To: <1280319830-20483-1-git-send-email-Matthieu.Moy@imag.fr> (Matthieu Moy's message of "Wed\, 28 Jul 2010 14\:23\:50 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152213>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

>From: Cl=E9ment Poulain <clement.poulain@ensimag.imag.fr>
>
>Create a checkbox "Use Textconv For Diffs and Blame" in git-gui option=
s.
>If checked and if the driver for the concerned file exists, git-gui ca=
lls diff
>and blame with --textconv option
>
>Signed-off-by: Cl=E9ment Poulain <clement.poulain@ensimag.imag.fr>
>Signed-off-by: Diane Gasselin <diane.gasselin@ensimag.imag.fr>
>Signed-off-by: Axel Bonnet <axel.bonnet@ensimag.imag.fr>
>Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
>---
>
>This patch was originally written by Cl=E9ment Poulain (a student of
>mine), it was not mergeable at the time it was sent, since it relied
>on a patch serie introducing "git cat-file --textconv". Now that this
>cat-file --textconv is in a git release (1.7.2), I guess it's time to
>get this merged into git-gui.
>
>I did review and test the patch, but I'm mostly useless in TCL, so I
>may have missed the obvious. That said, the patch is relatively simple
>and looks OK.

This looks generally fine but can you suggest some test that I can use
to ensure it is actually doing something. I tried committing some test
files containing cyrillic characters but I see no difference between
using an unpatched git-gui and your patched version with git 1.7.2

>diff --git a/git-gui/lib/blame.tcl b/git-gui/lib/blame.tcl
>index 786b50b..ead68fd 100644
>--- a/git-gui/lib/blame.tcl
>+++ b/git-gui/lib/blame.tcl
>@@ -449,11 +449,28 @@ method _load {jump} {
>=20
> 	$status show [mc "Reading %s..." "$commit:[escape_path $path]"]
> 	$w_path conf -text [escape_path $path]
>+
>+	set do_textconv 0
>+	if {![is_config_false gui.textconv] && [git-version >=3D 1.7.2]} {
>+		set filter [gitattr $path diff set]
>+		set textconv [get_config [join [list diff $filter textconv] .]]
>+		if {$filter ne {set} && $textconv ne {}} {
>+			set do_textconv 1
>+		}
>+	}
> 	if {$commit eq {}} {
>-		set fd [open $path r]
>+		if {$do_textconv ne 0} {
>+			set fd [open "|$textconv $path" r]

This is better written as
  set fd [open |[list $textconv $path] r]
in case there are spaces in either of the two components.

>+		} else {
>+			set fd [open $path r]
>+		}
> 		fconfigure $fd -eofchar {}
> 	} else {
>-		set fd [git_read cat-file blob "$commit:$path"]
>+		if {$do_textconv ne 0} {
>+			set fd [git_read cat-file --textconv "$commit:$path"]
>+		} else {
>+			set fd [git_read cat-file blob "$commit:$path"]
>+		}
> 	}
> 	fconfigure $fd \
> 		-blocking 0 \
