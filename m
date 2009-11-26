From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH/RFC 08/11] daemon: use explicit file descriptor
Date: Thu, 26 Nov 2009 23:03:57 +0100
Message-ID: <200911262303.57228.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <1259196260-3064-8-git-send-email-kusmabite@gmail.com> <1259196260-3064-9-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Cc: "Erik Faye-Lund" <kusmabite@googlemail.com>, git@vger.kernel.org,
	dotzenlabs@gmail.com, "Erik Faye-Lund" <kusmabite@gmail.com>
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Thu Nov 26 23:04:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDmRk-0007Ew-DU
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 23:04:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753109AbZKZWEF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 17:04:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751350AbZKZWEE
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 17:04:04 -0500
Received: from [93.83.142.38] ([93.83.142.38]:59490 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753105AbZKZWEE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 17:04:04 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 5B40319F4D0;
	Thu, 26 Nov 2009 23:03:57 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <1259196260-3064-9-git-send-email-kusmabite@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133842>

On Donnerstag, 26. November 2009, Erik Faye-Lund wrote:
> This patch adds support to specify an explicit file
> descriotor for communication with the client, instead
> of using stdin/stdout.
>
> This will be useful for the Windows port, because it
> will use threads instead of fork() to serve multiple
> clients, making it impossible to reuse stdin/stdout.
>
> Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
> ---
>  daemon.c |   34 ++++++++++++++++------------------
>  1 files changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/daemon.c b/daemon.c
> index 07d7356..a0aead5 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -263,7 +263,7 @@ static char *path_ok(char *directory)
>  	return NULL;		/* Fallthrough. Deny by default */
>  }
>
> -typedef int (*daemon_service_fn)(void);
> +typedef int (*daemon_service_fn)(int);
>  struct daemon_service {
>  	const char *name;
>  	const char *config_name;
> @@ -287,7 +287,7 @@ static int git_daemon_config(const char *var, const
> char *value, void *cb) return 0;
>  }
>
> -static int run_service(char *dir, struct daemon_service *service)
> +static int run_service(int fd, char *dir, struct daemon_service *service)
>  {
>  	const char *path;
>  	int enabled = service->enabled;
> @@ -340,7 +340,7 @@ static int run_service(char *dir, struct daemon_service
> *service) */
>  	signal(SIGTERM, SIG_IGN);
>
> -	return service->fn();
> +	return service->fn(fd);
>  }
>
>  static void copy_to_log(int fd)
> @@ -364,7 +364,7 @@ static void copy_to_log(int fd)
>  	fclose(fp);
>  }
>
> -static int run_service_command(const char **argv)
> +static int run_service_command(int fd, const char **argv)
>  {
>  	struct child_process cld;
>
> @@ -372,37 +372,35 @@ static int run_service_command(const char **argv)
>  	cld.argv = argv;
>  	cld.git_cmd = 1;
>  	cld.err = -1;
> +	cld.in = cld.out = fd;

You shouldn't do that. In fact, the next patch 9 has a hunk that correctly 
calls dup() once.

> -	close(0);
> -	close(1);

Here, stdin and stdout were closed and start_command() used both. But these 
two new calls

> +	exit(execute(0, addr));
> ...
> +		return execute(0, peer);

are the only places where a value is assigned to fd. Now it is always only 
stdin. Where does the old code initialize stdout? Shouldn't this place need a 
change, too?

-- Hannes
