From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 1/4] run-command: add new check_command helper
Date: Tue, 02 Apr 2013 21:16:59 +0200
Message-ID: <515B2EAB.10402@kdbg.org>
References: <1364898709-21583-1-git-send-email-felipe.contreras@gmail.com> <1364898709-21583-2-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 02 21:17:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN6i4-0007VZ-VM
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:17:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932309Ab3DBTRD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:17:03 -0400
Received: from bsmtp1.bon.at ([213.33.87.15]:64111 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932097Ab3DBTRC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:17:02 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id EB1C513004E;
	Tue,  2 Apr 2013 21:16:59 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 9F77019F312;
	Tue,  2 Apr 2013 21:16:59 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130307 Thunderbird/17.0.4
In-Reply-To: <1364898709-21583-2-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219854>

Am 02.04.2013 12:31, schrieb Felipe Contreras:
> And persistent_waitpid() to recover the information from the last run.

I'm not a fan of this new API, because it looks like a workaround
for a problem that should have been solved in a cleaner way. But if
we can't avoid it, please also add a paragraph to
Documentation/technical/api-run-command.txt

> +int check_command(struct child_process *cmd)
> +{
> +	int status;
> +	pid_t waiting;
> +
> +	if (cmd->last_status.valid)
> +		return 0;
> +
> +	while ((waiting = waitpid(cmd->pid, &status, WNOHANG)) < 0 && errno == EINTR)
> +		; /* nothing */
> +
> +	if (!waiting)
> +		return 1;
> +
> +	if (waiting == cmd->pid) {
> +		cmd->last_status.valid = 1;
> +		cmd->last_status.status = status;
> +		return 0;
> +	}
> +
> +	if (waiting > 0)
> +		die("BUG: waitpid reported a random pid?");
> +
> +	return 0;
> +}
> +
>  static void prepare_run_command_v_opt(struct child_process *cmd,
>  				      const char **argv,
>  				      int opt)
> @@ -729,7 +770,7 @@ error:
>  int finish_async(struct async *async)
>  {
>  #ifdef NO_PTHREADS
> -	return wait_or_whine(async->pid, "child process");
> +	return wait_or_whine(cmd, async->pid, "child process");

This breaks the NO_PTHREADS build because cmd is undeclared. Perhaps
this on top:

diff --git a/run-command.c b/run-command.c
index a9fa779..a02ef62 100644
--- a/run-command.c
+++ b/run-command.c
@@ -230,7 +230,7 @@ static pid_t persistent_waitpid(struct child_process *cmd, pid_t pid, int *statu
 {
 	pid_t waiting;
 
-	if (cmd->last_status.valid) {
+	if (cmd && cmd->last_status.valid) {
 		*status = cmd->last_status.status;
 		return pid;
 	}
@@ -771,7 +771,7 @@ int start_async(struct async *async)
 int finish_async(struct async *async)
 {
 #ifdef NO_PTHREADS
-	return wait_or_whine(cmd, async->pid, "child process");
+	return wait_or_whine(NULL, async->pid, "child process");
 #else
 	void *ret = (void *)(intptr_t)(-1);
 
