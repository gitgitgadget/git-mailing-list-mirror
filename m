Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3DFC4361B
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:31:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1445C21D42
	for <git@archiver.kernel.org>; Mon, 14 Dec 2020 16:31:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440047AbgLNQbR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Dec 2020 11:31:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54833 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439397AbgLNQbR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Dec 2020 11:31:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 315C892129;
        Mon, 14 Dec 2020 11:30:36 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3AiXS1pGzWGk
        QS6geTtfRN8/hE8=; b=UVi5T6ntFjshUlrA/mvURqZwUnb1eoE2HYttux+qPm+n
        vwi7YEyJG1PSluTbU53yqNMBJgweb/pua8g7ELWcQ4MAQk21bx+5ZlFIOJwBLrPw
        HbKMb9dMNMMgTv59I26nupGg83GOiksIBM/EitIppDcLj+woYqkF+qDzQd3gQWE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=wxl50x
        N00JNCVeXQvCaTned1UCQOHPFNvbc/yvNcvqWmKpm0JGVsOUsMunSPN/2NsqhShD
        c3SM/a/GYIOytxoOKHb8O9x3fbtGlIbEnAQYtPlHyNAYuSapcybD6XRKfSomhIic
        lpxg7kBECts+ZaU+hfU8YPTLvOZKaZZZJByoY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2529592128;
        Mon, 14 Dec 2020 11:30:36 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 88EDF92127;
        Mon, 14 Dec 2020 11:30:35 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] clone: in protocol v2, use remote's default branch
References: <20201208013121.677494-1-jonathantanmy@google.com>
        <20201211210508.2337494-1-jonathantanmy@google.com>
        <87blewwoil.fsf@evledraar.gmail.com>
Date:   Mon, 14 Dec 2020 08:30:34 -0800
In-Reply-To: <87blewwoil.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 14 Dec 2020 13:38:58 +0100")
Message-ID: <xmqqim94e4et.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B1668F90-3E29-11EB-B297-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> On the client side, Git will always send the "unborn" argument if it i=
s
>> supported by the server. During "git clone", if cloning an empty
>> repository, Git will use the new information to determine the local
>> branch to create. In all other cases, Git will ignore it.
>
> I'm not a fan of this change not because of the whole s/master/whatever=
/
> discussion, but because of the magic it adds for seemingly little gain =
&
> without any documentation.
>
> So if I have init.defaultBranch explicitly set that'll be ignored on
> "clone", but on "init/git remote add/fetch" it won't?

That description is backwards.

To help interoperate with the repository you cloned from better, we
made it easy to use whatever your 'origin' uses. "git clone" does so
by (1) in the original implementation, by inferring where HEAD
points at over there by comparing the objects reported for HEAD and
tips of branches (2) later, by adding symref capability to the
protocl so that the sending repository can tell exactly which branch
its HEAD points at.  What was lacking was that symref capability is
not sent if there is nothing in the repository.  And I think this is
an attempt to bring that "cloning nothing" case in line with a clone
of a repository with contents.

> Shouldn't this at the very least be a
> init.defaultBranchFromRemote=3D<bool> which if set overrides
> init.defaultBranch? We could turn that to "true" by default and get the
> same behavior as you have here, but with less inexplicable magic for th=
e
> user, no?

I view the change in the patch being discussed a bugfix (clone ought
to follow whatever the other side uses by default, unless you say -b,
and the case when cloning an empty repository was buggy).  I am OK
if we wanted to consider a _new_ feature to always use the name you
want locally (i.e. as if you added "-b $(git config init.defaultBranch)"
on your "git clone" command line), but that is a new feature that needs
to be discussed in a separate topic.

> Another reason I'm not a fan of it is because it's another piece of
> magic "clone" does that you can't emulate in "init/fetch".

That ship has sailed longlonglong time ago when dfeff66e (revamp
git-clone., 2006-03-20) started pointing our HEAD to match theirs.

> But shouldn't there at least be a corresponding "fetch" option? On init
> we'll create head, but "git fetch --clobber-my-idea-of-HEAD-with-remote
> ..."?

It may be nice to have a corresponding one, but again, that is a
separate topic on a new feature, and not relevant in the context of
this fix.

> Maybe not for reasons I haven't thought of, but I'd at least be much
> happier with an updated commit message justifying another special-case
> in clone that you can't do with "init/fetch".

This is *not* another special-case, but is 14-year old outstanding
one, so I do not think there specifically needs such justification.
The log message DOES need to be clarified.  Your mistaking that this
is a new feature and not a bugfix may be a good indication that the
proposed log message is not doing its job.

> And on the "litte gain" side of things: I very much suspect that the
> only users who'll ever use this will be some big hosting providers (but
> maybe not, the commit doesn't suggest a use-case).

Explorers who learn this new GitHub or GitLab thingy, create an
empty repository there and then clone it to their local disk, just
to dip their toes in the water, would most benefit.  Those of us who
are working on an already existing and populated projects won't be
helped or bothered.  We do sometimes create our own repositories and
publish to hosting sites, and I expect that many experienced Git
users follow the "local first and the push", and they won't be
helped or bothered.

But I expect some do "create a void at the hosting site and clone to
get a local playpen" for their real projects.  They would be helped,
and because Git userbase is populous enough that their number in
absolute terms would not be insignificant, even if they weren't in
percentage terms.
