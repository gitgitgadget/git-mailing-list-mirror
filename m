From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] transport.c: call dash-less form of receive-pack and upload-pack on remote
Date: Sat, 01 Dec 2007 11:30:11 -0800
Message-ID: <7vzlwu43i4.fsf@gitster.siamese.dyndns.org>
References: <20071127150229.GA14859@laptop> <20071127160423.GA22807@laptop>
	<Pine.LNX.4.64.0711271617350.27959@racer.site>
	<20071128000731.GD9174@efreet.light.src>
	<7v8x4jb295.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711280036p33583824ge59af93bbe3f0a78@mail.gmail.com>
	<7vfxyq2c9b.fsf@gitster.siamese.dyndns.org>
	<fcaeb9bf0711281917p56cc4228m6c401286439e2a34@mail.gmail.com>
	<alpine.LFD.0.99999.0711290905510.9605@xanadu.home>
	<7vd4tsvfvk.fsf@gitster.siamese.dyndns.org>
	<DB613F3E-85CC-4AF0-928C-4F4E4C8E9FB8@orakel.ntnu.no>
	<Pine.LNX.4.64.0711301207020.27959@racer.site>
	<7vlk8f9m52.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712010959180.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eyvind Bernhardsen <eyvind-git-list@orakel.ntnu.no>,
	Nicolas Pitre <nico@cam.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Jan Hudec <bulb@ucw.cz>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Dec 01 20:30:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IyY33-0002Gc-LL
	for gcvg-git-2@gmane.org; Sat, 01 Dec 2007 20:30:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbXLATaY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2007 14:30:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753034AbXLATaY
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Dec 2007 14:30:24 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:50550 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752603AbXLATaW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2007 14:30:22 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id D49F92EF;
	Sat,  1 Dec 2007 14:30:43 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 0B9CC9BCCD;
	Sat,  1 Dec 2007 14:30:36 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712010959180.27959@racer.site> (Johannes
	Schindelin's message of "Sat, 1 Dec 2007 10:17:03 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66732>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I only eyeball-tested it and looks Okay, but that does not assure us
>> much ;-).  Is this change easy to test using local transport?
>
> Seems like it breaks down with git-shell.  But then, I think that we just 
> have to fix execv_git_cmd() to call builtins via "git" instead.

So in execv_git_cmd(), instead of doing the strbuf_addf(), we do
something like this (and drop your patch)?

---
 exec_cmd.c |   34 +++++++++++++---------------------
 1 files changed, 13 insertions(+), 21 deletions(-)

diff --git a/exec_cmd.c b/exec_cmd.c
index 2d0a758..2920335 100644
--- a/exec_cmd.c
+++ b/exec_cmd.c
@@ -65,32 +65,24 @@ void setup_path(const char *cmd_path)
 
 int execv_git_cmd(const char **argv)
 {
-	struct strbuf cmd;
-	const char *tmp;
-
-	strbuf_init(&cmd, 0);
-	strbuf_addf(&cmd, "git-%s", argv[0]);
-
-	/*
-	 * argv[0] must be the git command, but the argv array
-	 * belongs to the caller, and may be reused in
-	 * subsequent loop iterations. Save argv[0] and
-	 * restore it on error.
-	 */
-	tmp = argv[0];
-	argv[0] = cmd.buf;
-
-	trace_argv_printf(argv, -1, "trace: exec:");
+	int i;
+	const char **args;
+
+	for (i = 0; argv[i]; i++)
+		;
+	args = xcalloc(i + 1, sizeof(*args));
+	for (i = 0; argv[i]; i++)
+		args[i+1] = argv[i];
+	args[0] = "git";
+	args[i+1] = NULL;
+	trace_argv_printf(args, -1, "trace: exec:");
 
 	/* execvp() can only ever return if it fails */
-	execvp(cmd.buf, (char **)argv);
+	execvp(args[0], (char **)args);
 
 	trace_printf("trace: exec failed: %s\n", strerror(errno));
 
-	argv[0] = tmp;
-
-	strbuf_release(&cmd);
-
+	free(args);
 	return -1;
 }
 
