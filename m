From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH 2/3] Add read-cache--daemon
Date: Tue, 13 May 2014 13:52:50 +0200
Message-ID: <CABPQNSaSDRhuQYey0ad6J0cXrCzrK1CYZQar5GgUM8g3JVmRSA@mail.gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com> <1399979737-8577-3-git-send-email-pclouds@gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT Mailing-list <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 13:53:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkBH5-00028h-TW
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 13:53:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754036AbaEMLxb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 13 May 2014 07:53:31 -0400
Received: from mail-ie0-f182.google.com ([209.85.223.182]:40453 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752985AbaEMLxa convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 May 2014 07:53:30 -0400
Received: by mail-ie0-f182.google.com with SMTP id tp5so174818ieb.41
        for <git@vger.kernel.org>; Tue, 13 May 2014 04:53:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=Q75/zfiplxQZYlfqEKqlpMbUr7tFDV7gUOeiw4I1WBQ=;
        b=DGSvG+WuQOvcvXicyWFGlpYVYgJemXJu4WyNx5iATvCRG8R4v4tm4bXIvgQAuYFc9w
         rXdK6blpg1xo2qmcFzFmn8bvSIc0qNhBCKiRmuMmNr5DpYk1YHMdrkrhObjfHheS0X32
         GU+8ir0wWwcA6JmDpSBXcaN6cHVr0GbrVAAlonOoKi3qqCY2/PKkdgn7wl1NThBos+ja
         cr9FizmZalMy7OWeUBmFkF84R23jT2zjO83NmPaGSVHpR83cAEAx82f0wS7taF1vUv3W
         y2QXR68Ab55AQ9za6AC/MMrDvSzybyNMMqW5TgSCNGMYsZAk9V6MfXOp8d4yU0JV52F2
         qtHg==
X-Received: by 10.50.92.98 with SMTP id cl2mr54940587igb.14.1399982010460;
 Tue, 13 May 2014 04:53:30 -0700 (PDT)
Received: by 10.64.166.135 with HTTP; Tue, 13 May 2014 04:52:50 -0700 (PDT)
In-Reply-To: <1399979737-8577-3-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248772>

On Tue, May 13, 2014 at 1:15 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> diff --git a/Makefile b/Makefile
> index 028749b..98d22de 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1502,6 +1502,12 @@ ifdef HAVE_DEV_TTY
>         BASIC_CFLAGS +=3D -DHAVE_DEV_TTY
>  endif
>
> +ifdef HAVE_SHM
> +       BASIC_CFLAGS +=3D -DHAVE_SHM
> +       EXTLIBS +=3D -lrt
> +       PROGRAM_OBJS +=3D read-cache--daemon.o
> +endif
> +

I think read-cache--daemon will fail in case of NO_UNIX_SOCKETS.

But, read-cache--daemon.c only gets compiled if we have shm_open...

> diff --git a/git-compat-util.h b/git-compat-util.h
> index f6d3a46..b2116ab 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -723,4 +723,12 @@ struct tm *git_gmtime_r(const time_t *, struct t=
m *);
>  #define gmtime_r git_gmtime_r
>  #endif
>
> +#ifndef HAVE_SHM
> +static inline int shm_open(const char *path, int flags, int mode)
> +{
> +       errno =3D ENOSYS;
> +       return -1;
> +}
> +#endif


=2E..yet, you introduce a compatibility-shim...

> diff --git a/read-cache--daemon.c b/read-cache--daemon.c
> new file mode 100644
> index 0000000..52b4067
> --- /dev/null
> +++ b/read-cache--daemon.c
> @@ -0,0 +1,167 @@
> +#include "cache.h"
> +#include "sigchain.h"
> +#include "unix-socket.h"
> +#include "split-index.h"
> +#include "pkt-line.h"
> +
> +static char *socket_path;
> +static struct strbuf shm_index =3D STRBUF_INIT;
> +static struct strbuf shm_sharedindex =3D STRBUF_INIT;
> +
> +static void cleanup_socket(void)
> +{
> +       if (socket_path)
> +               unlink(socket_path);
> +       if (shm_index.len)
> +               shm_unlink(shm_index.buf);
> +       if (shm_sharedindex.len)
> +               shm_unlink(shm_sharedindex.buf);
> +}
> +
> +static void cleanup_socket_on_signal(int sig)
> +{
> +       cleanup_socket();
> +       sigchain_pop(sig);
> +       raise(sig);
> +}
> +
> +static void share_index(struct index_state *istate, struct strbuf *s=
hm_path)
> +{
> +       struct strbuf sb =3D STRBUF_INIT;
> +       void *map;
> +       int fd;
> +
> +       strbuf_addf(&sb, "/git-index-%s", sha1_to_hex(istate->sha1));
> +       if (shm_path->len && strcmp(sb.buf, shm_path->buf)) {
> +               shm_unlink(shm_path->buf);
> +               strbuf_reset(shm_path);
> +       }
> +       fd =3D shm_open(sb.buf, O_RDWR | O_CREAT | O_TRUNC, 0700);
> +       if (fd < 0)
> +               return;

=2E..that only gets called from read-cache--daemon.c, which already onl=
y
gets compiled if we have open?
