Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DF0C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 07:04:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D487230F9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 07:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbhAGHEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 02:04:35 -0500
Received: from mail-ej1-f48.google.com ([209.85.218.48]:36117 "EHLO
        mail-ej1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725306AbhAGHEf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 02:04:35 -0500
Received: by mail-ej1-f48.google.com with SMTP id lt17so8371664ejb.3
        for <git@vger.kernel.org>; Wed, 06 Jan 2021 23:04:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wFt3jMg/SduBJZqleV+kNuMVIxVPLZS0KLAmaYNJUQM=;
        b=uEQW8o3og4qbrBKcsMgqCQ7hGj/FaVrZOLWi+21QzT/W+mite0HnKnpslXwhlaYqu8
         v3Qlhk69V4PnTkuK0Kg+C+lqFJkOb5VKAlmodUzWcV3QFsC9xiX+OmVgrDED/QSFLYPP
         a3dkbRvVRtM7rUTfqosXjlBwapHk6SI05Da6PKkKWbi6rtRFgruD4pjir3/xVs/tFJXY
         Ds2ZgXA/8znPC6k6TYeWfT1VXvWu+wwnDNbarul+76cEOC+JcJgDRlKgo15IyAIeCInS
         0cH0xO3yFONu+k6yWArMJnJFKqnjAjq+ZDEjJNrJopQDdb2MdGL7YFwkEG4iQBaUYfn6
         k1IQ==
X-Gm-Message-State: AOAM533Z7oF+MpOanC53wMPlDHm36nuEMqCUVyoiebp2fgdqMJkzSGys
        wq7+FIwVAd6d7Z48DmS4Hj0uMgVsGs0KQoCIEKI=
X-Google-Smtp-Source: ABdhPJwW7lS116/1bI+3ejls63aaRzZzhBigW440lch9Rg7pVoeISP9F9H4HDNBOVzH+fFSYiSgCGCLZJx1hqfWc5Ac=
X-Received: by 2002:a17:906:d0c1:: with SMTP id bq1mr5188620ejb.202.1610003032204;
 Wed, 06 Jan 2021 23:03:52 -0800 (PST)
MIME-Version: 1.0
References: <20210105064502.725307-1-adlternative@gmail.com> <20210105064502.725307-2-adlternative@gmail.com>
In-Reply-To: <20210105064502.725307-2-adlternative@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 7 Jan 2021 02:03:41 -0500
Message-ID: <CAPig+cQL=b-nF6nADaWueJaDmxCgmZbUwWj6=dAwYQ=vVrkifg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 1/1] strbuf.c/h: add the constant version
 initialization method of strbuf
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 5, 2021 at 1:46 AM ZheNing Hu <adlternative@gmail.com> wrote:
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>

Please write a commit message which (at least briefly) explains why
this change is useful.

> diff --git a/strbuf.c b/strbuf.c
> @@ -58,17 +58,32 @@ void strbuf_init(struct strbuf *sb, size_t hint)
> +void strbuf_const_to_no_const(struct strbuf *sb)
> +{
> +       if (sb->len && !sb->alloc) {
> +               char *new_buf = xstrdup(sb->buf);

strbuf is allowed to contain '\0' characters, so this call to
xstrdup() will not allocate the correct amount of memory if there is
an embedded '\0'

> +               int len = sb->len;
> +               strbuf_init(sb, sb->len);
> +               sb->buf = new_buf;
> +               sb->len = len;
> +               sb->buf[sb->len] = '\0';
> +       }
> +}

This function can probably be simplified to:

    void strbuf_const_to_no_const(struct strbuf *sb)
    {
        if (sb->len && !sb->alloc) {
            const char *v = sb->buf;
            size_t n = sb->len;
            strbuf_init(sb, n);
            strbuf_add(sb, v, n);
        }
    }

>  void strbuf_release(struct strbuf *sb)
>  {
>         if (sb->alloc) {
>                 free(sb->buf);
>                 strbuf_init(sb, 0);
> -       }
> +       }else if(sb->len)
> +               strbuf_init(sb, 0);
>  }

I think this can be simplified to:

    void strbuf_release(struct strbuf *sb)
    {
        if (sb->alloc)
            free(sb->buf);
        if (sb->len)
            strbuf_init(sb, 0);
    }

But it's probably okay to simplify it even further:

    void strbuf_release(struct strbuf *sb)
    {
        if (sb->alloc)
            free(sb->buf);
        strbuf_init(sb, 0);
    }

>  char *strbuf_detach(struct strbuf *sb, size_t *sz)
>  {
>         char *res;
> +       if (sb->len && !sb->alloc)
> +               die("you should not use detach in a const_strbuf");

I can't think of a good reason to enforce this harsh restriction. This
patch updates all the other destructive functions so they work
correctly with a buffer which was initialized from a constant string,
so this function should be able to do the same. For instance, I
believe the following would work instead:

    if (sb->len && !sb->alloc)
        strbuf_const_to_no_const(sb);

>         strbuf_grow(sb, 0);

In fact, since you changed strbuf_grow() to convert the buffer from
const to non-const, then you should be able to remove the above
conditional and die() altogether.

> @@ -89,7 +104,9 @@ void strbuf_attach(struct strbuf *sb, void *buf, size_t len, size_t alloc)
>  void strbuf_grow(struct strbuf *sb, size_t extra)
>  {
> -       int new_buf = !sb->alloc;
> +       int new_buf;
> +       strbuf_const_to_no_const(sb);
> +       new_buf = !sb->alloc;
> diff --git a/strbuf.h b/strbuf.h
> @@ -72,6 +72,13 @@ struct strbuf {
>  extern char strbuf_slopbuf[];
>  #define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }
> +#define STRBUF_INIT_CONST(str)  { .alloc = 0, .len = strlen(str), .buf = str }

There is a fundamental problem here. If the programmer writes:

    static struct strbuf x = STRBUF_INIT_CONST("");

then both `len` and `alloc` will be zero, so the conditional you use elsewhere:

    if (sb->len && !sb->alloc)

will not be able to detect that `buf` is pointing at a constant
string. You _may_ be able to work around this problem like this:

    if (!sb->alloc && (sb->len || sb->buf != strbuf_slopbuf))

to accurately detect a strbuf initialized with a constant string (but
I haven't tested this). Or, it might be possible to simplify it
further to:

    if (!sb->alloc && sb->buf != strbuf_slopbuf)

It would be a good idea to add a new (private) function which
encapsulates the complex condition so that it doesn't have to be
repeated all over the place. Perhaps:

    static int is_const(struct strbuf *sb) {
        return !sb->alloc && sb->buf != strbuf_slopbuf;
    }

or something.

> +/*
> + *  Through this function, we can turn a constant buffer into a non-constant buffer
> + */
> +void strbuf_const_to_no_const(struct strbuf *sb);

"constant" strbufs are an implementation detail which we probably
wouldn't want to publish as part of the public API. Unfortunately,
this function is needed by inline strbuf_setlen(), which is why you
added it to the header. Even so, because this is an implementation
detail, we may want to warn people against calling this function.
Perhaps like this:

    /* private -- do not call */
    void strbuf_const_to_no_const(struct strbuf *sb);

> @@ -159,6 +166,7 @@ void strbuf_grow(struct strbuf *sb, size_t amount);
>  static inline void strbuf_setlen(struct strbuf *sb, size_t len)
>  {
> +       strbuf_const_to_no_const(sb);
>         if (len > (sb->alloc ? sb->alloc - 1 : 0))
>                 die("BUG: strbuf_setlen() beyond buffer");
>         sb->len = len;

In [1], Dscho suggested that if the requested `len` is zero, then it
could treat that case specially by setting `buf` to `strbuf_slopbuf`
rather than going through the wasteful work of calling
strbuf_const_to_no_const(). Doing so may require moving the suggested
is_const() to the header, as well, so:

    /* private -- do not call */
    int strbuf_is_const(struct strbuf *sb);

[1]: https://public-inbox.org/git/nycvar.QRO.7.76.6.1806210857520.11870@tvgsbejvaqbjf.bet/
