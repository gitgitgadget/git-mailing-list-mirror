Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9AD1F461
	for <e@80x24.org>; Mon,  9 Sep 2019 17:12:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728928AbfIIRMI (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 13:12:08 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60354 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727423AbfIIRMI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 13:12:08 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 369CF68E62;
        Mon,  9 Sep 2019 13:12:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=r2vbsYxWZVhbsZtVUwD5YwwJcdg=; b=olDjDh
        Mn6sO/+6hTdNIM3rLrImGv4aWw1AuhvEIHnf6jPHvZTVDO0OLJR9s7eU3sBDGAa0
        lbX+N04+Al5WAOZkUUdw9xhVne14tOpQaj5xufN38GNFUPm3+ajmdyDm9n7VlJuJ
        RAbHHPhO26FuG+ehV//UHkgfjrUBEp43dv9Qg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=TM//a35EMDD+kKBh+AgRMrlUl+kN/px0
        nbzwZLU+5LrymF8XUAapftUf8XAfvFS8KV92/Ti6f7Kb0hTprECYroB9nOLU/I4V
        bb/wSDoAX1NwmhUvTe42KDs5bjMsutlCs1d7FBP/n5J2QNZt/wOxdzOvpY9v/OQw
        q/m3N2afbyY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D7AC68E61;
        Mon,  9 Sep 2019 13:12:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5925A68E5F;
        Mon,  9 Sep 2019 13:12:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Jeff King <peff@peff.net>, Jeff Hostetler <jeffhost@microsoft.com>,
        Jon Simons <jon@jonsimons.org>, git@vger.kernel.org,
        me@ttaylorr.com, sunshine@sunshineco.com, stolee@gmail.com
Subject: Re: [PATCH v3 1/2] list-objects-filter: only parse sparse OID when 'have_git_dir'
References: <20190829231925.15223-1-jon@jonsimons.org>
        <20190829231925.15223-2-jon@jonsimons.org>
        <xmqqr252y199.fsf@gitster-ct.c.googlers.com>
        <20190904045424.GA6488@sigill.intra.peff.net>
        <xmqqv9u6po4j.fsf@gitster-ct.c.googlers.com>
        <f32d2e8c-abec-0ec1-daa7-4c10470c5553@jeffhostetler.com>
Date:   Mon, 09 Sep 2019 10:12:01 -0700
In-Reply-To: <f32d2e8c-abec-0ec1-daa7-4c10470c5553@jeffhostetler.com> (Jeff
        Hostetler's message of "Mon, 9 Sep 2019 09:54:36 -0400")
Message-ID: <xmqqv9u1l7ha.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F1669A5C-D324-11E9-87F1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff Hostetler <git@jeffhostetler.com> writes:

> It would be nice if we could continue to let parse_list_objects_filter()
> do the syntax checking -- that is, we can still check that we received a
> ulong in "blob:limit:<nr>" and that "sparse:oid:<oid>" looks like a hex
> value, for example.  Just save the actual <oid> lookup to the higher
> layer, if and when that makes sense.

Hmmm, am I misremembering things or did I hear somebody mention in
this thread that people give "sparse:oid:master" (not blob object
name in hex, but a refname) and expect the other side to resolve it?
