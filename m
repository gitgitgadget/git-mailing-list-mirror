From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] transport-helper: check when helpers fail
Date: Mon, 22 Oct 2012 08:35:29 +0200
Message-ID: <5084E931.3010809@viscovery.net>
References: <1350847158-14154-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 22 08:35:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQBc7-0003ot-JO
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 08:35:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755042Ab2JVGfj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 02:35:39 -0400
Received: from so.liwest.at ([212.33.55.24]:49348 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753572Ab2JVGfj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 02:35:39 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TQBbm-0007s3-6a; Mon, 22 Oct 2012 08:35:30 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id BEF771660F;
	Mon, 22 Oct 2012 08:35:29 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <1350847158-14154-1-git-send-email-felipe.contreras@gmail.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208176>

Am 10/21/2012 21:19, schrieb Felipe Contreras:
> diff --git a/run-command.c b/run-command.c
> index 1101ef7..2852e9d 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -559,6 +559,23 @@ int run_command(struct child_process *cmd)
>  	return finish_command(cmd);
>  }
>  
> +int check_command(struct child_process *cmd)
> +{
> +	int status;
> +	pid_t pid;
> +
> +	pid = waitpid(cmd->pid, &status, WNOHANG);
> +
> +	if (pid < 0)
> +		return -1;
> +	if (WIFSIGNALED(status))
> +		return WTERMSIG(status);
> +	if (WIFEXITED(status))
> +		return WEXITSTATUS(status);
> +
> +	return 0;
> +}
> +

In this form, the function is not suitable as a public run-command API: If
the child did exit, it does not allow finish_command() to do its thing.
The only thing the caller of this function can do is to die() if it
returns non-zero. It doesn't report treat error cases in the same way as
wait_or_whine().

I would expect the function to be usable in this way:

	start_command(&proc);

	loop {
		if (check_command(&proc))
			break;
	}

	finish_command(&proc);

but it would require a bit more work because it would have to cache the
exit status in struct child_process.

BTW, you should check for return value 0 from waitpid() explicitly.

Another thought: In your use-case, isn't it so that it would be an error
that the process exited for whatever reason? I.e., even if it exited with
code 0 ("success"), it would be an error because it violated the protocol?

-- Hannes
