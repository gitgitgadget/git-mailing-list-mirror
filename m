From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] systemd socket activation support
Date: Thu, 2 Apr 2015 01:59:14 -0400
Message-ID: <CAPig+cQVLGAYKNJf2dZGpnZbU-GBzeVKpQG48cpFtX8uYZ_LPQ@mail.gmail.com>
References: <1427937796-10060-1-git-send-email-shawn@churchofgit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Shawn Landden <shawnlandden@gmail.com>
To: Shawn Landden <shawn@churchofgit.com>
X-From: git-owner@vger.kernel.org Thu Apr 02 07:59:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdY9x-0007qB-Gt
	for gcvg-git-2@plane.gmane.org; Thu, 02 Apr 2015 07:59:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752522AbbDBF7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2015 01:59:17 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:36706 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751054AbbDBF7Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2015 01:59:16 -0400
Received: by lbbug6 with SMTP id ug6so52061610lbb.3
        for <git@vger.kernel.org>; Wed, 01 Apr 2015 22:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=n36Mbdvl0A+eXxlAehUv+5FZ3hZrgifv3I6mvKOn6ik=;
        b=CqRZQ0GDfjOBjpu9M1UyFNuh+xdUWpKBZvdPezGkxIdiviXbKmqAr9Ld1tnxcGlnAo
         /DVA8N09ljsJh0HKOn87UKpnuG5caSqy+s+IOGapOMPITkMWsEPqgX/IsDqxhDgUc+FZ
         1UNUuwRr2qxAzFbbKnoB63U7x3jAA2grIx+n5Ena4gGWQ1jN5TuvZTrCFC0inasnpRVG
         X2qQFc7gd+eS1zXiJQuNndnzS/u3zsrRv1tVQabWyBsDAyZNKF2/i1eAL8F6/iw2FFW0
         wjC9uX/tPNV7alpwp2hKc/ZxMteoZGIlqX6r8kXoVLXDoQpv/RiBzW0vVxuSNCNlB0h4
         BzNw==
X-Received: by 10.112.173.41 with SMTP id bh9mr38472569lbc.107.1427954354765;
 Wed, 01 Apr 2015 22:59:14 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Wed, 1 Apr 2015 22:59:14 -0700 (PDT)
In-Reply-To: <1427937796-10060-1-git-send-email-shawn@churchofgit.com>
X-Google-Sender-Auth: KIyACu8emGe9SJlAx-gLSiDWL8Q
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266631>

On Wed, Apr 1, 2015 at 9:23 PM, Shawn Landden <shawn@churchofgit.com> wrote:
> From: Shawn Landden <shawnlandden@gmail.com>
>
> [PATCH] systemd socket activation support

This patch feels like an RFC rather than a properly fleshed-out
submission. If so, indicate such in the subject. Also, mention the
area you're touching, followed by a colon, followed by the summary of
the change:

    [PATCH/RFC] daemon: add systemd support

The commit message may be a bit lacking. You might want to explain why
this is desirable, perhaps mentioning that this complements existing
inetd support, and (for the uninitiated) how it differs from inetd
support (possibly citing documentation). It might also be a good idea
to mention that sd-daemon.[ch] are foreign imports (possibly citing
the source).

> Signed-off-by: Shawn Landden <shawn@churchofgit.com>

The Signed-off-by: email address differs from your From: address.

> ---
>  daemon.c           |  38 ++++++++++++---
>  git-daemon.service |   6 +++
>  git-daemon.socket  |   9 ++++
>  sd-daemon.c        | 132 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  sd-daemon.h        |  91 ++++++++++++++++++++++++++++++++++++

Necessary Documentation/git-daemon.txt changes are missing.
Makefile changes are likely missing.

More below.

> diff --git a/daemon.c b/daemon.c
> index 9ee2187..56b3cd4 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -5,6 +5,8 @@
>  #include "strbuf.h"
>  #include "string-list.h"
>
> +#include "sd-daemon.c"

This is kind of weird. Why this rather than the more typical approach
of including sd-daemon.h here, compiling sd-daemon.c separately, and
then combining them at link time? If there really is a good reason for
this arrangement, it's probably worthwhile explaining it in the commit
message.

>  #ifndef HOST_NAME_MAX
>  #define HOST_NAME_MAX 256
>  #endif
> @@ -29,6 +31,7 @@ static const char daemon_usage[] =
>  "           [--access-hook=<path>]\n"
>  "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
>  "                      [--detach] [--user=<user> [--group=<group>]]\n"
> +"           [--systemd]\n"
>  "           [<directory>...]";
>
>  /* List of acceptable pathname prefixes */
> @@ -1176,11 +1179,21 @@ static void store_pid(const char *path)
>  }
>
>  static int serve(struct string_list *listen_addr, int listen_port,
> -    struct credentials *cred)
> +    struct credentials *cred, int systemd_mode)
>  {
>         struct socketlist socklist = { NULL, 0, 0 };
> +       int i;
> +       int n;

These variables are used only within the 'if (systemd_mode)' scope,
thus can be declared there.

More below.

> -       socksetup(listen_addr, listen_port, &socklist);
> +       if (systemd_mode) {
> +               n = sd_listen_fds(0);
> +               ALLOC_GROW(socklist.list, socklist.nr + n, socklist.alloc);
> +               for (i = 0; i < n; i++)
> +                       socklist.list[socklist.nr++] = SD_LISTEN_FDS_START + i;
> +       }
> +
> +       if (listen_addr || !systemd_mode)
> +               socksetup(listen_addr, listen_port, &socklist);
>         if (socklist.nr == 0)
>                 die("unable to allocate any listen sockets on port %u",
>                     listen_port);
> @@ -1196,7 +1209,7 @@ int main(int argc, char **argv)
>  {
>         int listen_port = 0;
>         struct string_list listen_addr = STRING_LIST_INIT_NODUP;
> -       int serve_mode = 0, inetd_mode = 0;
> +       int serve_mode = 0, inetd_mode = 0, systemd_mode = 0;
>         const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
>         int detach = 0;
>         struct credentials *cred = NULL;
> @@ -1331,6 +1344,10 @@ int main(int argc, char **argv)
>                         informative_errors = 0;
>                         continue;
>                 }
> +               if (!strcmp(arg, "--systemd")) {
> +                       systemd_mode = 1;
> +                       continue;
> +               }
>                 if (!strcmp(arg, "--")) {
>                         ok_paths = &argv[i+1];
>                         break;
> @@ -1349,14 +1366,23 @@ int main(int argc, char **argv)
>                 /* avoid splitting a message in the middle */
>                 setvbuf(stderr, NULL, _IOFBF, 4096);
>
> -       if (inetd_mode && (detach || group_name || user_name))
> -               die("--detach, --user and --group are incompatible with --inetd");
> +       if ((inetd_mode || systemd-mode) && (detach || group_name || user_name))

I can't see how a variable named 'systemd-mode' would ever have compiled.

> +               die("--detach, --user and --group are incompatible with --inetd and --systemd");
> +
> +       if (systemd_mode && inetd_mode)
> +               die("--inetd is incompatible with --systemd");
>
>         if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
>                 die("--listen= and --port= are incompatible with --inetd");
>         else if (listen_port == 0)
>                 listen_port = DEFAULT_GIT_PORT;
>
> +       if (systemd_mode) {
> +               i = sd_listen_fds(0);
> +               if (i <= 0)
> +                       die("--systemd passed and not running from systemd or no file descriptors passed");

Perhaps rephrase as:

    --systemd requested but not invoked from systemd or file
descriptors not specified

> +       }
> +
>         if (group_name && !user_name)
>                 die("--group supplied without --user");
>
> @@ -1395,5 +1421,5 @@ int main(int argc, char **argv)
>                 cld_argv[i+1] = argv[i];
>         cld_argv[argc+1] = NULL;
>
> -       return serve(&listen_addr, listen_port, cred);
> +       return serve(&listen_addr, listen_port, cred, systemd_mode);
>  }
> diff --git a/git-daemon.service b/git-daemon.service
> new file mode 100644
> index 0000000..78c662e
> --- /dev/null
> +++ b/git-daemon.service
> @@ -0,0 +1,6 @@
> +[Unit]
> +Description=Git Daemon
> +
> +[Service]
> +ExecStart=/usr/lib/git-core/git-daemon --systemd --base-path=/var/lib /var/lib/git
> +User=gitdaemon

If the intention is that this file should get installed somewhere so
that the admin can copy it or link to it, then you will want to
augment the Makefile to do so. Likewise, the hardcoded paths
(/usr/lib/git-core and /var/lib/git) probably require munging based
upon the installation location.

An alternative would be to take a hint from what was done for inetd
support, and instead add this to Documentation/git-daemon.txt as an
example configuration file.

> diff --git a/git-daemon.socket b/git-daemon.socket
> new file mode 100644
> index 0000000..b3dd981
> --- /dev/null
> +++ b/git-daemon.socket
> @@ -0,0 +1,9 @@
> +[Unit]
> +Description=Git Daemon socket
> +
> +[Socket]
> +ListenStream=9418
> +
> +[Install]
> +WantedBy=sockets.target

Ditto regarding Makefile support or adding this as an example to
Documentation/git-daemon.txt.
