Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CBD761FBB0
	for <e@80x24.org>; Mon, 24 Oct 2016 17:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941093AbcJXRQC (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 13:16:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56563 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934250AbcJXRQB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 13:16:01 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 36A01489B3;
        Mon, 24 Oct 2016 13:16:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GQhjjG/fZo+Sult8+gqKVY38TY8=; b=faKiBu
        QL90TNZH2CSZPw1Sx4ebHJ10KGM0JnOTG6+wHFe/osNa2tMK3puktUouu6grfjvH
        PmWF6YupxYyyOFLo+H4o4arp2Zk+5raSI4z519S+7401KGAbyCYh2C8AokhbOQAt
        ny27OtWKw0GUQFt4m0LmlVWKcHMFf/7rmo+2I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CwPHh5I97Mb/1EmSY710gbTbBi8I659D
        uO7Pgi4IFBK6yVSFkDTfdiAPPz4pOzOAJAQWDbuYN9x6Sws63HJJOCpi7flCQP8E
        e1M8u/U6MF7c9syYrHXghluqPH6IdHybvIwfAnikdsMbxBfLr0fGGG+ic8gvCHa5
        aAZYbJ0PE38=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2BF93489B2;
        Mon, 24 Oct 2016 13:16:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 99738489B1;
        Mon, 24 Oct 2016 13:15:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH] hex: use unsigned index for ring buffer
References: <ebf769d4-771f-499e-c7fc-f0377d8df18e@web.de>
        <20161023091146.p2kmqvgwxdf77dnn@sigill.intra.peff.net>
        <fb816dd5-8fb9-c6a6-2ec2-9ea4dddfdb26@web.de>
        <20161024130015.awlmgpfzixiy6wkb@sigill.intra.peff.net>
Date:   Mon, 24 Oct 2016 10:15:57 -0700
In-Reply-To: <20161024130015.awlmgpfzixiy6wkb@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 24 Oct 2016 09:00:15 -0400")
Message-ID: <xmqqwpgx7jn6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 887C27D0-9A0D-11E6-8136-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> > You could also write the second line like:
>> > 
>> >   bufno %= ARRAY_SIZE(hexbuffer);
>> > 
>> > which is less magical (right now the set of buffers must be a power of
>> > 2). I expect the compiler could turn that into a bitmask itself.
>> ...
>
> I think it would be preferable to just fix it inline in each place.

Yeah, probably.

My initial reaction to this was

 char *sha1_to_hex(const unsigned char *sha1)
 {
-	static int bufno;
+	static unsigned int bufno;
 	static char hexbuffer[4][GIT_SHA1_HEXSZ + 1];
 	return sha1_to_hex_r(hexbuffer[3 & ++bufno], sha1);

"ah, we do not even need bufno as uint; it could be ushort or even
uchar".  If this were a 256 element ring buffer and the index were
uchar, we wouldn't even be having this discussion, and "3 &" is a
way to get a fake type that is a 2-bit unsigned integer that wraps
around when incremented.

But being explicit, especially when we know that we can rely on the
fact that the compilers are usually intelligent enough, is a good
idea, I would think.

Isn't size_t often wider than uint, by the way?  It somehow makes me
feel dirty to use it when we know we only care about the bottom two
bit, especially with the explicit "bufno %= ARRAY_SIZE(hexbuffer)",
but I may be simply superstitious in this case.  I dunno.
