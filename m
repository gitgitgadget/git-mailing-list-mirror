Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C75CC4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:19:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2ECFF22C9C
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 19:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729494AbgLDTTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 14:19:38 -0500
Received: from mail-ej1-f65.google.com ([209.85.218.65]:33959 "EHLO
        mail-ej1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLDTTi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 14:19:38 -0500
Received: by mail-ej1-f65.google.com with SMTP id g20so10292302ejb.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 11:19:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UtHHGPstpkjUw/zvJihLJQXj772PQKkCbPONl3Tu3rU=;
        b=LzhL1L5Ntmo4a1eUpivnygsPZ8K/o6p89xG3jlAgqr7NDjP96nrW2AzsLS8Vvzlz/K
         K35UvPQmOhMCNzzU+gpftaYi9xqbCBYpX5/wyNYgNqmENQmkgCT58NPnU64FmJ80oSSw
         1vmxRtHqkRmeMEx3U+aEJTYvpC+kPiP7sTQypGAGOcZRFLkbV8ogRxL/neKzU5kt8I9D
         n8FsXOKGCTUfeREH3YKvsS2MjCznWepL+c9rphxhzBvGGgp8QNpsLQY84j2w4+3ZxNPj
         wDb7BX5clZoxi+x/yzRB7QHk26dPrTlsaVfaVUFs9GmpgQPNUGM40QDgBWyT1LLTMyC+
         24UQ==
X-Gm-Message-State: AOAM530/L3+0qNAh3jjZ/kPwbqshQWv7ctDnIjlPcYxU8oDCY+8OK7o7
        PxOMT9FXNyLrHMiMvTzU0dwJP6fDgETpdHHR4fQ=
X-Google-Smtp-Source: ABdhPJzJj20xI1qfLIJ3FsxgiDO1HaOtoUcSPxTwv/z1WUadSD4rKTFuLlGxASDBJbR2L9h2XTHjXJfvPyY7Wii+4FE=
X-Received: by 2002:a17:906:4944:: with SMTP id f4mr8725240ejt.231.1607109536429;
 Fri, 04 Dec 2020 11:18:56 -0800 (PST)
MIME-Version: 1.0
References: <X8qEg/KiAQDugPC0@coredump.intra.peff.net> <X8qFo+GJJTbaPV58@coredump.intra.peff.net>
In-Reply-To: <X8qFo+GJJTbaPV58@coredump.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 4 Dec 2020 14:18:45 -0500
Message-ID: <CAPig+cTLs5bkY=Pwg+4tT2KHfVHFjkrNTeS_ygGEwq0cOOJ9wQ@mail.gmail.com>
Subject: Re: [PATCH 6/9] oid-array: provide a for-loop iterator
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 4, 2020 at 1:54 PM Jeff King <peff@peff.net> wrote:
> [...]
> The caller does have to remember to sort the array first. We could add
> an assertion into the helper that array->sorted is set, but I didn't
> want to complicate what is otherwise a pretty fast code path.
> [...]
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/oid-array.h b/oid-array.h
> @@ -111,4 +113,24 @@ void oid_array_filter(struct oid_array *array,
> +/**
> + * Find the next unique oid in the array after position "cur". You
> + * can use this to iterate over unique elements, like:
> + *
> + *   size_t i;
> + *   oid_array_sort(array);
> + *   for (i = 0; i < array->nr; i = oid_array_next_unique(array, i))
> + *     printf("%s", oid_to_hex(array->oids[i]);
> + *
> + * Non-unique iteration can just increment with "i++" to visit each element.
> + */

Minor: I see that the example code sorts the array first -- which is
necessary, as explained in the commit message -- but I wonder if it is
worth calling out explicitly in the prose:

    Find the next unique oid in the array after position `cur`.
    The array must be sorted for this to work. You can use
    this to iterate over unique elements like this:

> +static inline size_t oid_array_next_unique(struct oid_array *array, size_t cur)
> +{
> +       do {
> +               cur++;
> +       } while (cur < array->nr &&
> +                oideq(array->oid + cur, array->oid + cur - 1));
> +       return cur;
> +}
