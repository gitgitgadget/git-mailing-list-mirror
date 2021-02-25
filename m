Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 262EBC433DB
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 23:06:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F248E64EF5
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 23:06:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbhBYXGh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 18:06:37 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63738 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbhBYXGf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 18:06:35 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E0C5CB27CD;
        Thu, 25 Feb 2021 18:05:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sqrjiDj7X9lTdwKtF06vT3n3ia8=; b=hhbiZl
        smOFrh3013M19mYYr3JKEWjIZYAHXCMnBGK3U8h9zfjUq52v+Wx9orm0MLh8Nkw1
        tL5Zbbao1TuYJK151l8hSKS0jbpkGlkKnbomERy6+RR3QuscL+S7CTFSzuHsd4Ea
        JjY2oZ+2pgIC2pUWZL1aHReEBuhdoVre1s4zc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tcdeW8VP/2RmKQsYX1QH445YZ3plgssr
        mZU10hOxJNwg0hhA/gqnQGk+1XZgFxmkuCKDaE9Fb3MApv3eJNXhmALmvAtXP8bM
        ZPLdyKoaVG4qjSC5AZYwXmaDyh1za6mUC5bv/3HojzHH67aFUvhh6DO50CjxaPzd
        hqn8XHeLpOA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C29EBB27CC;
        Thu, 25 Feb 2021 18:05:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B1E4EB27CA;
        Thu, 25 Feb 2021 18:05:51 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
Subject: Re: [PATCH] convert: fail gracefully upon missing clean cmd on
 required filter
References: <b33d0dc82f5ff1fac6772e533bbf21eecfae44ed.1614277014.git.matheus.bernardino@usp.br>
Date:   Thu, 25 Feb 2021 15:05:50 -0800
In-Reply-To: <b33d0dc82f5ff1fac6772e533bbf21eecfae44ed.1614277014.git.matheus.bernardino@usp.br>
        (Matheus Tavares's message of "Thu, 25 Feb 2021 15:16:56 -0300")
Message-ID: <xmqqsg5jsq7l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 017E1D72-77BE-11EB-828D-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matheus Tavares <matheus.bernardino@usp.br> writes:

> The gitattributes documentation mentions that either the clean cmd or
> the smudge cmd can be left unspecified in a filter definition. However,
> when the filter is marked as 'required', the absence of any one of these
> two should be treated as an error. Git already fails under these
> circumstances, but not always in a pleasant way: omitting a clean cmd in
> a required filter triggers an assertion error which leaves the user with
> a quite verbose message:
>
> git: convert.c:1462: convert_to_git_filter_fd: Assertion "ca.drv->clean || ca.drv->process" failed.
>
> This assertion and the one above it are not really necessary, as the
> apply_filter() call bellow them already performs the same checks. And
> when these conditions are not met, the function returns 0, making the
> caller die() with a much nicer message. (Also note that die()-ing here
> is the right behavior as `would_convert_to_git_filter_fd() == true` is a
> precondition to use convert_to_git_filter_fd(), and the former is only
> true when the filter is required.) So remove both assertions and add two
> regression tests to make sure that git fails nicely when either the
> smudge or clean command is missing on a required filter.

Makes sense.

Will queue, thanks.
