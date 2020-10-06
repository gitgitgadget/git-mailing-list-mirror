Return-Path: <SRS0=+hCi=DN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C714C4363D
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 20:41:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1028A20659
	for <git@archiver.kernel.org>; Tue,  6 Oct 2020 20:41:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vS0BH0SP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgJFUlt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Oct 2020 16:41:49 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:63126 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbgJFUlt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Oct 2020 16:41:49 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id D555AE8142;
        Tue,  6 Oct 2020 16:41:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GAIeBL/0tAv3wxV9YuZShIF0r1A=; b=vS0BH0
        SPN+SzT0SO5i4/fQ4N1u3Kzihj8kbYYVDEuPXA5Xu/wvY9wzwAJs4ihEiJExSMYW
        Lz9R6EE7ROZhsCuUWr3B4SlkYO2tXDuINmiu4gfeO0FAGW9jSnxb9LLDXt2K8kTJ
        16Hbgmy3jPqItMvVRZX52BecgvQ+VRHjbISRo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Gx9+5z8f2Fsi8af1nl3je0dRlImEfot6
        L7vsk4R0qhKUxUCbH9+ZaxL1yRAaLyX1bcUZiMZzweiak8/6xCaVw+4FhNRbtPjA
        bZHX9e6JGsTtIpoUcvQI0HddmBYnnWHFnQDcCW/TDdY2Kdk89LRq1aKlv6oe1BhX
        VgSo5wttc4A=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CE610E8141;
        Tue,  6 Oct 2020 16:41:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0272AE8140;
        Tue,  6 Oct 2020 16:41:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 0/8] forbidding symlinked .gitattributes and .gitignore
References: <20201005071751.GA2290770@coredump.intra.peff.net>
        <20201005121609.GA2907272@coredump.intra.peff.net>
Date:   Tue, 06 Oct 2020 13:41:43 -0700
In-Reply-To: <20201005121609.GA2907272@coredump.intra.peff.net> (Jeff King's
        message of "Mon, 5 Oct 2020 08:16:09 -0400")
Message-ID: <xmqq1rib5bp4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 58FC1F0A-0814-11EB-AF1B-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Oct 05, 2020 at 03:17:51AM -0400, Jeff King wrote:
>
>> About 2 years ago as part of a security release we made it illegal to
>> have a symlinked .gitmodules file (refusing it both in the index and via
>> fsck). At the time we discussed (on the security list) outlawing
>> symlinks for other .git files in the same way, but we decided not to do
>> so as part of the security release, as it wasn't strictly necessary.
>> 
>> We publicly revisited the topic in:
>> 
>>   https://lore.kernel.org/git/20190114230902.GG162110@google.com/
>> 
>> but there were a few fixes needed, and it got forgotten. So here it is
>> again, with those fixes:
>> [...]
>
> And here's a v2 incorporating feedback from Jonathan. There are no
> substantial changes in the code. Most of the fixes are cosmetic, but the
> tests are beefed up a bit, as well:
>
>  - we now test that ntfs and hfs names are matched via fsck and
>    verify_path() for all file types. The bulk of this is in a new patch
>    5, and the final patches are adjusted to use the new helper.
>
>  - we confirm that read-tree doesn't write the forbidden entry into the
>    index (in addition to seeing that it complains)
>
>  - the test script name is now "bad-dotgitx" instead of the vague
>    "bad-meta-files"
>
>  - whitespace, typo-fixes, clarity, etc; the range diff is below

Thanks for a pleasant read.  Will queue.

