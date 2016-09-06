Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 650FC1F6BF
	for <e@80x24.org>; Tue,  6 Sep 2016 12:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933990AbcIFMoV (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Sep 2016 08:44:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62749 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933141AbcIFMoS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Sep 2016 08:44:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F2DF37644;
        Tue,  6 Sep 2016 08:44:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6ftjD/Abi4Jj7w86kV5K14kwG2I=; b=K0kFw7
        lxn3Ojtlml44/U39NJ4wDfqiRzO5RPneoRAVae30n4HYLXew2h9cEMvOnH+mwL4e
        Vp6Fl6ItCtaXeooyL5cPRlsxBQr4a8UaYm1Z/Zn9JkMpLPptri2ePTSzHOQ97PIn
        VAysPMmr1EKqE7raMioC7CK70TrYnzqju6dSY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=yMS7D7oi+dQQozLk+gHiuB6LHGZaJeu8
        YYDvAdasw8xhuMdBx3x0Int2l9joqpA3Rio/S1K2Vybfh3ZjXy8FtGepjWuu+fIe
        59SCoreihWDTOduNNFWtGIXdb5aXtW1j1xVudGKqIqR3NaZOnxlmrAY1Gv5Fjep5
        DJQDkbstNto=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 328A337643;
        Tue,  6 Sep 2016 08:44:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A003437642;
        Tue,  6 Sep 2016 08:44:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <stefanbeller@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [WIP PATCH v2] diff.c: emit moved lines with a different color
References: <20160904191435.14144-1-stefanbeller@gmail.com>
        <xmqq1t0yqinr.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xqx4PHHoKT_PK5s5eOtZMG9QJTSHED_=+BHZ=U330AQtw@mail.gmail.com>
        <CAGZ79kYPtvJ7iF8G5ihUCa5NwvDFa_Rzh+N7ar9QA2x74p2Z9g@mail.gmail.com>
Date:   Tue, 06 Sep 2016 05:44:09 -0700
In-Reply-To: <CAGZ79kYPtvJ7iF8G5ihUCa5NwvDFa_Rzh+N7ar9QA2x74p2Z9g@mail.gmail.com>
        (Stefan Beller's message of "Mon, 5 Sep 2016 19:09:30 -0700")
Message-ID: <xmqqoa41p59i.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C625070-742F-11E6-A70B-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> This new coloring is linear to the size of the patch, i.e. O(number of
> added/removed lines) in memory and for computational efforts I'd
> think it is O(n log n) as inserting into the hashmap is an amortized
> log n.

In addition to that O(n log n) overhead for book-keeping, you are
doing at least twice the amount of work compared to the original, if
you are still running the same xdiff twice to implement the two pass
approach.  That is why I thought this "twice as slow, at least"
needs to be off by default at least in the beginning.

Also there is the additional memory pressure coming from the fact
that the first pass will need to keep all the removed and added
lines in-core for all filepairs.  If you keep the entire diff output
in-core from the first pass, I do not think it would be that much
more memory overhead compared to what you are already doing, so the
cost of running the same xdiff twice is relatively easy to reduce, I
would imagine?  Instead of running the second xdi_diff_outf(), you
can drive your callback function out of what has been queued in the
first pass yourself.  But that is the next step "optimization" once
we got the basics right.

By the way, not running xdiff twice would also remove another worry
I have about correctness, in that the approach depends on xdiff
machinery to produce byte-for-byte identical result given the same
pair of input.  The output may currently be reproducible, but that
is an unnecessary and an expensive thing to rely on.

You may be able to save tons of memory if you do not store the line
contents duplicated.  The first pass callback can tell the line
numbers in preimage and postimage [*1*], so your record for a
removed line could be a pair <struct diff_filespec *, long lineno>
with whatever hash value you need to throw it into the hash bucket.

I know we use a hash function and a line comparison function that
are aware of -b/-w comparison in xdiff machinery, but I didn't see
you use them in your hashtable.  Can you match moved lines when
operating under various whitespace-change-ignoring modes?

Thanks.


[Footnote]

*1* You can learn all sort of things from emit_callback structure;
    if you need to pass more data from the caller of xdi_diff_outf()
    to the callback, you can even add new fields to it.

