Return-Path: <SRS0=ga/5=CR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13728C433E2
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 22:46:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 906912075A
	for <git@archiver.kernel.org>; Tue,  8 Sep 2020 22:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q+P9OWSu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728954AbgIHWqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Sep 2020 18:46:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61454 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgIHWqd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Sep 2020 18:46:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 7734BEFA67;
        Tue,  8 Sep 2020 18:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wRnBEdlXWIf1nO/2Oz0wJLH6JH0=; b=Q+P9OW
        Su6KjGlLMTK9fIV1YoN+H5Iz1Gepj6j1Hxeth6t9yeJMxFsj4LnKarlb25gt41mX
        NqVrDZVuUPsdJ3LBMfy6zeS+rvyWVcTM2xbjwhFr4L4O4mGe5ticUVg/iF7eh8GL
        OJRU1yQ/m7S0vIfN6jbjzJU/ETuXEakU8rIGs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BzraVUvG2jdY1FhsBySnsMVAbskUQB16
        kQX3xo2CRGTvPROhOzBVypWODA0CXwC46MRnnVtsSP8Ws1ih7rb9PoP+MRQXKG28
        0jc+8Acz1v/1q7dKiS1fKOf2GZGI2L9sV4T+Ldzu16szc11R10Wgyxpn8W/Gjo+o
        pSCtVOzF1Dg=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 70436EFA66;
        Tue,  8 Sep 2020 18:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id B7BFCEFA64;
        Tue,  8 Sep 2020 18:46:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Aaron Lipman <alipman88@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: allow merged and no-merged filters
References: <20200908153759.36504-1-alipman88@gmail.com>
Date:   Tue, 08 Sep 2020 15:46:27 -0700
In-Reply-To: <20200908153759.36504-1-alipman88@gmail.com> (Aaron Lipman's
        message of "Tue, 8 Sep 2020 11:37:59 -0400")
Message-ID: <xmqqsgbrx4xo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 22146AF6-F225-11EA-925D-843F439F7C89-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Aaron Lipman <alipman88@gmail.com> writes:

> Enable ref-filter to process multiple merged and no-merged filters, and
> extend functionality to git branch, git tag and git for-each-ref. This
> provides an easy way to check for branches that are "graduation
> candidates:"
>
> $ git branch --no-merged master --merged next
>
> To accomplish this, store the merged and no-merged filters in two
> commit_list structs (reachable_from and unreachable_from) rather than
> using a single commit struct (merge_commit).
>
> If passed more than one merged (or more than one no-merged) filter,
> mirror the existing boolean logic used by contains/no-contains filters:
> refs must satisfy any of the merged filters, and all of the no-merged
> filters.

I am not sure if the parallel with "contains" should hold in the
first place.

The way I would look at the --[no-]merged is that I'm enumerating
commits that would be shown in this corresponding revision walking
command:

	$ git log --decorate --oneline ^master ^maint next seen

If the tip of a branch appears in that output, then the branch is
included in the corresponding "git branch" output, and if it does
not, the branch is excluded from the corresponding "git branch"
output.  

	$ git branch \
		--no-merged master --no-merged maint \
		--merged next --merged seen

That would mean the rule would be "refs must be reachable by any one
(or more) of the <merged> commits, and must be reachable by none of
the <no-merged> commits".  I am not using the same phrasing you used
(i.e. "must satisify ... filter"), but are we saying the same thing?
It is unclear to me what you meant by "all of the no-merged filters".

The expectation is that topics in flight are either reachable from
'next' or 'seen' (there can be commits in 'next' but not in 'seen'
when fixes to mismerges are involved) and those already graduated
are either in 'master' or 'maint', and the above "log" and "branch"
would show the stuff still in flight.  But if you mean by "all of
the no-merged filters" that it must be in both 'master' and 'maint'
for a commit to be excluded from the output, it would not behave as
I would expect.

In _my_ history, since 'maint' is always kept as a subset to
'master' because I refrain from cherry-picking a fix that is in
'master' down to 'maint', I can use a single "--no-merged master" to
work around the problem, but in a larger scale projects where
cherry-picking fixes to maintainance track is more common, the above
does not sound so useful, at least at the first glance.

So I dunno.

Thanks.
