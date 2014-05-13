From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 5/8] read-cache: try index data from shared memory
Date: Tue, 13 May 2014 14:13:49 +0200
Message-ID: <CABPQNSa+QyKjhG=355aCVoPj_U09TU6Ep9djHD0kXX62od2zhA@mail.gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com> <1399979737-8577-8-git-send-email-pclouds@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 14:14:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkBbX-0002SI-1K
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 14:14:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbaEMMOc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 08:14:32 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:44084 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759665AbaEMMOa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2014 08:14:30 -0400
Received: by mail-ig0-f177.google.com with SMTP id l13so285911iga.10
        for <git@vger.kernel.org>; Tue, 13 May 2014 05:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=4gUAWlWfJhA/d5rcYuvjBmr1rDB7plETCp9+mxaFQ44=;
        b=bEy98K7QBSFap30LmPRwQehPnoJxRp3yhnFQMajEA8blpsIMU1tcR3HexVKFOKB/2L
         okGYZTpt+7HRaKVajGQHvEGtWZ9t547XeYVsxVhEmQ1Tm/ur5J95bpEDukCJF8SZix4j
         Y9fzlHR/o/KA/pDu7sZDtNxY9Wj+eKJ2umXV6ksGIGG31ueGQvTWYguVGlLFkBIkRkS0
         YEkXzmq6KPirJkgGnuDmHknM5RAkHHe87eebsXbCXAZC1wHuzFMGAQ8LJiI+bHZLNnK6
         hb6hbL9wUid8B9Yzxkl8uMLchDg/omA13ngxyq3NNGq8GSYe47JD4tLCDXKzjUE/Ctmz
         548g==
X-Received: by 10.50.153.11 with SMTP id vc11mr5855497igb.24.1399983270053;
 Tue, 13 May 2014 05:14:30 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 13 May 2014 05:13:49 -0700 (PDT)
In-Reply-To: <1399979737-8577-8-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248777>

On Tue, May 13, 2014 at 1:15 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Documentation/config.txt |  4 ++++
>  cache.h                  |  1 +
>  config.c                 | 12 ++++++++++++
>  environment.c            |  1 +
>  read-cache.c             | 43 ++++++++++++++++++++++++++++++++++++++=
+++++
>  submodule.c              |  1 +
>  6 files changed, 62 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d8b6cc9..ccbe00b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -617,6 +617,10 @@ relatively high IO latencies.  With this set to =
'true', Git will do the
>  index comparison to the filesystem data in parallel, allowing
>  overlapping IO's.
>
> +core.useReadCacheDaemon::
> +       Use `git read-cache--daemon` to speed up index reading. See
> +       linkgit:git-read-cache--daemon for more information.
> +
>  core.createObject::
>         You can set this to 'link', in which case a hardlink followed=
 by
>         a delete of the source are used to make sure that object crea=
tion
> diff --git a/cache.h b/cache.h
> index d0ff11c..fb29c7e 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -603,6 +603,7 @@ extern size_t packed_git_limit;
>  extern size_t delta_base_cache_limit;
>  extern unsigned long big_file_threshold;
>  extern unsigned long pack_size_limit_cfg;
> +extern int use_read_cache_daemon;
>
>  /*
>   * Do replace refs need to be checked this run?  This variable is
> diff --git a/config.c b/config.c
> index a30cb5c..5c832ad 100644
> --- a/config.c
> +++ b/config.c
> @@ -874,6 +874,18 @@ static int git_default_core_config(const char *v=
ar, const char *value)
>                 return 0;
>         }
>
> +#ifdef HAVE_SHM
> +       /*
> +        * Currently git-read-cache--daemon is only built when
> +        * HAVE_SHM is set. Ignore user settings if HAVE_SHM is not
> +        * defined.
> +        */
> +       if (!strcmp(var, "core.usereadcachedaemon")) {
> +               use_read_cache_daemon =3D git_config_bool(var, value)=
;
> +               return 0;
> +       }
> +#endif
> +
>         /* Add other config variables here and to Documentation/confi=
g.txt. */
>         return 0;
>  }
> diff --git a/environment.c b/environment.c
> index 5c4815d..b76a414 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -63,6 +63,7 @@ int merge_log_config =3D -1;
>  int precomposed_unicode =3D -1; /* see probe_utf8_pathname_compositi=
on() */
>  struct startup_info *startup_info;
>  unsigned long pack_size_limit_cfg;
> +int use_read_cache_daemon;
>
>  /*
>   * The character that begins a commented line in user-editable file
> diff --git a/read-cache.c b/read-cache.c
> index a5031f3..0e46523 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1462,6 +1462,48 @@ static struct cache_entry *create_from_disk(st=
ruct ondisk_cache_entry *ondisk,
>         return ce;
>  }
>
> +static void *try_shm(void *mmap, size_t *mmap_size)
> +{
> +       struct strbuf sb =3D STRBUF_INIT;
> +       size_t old_size =3D *mmap_size;
> +       void *new_mmap;
> +       struct stat st;
> +       int fd;
> +
> +       if (old_size <=3D 20 || !use_read_cache_daemon)
> +               return mmap;
> +
> +       strbuf_addf(&sb, "/git-index-%s.lock",
> +                   sha1_to_hex((unsigned char *)mmap + old_size - 20=
));
> +       fd =3D shm_open(sb.buf, O_RDONLY, 0777);

OK, so *here* you do an unguarded use of shm_open, but the code never
gets executed because of the HAVE_SHM guard in
git_default_core_config. Perhaps not introduce the compatibility shim
until this patch, then?
