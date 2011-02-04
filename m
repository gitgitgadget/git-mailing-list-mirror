From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH maint] start_command: flush buffers in the WIN32 code path as well
Date: Fri, 04 Feb 2011 11:23:45 +0000
Message-ID: <87sjw4jb5q.fsf@fox.patthoyts.tk>
References: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net>
	<1296747105-1663-5-git-send-email-patthoyts@users.sourceforge.net>
	<201102032108.54811.j6t@kdbg.org>
	<alpine.DEB.1.00.1102031426110.1541@bonsai2>
	<4D4BBBD6.7010100@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Feb 04 12:24:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlJlx-0001Wz-V6
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 12:24:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751385Ab1BDLYM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 06:24:12 -0500
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:53292 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751202Ab1BDLYL (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Feb 2011 06:24:11 -0500
Received: from [172.23.170.146] (helo=anti-virus03-09)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1PlJll-0005X3-0v; Fri, 04 Feb 2011 11:24:05 +0000
Received: from [77.100.97.230] (helo=fox.patthoyts.tk)
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.72)
	(envelope-from <patthoyts@users.sourceforge.net>)
	id 1PlJlS-0007US-Jw; Fri, 04 Feb 2011 11:23:46 +0000
Received: by fox.patthoyts.tk (Postfix, from userid 1000)
	id E11DC20265; Fri,  4 Feb 2011 11:23:45 +0000 (GMT)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
X-Home-Page: http://www.patthoyts.tk/
X-Web: http://www.patthoyts.tk/
In-Reply-To: <4D4BBBD6.7010100@viscovery.net> (Johannes Sixt's message of
	"Fri, 04 Feb 2011 09:41:58 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166037>

Johannes Sixt <j.sixt@viscovery.net> writes:

>From: Johannes Sixt <j6t@kdbg.org>
>
>The POSIX code path did The Right Thing already, but we have to do the same
>on Windows.
>
>This bug caused failures in t5526-fetch-submodules, where the output of
>'git fetch --recurse-submodules' was in the wrong order.
>
>Debugged-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
>Signed-off-by: Johannes Sixt <j6t@kdbg.org>
>---
>Am 2/3/2011 21:26, schrieb Johannes Schindelin:
>> Have you seen my response where I proved that it is a fflush() issue, most 
>> likely with mingw_spawn()?
>
>I think this is the correct fix.
>
> run-command.c |    2 +-
> 1 files changed, 1 insertions(+), 1 deletions(-)
>
>diff --git a/run-command.c b/run-command.c
>index 2a1041e..f91e446 100644
>--- a/run-command.c
>+++ b/run-command.c
>@@ -194,6 +194,7 @@ fail_pipe:
> 	}
> 
> 	trace_argv_printf(cmd->argv, "trace: run_command:");
>+	fflush(NULL);
> 
> #ifndef WIN32
> {
>@@ -201,7 +202,6 @@ fail_pipe:
> 	if (pipe(notify_pipe))
> 		notify_pipe[0] = notify_pipe[1] = -1;
> 
>-	fflush(NULL);
> 	cmd->pid = fork();
> 	if (!cmd->pid) {
> 		/*

This fixes the issue for me on msysGit. Thanks.

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
