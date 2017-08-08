Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D174208B5
	for <e@80x24.org>; Tue,  8 Aug 2017 23:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752154AbdHHXeT (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Aug 2017 19:34:19 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58677 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751791AbdHHXeS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2017 19:34:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 404199997B;
        Tue,  8 Aug 2017 19:34:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Rd9GpitrQq9nRQwCGuRkgDFy0G0=; b=Lxqdmh
        M1bqwCqYvlcAkQCahOUBSqJk08ILTXL0RZ06xGUyKtsbeoYsx3mhvnARzIbmjWse
        r+vK3JmVBNH4XCVSy0HrFX00+l7QRywD20Nr/2qrwJ+PAemtODc8m4HoZC4Qr+or
        HB7UjKq2UwE6sqjbGUK2V8ZN3C8wMRWe+C9z4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=K20VUtKtqy8vdIK4JD59d9v4xCvlOrvN
        k3ShmxY7robTO3k3u0xGg4esnGX2GvtbpIGoDFZdSAY6fLdh1RCdNE4sxKfwRN5Z
        1I22O4gsIZaTBprqIsG+XfPwBbUnUXzFFVmHnY7jH132wtpW8k+764Foew1otf5Q
        ykpkvlnFWyE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 35AAC9997A;
        Tue,  8 Aug 2017 19:34:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8CBDC99979;
        Tue,  8 Aug 2017 19:34:16 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     git <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        David Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: reftable [v6]: new ref storage format
References: <CAJo=hJtg0PAVHT1phbArdra8+4LfnEEuaj3fBid==BXkZghi8g@mail.gmail.com>
        <xmqqtw1hc28z.fsf@gitster.mtv.corp.google.com>
        <CAJo=hJsyoFeCQbeJ=2XCRcE1U0zYaRr8VvzXHwkPwisdfUm71Q@mail.gmail.com>
Date:   Tue, 08 Aug 2017 16:34:15 -0700
In-Reply-To: <CAJo=hJsyoFeCQbeJ=2XCRcE1U0zYaRr8VvzXHwkPwisdfUm71Q@mail.gmail.com>
        (Shawn Pearce's message of "Tue, 8 Aug 2017 15:27:05 -0700")
Message-ID: <xmqqy3qt8wi0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 17ED0BA2-7C92-11E7-9B4C-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Shawn Pearce <spearce@spearce.org> writes:

> Given that the index can now also be multi-level, I don't expect to
> see a 2G index. A 2G index forces the reader to load the entire 2G to
> take advantage of the restart table. It may be more efficient for such
> a reader to have had the writer make a mutli-level index, instead of a
> single monster index block. And so perhaps the writer shouldn't make a
> 2G index block that she is forced to buffer. :)

Ah, OK, then it is sensible to have all table blocks to have the
same format, and restart at the beginning to help readers would be a
fine choice.  For the same "let's make them as consistent" sake, I
am tempted to suggest that we lift "the index block can be 2G" and
have it also be within uint_24(), perhaps?  Otherwise the readers
would have to read (or mmap) the whole 2G.
