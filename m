From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] push: Use sideband channel for hook messages
Date: Fri, 05 Feb 2010 12:58:27 +0100
Message-ID: <4B6C07E3.5030705@viscovery.net>
References: <20100205033748.GA19255@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 12:58:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdMpb-0001Na-AG
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 12:58:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754982Ab0BEL6e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 06:58:34 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:64757 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754927Ab0BEL6d (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 06:58:33 -0500
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1NdMpQ-0005gM-5E; Fri, 05 Feb 2010 12:58:28 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id D432F1660F;
	Fri,  5 Feb 2010 12:58:27 +0100 (CET)
User-Agent: Thunderbird 2.0.0.23 (Windows/20090812)
In-Reply-To: <20100205033748.GA19255@spearce.org>
X-Spam-Score: 1.9 (+)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139044>

Shawn O. Pearce schrieb:
> Rather than sending hook messages over stderr, and losing them
> entirely on git:// and smart HTTP transports,

I don't think "losing them entirely" is true for the git:// protocol:
git-daemon writes receive-pack's stderr to the syslog.

The question is whether hook errors are intended for the remote side or
for the repository owner. Generally, I'd say for the latter. But since
your patch is about pushing, a repository owner must already trust the
remote side, and then it can be argued that in this case errors can be
sent to the remote.

> diff --git a/run-command.c b/run-command.c
> index cf2d8f7..7d1fd88 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -94,6 +94,9 @@ fail_pipe:
>  		else if (need_err) {
>  			dup2(fderr[1], 2);
>  			close_pair(fderr);
> +		} else if (cmd->err > 1) {
> +			dup2(cmd->err, 2);
> +			close(cmd->err);
>  		}
>  
>  		if (cmd->no_stdout)
> @@ -228,6 +231,8 @@ fail_pipe:
>  
>  	if (need_err)
>  		close(fderr[1]);
> +	else if (cmd->err)
> +		close(cmd->err);
>  
>  	return 0;
>  }

This requires similar adjustments in the Windows part.

Documentation/technical/api-runcommand.txt should be an update, too.

> @@ -326,10 +331,19 @@ static unsigned __stdcall run_thread(void *data)
>  int start_async(struct async *async)
>  {
>  	int pipe_out[2];
> +	int proc_fd, call_fd;
>  
>  	if (pipe(pipe_out) < 0)
>  		return error("cannot create pipe: %s", strerror(errno));
> -	async->out = pipe_out[0];
> +
> +	if (async->is_reader) {
> +		proc_fd = pipe_out[0];
> +		call_fd = pipe_out[1];
> +	} else {
> +		call_fd = pipe_out[0];
> +		proc_fd = pipe_out[1];
> +	}
> +	async->out = call_fd;

I don't particularly like this approach because it restricts the async
procedures to a one-way communication.

What would you think about passing both channels to the async callback,
and the communicating parties must agree on which channel they communicate
by closing the unused one? It would require slight changes to all current
async users, though. (It also requires in the threaded case that we pass
dup()s of the pipe channels.)

-- Hannes
