Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 756AAC433E6
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27E44235E4
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbhANCIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:08:49 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:55752 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729468AbhANCIn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 21:08:43 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9A8C810C5BF;
        Wed, 13 Jan 2021 21:08:00 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jqn63Gp7sZ6JB4oY5YZvc6ECuc8=; b=U8dMCA
        zGsj7rnzQjcw9l2Ha26djnTQF9ZI8Hlex+cIjI3jcAmMrF72S2mtf09Ll1J5nuQ8
        jUuap9x0njqUOl77ZcTynzUMuIgQiYJJy4wYA0yt1WrusXkNp+XCHpzyihvgjmBu
        34g/j01deXrw1PUj6m88Tv+XE57biRjWK9fKA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KDW0nUeTWEmfrbdVMciW5y0wlV7qv5E4
        yY5dCtkLVVr/Bm28BjxBTu6RsQcyz51f2N7n5DJRGZ9rEX8jrxCDFkLIXkw6x9Ad
        5zMHrpGMUCUnLwnDQsCrENcp4tIza/Ko+3482lShGcRb362KcZAVO4/vi1M5Zsld
        CSIRlOUHSgE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 93C1B10C5BE;
        Wed, 13 Jan 2021 21:08:00 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DD76410C5BD;
        Wed, 13 Jan 2021 21:07:57 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Haller <thaller@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: [bug] git-ls-files sometimes does not list files with pathspec
 magic ":(exclude)"
References: <e2dbe996f6a7285fe0487e34d65eccf712867547.camel@redhat.com>
Date:   Wed, 13 Jan 2021 18:07:56 -0800
In-Reply-To: <e2dbe996f6a7285fe0487e34d65eccf712867547.camel@redhat.com>
        (Thomas Haller's message of "Wed, 13 Jan 2021 18:41:28 +0100")
Message-ID: <xmqqa6tc1dab.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 523CB016-560D-11EB-85B4-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Haller <thaller@redhat.com> writes:

>       git ls-files -- src/platform/ ":(exclude)shared/n-acd"

This does look interesting.

$ git ls-files -- src/platform/ ":(exclude)shared/n-acd"
$ git ls-files -- src/platform/ ":(exclude)??????/?????"
$ git ls-files -- src/platform/ ":(exclude)??????/????"
$ git ls-files -- src/platform/ ":(exclude)??????/???"
$ git ls-files -- src/platform/ ":(exclude)??????/??"
$ git ls-files -- src/platform/ ":(exclude)??????/?"

None of the above gives any output.  And the '/' seems to be a red
herring.  None of the below (where the '/' in the exclude pathspec
is replaced with a single '?') gives any output, either.

$ git ls-files -- src/platform/ ":(exclude)????????????"
$ git ls-files -- src/platform/ ":(exclude)???????????"
$ git ls-files -- src/platform/ ":(exclude)??????????"
$ git ls-files -- src/platform/ ":(exclude)?????????"
$ git ls-files -- src/platform/ ":(exclude)????????"

But if we add one more "?" to the longuest ones, i.e.

$ git ls-files -- src/platform/ ":(exclude)?????????????"
$ git ls-files -- src/platform/ ":(exclude)shared/n-acd?"

we start seeing output.

What is curious is that the longest problematic negative pathspec,
"shared/n-acd" or "????????????", have the same length as
"src/platform" without the trailing slash.

    "shared/n-acd"
    "src/platform/"
    "????????????"

The rule IIUC is that a path must match one of the positive pathspec
and none of the negative pathspec, but it looks as if there is some
bogus optimization based on string length.

An experiment.  These ought to do the same as the first exacmple:

$ git ls-files -- src/platform/ ":(exclude)shared/n-ac[d]"
$ git ls-files -- src/platform/ ":(exclude)shared/n-[acd][acd][acd]"

but probably because of the character class [d], it seems to
defeat/bypass the broken "optimization" and gives what we expect
back.

I'll have to go back to the desk where I have a development
environment (not an end user enviornment) to dig deeper, but this is
intriguing.  I'll look more later unless somebody else beats me to
it.

Thanks for a report.
