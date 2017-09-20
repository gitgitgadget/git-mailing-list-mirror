Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 669482047F
	for <e@80x24.org>; Wed, 20 Sep 2017 03:54:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751343AbdITDyS (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Sep 2017 23:54:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56429 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751283AbdITDyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Sep 2017 23:54:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4846495410;
        Tue, 19 Sep 2017 23:54:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=w2KKwRWejcJYirfOgrKRLYqynaU=; b=EoGUtY
        qETPMJ6+8co+B7o1ki8QLH9hMUGVruUvwobkyoq/tdKV9Uh4HuiVpL8Wb0p7n5uH
        fpRuP+yP+bY2bwi85e+m6gqBz8TdVU8PCca91vhKR2M6nY2M4ks3LhuhtusZ5b/D
        9M25TT5qwaTLUk46Vy2aUaVlWtbO2SoQQfGPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=RQ7sJNw9aTNiWzr9ENY5a6IluuRTYAnP
        jWn5IyYXuOZCQak4CbzBGrobkfMA4/lCC3PEDHHNzEaskz+/xhRpbJge2k/EUg+u
        mP/jK9kD/zgODtNw4Cgp2dm/W2yPMbyvh0A6GsyO0A79PBoAWN02/hkjwrxbYux+
        mIFmUNixii8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 417C59540F;
        Tue, 19 Sep 2017 23:54:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 891CF9540E;
        Tue, 19 Sep 2017 23:54:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] for_each_string_list_item(): behave correctly for empty list
References: <cb2d4d71c7c1db452b86c8076c153cabe7384e28.1505490776.git.mhagger@alum.mit.edu>
        <20170915184323.GU27425@aiede.mtv.corp.google.com>
        <b8951886-feab-a87a-9683-3c155cfa98a8@alum.mit.edu>
        <b03c7b09-853f-a2ed-f73e-7d946c90cedb@gmail.com>
        <20170920023008.GB126984@aiede.mtv.corp.google.com>
Date:   Wed, 20 Sep 2017 12:54:15 +0900
In-Reply-To: <20170920023008.GB126984@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 19 Sep 2017 19:30:08 -0700")
Message-ID: <xmqqd16mowig.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5F978EB4-9DB7-11E7-A56E-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> ...  But a quick test with gcc 4.8.4
> -O2 finds that at least this compiler does not contain such an
> optimization.  The overhead Michael Haggerty mentioned is real.

Still, I have a feeling that users of string_list wouldn't care 
the overhead of single pointer NULL-ness check.

 - apply.c collects conflicted paths and reports them with fprintf().

 - builtin/clean.c uses the function to walk the list of paths to be
   removed, and either does a human interaction (for "-i" codepath)
   or goes to the filesystem to remove things.

 - builtin/config.c uses it in get_urlmatch() in preparation for
   doing network-y things.

 - builtin/describe.c walks the list of exclude and include patterns
   to run wildmatch on the candidate reference name to filter it out.

 ...

In all of these examples, what happens for each item in the loop
seems to me far heavier than the overhead this macro adds.

So...


