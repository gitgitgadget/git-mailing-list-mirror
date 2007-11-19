From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix start_command closing cmd->out/in regardless of cmd->close_out/in
Date: Mon, 19 Nov 2007 08:39:37 +0100
Message-ID: <47413DB9.9030306@viscovery.net>
References: <1195407366-1610-1-git-send-email-pkufranky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 08:40:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iu1F4-0003VW-57
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 08:40:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbXKSHjl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 02:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbXKSHjl
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 02:39:41 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:42829 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891AbXKSHjk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 02:39:40 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Iu1Dh-0002RH-FJ; Mon, 19 Nov 2007 08:39:01 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 351E369F; Mon, 19 Nov 2007 08:39:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <1195407366-1610-1-git-send-email-pkufranky@gmail.com>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65408>

Ping Yin schrieb:
> When 'FILE *fp' is assigned to child_process.out and then start_command or
> run_command is run, the standard output of the child process is expected to
> be outputed to fp. However, sometimes fp is not expected to be closed since
> further IO may be still performmed on fp.
> ---
>  run-command.c |    4 ----
>  1 files changed, 0 insertions(+), 4 deletions(-)
> 
> diff --git a/run-command.c b/run-command.c
> index 476d00c..4e5f58d 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -115,13 +115,9 @@ int start_command(struct child_process *cmd)
>  
>  	if (need_in)
>  		close(fdin[0]);
> -	else if (cmd->in)
> -		close(cmd->in);
>  
>  	if (need_out)
>  		close(fdout[1]);
> -	else if (cmd->out > 1)
> -		close(cmd->out);
>  
>  	if (need_err)
>  		close(fderr[1]);

This is dangerous! You have to audit all current callers whether they close 
cmd->in or cmd->out (if they don't need the fd anymore). Otherwise you risk 
to keep a writable pipe end open and then the reader hangs, waiting for 
input that will never arrive.

-- Hannes
