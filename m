From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [v6 PATCH] daemon: add systemd support
Date: Tue, 07 Apr 2015 12:02:11 +0100
Message-ID: <5523B933.8080302@ramsay1.demon.co.uk>
References: <1428372206-120089-1-git-send-email-shawn@churchofgit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Shawn Landden <shawn@churchofgit.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 07 13:08:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfRMk-0001Dd-4c
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 13:08:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335AbbDGLIR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Apr 2015 07:08:17 -0400
Received: from mdfmta005.mxout.tbr.inty.net ([91.221.168.46]:35028 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753174AbbDGLIR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Apr 2015 07:08:17 -0400
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Tue, 07 Apr 2015 07:08:16 EDT
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id BAFABA64E45;
	Tue,  7 Apr 2015 12:02:14 +0100 (BST)
Received: from mdfmta005.tbr.inty.net (unknown [127.0.0.1])
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP id 44A99A64E41;
	Tue,  7 Apr 2015 12:02:14 +0100 (BST)
Received: from [10.0.2.15] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta005.tbr.inty.net (Postfix) with ESMTP;
	Tue,  7 Apr 2015 12:02:13 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
In-Reply-To: <1428372206-120089-1-git-send-email-shawn@churchofgit.com>
X-MDF-HostID: 8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266908>

On 07/04/15 03:03, Shawn Landden wrote:
> systemd supports git-daemon's existing --inetd mode as well.
> --systemd allows git-daemon has the advantage of allowing one git-daemon
> to listen to multiple interfaces as well as the system one(s),
> and more allow git-daemon to not be spawned on every connection.
> 
> Signed-off-by: Shawn Landden <shawn@churchofgit.com>
> ---

I have not been following this patch review, but I just happened to
notice something while skimming the patch as this email floated by ...

> Respond to review by Eric Sunshine here:
> http://marc.info/?l=git&m=142836529908207&w=2
> 

[snip]

> diff --git a/daemon.c b/daemon.c
> index 9ee2187..9880858 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1,3 +1,7 @@
> +#ifdef HAVE_SYSTEMD
> +#  include <systemd/sd-daemon.h>
> +#endif
> +
>  #include "cache.h"
>  #include "pkt-line.h"
>  #include "exec_cmd.h"
> @@ -28,7 +32,11 @@ static const char daemon_usage[] =
>  "           [--(enable|disable|allow-override|forbid-override)=<service>]\n"
>  "           [--access-hook=<path>]\n"
>  "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
> +#ifdef HAVE_SYSTEMD
> +"                      [--systemd | [--detach] [--user=<user> [--group=<group>]]]\n" /* exactly 80 characters */
> +#else
>  "                      [--detach] [--user=<user> [--group=<group>]]\n"
> +#endif
>  "           [<directory>...]";
>  
>  /* List of acceptable pathname prefixes */
> @@ -1176,11 +1184,23 @@ static void store_pid(const char *path)
>  }
>  
>  static int serve(struct string_list *listen_addr, int listen_port,
> -    struct credentials *cred)
> +    struct credentials *cred, int systemd_mode)
>  {
>  	struct socketlist socklist = { NULL, 0, 0 };
>  

... this hunk splits a statement in two ...

> -	socksetup(listen_addr, listen_port, &socklist);
> +#ifdef HAVE_SYSTEMD
> +	if (systemd_mode) {
> +		int i, n;
> +
> +		n = sd_listen_fds(0);
> +		ALLOC_GROW(socklist.list, socklist.nr + n, socklist.alloc);
> +		for (i = 0; i < n; i++)
> +			socklist.list[socklist.nr++] = SD_LISTEN_FDS_START + i;
> +	}
> +
> +	if (listen_addr->nr > 0 || !systemd_mode)
> +#endif
> +		socksetup(listen_addr, listen_port, &socklist);

... here. I have not considered any possible subtlety in the code, but simply
considering the patch text, I think the following may be easier to read:

    #ifdef HAVE_SYSTEMD
    	if (systemd_mode) {
    	...
    	}

    	if (listen_addr->nr > 0 || !systemd_mode)
    		socksetup(listen_addr, listen_port, &socklist);
    #else
    	socksetup(listen_addr, listen_port, &socklist);
    #endif

Or, maybe:

    #if !defined(HAVE_SYSTEMD)
    	socksetup(listen_addr, listen_port, &socklist);
    #else
    	...
    #endif

Or, ... ;-)

ATB,
Ramsay Jones

>  	if (socklist.nr == 0)
>  		die("unable to allocate any listen sockets on port %u",
>  		    listen_port);
> @@ -1196,7 +1216,7 @@ int main(int argc, char **argv)
>  {
>  	int listen_port = 0;
>  	struct string_list listen_addr = STRING_LIST_INIT_NODUP;
> -	int serve_mode = 0, inetd_mode = 0;
> +	int serve_mode = 0, inetd_mode = 0, systemd_mode = 0;
>  	const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
>  	int detach = 0;
>  	struct credentials *cred = NULL;
> @@ -1331,6 +1351,12 @@ int main(int argc, char **argv)
>  			informative_errors = 0;
>  			continue;
>  		}
> +#ifdef HAVE_SYSTEMD
> +		if (!strcmp(arg, "--systemd")) {
> +			systemd_mode = 1;
> +			continue;
> +		}
> +#endif
>  		if (!strcmp(arg, "--")) {
>  			ok_paths = &argv[i+1];
>  			break;
> @@ -1349,8 +1375,16 @@ int main(int argc, char **argv)
>  		/* avoid splitting a message in the middle */
>  		setvbuf(stderr, NULL, _IOFBF, 4096);
>  
> -	if (inetd_mode && (detach || group_name || user_name))
> -		die("--detach, --user and --group are incompatible with --inetd");
> +	if ((inetd_mode || systemd_mode) && (detach || group_name || user_name))
> +		die("--detach, --user and --group are incompatible with --inetd and --systemd");
> +
> +#ifdef HAVE_SYSTEMD
> +	if (systemd_mode && inetd_mode)
> +		die("--inetd is incompatible with --systemd");
> +
> +	if (systemd_mode && !sd_booted())
> +		die("--systemd passed and not invoked from systemd");
> +#endif
>  
>  	if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
>  		die("--listen= and --port= are incompatible with --inetd");
> @@ -1395,5 +1429,5 @@ int main(int argc, char **argv)
>  		cld_argv[i+1] = argv[i];
>  	cld_argv[argc+1] = NULL;
>  
> -	return serve(&listen_addr, listen_port, cred);
> +	return serve(&listen_addr, listen_port, cred, systemd_mode);
>  }
> 
