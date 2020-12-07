Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDDA1C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 21:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82020238EC
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 21:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726164AbgLGVDd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Dec 2020 16:03:33 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53593 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgLGVDd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Dec 2020 16:03:33 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8BABB11D8AB;
        Mon,  7 Dec 2020 16:02:51 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WLUIjxdY8GDEUywJQRIYHZSwLYY=; b=WobCO8
        7XbNFZsVSVKxfqohOJHl58iVjsLO4TUIP2aW5MjkhMeK+zhFiW0bpVOOg2rCnWw3
        tuqcmsoVBFLosRLI9keLHRyIcJnTzoSrt+6HPCxC+0ceA8pvMD84E5C/tiHcQMjQ
        +58e98ZfpY3EMgj50vvKKmG6urvb4VJIqsTsk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Jmmx11Cp1Y2Ag9gDCrMTDNlY4vnbjs6q
        T+a4DhdWXoORJOTEHXLf+Epdb1EjC5jq1hmRmkYxtQ3KZJGkqYLyYu09cTCJg01W
        zuhd/fcQhqzbejmlhAxpmVNls9ZmtbVX00GCD5qB2Rtgt3n4RXpwqGIpOlkc0tLM
        PpYrtOIem7s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 83F8611D8AA;
        Mon,  7 Dec 2020 16:02:51 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C78CE11D8A9;
        Mon,  7 Dec 2020 16:02:48 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     Peter Kaestle <peter.kaestle@nokia.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.us>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH v2] submodules: fix of regression on fetching of
 non-init subsub-repo
References: <CAPig+cQ8VC2q4nuzgM9QxmddH4cMezbZdRZDxX1PqfW6XKcC_A@mail.gmail.com>
        <1607348819-61355-1-git-send-email-peter.kaestle@nokia.com>
        <xmqq360hbev1.fsf@gitster.c.googlers.com>
        <BF6B37E9-5AF9-4A81-90D8-0270D1269332@gmail.com>
Date:   Mon, 07 Dec 2020 13:02:46 -0800
In-Reply-To: <BF6B37E9-5AF9-4A81-90D8-0270D1269332@gmail.com> (Philippe
        Blain's message of "Mon, 7 Dec 2020 15:44:06 -0500")
Message-ID: <xmqqsg8h8h3d.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8FE2BF06-38CF-11EB-A19E-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philippe Blain <levraiphilippeblain@gmail.com> writes:

>>> +test_expect_success 'fetching a superproject containing an uninitialized sub/sub project' '
>>> +	# depends on previous test for setup
>>> +
>>> +	git -C B/ fetch &&
>>> +	compare_refs_in_dir A origin/master B origin/master
>> 
>> Can we do this without relying on the name of the default branch?
>> Perhaps when outer, middle and inner are prepared, they can be
>> forced to be on the 'sample' (not 'master' nor 'main') branch, or
>> something like that?
>
> Or, simpler, we could call "git remote set-head -a' 
> in A and B in the setup script, which would make
> origin/HEAD in A and B point to the default branch, 
> such that the call here could be :

The set-up prepares A and B by cloning from elsewhere, no?  Should
we even need a set-head call?

> compare_refs_in_dir A origin/HEAD B origin/HEAD

Yes, using HEAD would be another simple way to avoid having to rely
on the default behaviour.

THanks.
