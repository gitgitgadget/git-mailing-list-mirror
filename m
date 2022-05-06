Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AADEC433EF
	for <git@archiver.kernel.org>; Fri,  6 May 2022 16:42:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443862AbiEFQqZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 12:46:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379152AbiEFQqY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 12:46:24 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E725360DE
        for <git@vger.kernel.org>; Fri,  6 May 2022 09:42:40 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id EA80518502D;
        Fri,  6 May 2022 12:42:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mwywzJtEtCm1i5bIN4AFN8It1kW3qXQ1TqN9fq
        I3jy0=; b=xFi1LiNTfSgpqVdXKyFiILi6q4BMGw1L/hgMXqQV9v4g75P7mS0c61
        5cPIt+qGG5ABbVZQxKZnGlhoMehlsqthdK9rtgCXZxA7MTfInCQoWgY+DtRRdbp1
        NLQv+/iGpyttceYePI91bIQWnqXoLwiuAvzvb+Epygv23suIVB7mc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E323118502C;
        Fri,  6 May 2022 12:42:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7F6CB18502B;
        Fri,  6 May 2022 12:42:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Chris Down <chris@chrisdown.name>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Christian Couder <chriscool@tuxfamily.org>, kernel-team@fb.com
Subject: Re: [PATCH v2 1/2] bisect: output state before we are ready to
 compute bisection
References: <cover.1651796862.git.chris@chrisdown.name>
        <11edd3e4dbaac7fada8a3bcd43f4bbd353087637.1651796862.git.chris@chrisdown.name>
        <YnSNWMBRZA0S8X26@nand.local>
Date:   Fri, 06 May 2022 09:42:35 -0700
In-Reply-To: <YnSNWMBRZA0S8X26@nand.local> (Taylor Blau's message of "Thu, 5
        May 2022 22:52:08 -0400")
Message-ID: <xmqqmtfuobno.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88F8F95E-CD5B-11EC-A46F-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

>> +	if (!bs.nr_good && !bs.nr_bad)
>> +		printf(_("status: waiting for both good and bad commits\n"));
>> +	else if (bs.nr_good)
>> +		printf(Q_("status: waiting for bad commit, %d good commit known\n",
>> +			  "status: waiting for bad commit, %d good commits known\n",
>> +			  bs.nr_good), bs.nr_good);
>> +	else
>> +		printf(_("status: waiting for good commit(s), bad commit known\n"));
>> +}
>
> Could or should these printf()'s be advise() calls instead?

Given that existing bisect_next_all() mesasge to give estimates come
to the standard output, I do not think so.

	/*
	 * TRANSLATORS: the last %s will be replaced with "(roughly %d
	 * steps)" translation.
	 */
	printf(Q_("Bisecting: %d revision left to test after this %s\n",
		  "Bisecting: %d revisions left to test after this %s\n",
		  nr), nr, steps_msg);

I view these new messages as merely correcting the gap we used to
have.  We should have been giving feedback to the end-user when they
did something, but instead we were giving feedback only when we did
something, which resulted in the original "Huh?" that motivated this
series.

I actually wonder if we should do s/status:/Bisecting:/ to make the
messages even more uniform, but if we were to go in that direction
in the longer term, we'd probably be downcasing "Bisecting" to match
our error/warning/info messages.

Thanks.



