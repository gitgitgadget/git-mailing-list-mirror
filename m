Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91C141F461
	for <e@80x24.org>; Thu, 16 May 2019 02:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726218AbfEPCSl (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 22:18:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63896 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbfEPCSk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 22:18:40 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id F1313146311;
        Wed, 15 May 2019 22:18:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XfRyv5cxTHb90fp9aQgnvpwBgyo=; b=yP+f4W
        7E21Pfi7Mg22v6e+MmHQ5xO/JbMpt0fYViR6HNOtnJe3tfB12glV0fx7bCQ28VMS
        KAdFO6dyQceJAP+YTiAuUzAWatIvD272Cld3llmnjP2DdRW10dBJVYWXHPmZrWt5
        kQHZXKNSHZnN0KpStebef/Nn5hsEZeCqcUyAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ePDKulFI5D7yJZsN4+8mNTmdi2d/GAjT
        aKt8XlA9t1ZzDqryonqshS6IA94XP9HrvV5/+TCAL+LNLb/qD8u4BPJ3z4wsHrxj
        blkR5uFM+3eRkXsY99O2B3kg7lVqmsLmyi9LT4fYknKoQyoqlvwIZtOwdXBIjnRR
        hlIBCGBUZQw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E9B78146310;
        Wed, 15 May 2019 22:18:37 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F39514630F;
        Wed, 15 May 2019 22:18:37 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Poughon Victor <Victor.Poughon@cnes.fr>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Feedback on git-restore
References: <3E55146A6A81B44A9CB69CAB65908CEA6B91353C@TW-MBX-P01.cnesnet.ad.cnes.fr>
        <20190515103031.GA29149@ash>
Date:   Thu, 16 May 2019 11:18:36 +0900
In-Reply-To: <20190515103031.GA29149@ash> (Duy Nguyen's message of "Wed, 15
        May 2019 17:30:31 +0700")
Message-ID: <xmqq7ear5egz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9CAF612-7780-11E9-A4AA-E828E74BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I think it depends on whether use actively use the index, or you
> mostly ignore it and always do "git commit -a" and friends.
>
> When you do use the index, the "worktree <-> index <-> HEAD" is the
> three stages that you are aware, in that order, and restoring from the
> "next" stage is expected.
>
> It does feel natural for me that we "restore worktree from the index"
> and "restore index from HEAD". But maybe I'm just too used to the old
> way of thinking? Let's see what other people say.

I am somewhat sympathetic to unexperienced users who do not "get"
Git here, but because I still think you cannot make effective use of
Git without understanding the workflow using the index as an "extra"
level sitting between the working tree and the commits, I think it
is a learning experience worth investing in for a new user to get
used to the way of thinking you showed in the above paragraphs.

> This is also consistent with other commands, for example "git diff
> --staged/--cached" compares the index and HEAD and "git diff" compares
> worktree and the index. You would need extra effort e.g. "git diff
> HEAD" to compare the worktree and HEAD.

Exactly.

> This --index vs --staged was discussed and --staged is a compromise.
> The problem is --index means something different in existing
> commands. It specifies that you want to target both the index _and_
> worktree. --cached on the other hand only targets the index [1].
>
> It's confusing, yes. But --index/--cached is part of Git and we cannot
> just ignore our baggage and redefine --index to "just index".

Another thing worth pointing out here may be that a user would stop
feeling it a baggage once the index-centric way of thinking sinks
in.  Because the index is so central to the local use of Git
workflow (i.e. "I am just cloning and pulling from the outside world
to fllow along" does not count), "just the working tree and not the
index" mode is an anomaly, until/unless you start talking about
going backwards (e.g. "I've smudged my working tree by mistake, and
need to recover by copying something out to it", which is the mental
model of "restore").

	Side note: while at the mechanical level what it does is an
	equivalent to what "checkout -- <paths>" does, the mental
	models are different.  "checkout" is still a way to move
	forward "I need the contents of these paths in my next
	commit to look like those in that tree-ish, so copy them out
	to the working tree (to e.g. compile test) and also to the
	index (for e.g. the ease of committing after testing is
	done)".

> So the compromise is we leave --index/--cached alone and gradually
> move to the --staged/--worktree combo (for other commands as well).

I think what is truly new and valuable is the "working tree only,
bypassing the index" mode, but I am not sure if we want to always
force us to say both when we want to affect both the index and the
working tree, as the index is still central to the local workflow.
I am not sure if there is a wide agreement with such a "gradually
move to" plan.

Also, when you want to only affect the indexed contents, wouldn't
existing "--cached" suffice?

IOW, I do not mind --staged as a synonym for --cached, and --worktree
as a useful addition, but I do not think these new pair should replace
the existing ones.
