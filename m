Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0103EC433EF
	for <git@archiver.kernel.org>; Fri, 11 Feb 2022 20:01:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353051AbiBKUBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Feb 2022 15:01:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbiBKUBA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Feb 2022 15:01:00 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B942C50
        for <git@vger.kernel.org>; Fri, 11 Feb 2022 12:00:56 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0DC2A11318F;
        Fri, 11 Feb 2022 15:00:56 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1Pw+wvLvZm+W6Xeysj9Keob+OuHYziXEJPgu/Z
        3Gllo=; b=eCFws+P4pCCs2ng0h5gT8Db6SH31jmz2HFODRiwlRT+w526VB/zYJe
        mTNZFmQcqX0iJATp97yGQwcI+2QvB+v9GMMmCYA0BD+D7D886tY4v1MX18fuFVEt
        gOU85Y+k6EsqTRrmMWcXmnsXRGWvllx02KZA+VVCNvVsqhv5adzQg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 02FE911318E;
        Fri, 11 Feb 2022 15:00:56 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.212.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F24F11318D;
        Fri, 11 Feb 2022 15:00:55 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>, paulus@ozlabs.org
Subject: Re: [PATCH v3 4/4] gitk: pass --no-graph to `git log`
References: <20220211163627.598166-1-alexhenrie24@gmail.com>
        <20220211163627.598166-4-alexhenrie24@gmail.com>
        <xmqq1r09clxl.fsf@gitster.g>
        <CAMMLpeTBstt8qo2q6r=YCEi-h-G-EkjY=d7kHKeepzTvz1gmJg@mail.gmail.com>
        <xmqq5yplb46m.fsf@gitster.g>
Date:   Fri, 11 Feb 2022 12:00:54 -0800
In-Reply-To: <xmqq5yplb46m.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        11 Feb 2022 11:20:49 -0800")
Message-ID: <xmqqwni19nrd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 528339B6-8B75-11EC-9CAB-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Alex Henrie <alexhenrie24@gmail.com> writes:
>
>> What if we make log.graph=true also require feature.experimental=true?
>
> No.  feature.experimental is to give people an opt-in opportunity
> for features that we are considering to enable by default.
>
>> The log.graph option would really be a useful feature for people who
>> use Git exclusively from the CLI without any external tools. It seems
>> that the main challenge is how to give others time to adjust.

Let me clarify the first point by stating it a bit differently.

feature.experimental is all about this:

    We have an idea for this new feature.  We made it useful, and
    also made it not to regress the end-user experience for those
    who do not need the new feature, to the best of our ability.
    But there may be use cases we failed to consider while doing
    so.  So let's ask early adopters, who may use Git in contexts
    that are very different from ours, to try testing it out in
    their daily use, to see if there are unexpected glitches.

You do not have to argue how the --graph feature may be useful for
character terminal users.  We already know it is, otherwise we
wouldn't have added it in the first place.

And arguing how --graph feature is useful does not help prove
anything, when at the issue is if it is a good idea to allow the
log.graph configuration variable to affect (unfortunate) scripts
people wrote around "git log", instead of using plumbing commands,
negatively.  We already know it will hurt to force everybody to
update their script to explicitly pass --no-graph on the command
line.  This series hasn't done any of the "not to regress to the
best of our ability" part.

If there were an agreement on the general direction to _forbid_ use
of "git log" in scripts, which would require coordinated efforts to
help people migrate over time, e.g.

 - improve plumbing by adding features that people piled only on
   "git log" without allowing plumbing users the same over time.

 - perhaps an automated way to convert scripts that use "git log" to
   instead use "git log --no-graph"

to help script writers migrate away from "git log", adding log.graph
configuration variable may become very a good idea.

But without such effort starting at the same time and gaining
consensus (or already underway), just adding such a variable to
break existing scripts would not be a good idea worth asking the
early adopters to test.  We already know it would break scripts.
