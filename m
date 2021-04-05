Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BAD7C433B4
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 095DA613B2
	for <git@archiver.kernel.org>; Mon,  5 Apr 2021 17:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233755AbhDERFz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Apr 2021 13:05:55 -0400
Received: from mail-ed1-f52.google.com ([209.85.208.52]:45661 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233360AbhDERFz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Apr 2021 13:05:55 -0400
Received: by mail-ed1-f52.google.com with SMTP id dd20so6063564edb.12
        for <git@vger.kernel.org>; Mon, 05 Apr 2021 10:05:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tTXsmm2uA8wwRe63irn69+AOww5z32Z7+QZtPAj9SjE=;
        b=qaGvyVeqyYgylMjcJsylpGq6jpSv//oqxhY/GS1Dgvnhj6TQIuD+iBvzHhTCcaVLdd
         f/S1nZ+GcvT3ZG9U17oZryxmybXgCH8NNlagjpjIUhEgBtwsVtfJLuZDvRwyfWUL1C+Z
         DS4utcJW+yNaNCTTCWvV4JmHqziY9fKQFDyzDeqI9C9qdVl99l+peqPFE06inwQIWwU/
         McyKMg254wLjFH3aqt2VSU3WlXTuff7lhFzc6dh4T6oZw7AUUIybkjme4N31Ur1UetLG
         cL8pYMBiBaTWsQOEGEIYWGXFp38vgOtOVnumbT9Lc0RhheJNUhDLKNMz/SWeiejUgkUP
         SSQQ==
X-Gm-Message-State: AOAM533C0QLh2PQEZyZ1g+X/vbzOofO9Nw4R8bbZX6/Cy20NODzaYIep
        2O7ELkGlmGpkNuaRwdNHPhfB0ck1FljkcaQETz0=
X-Google-Smtp-Source: ABdhPJwzn1NhwFMEZbPfJEDl0vi0/oYwGyRyYeVAtyTjj/hT6ZAZ9WaAfJy+JS0KDh3T/YT1f49bnihg+5irsaHBtSc=
X-Received: by 2002:a05:6402:488:: with SMTP id k8mr32440803edv.233.1617642347720;
 Mon, 05 Apr 2021 10:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
In-Reply-To: <pull.927.git.1617631280402.gitgitgadget@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 5 Apr 2021 13:05:36 -0400
Message-ID: <CAPig+cRzv3sPHpOY_ZGBu8mGp=gy6E+c9ige3-AHh2DM+YcKjw@mail.gmail.com>
Subject: Re: [PATCH] [GSOC] ref-filter: use single strbuf for all output
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Hariom Verma <hariom18599@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 5, 2021 at 10:01 AM ZheNing Hu via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> When we use `git for-each-ref`, every ref will call
> `show_ref_array_item()` and allocate its own final strbuf
> and error strbuf. Instead, we can provide two single strbuf:
> final_buf and error_buf that get reused for each output.
> [...]
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---

Was there a discussion leading up to this change? If so, it may be a
good idea to provide a link to it in the mailing list here under the
"---" line.

Some comments below...

> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
> @@ -22,6 +22,8 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
>         struct ref_format format = REF_FORMAT_INIT;
> +       struct strbuf final_buf = STRBUF_INIT;
> +       struct strbuf error_buf = STRBUF_INIT;
>
>         for (i = 0; i < maxcount; i++)
> -               show_ref_array_item(array.items[i], &format);
> +               show_ref_array_item(array.items[i], &format, &final_buf, &error_buf);
>         ref_array_clear(&array);
>         return 0;
>  }

The call to strbuf_reset() within show_ref_array_item() does not free
the memory from the strbufs, so the memory is being leaked. Therefore,
at the end of this function, you should have:

    strbuf_release(final_buf);
    strbuf_release(error_buf);

> diff --git a/builtin/tag.c b/builtin/tag.c
> @@ -39,6 +39,8 @@ static int list_tags(struct ref_filter *filter, struct ref_sorting *sorting,
>         struct ref_array array;
> +       struct strbuf final_buf = STRBUF_INIT;
> +       struct strbuf error_buf = STRBUF_INIT;
>
>         for (i = 0; i < array.nr; i++)
> -               show_ref_array_item(array.items[i], format);
> +               show_ref_array_item(array.items[i], format, &final_buf, &error_buf);
>         ref_array_clear(&array);
>         free(to_free);

Leaking `final_buf` and `error_buf`.

> diff --git a/ref-filter.c b/ref-filter.c
> @@ -2436,16 +2436,16 @@ int format_ref_array_item(struct ref_array_item *info,
>  void show_ref_array_item(struct ref_array_item *info,
> -                        const struct ref_format *format)
> +                        const struct ref_format *format,
> +                        struct strbuf *final_buf,
> +                        struct strbuf *error_buf)
>  {
> -       struct strbuf final_buf = STRBUF_INIT;
> -       struct strbuf error_buf = STRBUF_INIT;
>
> -       if (format_ref_array_item(info, format, &final_buf, &error_buf))
> -               die("%s", error_buf.buf);
> -       fwrite(final_buf.buf, 1, final_buf.len, stdout);
> -       strbuf_release(&error_buf);
> -       strbuf_release(&final_buf);
> +       if (format_ref_array_item(info, format, final_buf, error_buf))
> +               die("%s", error_buf->buf);
> +       fwrite(final_buf->buf, 1, final_buf->len, stdout);
> +       strbuf_reset(error_buf);
> +       strbuf_reset(final_buf);
>         putchar('\n');
>  }

A couple comments:

It is especially ugly that `error_buf` needs to be passed in by the
caller since it is only ever used in case of an error, at which point
the program will die() anyhow, so it's not on a critical,
speed-sensitive path. The initialization with STRBUF_INIT is
practically cost-free, so this variable could easily stay local to
this function without cost-penalty rather than forcing the caller to
pass it in. (This assumes that none of the consumers of `error_buf`
down the line insert into the buffer unnecessarily, which is probably
a reasonable assumption.)

It is an unsafe assumption to only call strbuf_reset() at the end of
the function. For this to be robust, you can't assume that the caller
has given you an empty strbuf. Instead, you must ensure it by calling
strbuf_reset() at the start. (It doesn't hurt to also call
strbuf_reset() at the end, but that is not critical to correct
operation, so could be omitted.)

> @@ -2453,9 +2453,12 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
>         struct ref_array_item *ref_item;
> +       struct strbuf final_buf = STRBUF_INIT;
> +       struct strbuf error_buf = STRBUF_INIT;
> +
>         ref_item = new_ref_array_item(name, oid);
>         ref_item->kind = ref_kind_from_refname(name);
> -       show_ref_array_item(ref_item, format);
> +       show_ref_array_item(ref_item, format, &final_buf, &error_buf);
>         free_array_item(ref_item);
>  }

Leaking `final_buf` and `error_buf`.

> diff --git a/ref-filter.h b/ref-filter.h
> @@ -120,7 +120,10 @@ int format_ref_array_item(struct ref_array_item *info,
>  /*  Print the ref using the given format and quote_style */
> -void show_ref_array_item(struct ref_array_item *info, const struct ref_format *format);
> +void show_ref_array_item(struct ref_array_item *info,
> +                        const struct ref_format *format,
> +                        struct strbuf *final_buf,
> +                        struct strbuf *error_buf);

It is not clear to the person reading this what these two new
arguments are for or what should be provided, so the comment above the
function deserves an update explaining what these arguments are for
and how to provide them. This is especially important since this is a
public function.

If this function was merely internal to some builtin command, this
sort of change for the sake of optimization might not be so bad, but
as a public function, it comes across as rather ugly. In general, we
don't necessarily want to pollute an otherwise clean API with changes
which make the API uglier merely for the sake of tiny optimizations
like this (IMHO). The extra burden placed on callers by this change,
coupled with the ugliness this introduces into the API, makes the
change seem less than desirable.

One way you might be able to mitigate the undesirableness would be to
have two versions of this function. For instance:

    /* Print the ref using the given format and quote_style */
    show_ref_array_item(...);
   /* This is like show_ref_array_item() but ... */
    show_ref_array_item_optim(...);

The comment of the second function would, of course, need to explain
that it is similar to show_ref_array_item() but more optimal because
<some reasons> and that the caller is responsible for allocating and
releasing the strbufs, and that the strbufs are used only for
temporary storage, thus the caller should not assume anything about
them.

This way, callers which don't invoke show_ref_array_item() in a tight
loop don't need to be burdened by the new arguments (and won't have to
remember to release them), and callers with a tight loop can take
advantage of the optimization with the bit of extra work of having to
declare and release the strbufs.

So, having said all that, it's not clear that the ugliness and extra
work are worth the gain. However, if it is decided that the change is
worthwhile, then the commit message probably should explain cases in
which such an optimization will be really beneficial.
