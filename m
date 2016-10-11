Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B2B21F4F8
	for <e@80x24.org>; Tue, 11 Oct 2016 21:36:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753367AbcJKVgg (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Oct 2016 17:36:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63697 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753342AbcJKVgf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2016 17:36:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ED32543EFD;
        Tue, 11 Oct 2016 17:36:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wRyrk+tmNldBxPxt4jBBzAIrvxc=; b=CxADHg
        mH3Eq+XcM9XLmqBOzPob5AmoS43YO6gGB+/L3GkZo2FbG25OyhV428uPav8Jkt0C
        e0WfUoCWkrH8opAbe58xHfoK/lYpgw2TxtRhLR2Ly3OjJhzQ4gBGw1tBivocY7uf
        shapF7PAkFroT5+Pp5CYpY05mFNqlRwQhFz1Q=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HJAcfuQdvhcm6f2+/s3zEZ8ZRQVA+mWt
        mJ7IA1hqfYPmOc8FMEDMXvsIiZItwIWziCM87JKgekAlPxsYC2ffyQBM6L6ZBjB/
        VL27TNxEKU7MKkKFRg8RKb9cl8lgcWRvw+p2p7HLqiTA4c3oMfUN37dVXLZq8CKY
        gzLFiP2HC/I=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E26D343EFC;
        Tue, 11 Oct 2016 17:36:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 42B2D43EF6;
        Tue, 11 Oct 2016 17:36:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/2] Support `git reset --stdin`
References: <cover.1476202100.git.johannes.schindelin@gmx.de>
        <20161011183448.yasglfjelo4kgrq4@sigill.intra.peff.net>
        <xmqqshs28z52.fsf@gitster.mtv.corp.google.com>
        <20161011212644.zzqidtcgatu3qsei@sigill.intra.peff.net>
Date:   Tue, 11 Oct 2016 14:36:31 -0700
In-Reply-To: <20161011212644.zzqidtcgatu3qsei@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 11 Oct 2016 17:26:44 -0400")
Message-ID: <xmqqoa2q7elc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C77DD478-8FFA-11E6-B1FD-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> If read-tree had pathspec support (i.e. "read these and only these
>> paths given from the command line into the index from a given
>> tree-ish"), that would have been the most natural place to extend
>> with "oh, by the way, instead of the command line, you can feed the
>> paths on the standard input".
>> 
>> But it doesn't have one.
>
> True. I'd have done something more like:
>
>   git ls-tree -r $paths | git update-index --index-info
>
> but there are some corner cases around deleting paths from the index.

Ah, I would think read-tree has the exact same issue, even if we
added pathspec support, around removal.

So it is more like

	(
		printf "0 0000000000000000000000000000000000000000\t%s\n" $paths
		git --literal-pathspecs ls-tree -r --ignore-missing $paths
	) | git update-index --index-info

which does not look too bad, even though this

	printf "%s\n" $paths | git reset --stdin

does look shorter.

