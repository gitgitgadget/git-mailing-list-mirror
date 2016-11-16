Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAC2220451
	for <e@80x24.org>; Wed, 16 Nov 2016 18:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932592AbcKPS6d (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Nov 2016 13:58:33 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53962 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753881AbcKPS6d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Nov 2016 13:58:33 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CAA654E025;
        Wed, 16 Nov 2016 13:58:31 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cUwK+ba1BM2ON0SuG95RQOSVBAM=; b=JlLuVQ
        xFYpgm2dVVAjGsevBhT7TTo+2znLLiuLyI4H/CSmi32HmyFg2p2xKzYzLq0rBFKT
        tFUHEaMMgJliyvlaoYKYc2MBIwjf1yklJloi7Vs4sckuS7V1P9C3WkJAXFridHL4
        SPdxAETSpzY89TohDZ5CinVEtgW1B7UxdzdsM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aezo14NX3q9Uhcak1J+9qjUA/EXbhBSn
        ofghWkSf1DOW2gKe21nvxCbIJC23wXJYE1ywzfUHvCgA3WS2aHJFec9Mo4N4Rvvm
        90liFlpQKelWrkOV3g69PXPUEPQrp8Kv537TniB/LhDVpPlodoR9wN/dPB+pe8fy
        UMVFKGGmq5s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C2C634E024;
        Wed, 16 Nov 2016 13:58:31 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3E9174E01C;
        Wed, 16 Nov 2016 13:58:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git <git@vger.kernel.org>
Subject: Re: Protecting old temporary objects being reused from concurrent "git gc"?
References: <1479219194.2406.73.camel@mattmccutchen.net>
        <20161115170634.ichqrqbhmpv2dsiw@sigill.intra.peff.net>
        <1479231184.2406.88.camel@mattmccutchen.net>
        <20161115174028.zvohfcw4jse3jrmm@sigill.intra.peff.net>
Date:   Wed, 16 Nov 2016 10:58:30 -0800
In-Reply-To: <20161115174028.zvohfcw4jse3jrmm@sigill.intra.peff.net> (Jeff
        King's message of "Tue, 15 Nov 2016 12:40:29 -0500")
Message-ID: <xmqq1sybqmjt.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AAA39B30-AC2E-11E6-B20E-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I suspect the issue is that read-tree populates the cache-tree index
> extension, and then write-tree omits the object write before it even
> gets to write_sha1_file().

Wait a minute.  The entries in the index and trees in the cache-tree
are root of "still in use" traversal for the purpose of pruning,
which makes the "something like this" patch unnecessary for the real
index file.

And for temporary index files that is kept for 6 months, touching
tree objects that cache-tree references is irrelevant---the blobs
recorded in the "list of objects" part of the index will go stale,
which is a lot more problematic.
