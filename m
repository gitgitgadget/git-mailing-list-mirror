Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 411DF1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 22:18:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751959AbdHCWSA (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 18:18:00 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35201 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751791AbdHCWR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 18:17:59 -0400
Received: by mail-ua0-f176.google.com with SMTP id d29so131605uai.2
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 15:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=k6Qd/nDj/Ja0igEdxWyUT+bC9iHGpiEF0B14clzXmF0=;
        b=aJYt+S9IiVtHT+LYzxkBFynzNa3aYk/7MyqN7V+AquKPFgbwv3HSneBJ5sae2Dz5xj
         qo1by6tWNCSqFAqQ5PO91fFUTIXMOUUQM9Oy8CUkebsec4H6NyJiQ3iK7vCelzWv7QmA
         J0koKYIZaZXFU6oRI07BuggZ8XBIC/VBp7lCk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=k6Qd/nDj/Ja0igEdxWyUT+bC9iHGpiEF0B14clzXmF0=;
        b=jLEBGXzOfLVLiPsX+iPImOpe/09dpi3u0cBe2k3AMIb6aO5kuwA5W6Yxn1AWsFE7Kb
         lN0jjjWAIV/d6HW7+1BSyBsFClWc4k94ANTdj+M+5NR9kUgjvmK868D7VLTIs9c89dEq
         RgHUrgtOCuMP+yuY9HIBjtsePy99s0NZn3zH9FeXUZ4LkqFUPGo0505SvaVxd3HwBWfp
         hMO04qqIpYx/9KGnax1UhPSs0IaQXjByW6NTCIezoIcxFPxt+g3waLUtvPca9EKMgrNY
         F8UsmZr2IbkbKIr1QkU6o4kJxqRBF1LV20cWUtJiIFgplYw+56DWp/czKo3ne02HasxU
         Iwbw==
X-Gm-Message-State: AIVw113IRUAVSpMjO/pSu6/q19nwnyzYtHmC1yfw9H89zKaHAwsifYif
        PYvbaiapXk1rleQk4z7qItC9E3k7jQG5
X-Received: by 10.176.75.167 with SMTP id v39mr242691uaf.11.1501798678367;
 Thu, 03 Aug 2017 15:17:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.83.7 with HTTP; Thu, 3 Aug 2017 15:17:37 -0700 (PDT)
In-Reply-To: <20170802202850.y2gja3qnpw35olty@sigill.intra.peff.net>
References: <CAJo=hJv7scc1L0_MdRkFeLAJGjYm2UkTFNOgj2e4+9Zj7KSiiQ@mail.gmail.com>
 <xmqqh8xpsq9c.fsf@gitster.mtv.corp.google.com> <20170802202850.y2gja3qnpw35olty@sigill.intra.peff.net>
From:   Shawn Pearce <spearce@spearce.org>
Date:   Thu, 3 Aug 2017 15:17:37 -0700
Message-ID: <CAJo=hJtXaDtouGU0noE0ueHJYr872OTfSt5Y9SmQ5xAA7g_CrA@mail.gmail.com>
Subject: Re: reftable [v4]: new ref storage format
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 2, 2017 at 1:28 PM, Jeff King <peff@peff.net> wrote:
> On Wed, Aug 02, 2017 at 12:50:39PM -0700, Junio C Hamano wrote:
>
>> With the traditional "packed-refs plus loose" layout, no matter how
>> many times a handful of selected busy refs are updated during the
>> day, you'd need to open at most two files to find out the current
>> value of a single ref (admittedly, the accessing of the second file,
>> after we realize that there is no loose one, would be very costly).
>> If you make a few commits on a topic branch A, then build a 100
>> commit series on top of another topic branch B, finding the current
>> value of A is still one open and read of refs/heads/A.
>>
>> With the reftable format, we'd need to open and read all 100
>> incremental transactions that touch branch B before realizing that
>> none of them talk about A, and read the next transaction file to
>> find the current value of A.  To keep this number low, we'd need
>> quite a frequent compaction.
>
> I think this is where compaction cleverness can come in.
>
> One relatively easy optimization would be to note when the most recent
> reftable contains a subset of the refs we are currently updating (and
> the obvious string-of-updates to a single ref falls under that), and do
> a "quick" compaction where we simply drop[1] that reftable in favor of
> ours. That compaction is essentially free, because we know those entries
> aren't valid anymore anyway.
>
> I'm actually not sure if this is a strict "drop", though, because of
> reflogs. If the reflog is written into the same file as the ref update,
> then you'd need to roll its entry into your new update, too. But see
> below anyway.
>
> For more complicated cases, there's some cleverness you can do with
> small on-the-fly compactions. Even if there are entries in the last few
> reftables that we're not currently updating, it's pretty cheap to roll a
> few of them up into our new reftable if it lets us drop some
> intermediate reftables. E.g., if we're writing a new reftable with a 4K
> block size but only have 100 bytes of new data, we're probably best to
> roll up a previous 500-byte reftable.
>
> That one's an obvious optimization because we know that the filesystem
> is going to make us spend 4K either way, so rounding up to that is
> generally free-ish.

Yes. I was trying to propose exactly this in the first draft of
reftable, but someone on list didn't like the idea of an update
transaction stalling to perform a compaction, so I took that text out
in later drafts.

What I had envisioned is exactly what you mention; an update of
refs/heads/B that is just going to overlay another small reftable that
also recently updated refs/heads/B should just replace that table
instead of pushing onto the stack. Or if the combined top of stack +
new table is under 4K, they should just combine together instead of
pushing a new table onto the stack.


> What's less obvious is when we should roll up a bunch of 4K tables into
> one (let's say) 32K table.  I think there's a formula for doing this
> geometrically so that the amortized cost of writing stays under a
> certain bound (linear?). But I haven't thought it through (or looked it
> up); I was hoping Shawn had already done so and could dump that wisdom
> on us.

Sorry, I haven't done that. :)


>> We can just declare that reftable format is not for desktop clients
>> but for server implementations where frequent compaction would not
>> be an annoyance to the users, but I'd wish we do not have to.
>
> Yeah, I agree we should avoid that. I would love to eventually kill off
> the loose/packed backend (or at least make it historical and read-only,
> so that a reasonable response to people complaining about its races and
> lack of atomicity is "please upgrade to reftables").

I'd also really like reftable to be useful for "desktop clients". I'd
consider it something of a design failure if the format was horribly
unsuitable in some way to that use case. I think the small compactions
during updates will be essential to supporting the typical developer's
workflow.
