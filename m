From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2] alias: use run_command api to execute aliases
Date: Thu, 6 Jan 2011 21:27:56 +0100
Message-ID: <201101062127.56597.j6t@kdbg.org>
References: <1294343649-6272-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, jrnieder@gmail.com
To: "Erik Faye-Lund" <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 21:28:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PawRI-0002Cn-Am
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 21:28:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752172Ab1AFU17 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 15:27:59 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:44309 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751763Ab1AFU16 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 15:27:58 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 7719310016;
	Thu,  6 Jan 2011 21:28:01 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id AD65419F5EE;
	Thu,  6 Jan 2011 21:27:56 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1294343649-6272-1-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164667>

On Donnerstag, 6. Januar 2011, Erik Faye-Lund wrote:
> @@ -177,22 +177,22 @@ static int handle_alias(int *argcp, const char
> ***argv) alias_string = alias_lookup(alias_command);
>  	if (alias_string) {
>  		if (alias_string[0] == '!') {
> +			const char **alias_argv;
> +			int argc = *argcp, i;
> +
>  			commit_pager_choice();
> -			if (*argcp > 1) {
> -				struct strbuf buf;
> -
> -				strbuf_init(&buf, PATH_MAX);
> -				strbuf_addstr(&buf, alias_string);
> -				sq_quote_argv(&buf, (*argv) + 1, PATH_MAX);
> -				free(alias_string);
> -				alias_string = buf.buf;
> -			}
> -			trace_printf("trace: alias to shell cmd: %s => %s\n",
> -				     alias_command, alias_string + 1);
> -			ret = system(alias_string + 1);
> -			if (ret >= 0 && WIFEXITED(ret) &&
> -			    WEXITSTATUS(ret) != 127)
> -				exit(WEXITSTATUS(ret));
> +
> +			/* build alias_argv */
> +			alias_argv = xmalloc(sizeof(char *) * argc + 1);
> +			alias_argv[0] = alias_string + 1;
> +			for (i = 1; i < argc; ++i)
> +				alias_argv[i] = (*argv)[i];
> +			alias_argv[argc] = NULL;
> +
> +			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
> +			if (ret >= 0)   /* normal exit */
> +				exit(ret);
> +
>  			die("Failed to run '%s' when expanding alias '%s'",
>  			    alias_string + 1, alias_command);

At this point, errno has a meaning. I'd perhaps change this to:

			die_errno("While expanding alias '%s': '%s'",
				alias_command, alias_string + 1);

-- Hannes
