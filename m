Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D6F61F463
	for <e@80x24.org>; Fri, 13 Sep 2019 18:05:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388644AbfIMSFW (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Sep 2019 14:05:22 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58402 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387471AbfIMSFW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Sep 2019 14:05:22 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 432E583F53;
        Fri, 13 Sep 2019 14:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WHNnBWudAHaIeVWcUcaoHWdlbvc=; b=aNrr91
        LHKpCNKNQMRJC6HtneKwKzzOa0N3sFTr+aXCEoqMj6dDJTKlkZJaiTzCe6M8qXe/
        9OhKGxbYid8Ivu6IVfYbJaeL5GO/aG2WdWvggoDKO6wT4FsVdwKYgUzdg8m3wYUs
        O/hcPO6unpoxWb8FSXGaFyWpVG+9pFpIKsnoM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VJ3fa+7qxvwDq3H8yZRJveqpL4hpnSzU
        K7nMru5Opmt2YVWV1iJWHyIJhKX4Y7GSRqf9dmy2M85licUUrXaBFtZsOpUGAHOf
        RnT3+BMOsqPKuNHukee+9J3p52U71NDyzsmLr11hPnrJLquzTNbOJmNIlkYQMvWL
        0ZYNoyQI7us=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3B4AB83F51;
        Fri, 13 Sep 2019 14:05:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E5E4683F4E;
        Fri, 13 Sep 2019 14:05:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH] list-objects: don't queue root trees unless revs->tree_objects is set
References: <20190912000414.GA31334@sigill.intra.peff.net>
        <20190912001846.GA31370@sigill.intra.peff.net>
        <20190912011137.GA23412@sigill.intra.peff.net>
        <xmqqd0g5h2xm.fsf@gitster-ct.c.googlers.com>
        <20190912223400.GA2580@sigill.intra.peff.net>
Date:   Fri, 13 Sep 2019 11:05:14 -0700
In-Reply-To: <20190912223400.GA2580@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 12 Sep 2019 18:34:00 -0400")
Message-ID: <xmqqftl0dqcl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0A92ABF4-D651-11E9-BE14-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Thanks for spotting it.  I wonder if it was broken like this forever
>> since the beginning X-<.
>
> Not quite since the beginning; it comes from 8d2dfc49b1
> (process_{tree,blob}: show objects without buffering, 2009-04-10). I
> suspect nobody noticed because the cost for the normal case is really
> just shuffling some pointers around. It's only because it actively works
> against the commit-graph optimizations that it's so expensive there.

Yeah, that is what I meant by "since the beginning" (of
commit-graph, that is).

> I was surprised (and pleased) by how much such a simple thing helped.

Yes, it is very pleasing.  Thanks.
