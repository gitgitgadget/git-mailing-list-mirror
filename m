From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] run-command: detect finished children by closed pipe
 rather than waitpid
Date: Sat, 7 Nov 2015 10:01:14 +0100
Message-ID: <563DBDDA.2000106@kdbg.org>
References: <1446853737-19047-1-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: ramsay@ramsayjones.plus.com, jacob.keller@gmail.com, peff@peff.net,
	gitster@pobox.com, jrnieder@gmail.com,
	johannes.schindelin@gmail.com, Jens.Lehmann@web.de,
	ericsunshine@gmail.com
To: Stefan Beller <sbeller@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 07 10:01:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuzNi-0004JE-Ka
	for gcvg-git-2@plane.gmane.org; Sat, 07 Nov 2015 10:01:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751671AbbKGJBT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 7 Nov 2015 04:01:19 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:16645 "EHLO bsmtp4.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751378AbbKGJBS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 7 Nov 2015 04:01:18 -0500
Received: from dx.site (unknown [93.83.142.38])
	by bsmtp4.bon.at (Postfix) with ESMTPSA id 3ntCHb3dLzz5tlJ;
	Sat,  7 Nov 2015 10:01:15 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.site (Postfix) with ESMTP id D98E0438;
	Sat,  7 Nov 2015 10:01:14 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1446853737-19047-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281015>

Am 07.11.2015 um 00:48 schrieb Stefan Beller:
> Detect if a child stopped working by checking if their stderr pipe
> was closed instead of checking their state with waitpid.
> As waitpid is not fully working in Windows, this is an approach which
> allows for better cross platform operation. (It's less code, too)
>
> Previously we did not close the read pipe of finished children, which we
> do now.
>
> The old way missed some messages on an early abort. We just killed the
> children and did not bother to look what was left over. With this approach
> we'd send a signal to the children and wait for them to close the pipe to
> have all the messages (including possible "killed by signal 15" messages).
>
> To have the test suite passing as before, we allow for real graceful
> abortion now. In case the user wishes to abort parallel execution
> the user needs to provide either the signal used to kill all children
> or the children are let run until they finish normally.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>   Hi,
>
>   this applis on top of origin/sb/submodule-parallel-fetch,
>   making Windows folks possibly even more happy. It makes the code easier
>   to read and has less races on cleaning up a terminated child.
>
>   It follows the idea of Johannes patch, instead of encoding information in .err
>   I removed the in_use flag and added a state, currently having 3 states.
>
>   Thanks,
>   Stefan
>
>   Johannes schrieb:
>   > First let me say that I find it very questionable that the callbacks
>   > receive a struct child_process.
>
>   I tried to get rid of the child_process struct in the callbacks, but that's
>   not as easy as one may think.

Fair enough. I see you removed .err, .no_stdin and .stdout_to_stderr 
from the callback. Good.

>   		pp->nr_processes--;
> -		pp->children[i].in_use = 0;
> +		pp->children[i].state = FREE;
>   		pp->pfd[i].fd = -1;
>   		child_process_deinit(&pp->children[i].process);

This cleanup is implied by finish_command and can be removed.

>   		child_process_init(&pp->children[i].process);

> @@ -1195,12 +1175,12 @@ int run_processes_parallel(int n,
>   		    i < spawn_cap && !pp->shutdown &&
>   		    pp->nr_processes < pp->max_processes;
>   		    i++) {
> -			int code = pp_start_one(pp);
> +			code = pp_start_one(pp);
>   			if (!code)
>   				continue;
>   			if (code < 0) {
>   				pp->shutdown = 1;
> -				kill_children(pp, SIGTERM);
> +				kill_children(pp, -code);

I'll see what this means for our kill emulation on Windows. Currently, 
we handle only SIGTERM.

>   			}
>   			break;
>   		}

Thanks you very much!

-- Hannes
