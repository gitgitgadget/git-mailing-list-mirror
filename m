Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74AEC388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:34:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53BF020728
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="i5qYdT1f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732542AbgKEVe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:34:26 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51709 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732046AbgKEVe0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:34:26 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B36ADF9FFE;
        Thu,  5 Nov 2020 16:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b9KkMQGuznSsUYUEIoD+vpyys+Q=; b=i5qYdT
        1fFXYJDlYyS6cXLGVEDZ7MGZwVN0FMZNEQanFpnOvV7fv4/BW4lbofpJYWKxT9rd
        TBKWIideI4a/l0B0/Z+1TeuY7ELDCIY3iG2b1mcehaxkH3HG7XAh0gXl+hkTk4yP
        4Dp6zN7nHpSirpzJSAr2RwKzFfL8N4XHzwIp4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c0kxFh1p/TOQNju6Ecsdd5GX6hqtrSbe
        Xp8cr+3oDUhBmoIODc/gmVbbvYxGPr1w5uN2lA6swMa4bQJT6JjXzyWPT288t34T
        ZK5w5v8HvW3/px+qe0zLhg8hBBB/n8FXIbrkSfZN8PRhrWm+Ry9rUNPeIRvWlodj
        gYEP+yLlyuw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC58AF9FFD;
        Thu,  5 Nov 2020 16:34:24 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 048D9F9FFB;
        Thu,  5 Nov 2020 16:34:21 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] update-ref: Allow creation of multiple transactions
References: <cover.1604501265.git.ps@pks.im>
        <eec7c2e8ec3e49b34066190d59fc45276bed637f.1604501265.git.ps@pks.im>
        <20201105192901.GA121650@coredump.intra.peff.net>
Date:   Thu, 05 Nov 2020 13:34:20 -0800
In-Reply-To: <20201105192901.GA121650@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 5 Nov 2020 14:29:01 -0500")
Message-ID: <xmqqa6vvij37.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB1AC956-1FAE-11EB-949C-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> +test_expect_success 'transaction can create and delete' '
>> +	cat >stdin <<-EOF &&
>> +	start
>> +	create refs/heads/create-and-delete $A
>> +	commit
>> +	start
>> +	delete refs/heads/create-and-delete $A
>> +	commit
>> +	EOF
>> +	git update-ref --stdin <stdin >actual &&
>> +	printf "%s: ok\n" start commit start commit >expect &&
>> +	test_path_is_missing .git/refs/heads/create-and-delete
>> +'
>
> The tests all look quite reasonable to me. Touching .git/refs like this
> is a bit gross (and something we may have to deal with if we introduce
> reftables, etc). But it's pretty pervasive in this file, so matching
> the existing style is the best option for now.


Shouldn't "git show-ref --verify" be usable portably across ref backends
to test if a well-formed ref was created (or was not created)?

On the ref-creation side, there are cases where we need to directly
futz with the filesystem entity.  For example, "git update-ref"
cannot be used to place a non-commit at "refs/heads/foo", so
something like

	git rev-parse HEAD^{tree} >.git/refs/heads/bad-branch

cannot be avoided (this is a tangent but we probably should add a
way to force setting _any_ value to any ref, that may not even point
at an existing object or an object of a wrong type, to help test
scripts).

But I do not think this is such a case.
