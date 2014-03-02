From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 01/27] path.c: make get_pathname() return strbuf
 instead of static buffer
Date: Sun, 2 Mar 2014 14:51:35 -0500
Message-ID: <CAPig+cQubZByK3rNPOJy8rfLZpALpW0dOMz55gnFWRPppTAApg@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-1-git-send-email-pclouds@gmail.com>
	<1393675983-3232-2-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 02 20:51:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKCQH-0003HZ-OK
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 20:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751874AbaCBTvg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Mar 2014 14:51:36 -0500
Received: from mail-yh0-f47.google.com ([209.85.213.47]:46953 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751701AbaCBTvf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Mar 2014 14:51:35 -0500
Received: by mail-yh0-f47.google.com with SMTP id c41so2807681yho.20
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 11:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=PMl4Woe8zP79FPW0WHwzWaWjAWRnWFUQD9boWtzoL6M=;
        b=QapNPDLs2prLLIqrlLGTclbDdRallTirMrnItrJkR/wJAKndTh96cWfuWOiQqARelX
         gVYvWE66/cXVH2KO4TODj3NRMAM01cfkkgFAI25D4F6dKUVqjhOY+UUosYsCNiSAOmM4
         xkTh5i/jykGR4Xpv/xvN0lqB/XoZNZgFWoM67od1ls8LMRd9I1ia6NkPneewfFqNDKEs
         FNQ6MkNj78OjjEzS36CnTijl8WDHZwdUYT6Jrs2pGtWyt85bCje8DGHlJpwoVbR4l5/Z
         2VqCSZIF/kNDWvE9xNzgiMKpFiLwRkFELF3UHKQJ+cmmJ+4Ie/PTmUyoetRwBzNJf+Vq
         HF6g==
X-Received: by 10.236.36.16 with SMTP id v16mr35476yha.153.1393789895256; Sun,
 02 Mar 2014 11:51:35 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 2 Mar 2014 11:51:35 -0800 (PST)
In-Reply-To: <1393675983-3232-2-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: EyhTDUurt5fA_uz-e1EE-0YNTRU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243158>

On Sat, Mar 1, 2014 at 7:12 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> We've been avoiding PATH_MAX whenever possible. This patch makes
> get_pathname() return a strbuf and updates the callers to take
> advantage of this. The code is simplified as we no longer need to
> worry about buffer overflow.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/path.c b/path.c
> index 24594c4..5346700 100644
> --- a/path.c
> +++ b/path.c
> @@ -49,85 +60,70 @@ char *mksnpath(char *buf, size_t n, const char *f=
mt, ...)
>         return cleanup_path(buf);
>  }
>
> -static char *vsnpath(char *buf, size_t n, const char *fmt, va_list a=
rgs)
> +static void vsnpath(struct strbuf *buf, const char *fmt, va_list arg=
s)
>  {
>         const char *git_dir =3D get_git_dir();
> -       size_t len;
> -
> -       len =3D strlen(git_dir);
> -       if (n < len + 1)
> -               goto bad;
> -       memcpy(buf, git_dir, len);
> -       if (len && !is_dir_sep(git_dir[len-1]))
> -               buf[len++] =3D '/';
> -       len +=3D vsnprintf(buf + len, n - len, fmt, args);
> -       if (len >=3D n)
> -               goto bad;
> -       return cleanup_path(buf);
> -bad:
> -       strlcpy(buf, bad_path, n);
> -       return buf;
> +       strbuf_addstr(buf, git_dir);
> +       if (buf->len && !is_dir_sep(buf->buf[buf->len - 1]))
> +               strbuf_addch(buf, '/');
> +       strbuf_vaddf(buf, fmt, args);
> +       strbuf_cleanup_path(buf);
>  }

There's a slight semantic change here. The old code overwrote 'buf',
but the new code appends to 'buf'. For someone familiar with
sprintf(), or typical va_list or variadic functions there may be an
intuitive expectation that 'buf' will be overwritten. Should this code
be doing strbuf_reset() as its first action (or should that be the
responsibility of the caller who is reusing 'buff')?

>  char *mkpath(const char *fmt, ...)
>  {
>         va_list args;
> -       unsigned len;
> -       char *pathname =3D get_pathname();
> -
> +       struct strbuf *pathname =3D get_pathname();
>         va_start(args, fmt);
> -       len =3D vsnprintf(pathname, PATH_MAX, fmt, args);
> +       strbuf_vaddf(pathname, fmt, args);
>         va_end(args);
> -       if (len >=3D PATH_MAX)
> -               return bad_path;
> -       return cleanup_path(pathname);
> +       return cleanup_path(pathname->buf);
>  }

Prior to this change, it was possible (though probably not
recommended) for a caller to append gunk to the returned path up to
PATH_MAX without worrying about stomping memory. With the change, this
is no longer true. Should the function be changed to return 'const
char *' to enforce this restriction?

>  char *git_path(const char *fmt, ...)
>  {
> -       char *pathname =3D get_pathname();
> +       struct strbuf *pathname =3D get_pathname();
>         va_list args;
> -       char *ret;
> -
>         va_start(args, fmt);
> -       ret =3D vsnpath(pathname, PATH_MAX, fmt, args);
> +       vsnpath(pathname, fmt, args);
>         va_end(args);
> -       return ret;
> +       return pathname->buf;
>  }

Ditto.

>
>  void home_config_paths(char **global, char **xdg, char *file)
> @@ -158,41 +154,27 @@ void home_config_paths(char **global, char **xd=
g, char *file)
>
>  char *git_path_submodule(const char *path, const char *fmt, ...)
>  {
> -       char *pathname =3D get_pathname();
> -       struct strbuf buf =3D STRBUF_INIT;
> +       struct strbuf *buf =3D get_pathname();
> ...
> +       strbuf_cleanup_path(buf);
> +       return buf->buf;
>  }

And here?

>
>  int validate_headref(const char *path)
> --
> 1.9.0.40.gaa8c3ea
