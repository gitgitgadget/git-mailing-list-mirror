Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBEDC433F5
	for <git@archiver.kernel.org>; Thu, 28 Apr 2022 20:32:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350891AbiD1Ufi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Apr 2022 16:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350377AbiD1Ufe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Apr 2022 16:35:34 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D344EC0D3D
        for <git@vger.kernel.org>; Thu, 28 Apr 2022 13:32:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7885217D986;
        Thu, 28 Apr 2022 16:32:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8OZbX6QXr1uX8Wwro92Qu0hZGBIf4Tfdad8/Jv
        nQOuY=; b=bAjHyfy1LWJbs81uZnMUZ8XC7fgkrkFjkgxD9Sc1u8/mlaQGtULkp0
        basACGI+lcDwgajt3c/BibqiwoycsrpN1Dptz99uzKddo/Kzu+5j8BsakzqPk9O3
        C9X5ruWmQFDBpcTGpt0CaURUl+y+bzD+nqwSkl79GIwx6Kky92auo=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7169A17D985;
        Thu, 28 Apr 2022 16:32:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.65.128])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id F2B9117D97F;
        Thu, 28 Apr 2022 16:32:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     <rsbecker@nexbridge.com>
Cc:     =?utf-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?= <carenas@gmail.com>,
        <git@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] t: add tests for safe.directory when running
 with sudo
References: <20220428033544.68188-1-carenas@gmail.com>
        <20220428105852.94449-1-carenas@gmail.com>
        <20220428105852.94449-4-carenas@gmail.com>
        <xmqq7d79du6c.fsf@gitster.g>
        <000001d85b39$9d5cfc90$d816f5b0$@nexbridge.com>
Date:   Thu, 28 Apr 2022 13:32:12 -0700
In-Reply-To: <000001d85b39$9d5cfc90$d816f5b0$@nexbridge.com>
        (rsbecker@nexbridge.com's message of "Thu, 28 Apr 2022 15:53:12
        -0400")
Message-ID: <xmqqbkwleypf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 49AE377A-C732-11EC-88B2-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

<rsbecker@nexbridge.com> writes:

>>> +test_lazy_prereq SUDO '
>>> +	is_root sudo &&
>>> +	! sudo grep -E '^[^#].*secure_path' /etc/sudoers '
>
> /etc/sudoers is not standard although usual. This path should come
> from a knob somewhere. We can't run this test on our x86 system
> anyway - no access to root or sudo even though it is
> installed. Also, /etc/sudoers is typically secured 0600 so the
> grep will fail even if is_root passes - and I'm worried about the
> portability of is_root, which is mostly Linux.

True.

On a box I happen to be using, the grep gives me

    Defaults secure_path=/usr/sbin:/usr/bin:/sbin:/bin

and makes the prereq fail.  Which is sort-of expected, and I
understand why this check is here, but I suspect that any sane and
sensible installations would reinitialize the path to a fairly
restricted one with the mechanism, so we wouldn't be testing this on
majority of places, I am afraid.

What we really care is that we use the same PATH as the test
environment uses, including "we want to test the binary we just
built" (or "at the specified path", when GIT_TEST_INSTALLED is in
effect).  I wonder what the right way to carry $PATH and other
environment variables down to whatever "sudo" in the test runs.

    $ foo=foobla; export foo
    $ sudo sh -c set | grep foo; echo $?
    1

so resetting PATH from an environment we export, e.g.

    USE_THIS_PATH=$PATH sudo sh -c '
	PATH=$USE_THIS_PATH
	... invoke our git normally here  ...
	git status
    '

would not work X-<.  Worse yet, other environment variables such as
GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME that we set in our tests may
probably be cleared before "sudo" runs any test command, so rejecting
an installaion whose "sudo" resets PATH with the above check is probably
insufficient to give our tests a reasonable envionment to run in.

>>Overall, I like the simplicity and clarity of "do not start this test as 'root'" in the
>>previous round much better.
>>
>>But other than that, the test coverage given by this patch looks quite sensible.

So, I unfortunately have to strike the last sentence from my earlier
response.  The tests do mean well, but I doubt they would work in
the way the good intentions planned them to work.

