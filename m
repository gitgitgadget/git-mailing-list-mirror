Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B622047F
	for <e@80x24.org>; Wed, 26 Jul 2017 19:36:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751395AbdGZTgi (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Jul 2017 15:36:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64488 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750867AbdGZTgg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Jul 2017 15:36:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 29A6990935;
        Wed, 26 Jul 2017 15:36:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jHl2ZgZjx+TTOp7Q0Yqvs/23t/A=; b=XFnDIf
        OK0lQfSk0nYGb25lm+x7ap/6dZJBUFV3Qjh1ECijVUgPipE8xTYpFdECUgwQvDBq
        bkfwtWjXxcaB7/2v/0U8HwWRx71/w+ZDqhBD6DthYyLDcBlZPY1TrhnqyqiwLSez
        nujD7k5VIDi/1eZqjFYxj4mU3v/3rOoHJrhXo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=U4+TlXU8O1qZyu8DenoH46MK8MmMIAri
        XlZDzMU+uFIIb0X0fPl1Kdqaxdf8r2JHNj/oW7CC9OnCrzSwiSeOPslslYxGQrxZ
        NOuU2RBB7dl3ABIfxp9+59AD+Al9bg/QMD7STHB1eB3HdGO7uO43VwjiqlCsaTeh
        Ni3YNSwr7rk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 226D190934;
        Wed, 26 Jul 2017 15:36:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 82E3690932;
        Wed, 26 Jul 2017 15:36:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] recursive submodules: detach HEAD from new state
References: <20170724173601.19921-1-sbeller@google.com>
        <20170724180312.GE13924@aiede.mtv.corp.google.com>
        <xmqq8tjdcyf1.fsf@gitster.mtv.corp.google.com>
        <xmqqr2x5bhk7.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZdoktBRBuNxVk-zehZR3Z-egEPG81KQ9WqHTEtrm+5uw@mail.gmail.com>
Date:   Wed, 26 Jul 2017 12:36:27 -0700
In-Reply-To: <CAGZ79kZdoktBRBuNxVk-zehZR3Z-egEPG81KQ9WqHTEtrm+5uw@mail.gmail.com>
        (Stefan Beller's message of "Tue, 25 Jul 2017 15:27:07 -0700")
Message-ID: <xmqqy3rbq9c4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B81A1984-7239-11E7-A975-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> So I took a step back and wrote about different proposals where
> we want to go long term. See below. This will help us
> figuring out how to approach this bug correctly.

Thanks for writing this.

> RFC: A new type of symbolic refs
>
> A symbolic ref can currently only point at a ref or another symbolic ref.
> This proposal show cases different scenarios on how this could change in
> the future.
>
>
>
> A: HEAD pointing at the superprojects index
> ===========================================
>
> Introduce a new symbolic ref that points at the superprojects index of
> the gitlink. The format is
>
>   "repo:" <superprojects gitdir> '\0' <gitlink-path> '\0'
>
> Ref read operations
> -------------------
>   e.g. git log HEAD
>
> Just like existing symrefs, the content of the ref will be read and followed.
> On reading "repo:", the sha1 will be obtained equivalent to:
>
>     git -C <superproject> ls-files -s <gitlink-path> | awk '{ print $2}'
>
> In case of error
> (superproject not found, gitlink path does not exist), the ref is broken and
>
> Ref write operations driven by the submodule, affecting symrefs
> ---------------------------------------------------------------
>   e.g. git checkout <other branch> (in the submodule)
>
> In this scenario only the HEAD is optionally attached to the superproject,
> so we can rewrite the HEAD to be anything else, such as a branch just fine.
> Once the HEAD is not pointing at the superproject any more, we'll leave the
> submodule alone in operations driven by the superproject.

That explains what the proposed code _does_.  It does not explain
why the chosen behaviour is a sensible one.

This illustrates the point I have trouble with when trying to judge
all of these discrete update proposals to submodules.  They only say
"This feature does this in this case, does that in that case,..."
but lack "this is meant to be used when you want to implement the
workflow that goes like this, and fits as a building block at this
point for that workflow. Other elements needed to support that
workflow well are ...".  No proposal gives a big picture and explain
how these small bits fit together.

For example, I would understand better if this write-up of yours
were not organized with the "proposal X added A that behaves this
way and added B that behaves that way" as its major axis, but
instead was written with the workflow that is meant to be realized
as its major axis, e.g.

    A project may want to use submodules as if it is just part of
    superproject.  In such a project, checking out branch X at the
    superproject level, working on files in both superproject and
    submodules, and then committing recursively and pushing the
    results out recursively at the superproject level, all would
    want to affect the same branch X at all levels in the upstream.

may be one possible workflow you want to support.  As one ingredient
to support such structure, the HEAD in the submodule that points at
an index entry in the superproject may be very useful.  After a
recursive checkout at the superproject level, the HEAD of the
submodule ought to be what came from and recorded in the tree in the
superproject, and after a commit in the submodule, the HEAD moves to
the new commit and the entry in the superproject's index also gets
updated which would have a nice property that "commit" in submodule
acts almost like "add" in superproject.  A recursive "git diff" would
show that submodule is clean after such a commit, recursive "push"
would know which branch to push out, etc.

And when operating in such a mode, it would make most sense if "git
checkout" of a different branch Y in a submodule repository is
either forbidden, or should behave as if the submodule directory
were an ordinary directory of the superproject (i.e. causing
recursive checkout of the branch Y at the superproject level).

BUT.

Because none of the proposals paint a big picture (e.g. the big
picture the above hypothetical example gives is that the core
concept of this particular workflow being supported is that
everything recursively stays on the branch with the same name), we
cannot judge if it is sensible for "a new style symref" to be
updated/demoted to a normal branch pointer when "git checkout"
happens.  It is not sensible in such a hypothetical workflow, but it
may be very sensible in another workflow.  Without stating what
big-picture goal is being achieved, it is impossible to see if a
proposal to add/change an individual component that is to be used as
a building block makes sense.

Historically, we can get away without giving choices of "supported
workflows", allowing the user to pick one, and explaining how things
fit together, primarily because the operations that can recurse were
primarily read-only e.g. status, grep, etc., and the supported model
was "the user can be on whatever branch or detached in each
submodule that may or may not be consistent with what happens in the
superproject; it is up to the user to hang themselves with the long
rope".  When allowing potentially destructive operations like
checkout to go recursive [*1*], depending on how the entire tree of
repositories is meant to be managed, sensible mode of operation
would be different, but without defining what various ways "how the
entire tree of repositories is meant to be managed" are supported,
we cannot teach such operations to go recursive in a sensible way.

[Footnote]

*1* Some readers may wonder "checkout is destructive???", and in the
    context of this discussion, it is.  Recursive checkout done at
    the superproject level that rewinds the branch currently checked
    out in a submodule is destructive by potentially losing history,
    and a recursive checkout that checks out a different branch in a
    submodule can be destructive by changing where the next "git push"
    in a submodule would go, depending on how the entire tree of
    repositories is meant to be managed.  In some workflows, always
    detaching HEAD to the commit that is bound to the superproject
    may be _the_ sensible way to recursively check out a branch.  In
    some other workflows, detecting that the submodule is on a
    branch that is not the branch the superproject is checking out
    and erroring out may be more sensible way.
