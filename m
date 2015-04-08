From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [v7 PATCH] daemon: add systemd support
Date: Wed, 8 Apr 2015 16:21:20 -0400
Message-ID: <CAPig+cT4Y7RD+7N3GcfNgUfTn2cDGpC6CJU-0JKQ7-oFECKuFQ@mail.gmail.com>
References: <CABPQNSa-45ZsUX54Ym3dQa+HU63abcQ9O3v8maRe9e_-38Ef+Q@mail.gmail.com>
	<1428520491-74980-1-git-send-email-shawn@churchofgit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Shawn Landden <shawn@churchofgit.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 22:21:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfwTY-0006PL-Is
	for gcvg-git-2@plane.gmane.org; Wed, 08 Apr 2015 22:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753905AbbDHUVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2015 16:21:23 -0400
Received: from mail-lb0-f170.google.com ([209.85.217.170]:33547 "EHLO
	mail-lb0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbbDHUVW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2015 16:21:22 -0400
Received: by lbbzk7 with SMTP id zk7so75948275lbb.0
        for <git@vger.kernel.org>; Wed, 08 Apr 2015 13:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=EjsGgam1Jhv0TeR7KsWlLP9EMqQD3GinZchStmxglOE=;
        b=nq9k4485Ve1dTmQhBX2nR0JZO4hAqXpddh2Z2hMOn2aknISbVgj2VjvhDbK9wgA4c7
         AK47k1SN9D9TeOYHLzPljbwCoPgWmi1hEvIT9xT5PKc8vfvI4O9tEUkMimQkszbTZtoO
         /lFTSPmOaO1AsqBe7EMI+eAmwSZ1j28W/BtauBoZO3AtPVj7DU+1AuDWG3SraQPaJYU6
         9Bhji8XB0Hvbv0eZv7Z4nGirNHvi6pwvkxknhvfLmCR6e6T6/PB5Uw/CTWvKJsJqodEE
         Q8uCeyZdh2oF9fQ6NEpEcUonTB2CfSvF8z3ttPj4FYP+bwEiK+4HnMeyyLXOzPNNuQaF
         XFHg==
X-Received: by 10.112.163.229 with SMTP id yl5mr24664811lbb.60.1428524480616;
 Wed, 08 Apr 2015 13:21:20 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Wed, 8 Apr 2015 13:21:20 -0700 (PDT)
In-Reply-To: <1428520491-74980-1-git-send-email-shawn@churchofgit.com>
X-Google-Sender-Auth: LGnjDVGrEdfoJGcLWBG9nGFIZ8s
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266970>

On Wed, Apr 8, 2015 at 3:14 PM, Shawn Landden <shawn@churchofgit.com> wrote:
> [v7 PATCH] daemon: add systemd support
>
> git-daemon's --systemd mode allows git-daemon to be connect-activated
> on one or more addresses or ports. Unlike --inetd[1], git-daemon is
> not spawned for every connection.
>
> [1]which systemd is compatible with using its Accept=yes mode
>
> Signed-off-by: Shawn Landden <shawn@churchofgit.com>
> ---
> Repond to Eric Sunshine's review of v6
> More documentation.

Does this v7 differ from the v7 which you sent yesterday[1]?

[1]: http://git.661346.n2.nabble.com/v7-PATCH-daemon-add-systemd-support-td7628519.html

> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index a69b361..0eab51b 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -19,7 +19,8 @@ SYNOPSIS
>              [--access-hook=<path>] [--[no-]informative-errors]
>              [--inetd |
>               [--listen=<host_or_ipaddr>] [--port=<n>]
> -             [--user=<user> [--group=<group>]]]
> +             [--systemd |
> +              [--user=<user> [--group=<group>]]]
>              [<directory>...]
>
>  DESCRIPTION
> @@ -81,8 +82,8 @@ OPTIONS
>
>  --inetd::
>         Have the server run as an inetd service. Implies --syslog.
> -       Incompatible with --detach, --port, --listen, --user and --group
> -       options.
> +       Incompatible with --systemd, --detach, --port, --listen, --user and
> +       --group options.
>
>  --listen=<host_or_ipaddr>::
>         Listen on a specific IP address or hostname.  IP addresses can
> @@ -146,8 +147,8 @@ OPTIONS
>         the option are given to `getpwnam(3)` and `getgrnam(3)`
>         and numeric IDs are not supported.
>  +
> -Giving these options is an error when used with `--inetd`; use
> -the facility of inet daemon to achieve the same before spawning
> +Giving these options is an error when used with `--inetd` or `--systemd`; use
> +the facility of systemd or the inet daemon to achieve the same before spawning
>  'git daemon' if needed.
>  +
>  Like many programs that switch user id, the daemon does not reset
> @@ -180,6 +181,16 @@ Git configuration files in that directory are readable by `<user>`.
>         errors are not enabled, all errors report "access denied" to the
>         client. The default is --no-informative-errors.
>
> +--systemd::
> +       For running git-daemon under systemd(1) which will pass
> +       an open connection. This is similar to --inetd, except
> +       that more than one address/port can be listened to at once
> +       both through systemd and through --listen/--port, and git-daemon
> +       doesn't get invoked for every connection, but only the first.
> +       For more details see systemd.socket(5). Incompatible with
> +       --inetd, --detach, --user and --group options.
> +       Works with the session manager (systemd --user) too.
> +
>  --access-hook=<path>::
>         Every time a client connects, first run an external command
>         specified by the <path> with service name (e.g. "upload-pack"),
> @@ -305,6 +316,34 @@ selectively enable/disable services per repository::
>                 uploadarch = true
>  ----------------------------------------------------------------
>
> +systemd configuration example::
> +Example systemd configuration files, typically placed in `/etc/systemd/system`
> +or `$HOME/.config/systemd/user`.
> ++
> +`git-daemon.socket`
> ++
> +----------------------------------------------------------------
> +[Unit]
> +Description=Git Daemon socket
> +
> +[Socket]
> +ListenStream=9418
> +
> +[Install]
> +WantedBy=sockets.target
> +----------------------------------------------------------------
> ++
> +`git-daemon.service`
> ++
> +----------------------------------------------------------------
> +[Unit]
> +Description=Git Daemon
> +
> +[Service]
> +ExecStart=/usr/lib/git-core/git-daemon --systemd --reuseaddr --base-path=/var/lib /var/lib/git
> +User=git-daemon
> +StandardError=null
> +----------------------------------------------------------------
>
>  ENVIRONMENT
>  -----------
> diff --git a/Makefile b/Makefile
> index 5f3987f..415ac21 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -42,6 +42,9 @@ all::
>  # Define NO_EXPAT if you do not have expat installed.  git-http-push is
>  # not built, and you cannot push using http:// and https:// transports (dumb).
>  #
> +# Define NO_SYSTEMD to prevent systemd socket activation support from being
> +# built into git-daemon.
> +#
>  # Define EXPATDIR=/foo/bar if your expat header and library files are in
>  # /foo/bar/include and /foo/bar/lib directories.
>  #
> @@ -995,6 +998,13 @@ ifeq ($(uname_S),Darwin)
>         PTHREAD_LIBS =
>  endif
>
> +ifndef NO_SYSTEMD
> +       ifeq ($(shell echo "\#include <systemd/sd-daemon.h>" | $(CC) -E - -o /dev/null 2>/dev/null && echo y),y)
> +               BASIC_CFLAGS += -DHAVE_SYSTEMD
> +               EXTLIBS += -lsystemd
> +       endif
> +endif
> +
>  ifndef CC_LD_DYNPATH
>         ifdef NO_R_TO_GCC_LINKER
>                 # Some gcc does not accept and pass -R to the linker to specify
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
>         struct socketlist socklist = { NULL, 0, 0 };
>
> -       socksetup(listen_addr, listen_port, &socklist);
> +#ifdef HAVE_SYSTEMD
> +       if (systemd_mode) {
> +               int i, n;
> +
> +               n = sd_listen_fds(0);
> +               ALLOC_GROW(socklist.list, socklist.nr + n, socklist.alloc);
> +               for (i = 0; i < n; i++)
> +                       socklist.list[socklist.nr++] = SD_LISTEN_FDS_START + i;
> +       }
> +
> +       if (listen_addr->nr > 0 || !systemd_mode)
> +#endif
> +               socksetup(listen_addr, listen_port, &socklist);
>         if (socklist.nr == 0)
>                 die("unable to allocate any listen sockets on port %u",
>                     listen_port);
> @@ -1196,7 +1216,7 @@ int main(int argc, char **argv)
>  {
>         int listen_port = 0;
>         struct string_list listen_addr = STRING_LIST_INIT_NODUP;
> -       int serve_mode = 0, inetd_mode = 0;
> +       int serve_mode = 0, inetd_mode = 0, systemd_mode = 0;
>         const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
>         int detach = 0;
>         struct credentials *cred = NULL;
> @@ -1331,6 +1351,12 @@ int main(int argc, char **argv)
>                         informative_errors = 0;
>                         continue;
>                 }
> +#ifdef HAVE_SYSTEMD
> +               if (!strcmp(arg, "--systemd")) {
> +                       systemd_mode = 1;
> +                       continue;
> +               }
> +#endif
>                 if (!strcmp(arg, "--")) {
>                         ok_paths = &argv[i+1];
>                         break;
> @@ -1349,8 +1375,16 @@ int main(int argc, char **argv)
>                 /* avoid splitting a message in the middle */
>                 setvbuf(stderr, NULL, _IOFBF, 4096);
>
> -       if (inetd_mode && (detach || group_name || user_name))
> -               die("--detach, --user and --group are incompatible with --inetd");
> +       if ((inetd_mode || systemd_mode) && (detach || group_name || user_name))
> +               die("--detach, --user and --group are incompatible with --inetd and --systemd");
> +
> +#ifdef HAVE_SYSTEMD
> +       if (systemd_mode && inetd_mode)
> +               die("--inetd is incompatible with --systemd");
> +
> +       if (systemd_mode && !sd_booted())
> +               die("--systemd passed and not invoked from systemd");
> +#endif
>
>         if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
>                 die("--listen= and --port= are incompatible with --inetd");
> @@ -1395,5 +1429,5 @@ int main(int argc, char **argv)
>                 cld_argv[i+1] = argv[i];
>         cld_argv[argc+1] = NULL;
>
> -       return serve(&listen_addr, listen_port, cred);
> +       return serve(&listen_addr, listen_port, cred, systemd_mode);
>  }
> --
> 2.2.1.209.g41e5f3a
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
