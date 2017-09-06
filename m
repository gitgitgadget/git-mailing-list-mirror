Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 13A10208E3
	for <e@80x24.org>; Wed,  6 Sep 2017 03:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752840AbdIFDn1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 23:43:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63542 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752471AbdIFDn1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 23:43:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85568970E6;
        Tue,  5 Sep 2017 23:43:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=ZwioQpdvnznVHxn5MWVNLg1poNo=; b=w/4xHFnSREjmJsOtgt7d
        g171lD5M+03jHGsMWed12L7dd9QMnyXDq/v0kT4hXOjieUgxolQaxhjoCpxP756H
        GyOtQ4QsQ+ZzLXS5Z60ph+HKgzi7sIgiaVRYLaY14UKdV1J9cS/BycvthntcLsD0
        Ot3ybLWimnWfun+iamdLL8c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=SQM0Z9tRmgsDszZN2GFIYDFAhUrzY7oF5/AttSrvCyKiSv
        NQFRZr9ATCxCKoKZ+OO5xIBMI9RNdICvMNMvzsQ2N8Abvft/54Pv/CrnCEjjMi5I
        7b+M+46N1Iw8cJZx1s9wWkEuyf0sw591VuaMugwYRwOS3paspkfmMVJDqXBGo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7D717970E5;
        Tue,  5 Sep 2017 23:43:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF686970E4;
        Tue,  5 Sep 2017 23:43:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <git@jeffhostetler.com>, martin.agren@gmail.com,
        git@vger.kernel.org, jeffhost@microsoft.com
Subject: Re: [PATCH] hashmap: add API to disable item counting when threaded
References: <adb37b70139fd1e2bac18bfd22c8b96683ae18eb.1502780344.git.martin.agren@gmail.com>
        <20170830185922.10107-1-git@jeffhostetler.com>
        <20170830185922.10107-2-git@jeffhostetler.com>
        <alpine.DEB.2.21.1.1709020109520.4132@virtualbox>
        <20170902081747.lca2kkzpniykdxy2@sigill.intra.peff.net>
Date:   Wed, 06 Sep 2017 12:43:24 +0900
Message-ID: <xmqqwp5c7aqr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 89F41D6A-92B5-11E7-9ACB-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Sep 02, 2017 at 01:31:19AM +0200, Johannes Schindelin wrote:
>
>> BTW this made me think that we may have a problem in our code since
>> switching from my original hashmap implementation to the bucket one added
>> in 6a364ced497 (add a hashtable implementation that supports O(1) removal,
>> 2013-11-14): while it is not expected that there are many collisions, the
>> "grow_at" logic still essentially assumes the number of buckets to be
>> equal to the number of hashmap entries.
>
> I'm confused about what the problem is. If I am reading the code
> correctly, "size" is always the number of elements and "grow_at" is the
> table size times a load factor. Those are the same numbers you'd use to
> decide to grow in an open-address table.
>
> It's true that this does not take into account the actual number of
> collisions we see (or the average per bucket, or however you want to
> count it). But generally nor do open-address schemes (and certainly our
> other hash tables just use load factor to decide when to grow).

Are we comparing the hashmap.[ch] with the hash.[ch] added in
9027f53c ("Do linear-time/space rename logic for exact renames",
2007-10-25)?  I am a bit confused because Johannes calls it "my"
original.

Unless the real person in this discussion thread sending the
messages under Johannes's name is Linus, that is ;-).  Or maybe the
"original" being compared is something other than the series with
6a364ced497 replaced with its hashmap.[ch]?

In any case, I do think your reading of the code is correct in that
the comparison between size and grow-at/shrink-at is done correctly
with the true load factor of the table, not how many buckets out of
the possible buckets are filled.  

Old one used to grow at 50% full and never shrunk it, but the
current one grows at 80% and shrinks at a bit below 40%; I agree
with Dscho's feeling (in part not quoted above) that 50% vs 80%
doesn't seem to have been backed by any numbers, but optimizing the
load factor is outside the scope of this series, I would think.

6a364ced ("add a hashtable implementation that supports O(1)
removal", 2013-11-14) credits less frequent resizing for gain of
insert performance, but my hunch is that the need for frequent
resizing in the version before it primarily comes from the fact that
the table started empty (as opposed to having an initial size of 64,
which is what the current implementation uses).
