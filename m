From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [msysGit] [PATCH v3 08/14] daemon: use run-command api for async
 serving
Date: Sun, 10 Oct 2010 15:56:13 -0400
Message-ID: <4CB21A5D.4020408@sunshineco.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com> <1286716854-5744-9-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 21:56:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P520O-0007ZT-1h
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 21:56:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751364Ab0JJT4T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 15:56:19 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:45435 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750808Ab0JJT4R (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 15:56:17 -0400
Received: by pwj4 with SMTP id 4so714647pwj.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 12:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=hZizDQJqMTVgJFf03BX1MFY/o4lxkQAr+Q9eXYxyxR0=;
        b=JFOy8qXKN2yor06A5xqFdkWRLPR16xxe7a0xrkckfHX6Mqn7ZEwjU205bXrjWXT9Nb
         NzLz2ohUtYqmRkuFMWPiYtnmKoOo9Wp72nMfHRYTRwhNbFwjUQFSS5UMc01mInZ0BdlF
         bhl4bg61b42fNoFj4OimrH+8iP0DkE1N3zahA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=MYXihZZGRs9jah/hafydp4ngUZggjUKp4afmvtzRfvKtgktXt0+3tmX9Lw/W5MNW1E
         HL8nvEXq0J7+GhDUZrSOhI74/mDuyxWTJsX0wJcjYHUZyB77ZjS5ze92R2Y3LCSqo1cW
         1pRA9EWFhtAxhfG/eO+CDSfTV+dMqcLuV+OeU=
Received: by 10.114.66.5 with SMTP id o5mr6031891waa.219.1286740577578;
        Sun, 10 Oct 2010 12:56:17 -0700 (PDT)
Received: from [192.168.1.1] (user-12l2cil.cable.mindspring.com [69.81.50.85])
        by mx.google.com with ESMTPS id r37sm11508453wak.11.2010.10.10.12.56.15
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 12:56:16 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
In-Reply-To: <1286716854-5744-9-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158695>

On 10/10/2010 9:20 AM, Erik Faye-Lund wrote:
> fork() is only available on POSIX, so to support git-daemon
> on Windows we have to use something else.
>
> Instead we invent the flag --serve, which is a stripped down
> version of --inetd-mode. We use start_command() to call
> git-daemon with this flag appended to serve clients.
>
> Signed-off-by: Erik Faye-Lund<kusmabite@gmail.com>
> ---
> @@ -654,14 +641,14 @@ static void remove_child(pid_t pid)
>    */
>   static void kill_some_child(void)
>   {
> -	const struct child *blanket, *next;
> +	struct child *blanket, *next;

It is not immediately obvious why 'const' was dropped.

> @@ -671,18 +658,26 @@ static void check_dead_children(void)
>   	int status;
>   	pid_t pid;
>
> -	while ((pid = waitpid(-1,&status, WNOHANG))>  0) {
> -		const char *dead = "";
> -		remove_child(pid);
> -		if (!WIFEXITED(status) || (WEXITSTATUS(status)>  0))
> -			dead = " (with error)";
> -		loginfo("[%"PRIuMAX"] Disconnected%s", (uintmax_t)pid, dead);
> -	}
> +	struct child **cradle, *blanket;
> +	for (cradle =&firstborn; (blanket = *cradle);)
> +		if ((pid = waitpid(blanket->cld.pid,&status, WNOHANG))>  1) {
> +			const char *dead = "";
> +			if (status)
> +				dead = " (with error)";
> +			loginfo("[%"PRIuMAX"] Disconnected%s", (uintmax_t)pid, dead);
> +
> +			/* remove the child */
> +			*cradle = blanket->next;
> +			live_children--;
> +			free(blanket);
> +		} else
> +			cradle =&blanket->next;
>   }
>
> +char **cld_argv;
>   static void handle(int incoming, struct sockaddr *addr, int addrlen)
>   {

Should 'cld_argv' be declared static?

-- ES
