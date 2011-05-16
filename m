From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 1/3] connect: treat generic proxy processes like ssh processes
Date: Mon, 16 May 2011 21:57:58 +0200
Message-ID: <4DD181C6.4020104@kdbg.org>
References: <20110516063944.GB25731@sigill.intra.peff.net> <20110516064607.GA19078@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 16 21:58:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QM3vh-0006vU-4w
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 21:58:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755458Ab1EPT6G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 15:58:06 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:18936 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1755428Ab1EPT6F (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 15:58:05 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id B67F2A7EB5;
	Mon, 16 May 2011 21:54:00 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 2D1D419F380;
	Mon, 16 May 2011 21:57:58 +0200 (CEST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; de; rv:1.9.2.17) Gecko/20110414 SUSE/3.1.10 Thunderbird/3.1.10
In-Reply-To: <20110516064607.GA19078@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173751>

Am 16.05.2011 08:46, schrieb Jeff King:
> The git_connect function returns two ends of a pipe for
> talking with a remote, plus a struct child_process
> representing the other end of the pipe. If we have a direct
> socket connection, then this points to a special "no_fork"
> child process.
> 
> The code path for doing git-over-pipes or git-over-ssh sets
> up this child process to point to the child git command or
> the ssh process. When we call finish_connect eventually, we
> check wait() on the command and report its return value.
> 
> The code path for git://, on the other hand, always sets it
> to no_fork. In the case of a direct TCP connection, this
> makes sense; we have no child process. But in the case of a
> proxy command (configured by core.gitproxy), we do have a
> child process, but we throw away its pid, and therefore
> ignore its return code.
> 
> Instead, let's keep that information in the proxy case, and
> respect its return code, which can help catch some errors

This patch looks strikingly familiar. I had written an almost identical
change more than 3 years ago and forgot about it, though the
justification I noted in the commit was more to properly shutdown the
proxy process rather than to abandon it and let it be collected by
init(8). Your justification is much better.

There's one problem with your implementation, though:

> -static void git_proxy_connect(int fd[2], char *host)
> +static struct child_process *git_proxy_connect(int fd[2], char *host)
>  {
>  	const char *port = STR(DEFAULT_GIT_PORT);
>  	char *colon, *end;
>  	const char *argv[4];
> -	struct child_process proxy;
> +	struct child_process *proxy;
>  
>  	if (host[0] == '[') {
>  		end = strchr(host + 1, ']');
> @@ -431,14 +431,15 @@ static void git_proxy_connect(int fd[2], char *host)
>  	argv[1] = host;
>  	argv[2] = port;
>  	argv[3] = NULL;
> -	memset(&proxy, 0, sizeof(proxy));
> -	proxy.argv = argv;
> -	proxy.in = -1;
> -	proxy.out = -1;
> -	if (start_command(&proxy))
> +	proxy = xcalloc(1, sizeof(*proxy));
> +	proxy->argv = argv;
> +	proxy->in = -1;
> +	proxy->out = -1;
> +	if (start_command(proxy))

At this point, proxy->argv would point to automatic storage; but we
need argv[0] in finish_command() for error reporting. In my
implementation, I xmalloced the pointer array and leaked it. (And
that's probably the reason that I never submitted the patch.) I
wouldn't dare to make argv just static because this limits us to have
just one open connection at a time established via git_proxy_connect().
Dunno...

Below is the interdiff that turns your patch into mine, mostly for
exposition: The two hunks in git_connect() are just cosmetic
differences. But the first hunk should be squashed into your patch to
fix a potential crash in an error situation (e.g., when the proxy
dies from a signal) at the cost of a small memory leak.

diff --git a/connect.c b/connect.c
index a28e084..8668913 100644
--- a/connect.c
+++ b/connect.c
@@ -399,9 +399,10 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
 {
 	const char *port = STR(DEFAULT_GIT_PORT);
-	const char *argv[4];
+	const char **argv;
 	struct child_process *proxy;
 
 	get_host_and_port(&host, &port);
 
+	argv = xmalloc(4*sizeof(*argv));
 	argv[0] = git_proxy_command;
 	argv[1] = host;
@@ -457,5 +458,5 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 	char *end;
 	int c;
-	struct child_process *conn;
+	struct child_process *conn = &no_fork;
 	enum protocol protocol = PROTO_LOCAL;
 	int free_path = 0;
@@ -543,8 +544,6 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 		if (git_use_proxy(host))
 			conn = git_proxy_connect(fd, host);
-		else {
+		else
 			git_tcp_connect(fd, host, flags);
-			conn = &no_fork;
-		}
 		/*
 		 * Separate original protocol components prog and path
