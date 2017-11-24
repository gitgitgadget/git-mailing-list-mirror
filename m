Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2F98920954
	for <e@80x24.org>; Fri, 24 Nov 2017 07:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbdKXHLy (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Nov 2017 02:11:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54297 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751241AbdKXHLx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Nov 2017 02:11:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0CF53B7767;
        Fri, 24 Nov 2017 02:11:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1L+dIDtyHWfYHfe5RlfWraIeSEI=; b=O61Rqj
        zGSowVb7RfFNEkRbG8pPuAjhik/+W1ku5+LUaToCv9sTwJHnF5NqiAavatcRXezY
        uLyGukvGKui/q/HfKTc/mvdtjhL03Ekug+hUza4shtWhygv6haMHXYCB8rRHV4O7
        k8PRgOgVHsK7q1G2nem6Zb2XRooPaUrC3tHi4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Y8pLS0n14uKsI79M4pTA1pAaBVpojOXD
        bzeanTn3AyqhA9c22f4+8FWEK5KU1gF0kYCcGGyyMyXryztWbxVOIBU78Lb+0bP3
        0yXyO01qc7RGmw+33DOud5stugFcbmViLinIywI7Sm3llP3o2dFs2lL/ku2MR0bi
        WwGW87Hz3aU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0485AB7766;
        Fri, 24 Nov 2017 02:11:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 72F70B7764;
        Fri, 24 Nov 2017 02:11:52 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 4/4] worktree: make add <path> dwim
References: <mailto:20171118224706.13810-1-t.gummerer@gmail.com>
        <20171122223020.2780-1-t.gummerer@gmail.com>
        <20171122223020.2780-5-t.gummerer@gmail.com>
Date:   Fri, 24 Nov 2017 16:11:51 +0900
In-Reply-To: <20171122223020.2780-5-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Wed, 22 Nov 2017 22:30:20 +0000")
Message-ID: <xmqq1skonoaw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BF13B5AE-D0E6-11E7-B5C7-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> Currently 'git worktree add <path>' creates a new branch named after the
> basename of the <path>, that matches the HEAD of whichever worktree we
> were on when calling "git worktree add <path>".
>
> Make 'git worktree add <path> behave more like the dwim machinery in
> 'git checkout <new-branch>', i.e. check if the new branch name uniquely
> matches the branch name of a remote tracking branch, and if so check out
> that branch and set the upstream to the remote tracking branch.
>
> This is a change of behaviour compared to the current behaviour, where
> we create a new branch matching HEAD.  However as 'git worktree' is
> still an experimental feature, and it's easy to notice/correct the
> behaviour in case it's not what the user desired it's probably okay to
> break existing behaviour here.

Is it "easy to notice"?  I doubt it.  Even if you assume that
everybody uses bash prompt that shows the name of the branch, the
user sees the same name of the branch in either mode.

> In order to also satisfy users who want the current behaviour of
> creating a new branch from HEAD, add a '--no-track' flag, which disables
> the new behaviour, and keeps the old behaviour of creating a new branch
> from the head of the current worktree.

I am not sure if this is a good match for "--track/--no-track";
which branch is to be checked out (either "automatically from the
unique remote-tracking branch" or "the current one") is one choice,
and whether the resulting branch is marked explicitly as integrating
with the remote or not is another choice within one branch of the
first choice.  IOW, this makes it impossible to say "create the branch
based on the unique remote-tracking branch, but do not add the two
branch.*.{merge,remote} variables".

Also, you have several mention of "remote tracking branch" in these
patches.  Please consistently spell them as "remote-tracking branch"
to be consistent with Documentation/glossary-content.txt and avoid a
casual/careful reference to "tracking branch" if possible, unless it
is quite clear to the readers that you are being loose for the sake
of brevity.  Some people used "tracking branch" to mean the local
branch that is marked as the branch to integrate with the work on
a branch at a remote that caused user confusion in the past.

That is

    refs/remotes/origin/topic is a remote-tracking branch for the
    branch 'topic' that came from the 'origin' remote.

    when you have branch.foo.remote=origin and
    branch.foo.merge=refs/heads/topic, then your local branch foo is
    marked to integrate with the 'topic' branch at the 'origin'
    remote.

and these two are quite different things that people in the past and
over time loosely used a phrase "tracking branch" to cause confusion.
