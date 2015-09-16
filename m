From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 29/67] use strip_suffix and xstrfmt to replace suffix
Date: Wed, 16 Sep 2015 00:38:12 -0400
Message-ID: <CAPig+cRefYKBOLJMsu+yAp7D=GYh4Pr5eXEeHXR0b-4hhOfxPQ@mail.gmail.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915154714.GC29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 06:38:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zc4U6-0007zz-7L
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 06:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751935AbbIPEiO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 00:38:14 -0400
Received: from mail-vk0-f44.google.com ([209.85.213.44]:33774 "EHLO
	mail-vk0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751850AbbIPEiN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 00:38:13 -0400
Received: by vkgd64 with SMTP id d64so93827598vkg.0
        for <git@vger.kernel.org>; Tue, 15 Sep 2015 21:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=2zL5xaxiavy6nlcOo85udaYbt+ne6KKXvZ5uYpNI8Ck=;
        b=KBJ0g95qrRTYHLdmTdegsb8vQ02rqqtVcr03QTIz2QRpCErqetK0910pQg5V6r8hx4
         FEuQmZXK3o37hEIgnzBfhtukZXz46pTJMmuG/x0JHBZVqRkL+Qg54JxQ7Itog6r9Th2R
         0DngDBecdOzQzH9tuYw4XnkmZElXNlqw0W4Y+TyHspM0F0GY3lgL7RTYpp5gy8mh2vvH
         bjAfSzK2fMs6imBbEkkSylOpMlHWWbGijnmguhq+txNtAFxgvIirHTUjf7PgIujeWdEA
         HD3UgKim01voPs2AJ2rRA6llt4vmneWWEKx5Gj/FXE5aKfmbK7vAfnVuoM6z8q23oUmc
         32cQ==
X-Received: by 10.31.151.84 with SMTP id z81mr14822454vkd.14.1442378292364;
 Tue, 15 Sep 2015 21:38:12 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Tue, 15 Sep 2015 21:38:12 -0700 (PDT)
In-Reply-To: <20150915154714.GC29753@sigill.intra.peff.net>
X-Google-Sender-Auth: LJQ7db6wmA-fSWzoItsh8enLv20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278001>

On Tue, Sep 15, 2015 at 11:47 AM, Jeff King <peff@peff.net> wrote:
> When we want to convert "foo.pack" to "foo.idx", we do it by
> duplicating the original string and then munging the bytes
> in place. Let's use strip_suffix and xstrfmt instead, which
> has several advantages:
>
>   1. It's more clear what the intent is.
>
>   2. It does not implicitly rely on the fact that
>      strlen(".idx") <= strlen(".pack") to avoid an overflow.
>
>   3. We communicate the assumption that the input file ends
>      with ".pack" (and get a run-time check that this is so).
>
>   4. We drop calls to strcpy, which makes auditing the code
>      base easier.
>
> Likewise, we can do this to convert ".pack" to ".bitmap",
> avoiding some manual memory computation.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/http.c b/http.c
> index 7b02259..e0ff876 100644
> --- a/http.c
> +++ b/http.c
> @@ -1511,6 +1511,7 @@ int finish_http_pack_request(struct http_pack_request *preq)
>         struct packed_git **lst;
>         struct packed_git *p = preq->target;
>         char *tmp_idx;
> +       size_t len;
>         struct child_process ip = CHILD_PROCESS_INIT;
>         const char *ip_argv[8];
>
> @@ -1524,9 +1525,9 @@ int finish_http_pack_request(struct http_pack_request *preq)
>                 lst = &((*lst)->next);
>         *lst = (*lst)->next;
>
> -       tmp_idx = xstrdup(preq->tmpfile);
> -       strcpy(tmp_idx + strlen(tmp_idx) - strlen(".pack.temp"),
> -              ".idx.temp");
> +       if (!strip_suffix(preq->tmpfile, ".pack.temp", &len))
> +               die("BUG: pack tmpfile does not end in .pack.temp?");
> +       tmp_idx = xstrfmt("%.*s.idx.temp", (int)len, preq->tmpfile);

These instances of repeated replacement code may argue in favor of a
general purpose replace_suffix() function:

    char *replace_suffix(const char *s, const char *old, const char *new)
    {
        size_t n;
        if (!strip_suffix(s, old, &n))
            die("BUG: '%s' does not end with '%s', s, old);
        return xstrfmt("%.*s%s", (int)n, s, new);
    }

or something.

>         ip_argv[0] = "index-pack";
>         ip_argv[1] = "-o";
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 637770a..7dfcb34 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -252,16 +252,11 @@ static int load_bitmap_entries_v1(struct bitmap_index *index)
>
>  static char *pack_bitmap_filename(struct packed_git *p)
>  {
> -       char *idx_name;
> -       int len;
> -
> -       len = strlen(p->pack_name) - strlen(".pack");
> -       idx_name = xmalloc(len + strlen(".bitmap") + 1);
> -
> -       memcpy(idx_name, p->pack_name, len);
> -       memcpy(idx_name + len, ".bitmap", strlen(".bitmap") + 1);
> +       size_t len;
>
> -       return idx_name;
> +       if (!strip_suffix(p->pack_name, ".pack", &len))
> +               die("BUG: pack_name does not end in .pack");
> +       return xstrfmt("%.*s.bitmap", (int)len, p->pack_name);
>  }
>
>  static int open_pack_bitmap_1(struct packed_git *packfile)
> diff --git a/sha1_file.c b/sha1_file.c
> index 28352a5..88996f0 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -671,13 +671,15 @@ static int check_packed_git_idx(const char *path, struct packed_git *p)
>  int open_pack_index(struct packed_git *p)
>  {
>         char *idx_name;
> +       size_t len;
>         int ret;
>
>         if (p->index_data)
>                 return 0;
>
> -       idx_name = xstrdup(p->pack_name);
> -       strcpy(idx_name + strlen(idx_name) - strlen(".pack"), ".idx");
> +       if (!strip_suffix(p->pack_name, ".pack", &len))
> +               die("BUG: pack_name does not end in .pack");
> +       idx_name = xstrfmt("%.*s.idx", (int)len, p->pack_name);
>         ret = check_packed_git_idx(idx_name, p);
>         free(idx_name);
>         return ret;
> --
> 2.6.0.rc2.408.ga2926b9
