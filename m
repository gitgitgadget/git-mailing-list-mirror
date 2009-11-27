From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH/RFC 09/11] daemon: use run-command api for async  serving
Date: Fri, 27 Nov 2009 21:59:38 +0100
Message-ID: <200911272159.38757.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <1259196260-3064-9-git-send-email-kusmabite@gmail.com> <1259196260-3064-10-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Erik Faye-Lund" <kusmabite@googlemail.com>, git@vger.kernel.org,
	dotzenlabs@gmail.com, "Erik Faye-Lund" <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Fri Nov 27 21:59:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE7v3-0003Lv-6O
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 21:59:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbZK0U7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Nov 2009 15:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751301AbZK0U7q
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 15:59:46 -0500
Received: from [93.83.142.38] ([93.83.142.38]:63839 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750956AbZK0U7p (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 15:59:45 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id D1FC519F60D;
	Fri, 27 Nov 2009 21:59:38 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1259196260-3064-10-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133937>

On Donnerstag, 26. November 2009, Erik Faye-Lund wrote:
>  static void check_dead_children(void)
>  {
> -	int status;
> -	pid_t pid;
> -
> -	while ((pid = waitpid(-1, &status, WNOHANG)) > 0) {
> -		const char *dead = "";
> -		remove_child(pid);
> -		if (!WIFEXITED(status) || (WEXITSTATUS(status) > 0))
> -			dead = " (with error)";
> -		loginfo("[%"PRIuMAX"] Disconnected%s", (uintmax_t)pid, dead);
> -	}
> +	struct child **cradle, *blanket;
> +	for (cradle = &firstborn; (blanket = *cradle);)
> +		if (!is_async_alive(&blanket->async)) {

This would be the right place to call finish_async(). But since we cannot 
wait, you invented is_async_alive(). But actually we are not only interested 
in whether the process is alive, but also whether it completed successfully 
so that we can add "(with error)". Would it make sense to have a function 
finish_async_nowait() instead of is_async_alive() that (1) stresses the 
start/finish symmetry and (2) can return more than just Boolean?

> +			*cradle = blanket->next;
> +			loginfo("Disconnected\n");

Here you are losing information about the pid, which is important to have in 
the syslog. The \n should be dropped.

> +	async.proc = async_execute;
> +	async.data = ss;
> +	async.out = incoming;
>
> -	dup2(incoming, 0);
> -	dup2(incoming, 1);
> +	if (start_async(&async))
> +		logerror("unable to fork");
> +	else
> +		add_child(&async, addr, addrlen);
>  	close(incoming);
> -
> -	exit(execute(0, addr));

In start_command(), the convention is that fds that are provided by the caller 
are closed by start_command() (even if there are errors). The close(incoming) 
that you leave here indicates that you are not using the same convention with 
start_async(). It would be nice to switch to the same convention.

-- Hannes
