Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C03420970
	for <e@80x24.org>; Wed, 12 Apr 2017 02:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752069AbdDLCjc (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 22:39:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58008 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751605AbdDLCjb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 22:39:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5A0D710D9;
        Tue, 11 Apr 2017 22:39:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7kXQjfqi5c0wU9p0bouCjR0ft3Y=; b=rlzedc
        +i27mb+c3Z74swe5sC53bNaL2YObw9H1f7afFV13TJjMEUR9rtE2vfLw2l2MitPF
        sGN8aEDOQ/P5yVhm/sKDi4f/MBRCzTNfIDu7hAZnRX81TpWnh7lQHunaLztLucUZ
        vdIlZIAQ9MDW9KaiSGRo6e4vOEyEGC7JmKfh8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xbWyyCARKWhwakhqqtP/rOGYt1cr0oPK
        ksHMIgBwxcAwkZ+SqrQU5b4UfFcZUQWTzJJQ+PKPZFE8HUjwN3SKZuoKeOBZRQUB
        LXba12sKKW/1YVyzmsCtfIc1NAsRlzRB+zfyu3jDF6KgTtDbKAxTPgZ+PcoC+VYH
        Y7nXgaz8/z4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC1FC710D8;
        Tue, 11 Apr 2017 22:39:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B06B710D7;
        Tue, 11 Apr 2017 22:39:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH v6] http.postbuffer: allow full range of ssize_t values
References: <20170411181357.16580-1-dturner@twosigma.com>
        <20170411182740.GO8741@aiede.mtv.corp.google.com>
        <20170411194127.cfy2omkdwhbtkn63@sigill.intra.peff.net>
Date:   Tue, 11 Apr 2017 19:39:27 -0700
In-Reply-To: <20170411194127.cfy2omkdwhbtkn63@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 11 Apr 2017 15:41:27 -0400")
Message-ID: <xmqqa87mqrhc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 40653B52-1F29-11E7-9499-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> The only unresolved issue was whether we can count on curl being new
>> enough for CURLOPT_POSTFIELDSIZE_LARGE to be present.  I say
>> "unresolved" but it is resolved in my mind since git doesn't build and
>> pass tests with such old versions of curl --- what's unresolved is
>> formalizing what the oldest curl version is that we want to support.
>> And that doesn't need to hold this patch hostage.
>
> It could build on older curl with a minor fix; the regression is in
> v2.12. So if we did want to continue to support the same versions of
> curl we did in v2.11, we could apply that fix and then we _would_ care
> about #ifdef-ing this.

What would the fix be?  Have a code that notices that the value set
to http.postbuffer is too large and ignore the request on the other
side of #ifdef, i.e. when Git is built with older curl that lack
CURLOPT_POSTFIELDSIZE_LARGE?

Something like that may be prudent for the 'maint' track.  But I
tend to agree that for feature releases, we should revisit what the
oldest version we claim to support from time to time and raise the
floor when we notice nobody has even been attempting to build the
other side of the #ifdef (and during that exercise, those who do
want to have older versions supported _can_ argue against removal of
#ifdef with patch to keep both side of #ifdef working).  I fully
agree with what you said earlier that it is irresponsible to the
users to keep #ifdef that gives a false impression that we are
maintaining both sides of them, when in reality the older side has
bit-rotten without anybody even noticing.

I suspect that it is a bit too late for the next release, but we can
decide by mid May for the one after 2.13 if we waned to.

> That isn't my preferred route; just pointing out that if the "oldest
> curl" question isn't settled, that could still be relevant to this
> patch. It doesn't have to be held hostage to the fix, but we should be
> aware we are digging the hole deeper.
>
> -Peff
