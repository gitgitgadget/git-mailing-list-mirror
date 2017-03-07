Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B0C61FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 18:34:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755743AbdCGSes (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 13:34:48 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52993 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754036AbdCGSeq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 13:34:46 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F7857BAD9;
        Tue,  7 Mar 2017 13:16:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rzc9WO5ye+ZOHSfDb7JTLF+Q8Sk=; b=sFz30P
        kpWVVZ4qB4CK5ktgnIa7cHWWUXfljzZkHWpdB3ffNxiYqcaYatLfIDRfkEU3xDNy
        Aecvwez7nTJC9MDsfBo90YKDJodhL0mZTZ8F8k/TQgo47U/+9MKtpwwhJosgx3gv
        GU+VCGU4OJ4mS7a7201oajhtTmXt2ZHHunex4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bsdQJDuUvHEwtEYCNOO43oXkFLa7q0y/
        PoG5etenouqHZGVoKhcdNdaUZAzSh5Q4IZrSgZHivqfBHYx1o/m1/CExD4G+tcZG
        1oog7jF8cNLTxdiNDfw0bCa9EvrLatOjUqtvLHLRySfnT60yHnzXCuGXOyHfH5yr
        7nOIQbF15Hg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1785A7BAD8;
        Tue,  7 Mar 2017 13:16:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 862997BAD7;
        Tue,  7 Mar 2017 13:16:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Christophe Macabiau <christophemacabiau@gmail.com>
Subject: Re: fatal error when diffing changed symlinks
References: <CAC0icTZ87yeYndPFyjD4nkJBcw5SC-bgUJYbEzYqH7YhSFZvuQ@mail.gmail.com>
        <xmqqshn34gsh.fsf@gitster.mtv.corp.google.com>
        <xmqqtw7j1i6d.fsf@gitster.mtv.corp.google.com>
        <20170224203523.mdoh4ivhwflmpr6j@sigill.intra.peff.net>
        <alpine.DEB.2.20.1702251336420.3767@virtualbox>
Date:   Tue, 07 Mar 2017 10:16:56 -0800
In-Reply-To: <alpine.DEB.2.20.1702251336420.3767@virtualbox> (Johannes
        Schindelin's message of "Sat, 25 Feb 2017 13:36:58 +0100 (CET)")
Message-ID: <xmqqfuip7y07.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4020A33A-0362-11E7-B9A5-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > When viewing a working tree file, oid.hash could be 0{40} and
>> > read_sha1_file() is not the right function to use to obtain the
>> > contents.
>> > 
>> > Both of these two need to pay attention to 0{40}, I think, as the
>> > user may be running "difftool -R --dir-diff" in which case the
>> > working tree would appear in the left hand side instead.
>> 
>> As a side note, I think even outside of 0{40}, this should be checking
>> the return value of read_sha1_file(). A corrupted repo should die(), not
>> segfault.
>
> I agree. I am on it.

Friendly ping, if only to make sure that we can keep a piece of this
thread in the more "recent" pile.

If you have other topics you need to perfect, I think it is OK to
postpone the fix on this topic a bit longer, but I'd hate to ship
two releases with a known breakage without an attempt to fix it, so
if you are otherwise occupied, I may encourage others (including me)
to take a look at this.  The new "difftool" also has a reported
regression somebody else expressed willingness to work on, which is
sort of blocked by everybody else not knowing the timeline on this
one.  cf. <20170303212836.GB13790@arch-attack.localdomain>

A patch series would be very welcome, but "Please go ahead if
somebody else has time, and I'll help reviewing" would be also
good.

Thanks.
