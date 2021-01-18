Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3A3C433E0
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 02:14:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2BF7224DF
	for <git@archiver.kernel.org>; Mon, 18 Jan 2021 02:14:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731092AbhARCLB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 21:11:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53679 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730934AbhARCKc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 21:10:32 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9080E10B2A6;
        Sun, 17 Jan 2021 21:09:48 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+vHsl2h1D0WQsFIPqKaxuCiZRXI=; b=BOwtnn
        +tmA5adYYj5Qx486HNvf48oJ8RcylYA+RJdq6JGofH3uwr0RRpNoNISiHtD3V0sR
        S74UlAOe2TIHvOnaeIRIy/plcvMq7jl3Osiq9w10p6x6XXNO/8zaZiBZh/y+nnh3
        7bbWGfK1aPNh8Z8bRxu23Dn8mNR6CPdBvJaSk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FpjcKQqsmUfTBBSgPNWGomQGkdF95R9J
        mkjEBP286QzZNiNsFd6RQcVITSvbTyethlz0Oyb270YxSoymtr51y22bT3kyQfIK
        usSN0LsV3Ud60soPyuovkLyTYymW2t4M1EqqUJpNkKUzBcZ6PalPMUSCcMHzYfQ0
        lkDCkQejz+4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 88F5810B2A5;
        Sun, 17 Jan 2021 21:09:48 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id CBCC510B2A4;
        Sun, 17 Jan 2021 21:09:45 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kyle Marek <kmarek@pdinc.us>
Cc:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH 2/2] revision: implement --show-linear-break for --graph
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
        <20210117110337.429994-1-kmarek@pdinc.us>
        <20210117110337.429994-3-kmarek@pdinc.us>
        <xmqqsg6zkwa8.fsf@gitster.c.googlers.com>
Date:   Sun, 17 Jan 2021 18:09:44 -0800
In-Reply-To: <xmqqsg6zkwa8.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 17 Jan 2021 14:56:15 -0800")
Message-ID: <xmqq35yzknbr.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3C385DB0-5932-11EB-9CED-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> In other words, revs->break_revision_mark is left NULL unless
> --show-linear-break is given.
>
>> @@ -4192,8 +4192,8 @@ const char *get_revision_mark(const struct rev_info *revs, const struct commit *
>>  		else
>>  			return ">";
>>  	} else if (revs->graph) {
>> -		if (!commit->parents)
>> -			return "#";
>> +		if (revs->break_revision_mark && !commit->parents)
>> +			return revs->break_revision_mark;
>
> And that causes this to break.  Now "--graph" alone won't show '#'
> for the root commits, despite that is what [1/2] wanted to do.
>
> Here is a fix-up, plus some minimum tests.  

Having said all that, I do not mind if the new markings were
activated only when --show-linear-break option (or a separate new
option) is given.  But if that is where we want to go, your [1/2]
that uses the new markings unconditionally is a regression.

A better organization, if we wanted to have multiple and smaller
steps than a single whole thing, would be:

 [1/2] Introduce a new "--mark-root-commits" option, or abuse the
       existing "--show-linear-break" option, and change "*<>"
       marking used for commits to "#LR" (or whatever appropriate)
       when the option is in effect.  Document the behaviour and add
       tests.

 [2/2] Introduce "--show-linear-break=<custom-value>" option.
       Document the behaviour and add tests.

If you apply [1/2] and [2/2] with the earlier fixes I sent, you'll
see many fallouts from existing tests, as the representation of the
root commit is changed unconditionally.  We view breakages of tests
as a rough estimate of how badly end-user scripts could break, and
the picture was not very pretty.  And that is why I am suggesting
the above "only do the new markings when asked, not unconditionally"
approach.

I still am skeptical that spending 3 more letters to denote roots is
worth it, though.

Thanks.
