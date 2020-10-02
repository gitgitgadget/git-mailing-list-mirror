Return-Path: <SRS0=3i0n=DJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 191C6C4363C
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 16:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA8B1206FA
	for <git@archiver.kernel.org>; Fri,  2 Oct 2020 16:41:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="NP+pb+ay"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387777AbgJBQlI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Oct 2020 12:41:08 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56544 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726017AbgJBQlH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Oct 2020 12:41:07 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4BB7A78AE4;
        Fri,  2 Oct 2020 12:41:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dS6ihW07MjElb+/T9LiGk244kFQ=; b=NP+pb+
        ayb+NpdtoNjnyuhSSuRtA67Fyvo4TkoeEXx1Nsei6SNbDh3Mtz+2ckwOkDywtX+Q
        VuGrsyem82x8CU/p/2VI78DJioNOiEIa4nr1dAl0BEWdEAHGcHKzrtizhl9i/OSU
        lFDk1zQ3bmf3DuwYr+TqUwHKSO4lWGq7JAPMw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=V291r6Gf4VoTFi+niNi3ez+6ydpt4OS+
        RGibVu22nm5D93nhyXDQWNhmj2Aw1NQ3CchuHUJzAmp6NPqaPGijBKZdTX5LOB46
        VsW58sBKpfXUl280YTcd58f+65CCvdCPsEl28cIoE8BbLj/t8pPRN0NR4flIlKbu
        NOuDoh/KD2k=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AED4378AE3;
        Fri,  2 Oct 2020 12:41:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0C59378AE2;
        Fri,  2 Oct 2020 12:41:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v9 1/3] push: add reflog check for "--force-if-includes"
References: <20200927141747.78047-1-shrinidhi.kaushik@gmail.com>
        <20201001082118.19441-1-shrinidhi.kaushik@gmail.com>
        <20201001082118.19441-2-shrinidhi.kaushik@gmail.com>
        <nycvar.QRO.7.76.6.2010021550170.50@tvgsbejvaqbjf.bet>
        <20201002150710.GA54370@mail.clickyotomy.dev>
Date:   Fri, 02 Oct 2020 09:41:03 -0700
In-Reply-To: <20201002150710.GA54370@mail.clickyotomy.dev> (Srinidhi Kaushik's
        message of "Fri, 2 Oct 2020 20:37:10 +0530")
Message-ID: <xmqqft6wa8dc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0FDBA406-04CE-11EB-92A7-01D9BED8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Srinidhi Kaushik <shrinidhi.kaushik@gmail.com> writes:

>> We should not call `in_merge_bases_many()` repeatedly: there is a much
>> better API for that: `get_reachable_subset()`.
>
> Perfect. I wasn't aware of this.

This is possibly a piece of misinformation.  in_merge_bases_many()
is designed to be callable more than once.  get_reachable_subset()
may be an overkill as we only are interested in a single "is this
one an ancestor of any of these?", not "which ones among these are
ancestors of the other set?".

> OK. The tests are passing with or without "GIT_TEST_COMMIT_GRAPH"
> by switching to "get_reachable_subset()" we don't have to toggle
> te feature during the check.

Correct.  Once the "see if this one is reachable from any of these"
is fixed (either by correcting the broken in_merge_bases_many() or
using get_reachable_subset()), we can get rid of this hack.

> Again, thank you so much working on this! If you'd like, I can go ahead
> and apply these patches and rename "reflog_commit_list" to "commit_array"
> in the next series (v10).

I like the s/list/array/ change, but I do not think switching to
get_reachable_subset() and having to receive a commit list only to
free the list is warranted.

Derrick sent a fix to in_merge_bases_many() in the near-by thread.

Thanks.
