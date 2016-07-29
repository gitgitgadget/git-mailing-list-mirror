Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9DF01F955
	for <e@80x24.org>; Fri, 29 Jul 2016 17:47:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753187AbcG2Rrc (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 13:47:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54938 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753130AbcG2Rrb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 13:47:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F34FF2F0A3;
	Fri, 29 Jul 2016 13:47:29 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=VuMcqpErBEVHWFxJy40C+EVUQIo=; b=Nj2frI
	1erb/Ry9Rhm42ZN5DnZOW5OWMTQUf2EqnkRiJ0A2n5OXKG7b5WhoHW28VrWwLx4D
	xFmi/ytZ8TrvQ+4GUqHdMrpVQfm5FzXEINbjoJLnifr3PbOKiCHioHEbkdsgqUw0
	VAqKfBHXnhqqcpvwkKJtoIBV3u3suYiUEfca8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=FJRTSOB3FFb4z4pNHfNXeB73wHB/dtKL
	mDGZDNDCBPiIYCt8ZZP3FxJFfcjhLEi22pGtGdswumCSrPqEVUlLI0XplaT+K6xH
	6dHmW2GIBudHW+9IAh6F6AGnpJWb2q/ksch0K4UX052YaDi7Nj2aYL5jy/eCcTxb
	xI2BwUYB5cw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EB7082F0A2;
	Fri, 29 Jul 2016 13:47:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 73BBC2F0A1;
	Fri, 29 Jul 2016 13:47:29 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Dakota Hawkins <dakotahawkins@gmail.com>
Cc:	git@vger.kernel.org
Subject: Re: Issue with global config defaults "user.useConfigOnly = true" + "pull.rebase = preserve" - "user.email"
References: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
Date:	Fri, 29 Jul 2016 10:47:27 -0700
In-Reply-To: <CAG0BQXnVAYdpk9EM_uiD+=UKSKmK=z1YEar5MresTr5XfDCxHw@mail.gmail.com>
	(Dakota Hawkins's message of "Fri, 29 Jul 2016 05:17:15 -0400")
Message-ID: <xmqqoa5gnxow.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 84FA73A2-55B4-11E6-94C6-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Dakota Hawkins <dakotahawkins@gmail.com> writes:

> I have a question which may be a bug (I'm a bit skeptical), but here goes:
>
> In my global .gitconfig, I have "user.useConfigOnly = true" and
> user.email isn't set there (I prefer to be forced to set it on a
> per-repo basis, as I use different emails for work and personal
> repos). I ALSO have "pull.rebase = preserve" set.
>
> An example of the problem I have is with tools like golang (I filed an
> issue there, they closed it and suggested the problem is with git or
> my config: https://github.com/golang/go/issues/16516#issuecomment-235800085)
> that use git to pull in package repos without any real user
> interaction. When something like that runs a git pull for me (to
> update a package repo) my global config makes it try to rebase, which
> fails because git doesn't know who I am.

It's an interesting chicken-and-egg problem that user.useConfigOnly
introduces.  It seems that the design of that configuration variable
is not perfect and has room for improvement.

> In those cases specifically, I never have local commits that differ
> from the remote, so a "pull --ff-only" should leave me in the same
> state as a "pull --rebase".
>
> Is this a case of rebase trying to make sure it has enough information
> for me to be a committer before knowing whether I even need to rewrite
> any commits, and could/should that be avoided?  Alternatively (or also)
> could/should rebase detect that a fast-forward is possible and prefer
> to do that instead?

I think that is a reasonable argument, but to solve this for a more
general case, shouldn't we be discussing a solution that would also
work when rebase _does_ need to create a new commit?  And when the
latter is solved, I would imagine that "this rebase happens to be
fast-forward, and not having an ident shouldn't be an issue for this
special case" would become moot.
