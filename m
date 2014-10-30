From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 06/19] untracked cache: record/validate dir mtime and
 reuse cached output
Date: Thu, 30 Oct 2014 12:19:12 -0400
Message-ID: <CAPig+cRQPWRjCeZ6LD0pn3DRX_rZcG-modk5OGXxqoyb=kE6iw@mail.gmail.com>
References: <1414411846-4450-1-git-send-email-pclouds@gmail.com>
	<1414411846-4450-7-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 30 17:19:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XjsRW-00052q-FM
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 17:19:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759265AbaJ3QTQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 Oct 2014 12:19:16 -0400
Received: from mail-yh0-f47.google.com ([209.85.213.47]:46842 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759245AbaJ3QTN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Oct 2014 12:19:13 -0400
Received: by mail-yh0-f47.google.com with SMTP id i57so1789491yha.34
        for <git@vger.kernel.org>; Thu, 30 Oct 2014 09:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=frPhK5uyMRtv4qZrOhGTq+Vv9JE1pK/rovE0Jt3fajc=;
        b=FypUexM2GFZJnaDQqc2qsP50VXl8b3uxxOmBz64fUTvpovIvgI9svMaqVr2x/O2+Lv
         Al1rVQa0WkpjFr1rSDAnr8+KfJWBjO02h7lH+vuCxFZBLSJ4+SN4z4JiUrO8GdxU9ie0
         RT/uFcTSXR+9jr337olQc24KmxbXPKExvT9jNNdiBJutHtLxk0X14dvfmQwQLhUzoHN+
         OV41r0stvPA58x/rJhs36IeAELbvZWEKR7avg2/NnjrBLGAMqZOW6alfzmUQ6oGnj0bn
         vwIuRgFoQoH3nf4Xr4ElKh9TnqQsKwnCABhzyCtG6NIui+ZGCRFWnM0OBaDyZ2oLe02H
         V5Uw==
X-Received: by 10.236.210.114 with SMTP id t78mr3699640yho.148.1414685952807;
 Thu, 30 Oct 2014 09:19:12 -0700 (PDT)
Received: by 10.170.68.68 with HTTP; Thu, 30 Oct 2014 09:19:12 -0700 (PDT)
In-Reply-To: <1414411846-4450-7-git-send-email-pclouds@gmail.com>
X-Google-Sender-Auth: X0uVkb3tlBlMyfNGLc1wzeEbhdA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 27, 2014 at 8:10 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc =
Duy <pclouds@gmail.com> wrote:
> diff --git a/dir.c b/dir.c
> index 2793e57..55780a7 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -37,7 +37,12 @@ enum path_treatment {
> +static enum path_treatment treat_path_fast(struct dir_struct *dir,
> +                                          struct untracked_cache_dir=
 *untracked,
> +                                          struct cached_dir *cdir,
> +                                          struct strbuf *path,
> +                                          int baselen,
> +                                          const struct path_simplify=
 *simplify)
> +{
> +       if (!cdir->ucd) {
> +               strbuf_setlen(path, baselen);
> +               strbuf_addstr(path, cdir->file);
> +               return path_untracked;
> +       }
> +       strbuf_setlen(path, baseline);

Would it make sense to move the strbuf_setlen(path,baseline) above the
conditional since it is common to both cases, or are they conceptually
distinct enough that it is clearer to duplicate the function call for
each case?

> +       strbuf_addstr(path, cdir->ucd->name);
> +       /* treat_one_path() does this before it calls treat_directory=
() */
> +       if (path->buf[path->len - 1] !=3D '/')
> +               strbuf_addch(path, '/');
> +       if (cdir->ucd->check_only)
> +               /*
> +                * check_only is set as a result of treat_directory()=
 getting
> +                * to its bottom. Verify again the same set of direct=
ories
> +                * with check_only set.
> +                */
> +               return read_directory_recursive(dir, path->buf, path-=
>len,
> +
> +                                               cdir->ucd, 1, simplif=
y);

Unusual blank line placement.

> +       /*
> +        * We get path_recurse in the first run when
> +        * directory_exists_in_index() returns index_nonexistent. We
> +        * are sure that new changes in the index does not impact the
> +        * outcome. Return now.
> +        */
> +       return path_recurse;
> +}
> +
> @@ -1477,6 +1590,12 @@ static void close_cached_dir(struct cached_dir=
 *cdir)
>  {
>         if (cdir->fdir)
>                 closedir(cdir->fdir);
> +       /*
> +        * We have gone through this directory and found no untracked
> +        * entries. Mark it valid.
> +        */
> +       if (cdir->untracked && !cdir->untracked->valid)
> +               cdir->untracked->valid =3D 1;

Or, stated more simply:

   if (cdir->untracked)
        cdir->untracked->valid =3D 1;

>  }
>
>  /*
