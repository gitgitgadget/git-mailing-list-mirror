Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A94C0C43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 06:21:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbiGJGVb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 02:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJGV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 02:21:29 -0400
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58841EEC6
        for <git@vger.kernel.org>; Sat,  9 Jul 2022 23:21:27 -0700 (PDT)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-31caffa4a45so22256897b3.3
        for <git@vger.kernel.org>; Sat, 09 Jul 2022 23:21:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=up94bZ03J6kj4XzmHfXUUXLJgSk3yZ54Z4M74YS3m9w=;
        b=fsNVuD/QYzNGJV0LOdUpE8QR9NFgC9gKtM4Oz70zCJD10PlD8+MKBciM/PVx8KUb1X
         HfZ2ij9wR/nOGnob+K6PkNmd7DX6S1a38Rf7BRTZNJnOdUl/OA2uNLWMkeZ30QA0o0pK
         ahEL4Rpfu/0l2kX9souV2C5YeFXSCaWngnit+KhNYR93JHBufykUTxdU8XRj88oGbXQp
         WxpwhtkaS5y11W17UOwpCT2hGAjlvWUHJXXNg/Xb6UMmA+K1gaJUXGwrHuCH93tO9L/w
         /DTHox5+EvjrD12Acp1RjJvLR8/NH2JH2jBxMG9J/MMeElPyQFJOnyh2wSlJWVD/nC5P
         4lhA==
X-Gm-Message-State: AJIora/j89uXvxJkefUe+ShWnTaTj3sXTON6rtxKeA4dH5af4vMRlFOY
        5l2I7kJUJqEQE4aw4mbGDiBduBvh8xkGGHkafTs=
X-Google-Smtp-Source: AGRyM1ufDmKXgzDFw1/4yTtWrM81LHQmzZDvBd0HBoh4nPTZmF/pt5YSSgKFHm2BfYbPbYYwz3djFXlxx+/kOhYiB58=
X-Received: by 2002:a81:dd02:0:b0:317:927d:6b9d with SMTP id
 e2-20020a81dd02000000b00317927d6b9dmr13396273ywn.482.1657434087081; Sat, 09
 Jul 2022 23:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1281.git.1657202265048.gitgitgadget@gmail.com>
 <pull.1281.v2.git.1657279447515.gitgitgadget@gmail.com> <CAPig+cTX76ZMG_S-qOX_JDxYVWXRvtP2Ref4k8uM1KJaDwX9=w@mail.gmail.com>
 <xmqqwncmt3el.fsf@gitster.g> <CAPig+cScKabgrh80e5rqWX8cnNEgvxP9JyVJCu+afBOJk_yopg@mail.gmail.com>
 <xmqqilo5sel6.fsf@gitster.g>
In-Reply-To: <xmqqilo5sel6.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Sun, 10 Jul 2022 02:21:16 -0400
Message-ID: <CAPig+cSqBARuXgcr3W4_1fEb_d4srXCkW=Ur20VV2jyT9sVNkA@mail.gmail.com>
Subject: Re: [PATCH v2] gpg-interface: add function for converting trust level
 to string
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jaydeep Das via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Jaydeep Das <jaydeepjd.8914@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jul 10, 2022 at 1:48 AM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > Given the small, fixed number of trust levels, and if the list is
> > unlikely to change much in the future, I might suggest simply
> > initializing the fields at compile-time rather than on-demand at
> > run-time:
> >
> >     static struct {
> >         const char *key;
> >         const char *display_key;
> >         enum signature_trust_level value;
> >     } sigcheck_gpg_trust_level[] = {
> >         { "UNDEFINED", "undefined", TRUST_UNDEFINED },
> >         { "NEVER", "never", TRUST_NEVER },
> >         { "MARGINAL", "marginal", TRUST_MARGINAL },
> >         { "FULLY", "fully", TRUST_FULLY },
> >         { "ULTIMATE", "ultimate", TRUST_ULTIMATE },
> >     };
>
> Yup, that is even better.  I wonder if we can upcase in C
> preprocessor macro?  It would be wonderful if we can do so,
> but for just 5 entries, we can type each token three times
> just fine.

No standardized way to upcase via the C preprocessor, as far as I
know. At any rate, I suspect such a macro would be uglier and harder
to reason about than the code above, which is dead-simple to
understand.
