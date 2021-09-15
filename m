Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE075C433F5
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:17:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9DFD5611C4
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 18:17:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbhIOSTJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 14:19:09 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61699 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230142AbhIOSTG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 14:19:06 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2458B13D798;
        Wed, 15 Sep 2021 14:17:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dKeMtPxktwe70KNqrYL9M1EAc5/bl+Cm1nxufA
        pXZ/o=; b=JnVxTIBzYKKH/hI3wiTDvZPpZdWaMcUoD8vv7GtVvreScUdQFblZg1
        PL0vdhjR3T8qacamnIghN/FjdUT8LTiBlkmZGS9beSeQ2H2Yv8mKGuQsRSBD2OwE
        Vvuz1G3+cfFFxJKxoS2pfIOB4Jv0VphzU3yJDBWpIEl6c9e9Oasj0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 1DC2313D797;
        Wed, 15 Sep 2021 14:17:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6859113D796;
        Wed, 15 Sep 2021 14:17:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Rolf Eike Beer <eb@emlix.com>
Subject: Re: data loss when doing ls-remote and piped to command
References: <6786526.72e2EbofS7@devpool47>
Date:   Wed, 15 Sep 2021 11:17:42 -0700
In-Reply-To: <6786526.72e2EbofS7@devpool47> (Rolf Eike Beer's message of "Wed,
        15 Sep 2021 14:43:10 +0200")
Message-ID: <xmqqwnnhwvnd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 38E61170-1651-11EC-AE5B-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rolf Eike Beer <eb@emlix.com> writes:

> The given repository is a clone of the vanilla kernel.
>
> /usr/bin/git --git-dir=/home/ebeer/repos/upstream/linux/.git ls-remote origin 2>&1 | less
>
> And I then see things like this:
>
> 6f38b5d6cfd43dde3058a10c68baae9cf17af912        refs/tags/v5.0-rc2
> 1c7fc5cbc33980acd13ae83d0b416db002fe95601e7f97f64b59514d936     refs/tags/v5.7-rc2^{}
> d0709bb6da2ab6d49b11643e98abdf79b1a2817f        refs/tags/v5.7-rc3

Not offering any solution, just an observation of the problem and
annotating the report.

What we see on the second line is the beginning of peeled
v5.0-rc2^{} up to the "acd13" (that is, the first 19 bytes of the
line), followed by the full line for peeled v5.7-rc2^{} (which
begins with "ae83d").  12407 bytes in between are missing, which
is even more puzzling as it is not a nice round number.

I wonder if this is "less" misconfigured and misbehaving.  Did the
user after seeing v5.7-* tags scroll back with 'b' or something?

If the output (including the 2>&1 redirection) is sent to a file and
then "cat <that-file" is invoked, does the same thing happen?  How
about "cat <that-file | less"?
