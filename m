Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E7E6C2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 19:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B935C2223C
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 19:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TrT8d9A7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgKLS76 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 13:59:58 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53362 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbgKLS74 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 13:59:56 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC451F0F7E;
        Thu, 12 Nov 2020 13:59:54 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=D7M4bNxD/Y3QBgzIjqb0T8whg8Y=; b=TrT8d9
        A7c8qnAvGWH7/Uc9smP8S8dizP2AtmmUiXe2hGsF9JzMM82CreVisCYX4YZXXXQK
        8YR7Z8iKKXoC+hqPsWQqj9Tnh+acaTlqLoP1KlFNPXe/rISd0tTCkLVFBiXMAetK
        tZKaIRNGtI7WWPi3PrHWuut61+H4lFOD7GMxs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=L/o6wR8FQ/KnMco2wlM0LwMimJ2C93fw
        ynQNCFvS0j0XUA+/NE0hP57T1m6EVJ5AWPIdmkAjk8+dY+6a7UjvFzPrvTkWhxNx
        uKuOCFrH7C9HMlagiWhn5FRplo01ImY47yWP58EPu+zG9AoI9C7kCqw73rqozKhi
        FtaHxNiSMQg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4DE5F0F7D;
        Thu, 12 Nov 2020 13:59:54 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 35727F0F7C;
        Thu, 12 Nov 2020 13:59:52 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: git format-patch --range-diff bug?
References: <20201112174353.GD4270@szeder.dev>
        <xmqqk0uqjw4l.fsf@gitster.c.googlers.com>
        <CAPig+cT1zDT1iqRqO-4U8Rwq7p=MFm5Bkn990AVbxMHqp=knmg@mail.gmail.com>
Date:   Thu, 12 Nov 2020 10:59:50 -0800
In-Reply-To: <CAPig+cT1zDT1iqRqO-4U8Rwq7p=MFm5Bkn990AVbxMHqp=knmg@mail.gmail.com>
        (Eric Sunshine's message of "Thu, 12 Nov 2020 13:32:42 -0500")
Message-ID: <xmqqblg2jt95.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3EC39A56-2519-11EB-8EED-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> I haven't fully thought it through yet, but at this point, the best
> "fix" likely would be for `git format-patch --range-diff` to error out
> when it sees a 3-dot range. (Unless there is some other intuitive
> interpretation of a 3-dot range which escapes me.)

And possibly rename the option.  Giving "--range-diff=<prev>" is not
an instruction to run "git range-diff <prev>", so it is clear that
the option is misnamed.

It probably should have been "--[no-]range-diff" boolean that
controls if we add the range-diff from the previous, whose default
may be affected by the user of the "-v$n" option, plus another
option that gives where to find the "previous series", whose
presence probably trigger "--range-diff" implicitly, or something
like that.

And the option whose value we are having problem with is exactly
that "--previous-series=<prev>" option.
