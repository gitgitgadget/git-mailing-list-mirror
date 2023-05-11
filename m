Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD404C7EE23
	for <git@archiver.kernel.org>; Thu, 11 May 2023 04:12:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbjEKEMP convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Thu, 11 May 2023 00:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEKEMN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 00:12:13 -0400
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856D91BEE
        for <git@vger.kernel.org>; Wed, 10 May 2023 21:12:12 -0700 (PDT)
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-5ed99ebe076so71920996d6.2
        for <git@vger.kernel.org>; Wed, 10 May 2023 21:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683778331; x=1686370331;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EaTNAaR25MsM7ArphwUd6at2LAxO6FLXbIqifGFo1dc=;
        b=Df/cRBp5ReBQurtaNEyufJNj2zBQJYQSrHdNPL5M1w8HrESN8iawY9WQBwPldzQXbF
         M25xWS25RFNQaz+YM6H0x4NhRp7EQfZkOkFwJ2Y06Vh1pOJibFhG4UmxVbj0bmKVkqnU
         liiB0xZhIf2mcb+VndTho9BcVGLNFmkjrUs5IBRrMw9b3Mrz1u2HBTGEoCne3F/ngmcE
         Ib0nIel4YWs9XPQLMXB+BtAdDaBOjWNfEAMAHdAzDeXqtPBbn/9Zc28Eos85rRTo/JG5
         3cmOm/J5/Ir24UTiHejgYzdGFaD7CtEVZnR3EKxhVYkBYu3ewuTKUKk8/ussaGqVq1JL
         7F3Q==
X-Gm-Message-State: AC+VfDw9qojvhiKPxvo2c3KBq9P95ItYwUit9i6qaRg6e96zvAawP+Ct
        i2zscAQoP1m0YTY8RzrMikq1PD1uBsQmUvodhk2g60Vw
X-Google-Smtp-Source: ACHHUZ43wUyNlNCYt2ngpmIrU2jnuHkvzlHzakcV0v6Y/EUJJUKpm/SemiSY0JsCxz12H/X7aoervu5H4Cxgr/tsdv8=
X-Received: by 2002:a05:6214:d68:b0:5f1:6892:7440 with SMTP id
 8-20020a0562140d6800b005f168927440mr34479156qvs.23.1683778331315; Wed, 10 May
 2023 21:12:11 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
 <pull.1164.v2.git.1648743688825.gitgitgadget@gmail.com> <xmqqk0c926zf.fsf@gitster.g>
In-Reply-To: <xmqqk0c926zf.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 11 May 2023 00:11:58 -0400
Message-ID: <CAPig+cSmwQGSmm=drVodNzL0OmfG0EFawev=PjzJ4TbKgJhHsg@mail.gmail.com>
Subject: Re: [PATCH v2] worktree: add -z option for list subcommand
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Jean=2DNo=C3=ABl_Avila?= <jn.avila@free.fr>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 31, 2022 at 4:37 PM Junio C Hamano <gitster@pobox.com> wrote:
> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > Add a -z option to be used in conjunction with --porcelain that gives
> > NUL-terminated output. As 'worktree list --porcelain' does not quote
> > worktree paths this enables it to handle worktree paths that contain
> > newlines.
> >
> > Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> > ---
> >     worktree: add -z option for list subcommand
> >
> >     Thanks to Eric, Jean-Noël and Junio for their comments on V1. I've
> >     reworded the docs and option help and tweaked the tests as suggested by
> >     Eric, fixed the error messages as suggested by Eric/Jean-Noël and
> >     changed the implementation to use write_name_quoted() as suggested by
> >     Junio. I've punted doing anything about quoting the output without -z
> >     for now, I'll fix that with and without --porcelain in another series.
>
> Thanks for an update.  Will queue.  I think this iteration is good
> to merge to 'next', but let's wait for a few days to see what others
> think.

Agreed. I think this version addresses my review comments on earlier
rounds and seems to be in good shape.

(Sorry for the late response.)
