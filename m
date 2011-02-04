From: Johannes Sixt <j.sixt@viscovery.net>
Subject: [PATCH maint] start_command: flush buffers in the WIN32 code path
 as well
Date: Fri, 04 Feb 2011 09:41:58 +0100
Message-ID: <4D4BBBD6.7010100@viscovery.net>
References: <1296747105-1663-1-git-send-email-patthoyts@users.sourceforge.net> <1296747105-1663-5-git-send-email-patthoyts@users.sourceforge.net> <201102032108.54811.j6t@kdbg.org> <alpine.DEB.1.00.1102031426110.1541@bonsai2>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Feb 04 09:42:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlHF6-00072L-GW
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 09:42:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753012Ab1BDImI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 4 Feb 2011 03:42:08 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:34243 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752777Ab1BDImF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Feb 2011 03:42:05 -0500
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1PlHEt-0002yT-7z; Fri, 04 Feb 2011 09:41:59 +0100
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 0222F1660F;
	Fri,  4 Feb 2011 09:41:58 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <alpine.DEB.1.00.1102031426110.1541@bonsai2>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166026>

From: Johannes Sixt <j6t@kdbg.org>

The POSIX code path did The Right Thing already, but we have to do the same
on Windows.

This bug caused failures in t5526-fetch-submodules, where the output of
'git fetch --recurse-submodules' was in the wrong order.

Debugged-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Johannes Sixt <j6t@kdbg.org>
---
Am 2/3/2011 21:26, schrieb Johannes Schindelin:
> Have you seen my response where I proved that it is a fflush() issue, most 
> likely with mingw_spawn()?

I think this is the correct fix.

 run-command.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/run-command.c b/run-command.c
index 2a1041e..f91e446 100644
--- a/run-command.c
+++ b/run-command.c
@@ -194,6 +194,7 @@ fail_pipe:
 	}
 
 	trace_argv_printf(cmd->argv, "trace: run_command:");
+	fflush(NULL);
 
 #ifndef WIN32
 {
@@ -201,7 +202,6 @@ fail_pipe:
 	if (pipe(notify_pipe))
 		notify_pipe[0] = notify_pipe[1] = -1;
 
-	fflush(NULL);
 	cmd->pid = fork();
 	if (!cmd->pid) {
 		/*
-- 
1.7.4.1253.g00c7
