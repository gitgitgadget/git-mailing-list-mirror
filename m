Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3E40C6FA83
	for <git@archiver.kernel.org>; Tue, 13 Sep 2022 00:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiIMAOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Sep 2022 20:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiIMAOm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Sep 2022 20:14:42 -0400
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7860A2707
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 17:14:39 -0700 (PDT)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3321c2a8d4cso120724557b3.5
        for <git@vger.kernel.org>; Mon, 12 Sep 2022 17:14:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=0GpaplGOLF/P1X/4Uc48h7nWRjs8pudT+vGzDWCsV84=;
        b=M8/uIGZr/n7nRJ8YFQ/mjfZqYZ/ptE8086ACA5uh+FFyZQt3ENYo1AH9UcLaaoOR9M
         pr0MUVIWCRW6z8Vp8Uc8XOPfQdaGm6rfTzuSzbz+oCWW5DpxE9uk3cH/8ZSvT8u8vV87
         oiVEVniTgPGOc7AO94ZZHzLGKfUNBTrCas5+nxhfrKFYPhfOavVCycNzhwUYmeWb08Qh
         ZNUnwwFCkcMMUMxrjHotI30mJj00yybw1dalgU1AATYr5M4DIL11NnLi5qEaLetCUNLa
         t6aTyJAqFDeodArygUNzvPPdDlIoVudsm7epI1waJD+1hZJGwUcbpjEU1g6S59BmHrzE
         b52g==
X-Gm-Message-State: ACgBeo0HL2kYBodGQGHC1dXxLtw8h+diZxYtRx8qAENTA40PPuQtBGx1
        arYNuVTTuBuu+KMCxgMhknWEYHqkpProw9wxJWM=
X-Google-Smtp-Source: AA6agR64Q6dlICGchqr75DOupWsKmPTwI1M6YXvjyWM98XLDViI+EgGcJ6hWE8M+d/CM4/I58iCQQDb/alhbtT4mVAQ=
X-Received: by 2002:a0d:fcc6:0:b0:349:7d12:7255 with SMTP id
 m189-20020a0dfcc6000000b003497d127255mr2465478ywf.427.1663028078622; Mon, 12
 Sep 2022 17:14:38 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1324.git.git.1663023888412.gitgitgadget@gmail.com> <xmqqsfkwb12i.fsf@gitster.g>
In-Reply-To: <xmqqsfkwb12i.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 12 Sep 2022 20:14:27 -0400
Message-ID: <CAPig+cTq3j5M7cz3T14h9U6e+H5PAu8JJ_Svq87W3WviwS6_qA@mail.gmail.com>
Subject: Re: [PATCH] chainlint: colorize problem annotations and test delimiters
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Eric Sunshine via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 12, 2022 at 7:55 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Eric Sunshine via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > +     $checked =~ s/(\?![^?]+\?!)/$c->{bold}$c->{red}$1$c->{reset}/mg;
>
> It may be just me, but coloring the whole "?!LOOP?!" in red feels a
> bit strange.  I would have expected more like
>
>         if ($c->{color_in_use}) {
>                 $checked =~ s/\?!([^?]+)\?!/$c->{bold}$c->{red}$1$c->{reset}/mg;
>         }
>
> IOW, switching between "?!LOOP?!" and "<BOLD><RED>LOOP<RESET>".
>
> But it may be just me.

That's possible, but I'd rather not do that for a couple reasons:

(1) Even with the coloring, I still find it handy to be able to search
for "?!" in the output in order to jump to the next problem (or to
filter to just the problem lines via, say, grep).

(2) In practice, I found that even after coloring those annotations in
red, it was still easy for the eye to glide right over them in the
output without really noticing them. Switching it to bold red helped a
bit, but my eye still glided over them sometimes. One possible reason
that the eye was able to glide over them may be because the "?!FOO?!"
annotations are very short bits of text buried in the much larger and
textually noisy test body. As such, having more characters "?!...?!"
may help capture the eye more easily than fewer characters. (In fact,
I briefly considered coloring the entire line red to combat the
eye-gliding problem but wasn't sure if that would be helpful or
hurtful.)
