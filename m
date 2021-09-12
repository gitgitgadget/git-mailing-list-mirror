Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F457C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 02:14:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 258E8611CC
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 02:14:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232492AbhILCKJ convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Sat, 11 Sep 2021 22:10:09 -0400
Received: from mail-ed1-f42.google.com ([209.85.208.42]:43882 "EHLO
        mail-ed1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231743AbhILCKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 22:10:09 -0400
Received: by mail-ed1-f42.google.com with SMTP id n10so8508570eda.10
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 19:08:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=cH1Nt6sjUknO7NYBcNVo/s44CkDYOlwVMtpFs942noo=;
        b=RN7LqsbsK1gFpFtjghmcMVLGcNuvQXaKwmjiVyhLEhpHjazXVvy/JSnUv7Qpgt8bLw
         jRudB510HIVoTve/G7vGHRTeVUdlvreqn1vIrXsKCiYpdclqiyxpF/7sDGaYlJtoZQDR
         Gns+gDxR3+6UePpQrpQDiBPoB5MHFEYMBU3qxxCPaRnUztPWfpvRZflrcOHhvLL0EBFK
         w3uxJk1kaCeLlrzQ30ygcuMOYasC/+z64Ht/DeT3Afj1RX6J5YmW8BuJTBxFTA9NrSsH
         bkqgCVHGmGXHk5iGhEQsq0xzwbTNo3rv5EZSGQPNBpUV7eR4iGBqZ6FdOh+9jI3mVA6i
         97nA==
X-Gm-Message-State: AOAM531pQdMluKJ9G60BAnmOqbUdAyoGvHSCxYVRUQdyvIvUauZItO78
        ghtpLhH6I4ZUwrK6VooPLd9Gfb4UVR8YnbfSQsA=
X-Google-Smtp-Source: ABdhPJyd1MrRCP8QU74dCj96D9GJNSXOp+bgQ2WOaRVNaBIEEDlWXo53IoeopMgR1yh9Mm4VX7XkQvQnxIeCXKaWqsw=
X-Received: by 2002:aa7:c7d0:: with SMTP id o16mr5856542eds.370.1631412534916;
 Sat, 11 Sep 2021 19:08:54 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631331139.git.me@ttaylorr.com> <2a16f11790b79ab452233b6f28acac607c0abd28.1631331139.git.me@ttaylorr.com>
 <87ee9va0ie.fsf@evledraar.gmail.com> <YTzYYfBGqG87O5mN@nand.local>
In-Reply-To: <YTzYYfBGqG87O5mN@nand.local>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sat, 11 Sep 2021 22:08:44 -0400
Message-ID: <CAPig+cRAKJyzuMwPNdmC+BobrMjk5TF-o3Ort8R0E77ij=g6_A@mail.gmail.com>
Subject: Re: [PATCH 2/8] builtin/multi-pack-index.c: support --stdin-packs mode
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 11, 2021 at 12:25 PM Taylor Blau <me@ttaylorr.com> wrote:
> On Sat, Sep 11, 2021 at 12:05:05PM +0200, Ævar Arnfjörð Bjarmason wrote:
> > Before calling string_list_clear(). I.e. we didn't strdup(), but during
> > free() we pretend that we did, because we did, just not in
> > string_list_append().
>
> Good catch. It's kind of gross, but the result is:
>
>  static void read_packs_from_stdin(struct string_list *to)
>  {
> -       struct strbuf buf = STRBUF_INIT;
> +       struct strbuf buf = STRBUF_INIT_NODUP;
>         while (strbuf_getline(&buf, stdin) != EOF) {
>                 string_list_append(to, strbuf_detach(&buf, NULL));
>         }
> @@ -107,6 +107,11 @@ static int cmd_multi_pack_index_write(int argc, const char **argv)
>                 ret = write_midx_file_only(opts.object_dir, &packs,
>                                            opts.preferred_pack, opts.flags);
>
> +               /*
> +                * pretend strings are duplicated to free the memory allocated
> +                * by read_packs_from_stdin()
> +                */
> +               packs.strdup_strings = 1;
>                 string_list_clear(&packs, 0);

An alternative is to do this:

    struct strbuf buf = STRBUF_INIT;
    ...
    while (...) {
        string_list_append_nodup(to, strbuf_detach(&buf, NULL));
        ...
    }
    ...
    string_list_clear(&packs, 0);

That is, use string_list_append_nodup(), which is documented as
existing precisely for this sort of use-case:

    Like string_list_append(), except string is never copied.  When
    list->strdup_strings is set, this function can be used to hand
    ownership of a malloc()ed string to list without making an extra
    copy.

(I mention this only for completeness but don't care strongly which
approach is used.)
