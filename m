Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 665692070F
	for <e@80x24.org>; Mon, 19 Sep 2016 16:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752124AbcISQaW (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 12:30:22 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51942 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752107AbcISQaV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 12:30:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5EB9E3E04A;
        Mon, 19 Sep 2016 12:30:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=t/aTks3rzG5j
        hJNuAuwJuSriyN8=; b=QUD/AxlAqNJ27BBViqyrXUSbYJNegjb2zPw70urTTo7E
        88JucMhFhP0WJLvw6XX6udjn10biBpEFNeTuwKe+kpXQUst9I8jM/y0dyuQ83Pl5
        kMq/rp+FVkfNkmrjLqMILGVEIDeiT/XTZcO10ZfOIidgFKjO8V1nDYpJWZ+l2Nw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=QOfvc0
        gBawWBx3i74oQcnwKDXyjDIoMDOuLBOsrRKbzRxKPl1EK9ivFZPljK9aIQGCWjac
        BKf+X15wnQSls/x87LQHUZMhlEoYkkiCMCf9b/XWCv2NmpEESEKaBTgKsx4f6R85
        LLcCuFvfH8TJ/FSl5g+3lrCD8DgMPZ1VJ7HmA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 55EAB3E049;
        Mon, 19 Sep 2016 12:30:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BE2623E041;
        Mon, 19 Sep 2016 12:30:19 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Ben Peart" <peartben@gmail.com>
Cc:     <pclouds@gmail.com>, "'Ben Peart'" <benpeart@microsoft.com>,
        <git@vger.kernel.org>
Subject: Re: [PATCH v3] checkout: eliminate unnecessary merge for trivial checkout
References: <20160913142628.15440-1-benpeart@microsoft.com>
        <xmqq7fafv376.fsf@gitster.mtv.corp.google.com>
        <BL2PR03MB3232D3128A72D4EC9ADC2C6F4F10@BL2PR03MB323.namprd03.prod.outlook.com>
        <BL2PR03MB323E1B2F810C63CB01AA234F4F30@BL2PR03MB323.namprd03.prod.outlook.com>
        <007401d21278$445eba80$cd1c2f80$@gmail.com>
Date:   Mon, 19 Sep 2016 09:30:17 -0700
In-Reply-To: <007401d21278$445eba80$cd1c2f80$@gmail.com> (Ben Peart's message
        of "Mon, 19 Sep 2016 09:18:08 -0400")
Message-ID: <xmqqzin3g8di.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 5AF2936E-7E86-11E6-83EC-096F12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Ben Peart" <peartben@gmail.com> writes:

> Let me see if I can better explain what I=E2=80=99m trying to accomplis=
h with this
> patch. =20
> =20
> "git checkout -b foo" (without -f -m or <start_point>) is defined in th=
e
> manual as being a shortcut for/equivalent to:
> =20
>         (1a) "git branch foo"
>         (1b) "git checkout foo"
> =20
> However, it has been our experience in our observed use cases and all t=
he
> existing git tests, that it can be treated as equivalent to:
> =20
>         (2a) "git branch foo"
>         (2b) "git symbolic-ref HEAD refs/heads/foo"
> =20
> That is, the common perception (use case) is to just create a new branc=
h
> "foo" (pointing at the current commit) and point HEAD at it WITHOUT mak=
ing
> any changes to the index or worktree.
> =20
> However, the (1b) command has "git reset" connotations in that it shoul=
d
> examine and manipulate the trees, index, and worktree in the expectatio=
n
> that there MIGHT be work to do.
> =20
> Since this additional work in (1b) takes minutes on large repos and (2b=
)
> takes less than a second, my intent was to identify the conditions that=
 this
> additional work will have no affect and thereby avoid it.
> =20
> Alternatively, was the "-b" option just created as a shortcut only to a=
void
> calling the separate "git branch foo" command and we should not think a=
bout
> the common perception and usage?

If you are trying to change the definition of "checkout -b" from 1
to 2 above, that is a completely different issue.  I thought this
was an attempt to optimize for the performance without changing the
behaviour.

So if you did not apologize like this...

> It is correct that this optimization will skip updating the tree to hon=
or
> any changes to the sparse-checkout in the case of creating a new branch=
.
> Unfortunately, I don't know of any way to detect the changes other than
> actually doing all the work to update the skip work tree bit in the ind=
ex.

... but insisted that skipping the yucky sparse-checkout adjustment
in this case was an intended behaviour change, I would have
understood (not necessarily agreed, though) what you were trying to
do.

> Beyond this code review process and testing, I don't know how else we m=
ake
> sure we're caught all the conditions where we are OK skipping some of t=
he
> steps. Any change has inherent risk - a change in behavior even more so=
.

At least we made one-step progress today.  I now know that you are
trying to change the behaviour, but I didn't know that last week,
when I was primarily reacting that your claim that this was
performance thing and assuming you meant no change in behaviour, but
there was clearly behaviour change, and it was apparent that the
denseness of the code made it almost impossible to see if there are
unintended changes.

I am still not sure if I like the change of what "checkout -b" is
this late in the game, though.
