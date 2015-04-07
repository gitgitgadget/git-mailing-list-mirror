From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [RFCv5 PATCH] daemon: add systemd support
Date: Mon, 6 Apr 2015 20:08:11 -0400
Message-ID: <CAPig+cTfj_j_rX6Bgz9UY8hYWzjCS4eSXa1DsS3FtMwP3+7i_g@mail.gmail.com>
References: <1428117740-32622-1-git-send-email-shawn@churchofgit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Shawn Landden <shawn@churchofgit.com>,
	Shawn Landden <shawnlandden@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 07 02:08:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YfH40-0001DO-GH
	for gcvg-git-2@plane.gmane.org; Tue, 07 Apr 2015 02:08:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752688AbbDGAIO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2015 20:08:14 -0400
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35067 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751421AbbDGAIN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2015 20:08:13 -0400
Received: by lbbuc2 with SMTP id uc2so27297316lbb.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2015 17:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=90OYzLbWPQl/bLlw88l4ySFX54ZKoUFwYR9GzuS9VHQ=;
        b=KkTyIavVGETuNNbdeFJYd2+UBmBeYrooM7ngaJyw1uT/W6QcwdNJpwRCrJoK0w0XNy
         ZtMBTjBwfDvc6cHdjHrjS032oJN4Yd/sREXc928tGQDq1GfL9QEYUu0fqqzSkty0mMIm
         UYQHbgbtSbssey95B3RESx9V6hp32JNvLCA8wDwHqo5IDdYuehwU2KlBbjvlDx68sqAL
         UGUkPh6/jhZ9orc6AL35BhN4D5eoCYtv6dHClmCVnwVLVm5WN0jDG9HLzcYQzD4K1TGr
         p22bXYykqiY2aDtnNwwQI0QPOZH2ftcnx1uFvie0qbAlo8PRjF+BD1LgjXiliQR0sQ4C
         4krQ==
X-Received: by 10.112.146.129 with SMTP id tc1mr15357621lbb.27.1428365291627;
 Mon, 06 Apr 2015 17:08:11 -0700 (PDT)
Received: by 10.114.78.69 with HTTP; Mon, 6 Apr 2015 17:08:11 -0700 (PDT)
In-Reply-To: <1428117740-32622-1-git-send-email-shawn@churchofgit.com>
X-Google-Sender-Auth: Xkz40G3ZkdWaD5kbqArICm4NosQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266893>

On Fri, Apr 3, 2015 at 11:22 PM, Shawn Landden <shawn@churchofgit.com> wrote:
> [RFCv5 PATCH] daemon: add systemd support

Now that you've included a documentation update and made the example
systemd configuration files more accessible, this feels like a more
properly fleshed-out submission (though the commit message is still
quite lacking), so it's probably time to drop the "RFC" designation.

> systemd supports git-daemon's existing --inetd mode as well.

What is the intention of this sentence, and how is it relevant to the patch?

Are you saying that git-daemon already works correctly with systemd
when using the --inetd option? If so, then the commit message should
explain how the new --systemd option is superior to --inetd in order
to justify the added complexity to both code and documentation. Some
of what you wrote in the documentation update may be useful in the
commit message to help convince the reader that the patch is
worthwhile.

> Signed-off-by: Shawn Landden <shawn@churchofgit.com>
> ---
> diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
> index a69b361..a273565 100644
> --- a/Documentation/git-daemon.txt
> +++ b/Documentation/git-daemon.txt
> @@ -18,7 +18,7 @@ SYNOPSIS
>              [--allow-override=<service>] [--forbid-override=<service>]
>              [--access-hook=<path>] [--[no-]informative-errors]
>              [--inetd |
> -             [--listen=<host_or_ipaddr>] [--port=<n>]
> +             [--listen=<host_or_ipaddr>] [--port=<n>] [--systemd]
>               [--user=<user> [--group=<group>]]]

The documentation (below) for the --systemd option says that it is
incompatible with --user= and --group=, so shouldn't this be:

    [--inetd |
        [--listen=<host_or_ipaddr>] [--port=<n>]
        [(--systemd | --user=<user> [--group=<group>])]]

or something?

More below.

>              [<directory>...]
>
> @@ -81,8 +81,8 @@ OPTIONS
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
> @@ -146,8 +146,8 @@ OPTIONS
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
> @@ -180,6 +180,14 @@ Git configuration files in that directory are readable by `<user>`.
>         errors are not enabled, all errors report "access denied" to the
>         client. The default is --no-informative-errors.
>
> +--systemd::
> +       For running git-daemon under systemd(1) which will pass
> +       an open connection. This is similar to --inetd, except
> +       that more than one address/port can be listened to at once
> +       both through systemd and through --listen, and git-daemon doesn't get
> +       invoked for every connection. For more details see systemd.socket(5).
> +       Incompatible with --inetd, --detach, --user and --group options.
> +
>  --access-hook=<path>::
>         Every time a client connects, first run an external command
>         specified by the <path> with service name (e.g. "upload-pack"),
> @@ -304,7 +312,30 @@ selectively enable/disable services per repository::
>                 uploadpack = false
>                 uploadarch = true
>  ----------------------------------------------------------------
> ++

Drop this "+" line.

> +
> +systemd configuration example::
> ++
> +----------------------------------------------------------------
> +# /etc/systemd/system/git-daemon.socket
> +[Unit]
> +Description=Git Daemon socket
>
> +[Socket]
> +ListenStream=9418
> +
> +[Install]
> +WantedBy=sockets.target
> +
> +# /etc/systemd/system/git-daemon.service
> +[Unit]
> +Description=Git Daemon
> +
> +[Service]
> +ExecStart=/usr/lib/git-core/git-daemon --systemd --reuseaddr --base-path=/var/lib /var/lib/git
> +User=git-daemon
> +StandardError=null
> +----------------------------------------------------------------

Unfortunately, plopping both of these example files into a single
verbatim block makes it difficult to see that there are indeed two
files being shown. Someone could easily overlook the second file after
seeing the initial "# /etc/systemd/system/git-daemon.socket" comment,
and merely copy/paste the entire block into that one file. It would be
better to split this into two verbatim blocks, one for each file,
while moving the filename outside the block, and including a bit more
explanation.

For instance:

    systemd configuration example::
        Example systemd configuration files, typically placed in
        `/etc/systemd/system`.
    +
    `git-daemon.socket`
    +
    ----------------------------------------------------------------
    [Unit]
    Description=Git Daemon socket
    ...
    ----------------------------------------------------------------
    +
    `git-daemon.service`
    +
    ----------------------------------------------------------------
    [Unit]
    Description=Git Daemon
    ...
    ----------------------------------------------------------------

All the pluses and back-ticks in the above illustration are intentional.

More below.

>  ENVIRONMENT
>  -----------
> diff --git a/Makefile b/Makefile
> index 5f3987f..83f5d8e 100644
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
> +       ifeq ($(shell echo "\#include <systemd/sd-daemon.h>" | $(CC) -E - -o /dev/null && echo y),y)

Unfortunately, this spews scary "<stdin>:1:10: fatal error:
'systemd/sd-daemon.h' file not found" errors at build-time on
platforms which lack that header. You might want to redirect stderr to
suppress the complaint. Perhaps like this:

    $(shell echo "..." | $(CC) -E - -o /dev/null 2>/dev/null && ...)

More below.

> +               BASIC_CFLAGS += -DHAVE_SYSTEMD
> +               EXTLIBS += -lsystemd
> +       endif
> +endif
> +
>  ifndef CC_LD_DYNPATH
>         ifdef NO_R_TO_GCC_LINKER
>                 # Some gcc does not accept and pass -R to the linker to specify
> diff --git a/daemon.c b/daemon.c
> index 9ee2187..ad8a79a 100644
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
> @@ -29,6 +33,9 @@ static const char daemon_usage[] =
>  "           [--access-hook=<path>]\n"
>  "           [--inetd | [--listen=<host_or_ipaddr>] [--port=<n>]\n"
>  "                      [--detach] [--user=<user> [--group=<group>]]\n"
> +#ifdef HAVE_SYSTEMD
> +"           [--systemd]\n"
> +#endif

This differs from the usage in the documentation where --systemd is
grouped with --listen and --port, etc. as an alternative to --inetd.

>  "           [<directory>...]";
>
>  /* List of acceptable pathname prefixes */
> @@ -1176,11 +1183,23 @@ static void store_pid(const char *path)
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
> @@ -1196,7 +1215,7 @@ int main(int argc, char **argv)
>  {
>         int listen_port = 0;
>         struct string_list listen_addr = STRING_LIST_INIT_NODUP;
> -       int serve_mode = 0, inetd_mode = 0;
> +       int serve_mode = 0, inetd_mode = 0, systemd_mode = 0;
>         const char *pid_file = NULL, *user_name = NULL, *group_name = NULL;
>         int detach = 0;
>         struct credentials *cred = NULL;
> @@ -1331,6 +1350,12 @@ int main(int argc, char **argv)
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
> @@ -1349,8 +1374,16 @@ int main(int argc, char **argv)
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
> @@ -1395,5 +1428,5 @@ int main(int argc, char **argv)
>                 cld_argv[i+1] = argv[i];
>         cld_argv[argc+1] = NULL;
>
> -       return serve(&listen_addr, listen_port, cred);
> +       return serve(&listen_addr, listen_port, cred, systemd_mode);
>  }
> --
> 2.2.1.209.g41e5f3a
