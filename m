Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4D3511F453
	for <e@80x24.org>; Fri,  8 Feb 2019 21:40:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727424AbfBHVkk (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Feb 2019 16:40:40 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:46904 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727260AbfBHVkk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Feb 2019 16:40:40 -0500
Received: by mail-qt1-f196.google.com with SMTP id y20so5619488qtm.13
        for <git@vger.kernel.org>; Fri, 08 Feb 2019 13:40:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k0QwxyGZPRMG/HwAngtJHUUahNc9w272JLzA+h4AL3I=;
        b=W6RGSUlm+6y0r/N+yhac4P6uLLbWrmriuyQFbja/jpIcTJTl81vClVIe0VZ9H0ZiV/
         Dc+++l5MtlufSL6UBB5vroHBz/qJKCBxGFwYhTO5yqbf7qC94eWRVA1bDfP4Ry8CgLfw
         Pr5u0wRXAIZGrY0buF3dCyAm4UxDs+cuhW/VT6QDykB1Qnw2G1CZOyt7seDdBFVGFM66
         T6RHFn2jxyIFtIFiN2frsSVCGEyukb3+10zjfs3RgQsIxwp6zGLxwzL6QxTu6GvtDJRZ
         dcy7RSynAA3xdpkZ6LRlBNFPlf1PjHJtNrjX1a9Iq4LzjAp947/P2qpzmjoq9O5LpCPV
         O5JA==
X-Gm-Message-State: AHQUAua7Ythk9Gju8PP/J5uunF7lm+5Pp0czQKhapYZOiOoyY5NTdRjO
        qERU5HmQiQ+ubyqCoibDQgmjLY1TKSsPY6Ieeqy7Wal+
X-Google-Smtp-Source: AHgI3IZ2mTeDZTw8n05gvH4Ns2F/4QtosgI8SdJJLwunfkI3eVjeoecvNwE/UlWaDZ39yKKRiVZRsbc6wQ2HwrPWcMM=
X-Received: by 2002:ac8:101a:: with SMTP id z26mr18346154qti.184.1549662039633;
 Fri, 08 Feb 2019 13:40:39 -0800 (PST)
MIME-Version: 1.0
References: <CAPig+cTn2gURyQgWHZQMNf2cZ+zwFhbH1Q4iPmbwuvYjMrPZPg@mail.gmail.com>
 <20190208212221.31670-1-max@max630.net>
In-Reply-To: <20190208212221.31670-1-max@max630.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Feb 2019 16:40:28 -0500
Message-ID: <CAPig+cSNoXQQrDDXt6yN-gbYc3P4ZEiwJL1nwQWBomyLdVm_Vg@mail.gmail.com>
Subject: Re: [PATCH v2] pack-refs: fail on falsely sorted packed-refs
To:     Max Kirillov <max@max630.net>
Cc:     Git List <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 8, 2019 at 4:22 PM Max Kirillov <max@max630.net> wrote:
> If packed-refs is marked as sorted but not really sorted it causes
> very hard to comprehend misbehavior of reference resolving - a reference
> is reported as not found, though it is listed by commands which output
> the references list.
>
> As the scope of the issue is not clear, make it visible by failing
> pack-refs command - the one which would not suffer performance penalty
> to verify the sortedness - when it encounters not really sorted existing
> data.
>
> Signed-off-by: Max Kirillov <max@max630.net>
> ---
> diff --git a/refs/packed-backend.c b/refs/packed-backend.c
> @@ -1137,6 +1138,21 @@ static int write_with_updates(struct packed_ref_store *refs,
> +               if (iter)
> +               {
> +                       if (prev_ref.len &&  strcmp(prev_ref.buf, iter->refname) > 0)
> +                       {
> +                               [...]
> +                               strbuf_release(&prev_ref);
> +                               goto error;
> +                       }
> +
> +                       strbuf_init(&prev_ref, 0);
> +                       strbuf_addstr(&prev_ref, iter->refname);
> +               }

The call to strbuf_init() is leaking the allocated strbuf buffer each
time through the loop. The typical way to re-use a strbuf, and the way
you should do it here, is strbuf_reset().
