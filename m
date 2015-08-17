From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v11 06/13] ref-filter: add option to filter out tags,
 branches and remotes
Date: Mon, 17 Aug 2015 00:42:52 -0400
Message-ID: <CAPig+cTZvSW8ZRLFLhmQTYBwotVjMWANZy0OAZHpA79vW8GfGQ@mail.gmail.com>
References: <1439661643-16094-7-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 17 06:43:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRCGQ-0004ia-OV
	for gcvg-git-2@plane.gmane.org; Mon, 17 Aug 2015 06:43:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbbHQEmx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2015 00:42:53 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36484 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750710AbbHQEmw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2015 00:42:52 -0400
Received: by ykfw73 with SMTP id w73so62673860ykf.3
        for <git@vger.kernel.org>; Sun, 16 Aug 2015 21:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=l/tblegEQRJzCIP5oAXyrhKziayt5DR9UUhBUFugEXI=;
        b=aFVW04QCXB9bmEI83t/MKrTbPdDD9UTpeL7p64iYet+xISx9X9rOJY7b8utsSbAHB/
         UWEKtB4AlY9XPTevujV8g1K/7yQ6nk76Nxh0wKEgFig4H11o9A4CV8safZuwtwGJfWkL
         xMtGVASF3jn4l1Pn8xn8KrT0kvbw+7/aUTu6vvkdFMNB39Wc2L1WhGhudvVHE6/YbO6a
         R20RZTxP4+dXPap2qV2nCweQ97gfRf2uy1L52I+A2KCGJ5dv1XCleSJUJIcCy22EDF8f
         jpf3gXFPSjel4Bbm72JFPYYY7bzcuIV2O2NqHbOQFpaARkFiguSY8bqbNprf4xfWORbI
         OrrQ==
X-Received: by 10.13.220.132 with SMTP id f126mr57294962ywe.39.1439786572257;
 Sun, 16 Aug 2015 21:42:52 -0700 (PDT)
Received: by 10.37.208.78 with HTTP; Sun, 16 Aug 2015 21:42:52 -0700 (PDT)
In-Reply-To: <1439661643-16094-7-git-send-email-Karthik.188@gmail.com>
X-Google-Sender-Auth: S-fUh7n8OkFc_m_z9QQihHxd47c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276029>

On Sat, Aug 15, 2015 at 2:00 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
> Add a function called 'for_each_reftype_fullpath()' to refs.{c,h}
> which iterates through each ref for the given path without trimming
> the path and also accounting for broken refs, if mentioned.
>
> Add 'filter_ref_kind()' in ref-filter.c to check the kind of ref being
> handled and return the kind to 'ref_filter_handler()', where we
> discard refs which we do not need and assign the kind to needed refs.
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> diff --git a/ref-filter.c b/ref-filter.c
> index eac99d0..abcd235 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -1226,16 +1262,29 @@ int filter_refs(struct ref_array *array, struct ref_filter *filter, unsigned int
>  {
>         struct ref_filter_cbdata ref_cbdata;
>         int ret = 0;
> +       unsigned int broken = 0;
>
>         ref_cbdata.array = array;
>         ref_cbdata.filter = filter;
>
>         /*  Simple per-ref filtering */
> -       if (type & (FILTER_REFS_ALL | FILTER_REFS_INCLUDE_BROKEN))
> -               ret = for_each_rawref(ref_filter_handler, &ref_cbdata);
> -       else if (type & FILTER_REFS_ALL)
> -               ret = for_each_ref(ref_filter_handler, &ref_cbdata);
> -       else if (type)
> +       if (type & FILTER_REFS_INCLUDE_BROKEN) {
> +               type -= FILTER_REFS_INCLUDE_BROKEN;

The above is a somewhat unusual way to say the more idiomatic:

    type &= ~FILTER_REFS_INCLUDE_BROKEN;

when dealing with bit flags. Is there precedence elsewhere in the
project for choosing '-' over '~'?

> +               broken = 1;
> +       }
> +
> +       filter->kind = type;
> +       if (type == FILTER_REFS_BRANCHES)
> +               ret = for_each_reftype_fullpath(ref_filter_handler, "refs/heads/", broken, &ref_cbdata);
> +       else if (type == FILTER_REFS_REMOTES)
> +               ret = for_each_reftype_fullpath(ref_filter_handler, "refs/remotes/", broken, &ref_cbdata);
> +       else if (type == FILTER_REFS_TAGS)
> +               ret = for_each_reftype_fullpath(ref_filter_handler, "refs/tags/", broken, &ref_cbdata);
> +       else if (type & FILTER_REFS_ALL) {
> +               ret = for_each_reftype_fullpath(ref_filter_handler, "", broken, &ref_cbdata);

These cases are all the same except for the (string) second argument,
aren't they? This might be less noisy and easier to follow if you
assign the appropriate string to a variable first, and then invoke
for_each_reftype_fullpath() once with the string variable as an
argument.

> +               if (type & FILTER_REFS_DETACHED_HEAD)
> +                       head_ref(ref_filter_handler, &ref_cbdata);
> +       } else
>                 die("filter_refs: invalid type");
>
>         /*  Filters that need revision walking */
> diff --git a/ref-filter.h b/ref-filter.h
> index 144a633..64fedd3 100644
> --- a/ref-filter.h
> +++ b/ref-filter.h
> @@ -14,8 +14,14 @@
> -#define FILTER_REFS_INCLUDE_BROKEN 0x1
> -#define FILTER_REFS_ALL 0x2
> +#define FILTER_REFS_INCLUDE_BROKEN 0x0001
> +#define FILTER_REFS_TAGS           0x0002
> +#define FILTER_REFS_BRANCHES       0x0004
> +#define FILTER_REFS_REMOTES        0x0008
> +#define FILTER_REFS_OTHERS         0x0010
> +#define FILTER_REFS_ALL            (FILTER_REFS_TAGS | FILTER_REFS_BRANCHES | \
> +                                   FILTER_REFS_REMOTES | FILTER_REFS_OTHERS)
> +#define FILTER_REFS_DETACHED_HEAD  0x0020

I suppose there's some good reason that FILTER_REFS_DETACHED_HEAD is
not a member of FILTER_REFS_ALL? Perhaps add a comment explaining it?

> diff --git a/refs.c b/refs.c
> index 2db2975..0f18c34 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2145,6 +2145,13 @@ int for_each_replace_ref(each_ref_fn fn, void *cb_data)
>                                strlen(git_replace_ref_base), 0, cb_data);
>  }
>
> +int for_each_reftype_fullpath(each_ref_fn fn, char *type, unsigned int broken, void *cb_data)
> +{
> +       if (broken)
> +               broken = DO_FOR_EACH_INCLUDE_BROKEN;

It's a bit ugly and confusing to have the same variable, 'broken', act
as both a boolean input argument and as a bit flag argument to the
called function.

> +       return do_for_each_ref(&ref_cache, type, fn, 0, broken, cb_data);
> +}
> +
>  int head_ref_namespaced(each_ref_fn fn, void *cb_data)
>  {
>         struct strbuf buf = STRBUF_INIT;
