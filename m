Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F72AC4332F
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 00:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 610AE60F8F
	for <git@archiver.kernel.org>; Sat, 11 Sep 2021 00:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235043AbhIKAx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 20:53:59 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60057 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235021AbhIKAx5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 20:53:57 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1ED4314B1F8;
        Fri, 10 Sep 2021 20:52:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=y01veVAxiLMWSNPSwrArHTFm8Z2JSBKhipUBWI
        iyvyU=; b=T6U2go24jNujw5zl1iHcp48NWeA2wMvlt9YHFI5+UgKfw4OwWLDxuQ
        30Fkg9qYFRgXbDDSURxKSvWsJ+WnNMt0O8cvFXqQ4NQi14voknmpOovQ5L+xntVc
        4ulVgQ+V2T1YhRQsoU8fQkB1zcPSnlMCvnZDgABhq+X+u2SoVrkvE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 172A914B1F7;
        Fri, 10 Sep 2021 20:52:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6284614B1F6;
        Fri, 10 Sep 2021 20:52:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] branch: add "inherit" option for branch.autoSetupMerge
References: <9628d145881cb875f8e284967e10f587b9f686f9.1631126999.git.steadmon@google.com>
        <0346f447548cfd11307173aaa3284d86a2ef689c.1631319742.git.steadmon@google.com>
Date:   Fri, 10 Sep 2021 17:52:41 -0700
In-Reply-To: <0346f447548cfd11307173aaa3284d86a2ef689c.1631319742.git.steadmon@google.com>
        (Josh Steadmon's message of "Fri, 10 Sep 2021 17:25:20 -0700")
Message-ID: <xmqqwnnondba.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 92861DC0-129A-11EC-B317-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> It can be helpful when creating a new branch to use the existing
> tracking configuration from the branch point. However, there is
> currently not a method to automatically do so.
>
> Teach branch.autoSetupMerge a new "inherit" option. When this is set,
> creating a new branch will cause the tracking configuration to default
> to the configuration of the branch point, if set.

So, when a new branch N is forked from an existing branch A that
builds on branch B (which could be a local branch under refs/heads/
or a remote-tracking branch under refs/remotes/), a plain-vanilla
auto-setup-merge makes N build on A but with 'inherit', N is marked
to build on B instead?

I do not think it is wise to hide this useful feature behind a
configuration variable.  

Rather, this should be made available first to users who do not even
set the configuration and then as a convenience measure, made usable
via the configuration mechanism as well.

The current "git branch --track N A" makes N build on A, so perhaps
"git branch --track=inherit N A" should make N build on whatever A
builds on.  We may need to give a synonym --track=direct to the
traditional "build on the original branch that was used to specfy
the fork point" while doing so.

And then on top of that, we can add configuration variable handling.

Depending on the value of branch.autoSetupMerge, "git branch -b" and
"git checkout -b" would pretend as if "--track" or "--track=inherit"
were given, or something along that line.  The end result may be the
same for those who only use the configuration variables, but it
would give us some flexibility to countermand the configuration from
the command line.  Those who set branch.autoSetupMerge to 'inherit'
cannot say "git checkout -b N --track=direct A" to express "With
this single invocation alone I am making N build on A, even though I
know I usually make N build on whatever A builds on" if you give
only the configuration variable.

Thanks.
