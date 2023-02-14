Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 737A4C05027
	for <git@archiver.kernel.org>; Tue, 14 Feb 2023 23:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbjBNXUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 18:20:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjBNXUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 18:20:16 -0500
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F1221A13
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 15:20:14 -0800 (PST)
Received: by mail-pj1-f45.google.com with SMTP id f16-20020a17090a9b1000b0023058bbd7b2so313820pjp.0
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 15:20:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zi81ZC8AofakJm77MS9R36Mm8LtlArDC0MpPZflxctU=;
        b=7Nox1cbg8oewy3lCq2HHblnFftDgHdwHIJ2TYsxwhvfVDTHNd+e6BWM5vxdinW8dTz
         cO5nuaRngWpunta5e/auKm7tsZInTnyRokwJeVthyf1v6X9aX4k0GlzNhk8w6xPlIoWY
         WRRC9lP3btWQqF2K1MO98E8ejEkP/EkhsggWro1U7Qzr3rbeTlYlUXwJ4W5y3b1QtpBy
         AarPlG3Dx1mhQI2AeExvrr7wuLs37lATmUZ3rv62cBHM06hQXPTeRSG1PzXFvuwwuW3D
         1hoBWrK5eGzUs9mY1cQiGW5tvbLLPgJQPBl2lh2C5nYU6cySj3gFHfoZ3lpnt2p/E73k
         ubOQ==
X-Gm-Message-State: AO0yUKVxkyHY3SRk+CjEUuDOgVjOuIFUOu83t7oMlY1jaIhiEESlvhDg
        MdUCdQbcZ4oTPPxuDAf1t/lfyG/LbupZU1Cxhfk=
X-Google-Smtp-Source: AK7set+m9JZ1TsOWpEMwTrsJuFQgLtwhqSwRjUTMOzeJ2ftobB21RPnIqR4Cd7I3XgTDp35R9wRbnxdwCBYVRWjkuEE=
X-Received: by 2002:a17:90a:4107:b0:234:190f:87e6 with SMTP id
 u7-20020a17090a410700b00234190f87e6mr269763pjf.8.1676416814289; Tue, 14 Feb
 2023 15:20:14 -0800 (PST)
MIME-Version: 1.0
References: <Y+vVFFCRem6t4IGM@coredump.intra.peff.net> <Y+vV8Ifkj1QV7KF0@coredump.intra.peff.net>
 <xmqqmt5f535i.fsf@gitster.g>
In-Reply-To: <xmqqmt5f535i.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 14 Feb 2023 18:20:03 -0500
Message-ID: <CAPig+cQPsrEJ3thaJ1cTkqFaKe34vmrtz_jNLHYTPkBoyMPm8g@mail.gmail.com>
Subject: Re: [PATCH 3/3] shorten_unambiguous_ref(): avoid sscanf()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?B?5a2f5a2Q5piT?= <mengziyi540841@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2023 at 4:48 PM Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
> > +     do {
> > +             if (!*rule)
> > +                     BUG("rev-parse rule did not have percent");
> > +             if (*rule == '%')
> > +                     break;
> > +     } while (*refname++ == *rule++);
>
> So, if we have refname="refs/heads/frotz" and rule="refs/%.*s", then
> we'll scan refname and rule to skip over their "refs/" prefix, and
> the next iteration, where post-increment moved the pointers to point
> at 'h' (at the beginning of "heads/frotz") on the refname side and
> '%' on the rule side, we iterate once more, notice *rule is '%', and
> break out of the loop.  We have refname="heads/frotz" and rule="%.*s"
>
> If we have refname="refsXheads/frotz" and rule="refs/%.*s", after
> skipping over "refs", refname points at 'X' while rule points at '/'
> and the loop needs to break.  Both pointers are post-incremented,
> and now we have refname="heads/frotz" and rule="%.*s".

Nice catch. I had sat staring at and worrying about the combined
comparison and post-increment, trying to come up with a failing edge
case but missed this one entirely.

This logic error missed by two people suggests that the patch probably
ought to be accompanied by some new tests.
