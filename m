From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 8/8] read-cache: inform the daemon that the index has been updated
Date: Tue, 13 May 2014 14:17:13 +0200
Message-ID: <CABPQNSY67gNZnDf27D8xLyiLrG+g13Zau2zY0vz_XgGJfj3cKw@mail.gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com> <1399979737-8577-11-git-send-email-pclouds@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 14:18:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkBei-0007Uu-Ek
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 14:18:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760170AbaEMMR4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 08:17:56 -0400
Received: from mail-ie0-f175.google.com ([209.85.223.175]:47631 "EHLO
	mail-ie0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759395AbaEMMRy convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2014 08:17:54 -0400
Received: by mail-ie0-f175.google.com with SMTP id y20so206513ier.20
        for <git@vger.kernel.org>; Tue, 13 May 2014 05:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=T8VUYlOs9BjQ15E7WJ3BSUdamv6kMshMUzZsdFu8C0A=;
        b=Dk6sI9BKEC/2ZsM4DAkQJr1+UHLG+Q+zffOy6fh/CcukXQwPd/uU4sGlromP3unnok
         Knkut6hJnQRrJYv+io0Vyppaeqj/GvTMee+6yThZcyGVcype5njjaUStE4OicBf494eI
         gEqO15OFjRzo48+dhtUTTwHmCWCGWLXSLjKoc/7wIsoGAh3lJOwv698xGGVAYz1BZyuB
         X9MEF3VT2DY1VeTr6NPcdRDiQz4grqIkyklgNwQd7sK+W8snAArdmrReO/bS5oMlPAoP
         PAmqbSWqOCEY2ynwuiMCJnSzi+iAiOIoH6KcxunlazUXlknmSrgTndEDuuy2nXySbAd0
         gFyA==
X-Received: by 10.50.85.18 with SMTP id d18mr54147310igz.42.1399983474050;
 Tue, 13 May 2014 05:17:54 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 13 May 2014 05:17:13 -0700 (PDT)
In-Reply-To: <1399979737-8577-11-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248778>

On Tue, May 13, 2014 at 1:15 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> The daemon would immediately load the new index in memory in
> background. Next time Git needs to read the index again, everything i=
s
> ready.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  cache.h      |  1 +
>  read-cache.c | 53 ++++++++++++++++++++++++++++++++++++++++++++++++--=
---
>  2 files changed, 49 insertions(+), 5 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index fb29c7e..3115b86 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -483,6 +483,7 @@ extern int is_index_unborn(struct index_state *);
>  extern int read_index_unmerged(struct index_state *);
>  #define COMMIT_LOCK            (1 << 0)
>  #define CLOSE_LOCK             (1 << 1)
> +#define REFRESH_DAEMON         (1 << 2)
>  extern int write_locked_index(struct index_state *, struct lock_file=
 *lock, unsigned flags);
>  extern int discard_index(struct index_state *);
>  extern int unmerged_index(const struct index_state *);
> diff --git a/read-cache.c b/read-cache.c
> index e98521f..d5c9247 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -16,6 +16,9 @@
>  #include "varint.h"
>  #include "split-index.h"
>  #include "sigchain.h"
> +#include "unix-socket.h"
> +#include "pkt-line.h"
> +#include "run-command.h"
>
>  static struct cache_entry *refresh_cache_entry(struct cache_entry *c=
e,
>                                                unsigned int options);
> @@ -2030,6 +2033,32 @@ void set_alternate_index_output(const char *na=
me)
>         alternate_index_output =3D name;
>  }
>
> +static void refresh_daemon(struct index_state *istate)
> +{
> +       int fd;
> +       fd =3D unix_stream_connect(git_path("daemon/index"));
> +       if (fd < 0) {
> +               struct child_process cp;
> +               const char *av[] =3D {"read-cache--daemon", "--detach=
", NULL };
> +               memset(&cp, 0, sizeof(cp));
> +               cp.argv =3D av;
> +               cp.git_cmd =3D 1;
> +               cp.no_stdin =3D 1;
> +               if (run_command(&cp))
> +                       warning(_("failed to start read-cache--daemon=
: %s"),
> +                               strerror(errno));
> +               return;
> +       }
> +       /*
> +        * packet_write() could die() but unless this is from
> +        * update_index_if_able(), we're about to exit anyway,
> +        * probably ok to die (for now). Blocking mode is another
> +        * problem to deal with later.
> +        */
> +       packet_write(fd, "refresh");
> +       close(fd);
> +}
> +

Seems the argument 'istate' isn't used.
