From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 3/5] run-command: Elaborate execvp error checking
Date: Wed, 25 Jan 2012 20:03:46 +0100
Message-ID: <4F205212.5080007@kdbg.org>
References: <1327444346-6243-1-git-send-email-fransklaver@gmail.com> <1327444346-6243-4-git-send-email-fransklaver@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C. Hamano" <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Frans Klaver <fransklaver@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 25 20:04:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rq88T-0003NJ-UO
	for gcvg-git-2@lo.gmane.org; Wed, 25 Jan 2012 20:03:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752041Ab2AYTDu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jan 2012 14:03:50 -0500
Received: from bsmtp3.bon.at ([213.33.87.17]:24792 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751366Ab2AYTDs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jan 2012 14:03:48 -0500
X-Greylist: delayed 487 seconds by postgrey-1.27 at vger.kernel.org; Wed, 25 Jan 2012 14:03:48 EST
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 011AB1001D;
	Wed, 25 Jan 2012 20:01:41 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8AC6E19F32A;
	Wed, 25 Jan 2012 20:03:46 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <1327444346-6243-4-git-send-email-fransklaver@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189119>

Am 24.01.2012 23:32, schrieb Frans Klaver:
> +static void inspect_failure(const char *argv0, int silent_exec_failure)
> +{
> +	int err = errno;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	/* errors not related to path */
> +	if (errno == E2BIG || errno == ENOMEM)
> +		die_file_error(argv0, err);
> +
> +	if (strchr(argv0, '/')) {
> +		if (file_exists(argv0)) {
> +			strbuf_add(&sb, argv0, strlen(argv0));
> +			inspect_file(&sb, err, argv0);

Can we end up here if errno == ENOENT? If so, silent_exec_failure must
be checked. (inspect_file does not return.)

> +		}
> +	} else {
> +		char *path, *next;
> +		path = getenv("PATH");
> +		while (path) {
> +			next = strchrnul(path, ':');
> +			if (path < next)
> +				strbuf_add(&sb, path, next - path);
> +			else
> +				strbuf_addch(&sb, '.');
> +
> +			if (!*next)
> +				path = NULL;
> +			else
> +				path = next + 1;
> +
> +			if (!is_searchable(sb.buf)) {
> +				strbuf_release(&sb);
> +				continue;
> +			}
> +
> +			if (sb.len && sb.buf[sb.len - 1] != '/')
> +				strbuf_addch(&sb, '/');
> +			strbuf_addstr(&sb, argv0);
> +
> +			if (file_exists(sb.buf))
> +				inspect_file(&sb, err, argv0);
> +
> +			strbuf_release(&sb);
> +		}
> +	}
> +
> +	if (err == ENOENT) {
> +		if (!silent_exec_failure)
> +			error("cannot exec '%s': %s", argv0,
> +					strerror(ENOENT));
> +		exit(127);
> +	} else {
> +		die_file_error(argv0, err);
> +	}
> +}
> +#endif
> +
>  int start_command(struct child_process *cmd)
>  {
>  	int need_in, need_out, need_err;
> @@ -280,14 +415,7 @@ fail_pipe:
>  		} else {
>  			execvp(cmd->argv[0], (char *const*) cmd->argv);
>  		}
> -		if (errno == ENOENT) {
> -			if (!cmd->silent_exec_failure)
> -				error("cannot run %s: %s", cmd->argv[0],
> -					strerror(ENOENT));
> -			exit(127);
> -		} else {
> -			die_errno("cannot exec '%s'", cmd->argv[0]);
> -		}
> +		inspect_failure(cmd->argv[0], cmd->silent_exec_failure);

Isn't it important that this function calls exit(127) if we want
silent_exec_failure and errno == ENOENT? But I don't see that this
guaranteed by inspect_failure; see above.

>  	}
>  	if (cmd->pid < 0)
>  		error("cannot fork() for %s: %s", cmd->argv[0],

-- Hannes
