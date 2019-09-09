Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EAEE1F461
	for <e@80x24.org>; Mon,  9 Sep 2019 17:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391382AbfIIRz0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 9 Sep 2019 13:55:26 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:57731 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728768AbfIIRz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Sep 2019 13:55:26 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 17FFB92879;
        Mon,  9 Sep 2019 13:55:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oswFmCRev9CET43lcW3U6aoCs88=; b=L472O0
        fFRdxDkW6Crk4NhC2rUTeVJEegBl5fQ0CI86Zkt3gBVJIQleRrcDd/1OkJL1AKiQ
        IZ+BxAJbPzFx9w+RCyhmwOVsRAv6wJj6HIzhc5pDiRanGuhjwTUAB8EkDR3KKsds
        WmRtzEMRA//Q+C7Fhhuk8RyBz2zR2Ujbvyjmo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=wkHt2/AOe/vn5bOvUZyzheccKcngpgDc
        +JMngY8kpOuoMlvRYIFUi+wMV5LTHi2SvTCG6/2l4u93mGa3VYvnrvkk3Hmc8Vb+
        w0rHot9K4uPLev56TiXSDkyp1CE5gd2362Y7Lj7O6Y3mkD5OYI8/OAsdmD7ttmsC
        EGxKNTD/4R8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E0C7A92878;
        Mon,  9 Sep 2019 13:55:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 044D792876;
        Mon,  9 Sep 2019 13:55:20 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        stolee@gmail.com
Subject: Re: [PATCH 3/3] commit-graph.c: handle corrupt/missing trees
References: <cover.1567720960.git.me@ttaylorr.com>
        <9fbd965e3892307bb5bb78952f017624fcc0b73a.1567720960.git.me@ttaylorr.com>
        <20190906061919.GA5122@sigill.intra.peff.net>
        <xmqqo8zxnz0m.fsf@gitster-ct.c.googlers.com>
        <20190906172851.GC23181@sigill.intra.peff.net>
Date:   Mon, 09 Sep 2019 10:55:18 -0700
In-Reply-To: <20190906172851.GC23181@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 6 Sep 2019 13:28:52 -0400")
Message-ID: <xmqqftl5l5h5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FDB8AC86-D32A-11E9-AC0A-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>>     Answer. There is a single hit inside fsck.c that wants to report
>>     an error without killing ourselves in fsck_commit_buffer().  I
>>     however doubt its use of get_commit_tree() is correct in the
>>     first place.  The function is about validating the commit object
>>     payload manually, without trusting the result of parse_commit(),
>>     and it does read the object name of the tree object; the call to
>>     get_commit_tree() used for reporting the error there should
>>     probably become has_object() on the tree_oid.
>
> I actually think that check should be removed entirely. That function is
> about checking the syntactic validity of the object itself, not about
> connectivity (which is handled separately). We already check that we
> have a valid "tree" pointer earlier in the function.

Of course, you're right.
