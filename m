Return-Path: <SRS0=1oE7=AU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5728CC433E0
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 00:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 14D0B20775
	for <git@archiver.kernel.org>; Thu,  9 Jul 2020 00:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Mai+8vk9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgGIAOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 20:14:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56861 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgGIAOX (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 20:14:23 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 05E3A7A438;
        Wed,  8 Jul 2020 20:14:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yJTyjnQo2omOazMqX+8CN3QBgXs=; b=Mai+8v
        k977x3jK5rzqfwIox1sG7VHv70fVr206rip6lynPSyd8wfRzMYDU6rOfWVSijCu7
        vz0gWPyRLT7f9g7cx9dDbRS+Z2zo0qiYhCmzGIrGUgAvolnX8oWZ7j/1PeEFbJmv
        bXrFA+85J6WhVGKiiJR0Z26NZH0qPeHZaRIfQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=A+uEKrWtVwlNYT8nmdDV8a0+9Jw5aDY5
        sihOS9sGqrxk5KKD2FbDBECbYZ1WZfMMtXxbEVR8Hsqr1Jj5I+hIrnkL5fQDF4e8
        NeX4gAtGE7uz4p8687CGuN7ZqszqOQqkr+MN4L3gSmHneNKwFN3Ky+3j0Yo2KPst
        dxGeXl653Ng=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F04AD7A437;
        Wed,  8 Jul 2020 20:14:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 81C987A436;
        Wed,  8 Jul 2020 20:14:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 4/4] ref-filter: add support for %(contents:size)
References: <20200707174049.21714-1-chriscool@tuxfamily.org>
        <20200707174049.21714-5-chriscool@tuxfamily.org>
        <xmqqk0zf3y8s.fsf@gitster.c.googlers.com>
Date:   Wed, 08 Jul 2020 17:14:19 -0700
In-Reply-To: <xmqqk0zf3y8s.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Tue, 07 Jul 2020 12:45:39 -0700")
Message-ID: <xmqqtuyhzgro.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22B1CDF0-C179-11EA-B445-01D9BED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Of course, we _could_ update the test_atom to do something magic
> only when the 'contents' atom is being asked.  We notice that $2 is
> 'contents', do the usual test_expect_success for 'contents', and
> then measure the byte length of $3 ourselves and test
> 'contents:size'.  That way, all the above test updates would become
> unnecessary (and the last two hunks of this patch can also go).
>
> That approach may even allow you to hide the details of sanitize-pgp
> in the updated test_atom so that the actual tests may not have to get
> updated even for signed tags.

After seeing the "wc -c" portability issues, I am now even more
inclined to say that the above is the right direction.  The
portability worries can and should be encapsulated in a single
test_atom helper function, just as it can be used to hide the
differences between signed tags, annotated tags and commits.

Thanks.

>> +# We cannot use test_atom to check contents:size of signed tags due to sanitize_pgp
>> +test_tag_contents_size_pgp () {
>> +	ref="$1"
>> +	test_expect_success $PREREQ "basic atom: $ref contents:size" "
>> +		git cat-file tag $ref | tail -n +6 | wc -c >expected &&
>> +		git for-each-ref --format='%(contents:size)' $ref >actual &&
>> +		test_cmp expected actual
>> +	"
>> +}
