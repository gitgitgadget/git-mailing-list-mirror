Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 223681F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 22:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730329AbfJCWQm (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 18:16:42 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:64353 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730297AbfJCWQm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 18:16:42 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 891318D994;
        Thu,  3 Oct 2019 18:16:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OykWiAZZkfQHPXG15hecD3U9HqQ=; b=HQQXoz
        Q6KjycehWZu7MQP8UYAD99S2daeOmMroTJ2uOCgysQ1VO/ieneNwEl1IHpIsKVCT
        miLO4k6oRXV7IOy/7G54WuMxk5FNXuhqwCgr76jZu7c0senF+vPU1ckJDXVDRcY7
        ls8K2Ryfbka6LNbZ12OG3TVw4XI6pxbpfaF+M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=xmhEn3RUeP2LvZxulFOZWbWmn5MTZiPx
        rkbeda8ENOfxfCuBNKP+xdsN//g/VRhizeKFkrjnfCnZDKnvAqc/6SnFaSTjzP3k
        7Xv/Ha5bWWRXk0F3uxjafS4oNiRErSJDeGCDMJQMk0KYv1CBbaXdgNIgvKUwdrIJ
        aojSilGGfis=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 81F6D8D993;
        Thu,  3 Oct 2019 18:16:40 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 37A258D990;
        Thu,  3 Oct 2019 18:16:37 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Allan Caffee <allan.caffee@gmail.com>,
        Noam Postavsky <npostavs@users.sourceforge.net>
Subject: Re: [BUG/PATCH 0/5] t4214: cleanup and demonstrate graph bug
References: <cover.1569407150.git.liu.denton@gmail.com>
        <20190925170902.GA11547@dentonliu-ltm.internal.salesforce.com>
        <20190926202326.GA16664@sigill.intra.peff.net>
Date:   Fri, 04 Oct 2019 07:16:34 +0900
In-Reply-To: <20190926202326.GA16664@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 26 Sep 2019 16:23:27 -0400")
Message-ID: <xmqqo8yxbhkt.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7762B924-E62B-11E9-B146-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> That works for the diagram in the code:
>
>            | *---.
>            | |\ \ \
>            |/ / / /
>            x 0 1 2
>
> where one of the parent lines is collapsing back to the left. But not
> for this more mundane case:
>
>   | *-----.   commit 211232bae64bcc60bbf5d1b5e5b2344c22ed767e
>   | |\ \ \ \  Merge: fc54a9c30c 9e30dd7c0e c4b83e618f 660265909f b28858bf65
>   | | | | | | 
>
> where we go straight down. I'm not sure I've fully grasped it, but it
> feels like that distinction is the source of the off-by-one. I'm not
> sure how to tell the difference here, though. I think it relies on the
> next commit on the left-hand line being the same as the first parent (or
> maybe any parent?).
>
> If I remove the use of parent_in_old_cols entirely, the merge looks
> right, but the "collapsing" one is broken (and t4214 fails).
>
> By the way, a useful trick I stumbled on to look at the coloring across
> many such merges:
>
>   git log --graph --format=%h --color | grep -A2 -e - | less -S
>
> It looks like every octopus in git.git is colored wrong (because they're
> the non-collapsing type).

Thanks for analysing further.  I wonder if new tests added by
Denton's BUG/PATCH series cover both kinds?  It would be good
to make sure that any "fix" corrects known-broken cases while
keeping the working cases still working.

Thanks.
