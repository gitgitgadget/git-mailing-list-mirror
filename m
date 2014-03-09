From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 28/28] count-objects: report unused files in $GIT_DIR/repos/...
Date: Sun, 9 Mar 2014 04:21:38 -0400
Message-ID: <CAPig+cQpzYo_VzJfjMCevYm4__bHPSaFLNZSv2MFMA3ondJoSQ@mail.gmail.com>
References: <1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1394246900-31535-1-git-send-email-pclouds@gmail.com>
	<1394246900-31535-29-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 09 09:21:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WMYzR-0002iV-6F
	for gcvg-git-2@plane.gmane.org; Sun, 09 Mar 2014 09:21:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752570AbaCIIVk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 9 Mar 2014 04:21:40 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:56318 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752367AbaCIIVi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Mar 2014 04:21:38 -0400
Received: by mail-yk0-f173.google.com with SMTP id 10so15833006ykt.4
        for <git@vger.kernel.org>; Sun, 09 Mar 2014 00:21:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=raGgcIFlV1m1CJXUAQ4xh7F1nZDaohCGyEdm1lRgdAE=;
        b=B/oNaOQfkOFw4VEGwDnMNMIZMiXn0knbEKiEXEnGuAzig1S00Jib5CKpmaPAiLCPdT
         XsAEvYhIrV58Cu2FuuAf656vy9DVlTjflarK3WhPYbXLnTuSlNgKCF0lo+LfhNjVYnjO
         Ct+44qv9v+oVWX4ODh8FHIVab+M57JwzC8HpKYtHkloI74x/C+sHjOz8fv+f3FFTT0pm
         JhWPyu374UXqbKKS75bjRWxN0vLKoZ+ZAq67iXu+coJK1itjdcB73GLGnJIoF1yw5+YP
         jmblppGhAgB1CKyN9mXNtIf5YjBDf/C71zl9ARCGjepP6HvL0e7k5DINKpswKmMJ6jNH
         qNbw==
X-Received: by 10.236.198.197 with SMTP id v45mr6304669yhn.87.1394353298244;
 Sun, 09 Mar 2014 00:21:38 -0800 (PST)
Received: by 10.170.180.134 with HTTP; Sun, 9 Mar 2014 00:21:38 -0800 (PST)
In-Reply-To: <1394246900-31535-29-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: uFfvWuLDt_IqaUM0mWi71LXNBVE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243694>

On Fri, Mar 7, 2014 at 9:48 PM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> In linked checkouts, borrowed parts like config is taken from
> $GIT_COMMON_DIR. $GIT_DIR/config is never used. Report them as
> garbage.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/path.c b/path.c
> index ddb5962..5a7dc45 100644
> --- a/path.c
> +++ b/path.c
> @@ -4,6 +4,7 @@
>  #include "cache.h"
>  #include "strbuf.h"
>  #include "string-list.h"
> +#include "dir.h"
>
>  static int get_st_mode_bits(const char *path, int *mode)
>  {
> @@ -91,9 +92,9 @@ static void replace_dir(struct strbuf *buf, int len=
, const char *newdir)
>  }

Do you want to add a comment here explaining what the "!" prefix on
some entries means, or is it sufficiently self-evident to anyone
looking at the consumers of this array?

>  static const char *common_list[] =3D {
> -       "/branches", "/hooks", "/info", "/logs", "/lost-found", "/mod=
ules",
> +       "/branches", "/hooks", "/info", "!/logs", "/lost-found", "/mo=
dules",
>         "/objects", "/refs", "/remotes", "/repos", "/rr-cache", "/svn=
",
> -       "config", "gc.pid", "packed-refs", "shallow",
> +       "config", "!gc.pid", "packed-refs", "shallow",
>         NULL
>  };
>
> @@ -107,6 +108,8 @@ static void update_common_dir(struct strbuf *buf,=
 int git_dir_len)
>         for (p =3D common_list; *p; p++) {
>                 const char *path =3D *p;
>                 int is_dir =3D 0;
> +               if (*path =3D=3D '!')
> +                       path++;
>                 if (*path =3D=3D '/') {
>                         path++;
>                         is_dir =3D 1;
> @@ -122,6 +125,28 @@ static void update_common_dir(struct strbuf *buf=
, int git_dir_len)
>         }
>  }
>
> +void report_linked_checkout_garbage(void)
> +{
> +       struct strbuf sb =3D STRBUF_INIT;
> +       const char **p;
> +       int len;
> +
> +       if (!git_common_dir_env)
> +               return;
> +       strbuf_addf(&sb, "%s/", get_git_dir());
> +       len =3D sb.len;
> +       for (p =3D common_list; *p; p++) {
> +               const char *path =3D *p;
> +               if (*path =3D=3D '!')
> +                       continue;
> +               strbuf_setlen(&sb, len);
> +               strbuf_addstr(&sb, path);
> +               if (file_exists(sb.buf))
> +                       report_garbage("unused in linked checkout", s=
b.buf);
> +       }
> +       strbuf_release(&sb);
> +}
> +
>  static void adjust_git_path(struct strbuf *buf, int git_dir_len)
>  {
>         const char *base =3D buf->buf + git_dir_len;
> --
> 1.9.0.40.gaa8c3ea
