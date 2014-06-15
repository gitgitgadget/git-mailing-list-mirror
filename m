From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] gitk: use mktemp -d to avoid predictable temporary directories
Date: Sun, 15 Jun 2014 08:51:23 +0100
Message-ID: <87k38ir4p0.fsf@red.patthoyts.tk>
References: <1402695828-91537-1-git-send-email-davvid@gmail.com>
Reply-To: patthoyts@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 15 09:52:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ww5F2-0005T9-Hd
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jun 2014 09:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751188AbaFOHwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2014 03:52:36 -0400
Received: from know-smtprelay-omc-9.server.virginmedia.net ([80.0.253.73]:45329
	"EHLO know-smtprelay-omc-9.server.virginmedia.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750707AbaFOHwf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2014 03:52:35 -0400
Received: from red.patthoyts.tk ([82.34.175.55])
	by know-smtprelay-9-imp with bizsmtp
	id EXsY1o03p1C56nm01XsZPK; Sun, 15 Jun 2014 08:52:33 +0100
X-Originating-IP: [82.34.175.55]
X-Spam: 0
X-Authority: v=2.1 cv=bdnlUY/B c=1 sm=1 tr=0 a=g1XlTrwDEGH9N8TSFs8Bjw==:117
 a=g1XlTrwDEGH9N8TSFs8Bjw==:17 a=6gpmbu8EOFEA:10 a=kTgFOqoTG8MA:10
 a=CtgcEeagiGAA:10 a=FP58Ms26AAAA:8 a=pGLkceISAAAA:8 a=TSbVqHtbAAAA:8
 a=7vUEEOO_AAAA:8 a=Rf460ibiAAAA:8 a=GL7PwzvV1XTUWR1-7wsA:9 a=vzeyefi7p7kA:10
 a=MSl-tDqOz04A:10 a=FIYWbwknd9UA:10 a=NWVoK91CQyQA:10
Received: from red.patthoyts.tk (localhost [127.0.0.1])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by red.patthoyts.tk (Postfix) with ESMTPS id 106FC1960FC2;
	Sun, 15 Jun 2014 08:52:33 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <1402695828-91537-1-git-send-email-davvid@gmail.com> (David
	Aguilar's message of "Fri, 13 Jun 2014 14:43:48 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251671>

David Aguilar <davvid@gmail.com> writes:

>gitk uses a predictable ".gitk-tmp.$PID" pattern when generating
>a temporary directory.
>
>Use "mktemp -d .gitk-tmp.XXXXXX" to harden gitk against someone
>seeding /tmp with files matching the pid pattern.
>
>Signed-off-by: David Aguilar <davvid@gmail.com>
>---
>This issue was brought up during the first review of the previous patch
>back in 2009.
>
>http://thread.gmane.org/gmane.comp.version-control.git/132609/focus=132748
>
>This is really [PATCH 2/2] and should be applied on top of my previous
>gitk patch.
>
> gitk | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/gitk b/gitk
>index 82293dd..dd2ff63 100755
>--- a/gitk
>+++ b/gitk
>@@ -3502,7 +3502,8 @@ proc gitknewtmpdir {} {
> 	} else {
> 	    set tmpdir $gitdir
> 	}
>-	set gitktmpdir [file join $tmpdir [format ".gitk-tmp.%s" [pid]]]
>+	set gitktmpformat [file join $tmpdir ".gitk-tmp.XXXXXX"]
>+	set gitktmpdir [exec mktemp -d $gitktmpformat]
> 	if {[catch {file mkdir $gitktmpdir} err]} {
> 	    error_popup "[mc "Error creating temporary directory %s:" $gitktmpdir] $err"
> 	    unset gitktmpdir

This is a problem on Windows where we will not have mktemp. In Tcl 8.6
the file command acquired a "file tempfile" command to help with this
kind of issue (https://www.tcl.tk/man/tcl8.6/TclCmd/file.htm#M39) but
for older versions we should probably stick with the existing pattern at
least on Windows.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
