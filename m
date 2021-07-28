Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C00D6C4338F
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:49:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D2060BD3
	for <git@archiver.kernel.org>; Wed, 28 Jul 2021 17:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhG1RtE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Jul 2021 13:49:04 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60474 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhG1RtA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jul 2021 13:49:00 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 235E4D9145;
        Wed, 28 Jul 2021 13:48:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=MAaA9W4978crguTq//yXYJP3/BVmmMES+QZYGm
        ylCHM=; b=sivsP9dS+iIIrc8WFIXdw2ozuxc7JvtOf+DyOQruJGcZZRP2ery9oO
        m1J6mxPfcDQkbvrNobday99b4m3T4Eb/4Qe1eP6H6cyG2DulcR4HBTrLkqaoHpCA
        zDDZFUz2DngY34D2yUHgFZ2m60EUReaueA1Sx5mSFF5tSVlhmxnKo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 18EF5D9144;
        Wed, 28 Jul 2021 13:48:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.71.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9158FD9143;
        Wed, 28 Jul 2021 13:48:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Boeckel <mathstuf@gmail.com>
Cc:     git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH 1/1] config: support setting up a remote tracking branch
 upon creation
References: <20210728135041.501850-1-mathstuf@gmail.com>
        <20210728135041.501850-2-mathstuf@gmail.com>
Date:   Wed, 28 Jul 2021 10:48:56 -0700
In-Reply-To: <20210728135041.501850-2-mathstuf@gmail.com> (Ben Boeckel's
        message of "Wed, 28 Jul 2021 09:50:41 -0400")
Message-ID: <xmqqim0u9vnb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 156371B2-EFCC-11EB-9AC1-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Boeckel <mathstuf@gmail.com> writes:

> The `branch.autoSetupMerge` works well for setting up tracking a local
> branch, but there is no mechanism to automatically set up a remote
> tracking situation.

This description is probably insufficient to explain what's missing,
probably because "set up a remote tracking situation" is a bit
fuzzy.

Without this patch, I can do this already:

    $ git checkout -t -b topic origin/topic

And after the above, we have

    [branch "topic"]
	remote = origin
	merge = refs/heads/topic

Of course, you can instead use a short-hand DWIM, e.g.

    $ git checkout topic ;# assuming origin/topic exists

gives us the same thing.  In either case, topic knows to integrate
with the 'topic' branch from remote 'origin' and push back there.

So instead of saying "there is no mechanism to ...", be a bit more
specific what you can and cannot do in this first paragraph.

Then we can describe the solution we'd propose in the second and
subsequent paragraphs.

Thanks.



> +branch.defaultRemote::
> +	When a new branch is created with 'git branch', 'git switch' or 'git
> +	checkout', this value will be used to initialize the
> +	"branch.<name>.remote" setting.

You mean without "-t"?  I offhand do not think of a reason why this
is a good idea.  How would one create local topic branches that you
plan to merge locally into your own larger topic branch to be shared
with others?  Shouldn't there be an easy way to countermand the
setting by this configuration?

> +branch.defaultPushRemote::
> +	When a new branch is created with 'git branch', 'git switch' or 'git
> +	checkout', this value will be used to initialize the
> +	"branch.<name>.pushRemote" setting.

Ditto.

> +branch.defaultMerge::
> +	When a new branch is created with 'git branch', 'git switch' or 'git
> +	checkout', this value will be used to initialize the
> +	"branch.<name>.merge" setting.

So the expected use case is to fork multiple local branches, to
integrate with the same branch from the remote?  I think we can
already do 

    $ git checkout -t -b xyzzy origin/master
    $ git checkout -t -b frotz origin/master

and you can lose -t with branch.autosetupmerge setting.  As the "git
branch" command needs to get the name of your branch (e.g. 'xyzzy'
or 'frotz') and which remote tracking branch you start from
(e.g. 'origin/master'), even with branch.{defaultRemote,defaultMerge}
configuration, you wouldn't lose that many keystrokes, I suspect.

Or do you plan to make

    $ git branch xyzzy

a short-hand for

    $ git branch -t xyzzy origin/master

when defaultRemote and defaultMerge are set to 'origin' and
'refs/heads/master'?  It would be way too confusing to start the
new branch from origin/master in such a case, as everybody learned
that "git branch xyzzy" that does not say where the branch initially
points at uses HEAD.
