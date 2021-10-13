Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AA99C433FE
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 23:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF3D160D42
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 23:37:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbhJMXj1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 19:39:27 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54186 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbhJMXj0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 19:39:26 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 488C7DA3FE;
        Wed, 13 Oct 2021 19:37:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=SuSja6VDKH7v8ZeOtzhLRnzYu9KS9Z/9SL4q3b
        lOzyM=; b=iyv3wp8c2gC3ftdGXQBE3EnfbQ+U8IcSlKF8xyvuvZdejTeRqHQGZn
        KZ5QQsDzGeZu0NxIn/Po+Sg98hkgLGSzTw2SynLCD1Xk1/7nH6y7gkyLnK0bt265
        KSNwv0hkkbMBIVzbj+TmE5L5bT++Jx2du9tKa6MhxvYV6E3xg5l/g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EC7DDA3FD;
        Wed, 13 Oct 2021 19:37:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9CC36DA3FC;
        Wed, 13 Oct 2021 19:37:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] remote: replace static variables with struct
 remote_state
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
        <20211013193127.76537-1-chooglen@google.com>
        <xmqqtuhkfzw8.fsf@gitster.g>
        <kl6ltuhk1tdg.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Wed, 13 Oct 2021 16:37:20 -0700
In-Reply-To: <kl6ltuhk1tdg.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Wed, 13 Oct 2021 14:56:27 -0700")
Message-ID: <xmqqmtncebtb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82FAB016-2C7E-11EC-B9D7-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> My primary line of thinking is that adding the backpointer from struct
> branch to struct repository adds "unnecessary" coupling between the two
> objects,...

meaning, that the paragraphs below will explain why the reference is
unnecessary?

> ...which causes the more concrete problems of:

> * Inconsistency between other functions that use struct repository as a
>   "context object". We now find ourselves having to justify why branch
>   functions can bypass the context object using a special pointer,
>   whereas other functions and structs (say, struct object) cannot.

Given that the API has been evolved over time from a "we deal only
with a single repository and everybody else can just fork into a
separate repository" to "now this function can work in the specified
repository", it is understandable that some still do take repository
as a separate parameter, even though the original counterpart that
did not take a repository pointer took an object that clearly can
belong to only one repository at a time.  They would need to be
cleaned up, and they do not make a good excuse to add more of them,
when we know we are dealing with objects that belong only to one
repository, like the "remote.c" contents we have been discussing.

IOW, we need to start somewhere to clean things up, so either we
teach multi-repository support to remote.c from day one, or we pass
a repository as a separate and redundant parameter, with the
intention to later clean up.  I suspect that this piece is isolated
enough that it is simpler to use as a starting point, and then the
callers into remote.c API can then be cleaned up, gradually extending
the circle.

The original counerpart may not have been about "the other object"
to begin with (e.g. "we have this string (not an object); resolve it
to an object name in the context of the given repository"), in which
case they are fine as they are, but I think most of the contents of
"remote.c" do not fall into this category.

> * Interface misuse, where callers can now dereference branch->repository
>   even though it is meant to be internal. This is also a possible source
>   of inconsistency.

I do not think it is meant to be internal to begin with.  If we
declare, after careful consideration, that an in-core branch object
given by remote.c API always belongs to one and only one repository,
then following the branch->repository pointer should be the
documented and kosher way to find out the repository by anybody who
is given the branch object.  A function that takes repo and branch
to pretend as if it can work with an inconsistent pair is an
invidation for the interface misuse, but I do not think it is a
misuse of the API for a codepath that obtained a branch instance
inspecting what repository it came from.

A function that takes a pair of remote and a branch object for
whatever reason may want to have an assert() that makes sure they
came from the same repository, by the way.

Also, some of the functions involved in this topic may need to say
"I have this string, please resolve it as an object name in the
context of this repository", and call a function that takes a
repository as "context".  The repository they use must be given by
their caller somehow---is there any valid case where it must be
different from the other parameter (i.e. contained object) they are
dealing with?  I do not think so.  So such a function would have to
say "resolve this string in the context of the repository
branch->repo" because the function was given an in-core branch
instance.

> * Extra memory consumption.

This is true.  It however is the only valid excuse I can fully agree
with for being hesitant to have "where did I come from" information.
We do grow each in-core branch and remote instance by an 8-byte
pointer (but we reduce the stackframe consumption by 8-byte along
each step in the callchain as we do not have to pass a repository as
a separate pointer parameter).

> objects). I do not think we are in the same position with struct branch;
> struct branch seems sufficiently separated to me.

Sufficiently separated in the sense that you take a branch from the
parent repository and throwing it at a function with a pointer to an
in-core repository for a submodule would make some sort of sense?  

Sorry, but I do not follow this part of your argument, at all.
