From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH] editor: use canonicalized absolute path
Date: Mon, 29 Jul 2013 17:03:49 +0700
Message-ID: <CACsJy8CQiESBsZvRB-Gs17Jg4Lvu-gJLUckV0njeTj+EwnTrig@mail.gmail.com>
References: <1375030782-13339-1-git-send-email-artagnon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 29 12:04:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V3kJU-0003fd-2W
	for gcvg-git-2@plane.gmane.org; Mon, 29 Jul 2013 12:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752865Ab3G2KEU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 29 Jul 2013 06:04:20 -0400
Received: from mail-oa0-f44.google.com ([209.85.219.44]:34386 "EHLO
	mail-oa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752663Ab3G2KET convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 Jul 2013 06:04:19 -0400
Received: by mail-oa0-f44.google.com with SMTP id l20so9175393oag.3
        for <git@vger.kernel.org>; Mon, 29 Jul 2013 03:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=fxrKH53141ptb/+uqVTMi+b9kGefwDlyboKLNTeqlio=;
        b=o0oDcZEk1tC4Mi+SJRA9vOR0VbGodXg+g9fTCdqdK9cwYnIylhhk5xYjU6VZqGEKm5
         Zi4DXiAA2eStXZsiyfiUjZ8wx2q8QteAqlgvd8GVlWhxABKpdKrkkxFRiNmwVDYZSYjd
         a3QLjawNhVp9tc/7n7FPKdLL9rc/evCrbmtgRPgMoxe9DM3y16UDveGBS9SPkbu6hZ7g
         B2T5j4hx7vsr4q4OrzEPLKpNlibj++d53ACifIzkmBMFy/BHtEnmYy7S4XAQyy30hrPg
         FzWUh8j/uz94dsQjVYvqD0AvSUKNBxqOEaohRNgZxtcktBdqKrelbbIaSZ6zt1A9G2CF
         igSg==
X-Received: by 10.182.165.133 with SMTP id yy5mr52103644obb.89.1375092259063;
 Mon, 29 Jul 2013 03:04:19 -0700 (PDT)
Received: by 10.182.87.105 with HTTP; Mon, 29 Jul 2013 03:03:49 -0700 (PDT)
In-Reply-To: <1375030782-13339-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231280>

On Sun, Jul 28, 2013 at 11:59 PM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> By improving the relative_path() algorithm, e02ca72 (path.c: refactor
> relative_path(), not only strip prefix, 2013-06-25) uncovered a laten=
t
> bug.  While most editor applications like cat and vim handle
> non-canonicalized relative paths fine, emacs does not.  This is due t=
o a
> long-standing bug in emacs, where it refuses to resolve symlinks in t=
he
> supplied path:
>
>   #!/bin/sh
>   mkdir z z/a z/b
>   echo moodle >z/a/file
>   ln -s z/b
>   cd b
>   emacs ../a/file # fail: opens /tmp/a/file
>
> Even if emacs were to be patched to fix this bug now, we still need t=
o
> support users running older versions.

We used to have workaround for external programs, e.g. 35ce862 (pager:
Work around window resizing bug in 'less' - 2007-01-24), so I don't
think this is a problem.

> Co-authored-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
> ---
>  Urgent candidate for maint.  I wrote to emacs-devel, but nobody seem=
s
>  to be interested; the sources are horrendously unmaintainable, and
>  the project should die soon.

Hey, I don't want to throw away years of training my fingers to use
emacs. It can't die until there is a viable fork :)

> diff --git a/editor.c b/editor.c
> index 27bdecd..0abbd8d 100644
> --- a/editor.c
> +++ b/editor.c
> @@ -37,7 +37,7 @@ int launch_editor(const char *path, struct strbuf *=
buffer, const char *const *en
>                 return error("Terminal is dumb, but EDITOR unset");
>
>         if (strcmp(editor, ":")) {
> -               const char *args[] =3D { editor, path, NULL };
> +               const char *args[] =3D { editor, real_path(path), NUL=
L };
>                 struct child_process p;
>                 int ret, sig;

real_path() returns a static buffer, which could be overwritten by the
next real_path() call. I checked and I think that won't happen. So the
patch looks good.
--=20
Duy
