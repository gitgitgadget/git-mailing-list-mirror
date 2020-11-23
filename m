Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2066C2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:12:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FFBE221E9
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 19:12:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cFe9aFv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgKWTMS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 14:12:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56645 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729352AbgKWTMR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 14:12:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7B45927DF;
        Mon, 23 Nov 2020 14:12:15 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=W3mMDkhD3oEA
        +Kmsm4wVHyhxTic=; b=cFe9aFv4yWeByhqRmJ6AO34n+FLOI+YXXLeGXVZQDhqR
        IbdZUh/I9+8HMjE3OJ2VBAeW83ZG+z6lHlPwo62HN3PvtmL5mjVH8vgYIEa0ff7O
        o8KWOvLBTJXwy7fW9oC9BIElYJhu7lxSYwMxmk3EVwmn/QbJnK6cM5RS8w59Jjk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WDju2j
        +Hlhs/1WHVrMkzEeftOEUxAi8b9ogaFnTx9g3eYrRlNlw76whhTBAG3grvbIaArX
        05Gb4ioczoBHS2iQRSHNW4Uusr5tN6qHxWEpD0Cz/Y+itOueL6ytBTUO4JU4I5M5
        Qwb4Z2a/guPwu0/feFKJdGp7M/cMnAqrKBD2w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D0335927DE;
        Mon, 23 Nov 2020 14:12:15 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 57E08927DD;
        Mon, 23 Nov 2020 14:12:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>
Cc:     git@vger.kernel.org
Subject: Re: Pick the right default and stop warn on `git pull`
References: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
Date:   Mon, 23 Nov 2020 11:12:13 -0800
In-Reply-To: <742df4c2-2bc5-8a4b-8de1-cd5e48718398@redhat.com>
 (=?utf-8?Q?=22V=C3=ADt?=
        Ondruch"'s message of "Mon, 23 Nov 2020 16:13:08 +0100")
Message-ID: <xmqqh7pfopki.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CC410DB0-2DBF-11EB-8249-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

V=C3=ADt Ondruch <vondruch@redhat.com> writes:

> While I understand that the merge after `git pull` is probably not the
> best strategy (as explained in [1]), asking people to change their=20
> configuration to choose their default strategy with every `git pull`
> is not any better.

There is no clear "default that would suit everybody".  There are
many people for whom 'rebase' is totally a wrong thing in their
'pull', and there are many people for whom 'merge' is totally a
wrong thing in their 'pull'.  Worse, because a user does not
necessarily play the same role in multiple projects, even the same
human user may want to use 'rebase' while working on some projects
while 'merge' is preferred on other projects.

And the userbase of Git is large enough that it is no longer a
viable approach to say "which group has more people?  pick the one
that is better to them" unless we are dealing with a _new_ feature.
Even 1% minority of the userbase is still a large number in absolute
terms.

That is why pull.rebase=3D(yes|no) exists to serve people with either
workflow to record preference just once for the repository with "git
config" and "git pull" would stop asking in the repository.

When they always prefer one way, they can even run "git config
--global" just once and the setting applies to all of their
repositories, stopping "git pull" from asking in any repository.

