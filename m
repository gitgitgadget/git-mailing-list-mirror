Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39E52C433F5
	for <git@archiver.kernel.org>; Wed, 26 Jan 2022 23:36:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbiAZXgK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Jan 2022 18:36:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59801 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233890AbiAZXgE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jan 2022 18:36:04 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D8211103E76;
        Wed, 26 Jan 2022 18:36:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lRM0P9eZkzSM1etOzIaoGVlEuF3c/X8DqOV7tM
        eV3Dc=; b=CrO+zhV4pg7fVI6C/irS1gKYiqkhz7GnXi+OafmqKnM0vntR1YV8iu
        enhduIkIJIx+NiL7rnxkSOUQOis2VYiUPWb0DWoxPZ2rnf3GFyYyHHpXqxfl7Nv8
        0idZBDmQApCVnSBkeMbo6VJKaPwMzs+sayGBk8wm4PeXr1xvZM4Is=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B2DF6103E75;
        Wed, 26 Jan 2022 18:36:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 009F4103E74;
        Wed, 26 Jan 2022 18:36:02 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] diff-filter: be more careful when looking for
 negative bits
References: <pull.1127.git.1643149759.gitgitgadget@gmail.com>
        <e8006493a9ed4da9b9125865e004ba7ace20e7a4.1643149759.git.gitgitgadget@gmail.com>
        <xmqq1r0vt0y7.fsf@gitster.g> <YfHRTrdwZVwxcPBK@nand.local>
Date:   Wed, 26 Jan 2022 15:36:01 -0800
In-Reply-To: <YfHRTrdwZVwxcPBK@nand.local> (Taylor Blau's message of "Wed, 26
        Jan 2022 17:55:10 -0500")
Message-ID: <xmqqtudqnk7y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B97B0562-7F00-11EC-8AE3-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> +		int has_positive = 0;
>> +		int has_negative = 0;
>> +
>> +		for (i = 0; (optch = optarg[i]) != '\0'; i++) {
>> +			if (optch < 'a' || 'z' < optch)
>> +				has_positive++;
>> +			else
>> +				has_negative++;
>> +		}
>> +
>> +		if (!has_positive && has_negative) {
>
> (One small nit that I absolutely do not care about is using a variable
> that starts with 'has_'--which I would expect to be a boolean--to count
> the number of positive/negative filters. Perhaps calling these

These variables are indeed used in the boolean sense (see how they
are used in the condition in the "if" statement).

If we wanted to short-circuit, we could do this:

	for (i = 0;
	     !has_positive && !has_negative &&
	     (optch = optarg[i]) != '\0';
	     i++) {
		if (isupper(optch))
			has_negative++;
		else
			has_positive++;
	}

and thanks to their names, nobody would be confused to find it is a
bug that these do not count when the loop exits early.  We shouldn't
name these positive_nr or negative_nr because we are not interested
in counting them.

It is just that "bool++" is more idiomatic than repeated assignment
"bool = 1" when setter and getter both know it is merely used as a
Boolean, and that is why they named as has_X, which clearly is a
name for a Boolean, not a counter.

Having said that, I do not mind if an assignment is used instead of
post-increment in new code.  I just think it is waste of time to go
find increments that toggle a Boolean to true and changing them to
assignments, and it is even more waste having to review such a code
churn, so let's not go there ;-)

But as I wrote in the big NEEDSWORK comment, this loop should
disappear when the code is properly rewritten to correct the
interaction between two or more "--diff-filter=" options, so it
would not matter too much.

Thanks.
