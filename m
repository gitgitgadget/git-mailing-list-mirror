From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] daemon: add systemd support
Date: Sun, 17 May 2015 15:58:11 -0400
Message-ID: <CAPig+cSOc8Qde1oxq2V+1m4gjnMHaa_mKXO4n21V6zQox9=6qg@mail.gmail.com>
References: <1431830650-111684-1-git-send-email-shawn@churchofgit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Shawn Landden <shawn@churchofgit.com>
X-From: git-owner@vger.kernel.org Sun May 17 21:58:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yu4hW-0000uK-OQ
	for gcvg-git-2@plane.gmane.org; Sun, 17 May 2015 21:58:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbbEQT6N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 May 2015 15:58:13 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34938 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865AbbEQT6M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 May 2015 15:58:12 -0400
Received: by igbyr2 with SMTP id yr2so32864758igb.0
        for <git@vger.kernel.org>; Sun, 17 May 2015 12:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=83FzI11G/QJKHxHQ25lfvjIZjhP7WV5Fg/kgga4YoAY=;
        b=m+781T9BYxb7MvHsLtFY2VqgWmJlZn0aDo2Z5I3xPh3V2mNWlbgCPG9dNRiqQRe2a8
         QsCPE76GFKU+C4wRQbUBNYTnINmZ7Uga6aex/WvUBA5v6duAoJ4Zcav8LJwCqlnSjlCm
         /rrdlogncNy2vSroDHeCwENUX1i/ZYDULPMIvLmPKRfHtjVe+tzYYxhtmEj2AEbmosxv
         vJlSspoQ9H7SGbZ0UAcESUwfa3lUXy0CnifN9iBl5HEiYmuLpl5+pF41fKpk0kNT6wcJ
         qjeNUDDGCv9sPToDa7kgmYP6c4xrjHAmYzi4qjg3UkfVjC414u4FVcdbM750zIFSrAPL
         yaQg==
X-Received: by 10.107.151.75 with SMTP id z72mr21467528iod.46.1431892691478;
 Sun, 17 May 2015 12:58:11 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Sun, 17 May 2015 12:58:11 -0700 (PDT)
In-Reply-To: <1431830650-111684-1-git-send-email-shawn@churchofgit.com>
X-Google-Sender-Auth: ntGSowavfcL4JKXCCcPfEVJemTo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269222>

On Sat, May 16, 2015 at 10:44 PM, Shawn Landden <shawn@churchofgit.com> wrote:
> daemon: add systemd support
>
> git-daemon's --systemd mode allows git-daemon to be connect-activated
> on one or more addresses or ports. Unlike --inetd[1], git-daemon is
> not spawned for every connection.
>
> [1]which systemd is compatible with using its Accept=yes mode
>
> Signed-off-by: Shawn Landden <shawn@churchofgit.com>
> ---

For convenience of other reviewers, this is v8. Links to all versions:

v8 (2015-05-17): http://thread.gmane.org/gmane.comp.version-control.git/269205

v7.1 (2015-04-08):
http://thread.gmane.org/gmane.comp.version-control.git/266632/focus=266969

v7 (2015-04-07): http://thread.gmane.org/gmane.comp.version-control.git/266926

v6 (2015-04-07): http://thread.gmane.org/gmane.comp.version-control.git/266895

v5 (2015-04-04): http://thread.gmane.org/gmane.comp.version-control.git/266759

v4 (2015-04-03):
http://git.661346.n2.nabble.com/RFCv4-PATCH-daemon-add-systemd-support-td7628351.html

v3 (2015-04-03):
http://git.661346.n2.nabble.com/v3RFC-systemd-socket-activation-support-td7628336.html

v2 (2015-04-02): http://thread.gmane.org/gmane.comp.version-control.git/266646

v1.1 (2015-04-02): http://thread.gmane.org/gmane.comp.version-control.git/266632

v1 (2015-04-02): http://thread.gmane.org/gmane.comp.version-control.git/266628

Below are some additional comments beyond what Junio already mentioned
in his review...

> diff --git a/Makefile b/Makefile
> index 36655d5..54986a0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -997,6 +1000,13 @@ ifeq ($(uname_S),Darwin)
>         PTHREAD_LIBS =
>  endif
>
> +ifndef NO_SYSTEMD
> +       ifeq ($(shell echo "\#include <systemd/sd-daemon.h>" | $(CC) -E - -o /dev/null 2>/dev/null && echo y),y)

It is highly unusual to place such an expensive check directly in
Makefile (or even config.mak.uname) where it will penalize everyone
(who hasn't disabled systemd) each time 'make' is invoked. This sort
of expensive detection is typically only done by the configure script.

> +               BASIC_CFLAGS += -DHAVE_SYSTEMD
> +               EXTLIBS += -lsystemd
> +       endif
> +endif
> diff --git a/daemon.c b/daemon.c
> index d3d3e43..42e1441 100644
> --- a/daemon.c
> +++ b/daemon.c
> @@ -1166,12 +1174,40 @@ static struct credentials *prepare_credentials(const char *user_name,
>  }
>  #endif
>
> +#ifdef HAVE_SYSTEMD
> +static int enumerate_sockets(struct socketlist *socklist, struct string_list *listen_addr, int listen_port, int systemd_mode)
> +{
> +       if (systemd_mode) {
> +               int i, n;
> +
> +               n = sd_listen_fds(0);
> +               if (n <= 0)
> +                       die("--systemd mode specified and no file descriptors recieved");
> +               ALLOC_GROW(socklist->list, socklist->nr + n, socklist->alloc);
> +               for (i = 0; i < n; i++)
> +                       socklist->list[socklist->nr++] = SD_LISTEN_FDS_START + i;
> +       }
> +
> +       if (listen_addr->nr > 0 || !systemd_mode)
> +               socksetup(listen_addr, listen_port, socklist);
> +
> +       return 0;

What is the significance of the return value of enumerate_sockets()?
It's unconditionally 0, even if socksetup() was never invoked, and
isn't checked by the caller.

> +}
> +#else
> +static int enumerate_sockets(struct socketlist *socklist, struct string_list *listen_addr, int listen_port, int systemd_mode)
> +{
> +       socksetup(listen_addr, listen_port, socklist);
> +
> +       return 0;
> +}
> +#endif
> @@ -1340,8 +1382,16 @@ int main(int argc, char **argv)
>                 /* avoid splitting a message in the middle */
>                 setvbuf(stderr, NULL, _IOFBF, 4096);
>
> -       if (inetd_mode && (detach || group_name || user_name))
> -               die("--detach, --user and --group are incompatible with --inetd");
> +       if ((inetd_mode || systemd_mode) && (detach || group_name || user_name))
> +               die("--detach, --user and --group are incompatible with --inetd and --systemd");
> +
> +#ifdef HAVE_SYSTEMD

This #if is unnecessary since 'systemd_mode' will never become true
(1) when HAVE_SYSTEMD is not defined, thus neither of the two
following 'if' conditionals will trigger anyhow.

> +       if (systemd_mode && inetd_mode)
> +               die("--inetd is incompatible with --systemd");
> +
> +       if (systemd_mode && !sd_booted())
> +               die("--systemd passed and not invoked from systemd");
> +#endif
>         if (inetd_mode && (listen_port || (listen_addr.nr > 0)))
>                 die("--listen= and --port= are incompatible with --inetd");
> --
> 2.2.1.209.g41e5f3a
