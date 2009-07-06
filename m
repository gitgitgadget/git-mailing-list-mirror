From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 4/7] run_command: report system call errors instead of
 returning error codes
Date: Mon, 06 Jul 2009 09:37:35 +0200
Message-ID: <4A51A9BF.5050104@viscovery.net>
References: <cover.1246734159.git.j6t@kdbg.org> <b73cf4b4cd09f4225098e71182044f64e12380aa.1246734159.git.j6t@kdbg.org> <d63e9230d57698a058c8a550709155e5e3222348.1246734159.git.j6t@kdbg.org> <4fe5ad61e7500735d1bbc12c98a863dd3499ea31.1246734159.git.j6t@kdbg.org> <ea2d8110ea70b8698bb3674ca4482db64053d841.1246734159.git.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 09:37:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNilq-0007Ju-GA
	for gcvg-git-2@gmane.org; Mon, 06 Jul 2009 09:37:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752415AbZGFHhk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 03:37:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752258AbZGFHhj
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 03:37:39 -0400
Received: from lilzmailso02.liwest.at ([212.33.55.13]:43511 "EHLO
	lilzmailso02.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752098AbZGFHhj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 03:37:39 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso02.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MNilc-0008Kr-Vv; Mon, 06 Jul 2009 09:37:37 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 58338735; Mon,  6 Jul 2009 09:37:36 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <ea2d8110ea70b8698bb3674ca4482db64053d841.1246734159.git.j6t@kdbg.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122775>

Johannes Sixt schrieb:
>  	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env);
> +	if (cmd->pid < 0 && errno != ENOENT)
> +		error("cannot spawn %s: %s", cmd->argv[0],
> +			strerror(failed_errno = errno));
>  
>  	if (cmd->env)
>  		free_environ(env);
> @@ -189,7 +203,6 @@ int start_command(struct child_process *cmd)
>  #endif
>  
>  	if (cmd->pid < 0) {
> -		int err = errno;
>  		if (need_in)
>  			close_pair(fdin);
>  		else if (cmd->in)
> @@ -200,9 +213,8 @@ int start_command(struct child_process *cmd)
>  			close(cmd->out);
>  		if (need_err)
>  			close_pair(fderr);
> -		return err == ENOENT ?
> -			-ERR_RUN_COMMAND_EXEC :
> -			-ERR_RUN_COMMAND_FORK;
> +		errno = failed_errno;
> +		return -1;
>  	}

Sorry to bother you once again. 'gcc -O2' correctly points out that
failed_errno could be used uninitialized (MinGW code path only).
Would you please squash this in?

-- Hannes

diff --git a/run-command.c b/run-command.c
--- a/run-command.c
+++ b/run-command.c
@@ -184,9 +184,9 @@ fail_pipe:
 	}

 	cmd->pid = mingw_spawnvpe(cmd->argv[0], cmd->argv, env);
+	failed_errno = errno;
 	if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
-		error("cannot spawn %s: %s", cmd->argv[0],
-			strerror(failed_errno = errno));
+		error("cannot spawn %s: %s", cmd->argv[0], strerror(errno));

 	if (cmd->env)
 		free_environ(env);
