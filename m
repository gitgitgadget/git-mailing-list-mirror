From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH/RFC] alias: use run_command api to execute aliases
Date: Thu, 6 Jan 2011 13:41:01 -0600
Message-ID: <20110106194101.GA14750@burratino>
References: <1294341187-3956-1-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jan 06 20:41:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pavi7-0008Fh-Ek
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 20:41:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752363Ab1AFTlT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 14:41:19 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:59149 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab1AFTlS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 14:41:18 -0500
Received: by qyj19 with SMTP id 19so19720967qyj.19
        for <git@vger.kernel.org>; Thu, 06 Jan 2011 11:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=OwyIJ2P/2MOPvwy7hJNzl4ZFNtCgCuPbotDXbyc5g0U=;
        b=qhBY8112eYXiD+7WK8u8kLygkhd77XwaYdeVpuZxoeMZmaX96jnd2zhbrN9QpwHITb
         ZX1TEWF6rGw3ZdvvO0MxwDoskny8ueTp5nQJnv28QYZ1p80dPfF3mhZFoST+xqLXKqxw
         U4Lp9Q/q834uCNdM/ZdqTFw7T5uYsNlE22Nlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=dFtuD0cHgrVfZHLb22QeK0zfN6zgLsbQkXwOOsx4grL887e3lNaW5NQvGe+upUq44O
         Qlv2uDW2msLYjArJBkPswgqYt0B5FvL3lQdPxjCpgda62KL/z0ongtaUphK/9xDCQFB5
         eKgkgAxTZSpggtxTIGLJsQyoBD5wfnUvw5s78=
Received: by 10.224.28.76 with SMTP id l12mr22873310qac.294.1294342877541;
        Thu, 06 Jan 2011 11:41:17 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id q12sm14576361qcu.18.2011.01.06.11.41.13
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 06 Jan 2011 11:41:14 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1294341187-3956-1-git-send-email-kusmabite@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164659>

Erik Faye-Lund wrote:

> --- a/git.c
> +++ b/git.c
> @@ -177,19 +177,20 @@ static int handle_alias(int *argcp, const char ***argv)
[...]
> -			trace_printf("trace: alias to shell cmd: %s => %s\n",
> -				     alias_command, alias_string + 1);

Replaced by

	trace: run_command: ...

(followed by "trace: exec: ..." on non-Windows (execv_shell_cmd)).
Ok.

> -			ret = system(alias_string + 1);
> +
> +			/* build alias_argv */
> +			alias_argv = malloc(sizeof(char *) * *argcp + 1);

This seems to be missing parentheses, so valgrind will complain
except on 8-bit systems. ;-)

What if malloc fails?

> +			alias_argv[0] = alias_string + 1;
> +			for (i = 1; i < *argcp; ++i)
> +				alias_argv[i] = (*argv)[i];
> +			alias_argv[*argcp] = NULL;

Nit: all these *argcp are noisy.

> +
> +			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
> +
>  			if (ret >= 0 && WIFEXITED(ret) &&

The return value from run_command and from system do not mean
the same thing.

>  			die("Failed to run '%s' when expanding alias '%s'",
>  			    alias_string + 1, alias_command);

run_command already prints an error message, but this one still
seems useful since it mentions the alias.

Except as noted above,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

diff --git a/git.c b/git.c
index 5b0b9d8..dbf061d 100644
--- a/git.c
+++ b/git.c
@@ -178,22 +178,20 @@ static int handle_alias(int *argcp, const char ***argv)
 	if (alias_string) {
 		if (alias_string[0] == '!') {
 			const char **alias_argv;
-			int i;
+			int argc = *argcp, i;
 
 			commit_pager_choice();
 
-			/* build alias_argv */
-			alias_argv = malloc(sizeof(char *) * *argcp + 1);
+			alias_argv = xmalloc(sizeof(*alias_argv) * (argc + 1));
 			alias_argv[0] = alias_string + 1;
-			for (i = 1; i < *argcp; ++i)
+			for (i = 1; i < argc; ++i)
 				alias_argv[i] = (*argv)[i];
-			alias_argv[*argcp] = NULL;
+			alias_argv[argc] = NULL;
 
 			ret = run_command_v_opt(alias_argv, RUN_USING_SHELL);
+			if (ret >= 0)	/* normal exit */
+				exit(ret);
 
-			if (ret >= 0 && WIFEXITED(ret) &&
-			    WEXITSTATUS(ret) != 127)
-				exit(WEXITSTATUS(ret));
 			die("Failed to run '%s' when expanding alias '%s'",
 			    alias_string + 1, alias_command);
 		}
