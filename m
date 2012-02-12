From: =?GB2312?B?0Oy1zw==?= <xudifsd@gmail.com>
Subject: Re: [PATCH] strbuf: move strbuf_readline_fd() from bundle.c to strbuf.{c,h}
Date: Sun, 12 Feb 2012 20:25:15 +0800
Message-ID: <CAMocUqSefruci_ueWHUH6rqz8VFcakHErq8QV_bvghWMyHKVJg@mail.gmail.com>
References: <CAMocUqRutwERQ64a=9t36Za6Lm8KxpseS0NYbdGKWbixbsXeyw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?GB2312?B?R2l0INPKvP7B0LHt?= <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 12 13:25:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwYV5-0005k1-42
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 13:25:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303Ab2BLMZS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 12 Feb 2012 07:25:18 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35197 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226Ab2BLMZR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 12 Feb 2012 07:25:17 -0500
Received: by bkcjm19 with SMTP id jm19so3898036bkc.19
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 04:25:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=suaBw6haVBMciSIooTKhuOZIwhhp/Wwvr090mbKOXwo=;
        b=rHTQsZg5axsuAUBouLoh/e1ZsVrlrOfQG0lmYcYBl3plVbclb+Im5P9mC845NGFYsB
         eve3swQx+VOrGN1g1r67kr/L3goycybdVQAAGh92hAxbephh6IWOXfg9DCnD9sYcjAHB
         ldqzfremUBltg4898g3ODOrRG6f2dDmDLFbag=
Received: by 10.204.151.11 with SMTP id a11mr5322562bkw.134.1329049515514;
 Sun, 12 Feb 2012 04:25:15 -0800 (PST)
Received: by 10.204.130.72 with HTTP; Sun, 12 Feb 2012 04:25:15 -0800 (PST)
In-Reply-To: <CAMocUqRutwERQ64a=9t36Za6Lm8KxpseS0NYbdGKWbixbsXeyw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190567>

Shouldn't I supposed to receive any information about this patch? Has
it accepted or not? If not what wrong with this patch?

=D4=DA 2012=C4=EA2=D4=C211=C8=D5 =CF=C2=CE=E75:50=A3=AC=D0=EC=B5=CF <xu=
difsd@gmail.com> =D0=B4=B5=C0=A3=BA
> strbuf_readline_fd() existed in bundle.c since e9ee84cf, but this
> function can be used elsewhere, and since it's relevant to strbuf, it
> should be in strbuf.{c,h}.
>
> Signed-off-by: Xu Di <xudifsd@gmail.com>
> ---
>  bundle.c |   18 +-----------------
>  strbuf.c |   16 ++++++++++++++++
>  strbuf.h |    1 +
>  3 files changed, 18 insertions(+), 17 deletions(-)
>
> diff --git a/bundle.c b/bundle.c
> index b8acf3c..9344a91 100644
> --- a/bundle.c
> +++ b/bundle.c
> @@ -7,6 +7,7 @@
>  #include "list-objects.h"
>  #include "run-command.h"
>  #include "refs.h"
> +#include "strbuf.h"
>
>  static const char bundle_signature[] =3D "# v2 git bundle\n";
>
> @@ -23,23 +24,6 @@ static void add_to_ref_list(const unsigned char
> *sha1, const char *name,
>        list->nr++;
>  }
>
> -/* Eventually this should go to strbuf.[ch] */
> -static int strbuf_readline_fd(struct strbuf *sb, int fd)
> -{
> -       strbuf_reset(sb);
> -
> -       while (1) {
> -               char ch;
> -               ssize_t len =3D xread(fd, &ch, 1);
> -               if (len <=3D 0)
> -                       return len;
> -               strbuf_addch(sb, ch);
> -               if (ch =3D=3D '\n')
> -                       break;
> -       }
> -       return 0;
> -}
> -
>  static int parse_bundle_header(int fd, struct bundle_header *header,
>                               const char *report_path)
>  {
> diff --git a/strbuf.c b/strbuf.c
> index ff0b96b..7532a13 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -282,6 +282,22 @@ void strbuf_addbuf_percentquote(struct strbuf
> *dst, const struct strbuf *src)
>        }
>  }
>
> +int strbuf_readline_fd(struct strbuf *sb, int fd)
> +{
> +       strbuf_reset(sb);
> +
> +       while (1) {
> +               char ch;
> +               ssize_t len =3D xread(fd, &ch, 1);
> +               if (len <=3D 0)
> +                       return len;
> +               strbuf_addch(sb, ch);
> +               if (ch =3D=3D '\n')
> +                       break;
> +       }
> +       return 0;
> +}
> +
>  size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
>  {
>        size_t res;
> diff --git a/strbuf.h b/strbuf.h
> index fbf059f..ecebd11 100644
> --- a/strbuf.h
> +++ b/strbuf.h
> @@ -109,6 +109,7 @@ static inline void strbuf_complete_line(struct st=
rbuf *sb)
>  }
>
>  extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
> +extern int strbuf_readline_fd(struct strbuf *sb, int fd);
>  /* XXX: if read fails, any partial read is undone */
>  extern ssize_t strbuf_read(struct strbuf *, int fd, size_t hint);
>  extern int strbuf_read_file(struct strbuf *sb, const char *path, siz=
e_t hint);
> --
> 1.7.8.1.749.gb6b3b
