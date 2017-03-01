Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19BE32027B
	for <e@80x24.org>; Wed,  1 Mar 2017 18:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752882AbdCASXU (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 13:23:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62776 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752761AbdCASXF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 13:23:05 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10EA075D77;
        Wed,  1 Mar 2017 13:20:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F09VzyqCy70EhZ0JQ/eC+geKmic=; b=rcC4pk
        vh7yCpeWpXyEkJHnkWfl0Oxk1NQ0NNinVOLs8XAdWqaaUvVfG55DWA8H4tKl8ZKN
        RIfAv8/5E/v9WeUkL+8u9eS7u530tg3338fP/yvCoPqz9QB82/s10rKUq2UqTMKN
        Ejh0dd/JyROBckszLc5mZiujQmzY4l+W2gFOw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=v727VfL7HFOB+XZQR7mBEiyRSVqapROh
        ZF+D9H+oRPDjwR6WoeTDADYKDIhKdQbdnROr+wkAwjv+Ux6e+WbIT9ohX2ulQM4d
        fEtZWG69c749CmoBHIR+4WE+eIMCDDpbbfvW8tUp3n/ckCictAVuAABKMjzWpQCz
        b/u1F0bppY8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 07EAB75D76;
        Wed,  1 Mar 2017 13:20:16 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5FF1575D75;
        Wed,  1 Mar 2017 13:20:15 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/6] Introduce a new "printf format" for timestamps
References: <cover.1488231002.git.johannes.schindelin@gmx.de>
        <f4ff525dda1964dd0e7cef1d0507e1f2403469e1.1488231002.git.johannes.schindelin@gmx.de>
Date:   Wed, 01 Mar 2017 10:20:14 -0800
In-Reply-To: <f4ff525dda1964dd0e7cef1d0507e1f2403469e1.1488231002.git.johannes.schindelin@gmx.de>
        (Johannes Schindelin's message of "Mon, 27 Feb 2017 22:31:31 +0100
        (CET)")
Message-ID: <xmqqbmtkhna9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B79238FE-FEAB-11E6-B1F7-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> So let's introduce the pseudo format "PRItime" (currently simply being
> "lu") so that it is easy later on to change the data type to time_t.

The problem being solved is a good thing to solve, and 

> -	printf("author-time %lu\n", ci.author_time);
> +	printf("author-time %"PRItime"\n", ci.author_time);

is one of the two ingredients to the solution for this line.  But
the final form would require casting ci.author_time to the type
expected by %PRItime format specifier.  With this change alone, you
could define PRItime to expect an winder type in the next step but
that would be a bad conversion.  IOW, changing only the format
without introducing an explicit cast appears to invite future
mistakes.

It would be better to introduce the timestamp_t we discussed earlier
before (or at) this step, and typedef it to ulong first, and then in
this step, change the above to

	printf("author-time %"PRItime"\n", (timestamp_t)ci.author_time);

to keep them in sync.  And at a later step in the series, you can
update definition of PRItime and timestamp_t to make them wider at
the same time, and the changes in this patch like the above line
would not need to be touched again.


