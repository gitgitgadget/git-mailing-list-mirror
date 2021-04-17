Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F65CC433B4
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 00:45:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6ADD7611AB
	for <git@archiver.kernel.org>; Sat, 17 Apr 2021 00:45:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhDQAqM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 20:46:12 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55144 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhDQAqL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 20:46:11 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DAC66B146B;
        Fri, 16 Apr 2021 20:45:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=b4uivGELG9NsCTsHGCQnMHNvnD8=; b=pVmRpk
        d35qRHUpqkEnp303Wkf5qEyBs3IjQh0u/fKHCNUIgqVCMmmnkXgYz/XPOgsCj4t7
        ym1CQ6R5U5Z30NhnutGtRdmFqFnph7GBAN71YHBHX70/9aSAMpsmBLs+ACInGuDX
        29RCXHqcy+NHAR5rSjOTopMQFnQ9p0WSMhCSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BUY4eeOKDviSsoX6iOMUqsaaAXMSmdRH
        4GkMhB4ssQLMN+7Z9ZRM+anuSPE+jMI2gAbjyOy37B0+Pog4wsJCwjzaO5QwnlRY
        wc5cR3LqF2+a9Sh2I3B3F7/BrRCExfzv626BEP7Opo0zmymdqSUEz1RmWQewsNMz
        I82o3LLinsQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CCFA4B1468;
        Fri, 16 Apr 2021 20:45:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3496CB1466;
        Fri, 16 Apr 2021 20:45:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jerry Zhang <jerry@skydio.com>
Cc:     git@vger.kernel.org, ross@skydio.com, abe@skydio.com,
        brian.kubisiak@skydio.com
Subject: Re: [PATCH] git-rev-list: add --exclude-path-first-parent flag
References: <20210417001525.19960-1-jerry@skydio.com>
Date:   Fri, 16 Apr 2021 17:45:44 -0700
In-Reply-To: <20210417001525.19960-1-jerry@skydio.com> (Jerry Zhang's message
        of "Fri, 16 Apr 2021 17:15:25 -0700")
Message-ID: <xmqqzgxxivrb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E8B7E60-9F16-11EB-A570-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jerry Zhang <jerry@skydio.com> writes:

> Add the --exclude-path-first-parent flag,
> which works similarly to --first-parent,
> but affects only the graph traversal for
> the set of commits being excluded.
>
>    -A-------E-HEAD
>      \     /
>       B-C-D
>
> In this example, the goal is to return the
> set {B, C, D} which represents a working
> branch that has been merged into main branch
> E. `git rev-list D ^E` will end up returning
> no commits since the exclude path eliminates
> D and its ancestors.
> `git rev-list --exclude-path-first-parent D ^E`
> however will return {B, C, D} as desired.

It is not clera why you want to have this, instead of doing a more
obvious "D..E^".  Even better is "E^..E", which is often what you
want when viewing a history like my 'seen' that is a straight-line
into which tips of branches are merged.

E^..E (or doing the same for any commit on the mainline in such a
history whose first-parent chain solely consists of merges) would
show the list of the commits that came from the side branch that was
merged, plus the merge commit, where the committer who created a
merge would hava a chance to give a summary of what happened on the
side branch.
