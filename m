Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7472F20193
	for <e@80x24.org>; Thu, 27 Oct 2016 16:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754835AbcJ0QNP (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Oct 2016 12:13:15 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64387 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751011AbcJ0QNO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Oct 2016 12:13:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4C37849A99;
        Thu, 27 Oct 2016 12:13:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4FLM+8r9L70sj5Ul+K64FmHUVpo=; b=m1IZLW
        bJnxMKQzfCdDbiIRfQ4Xd9Hl231NYseRrmxaSvtALhJrxXzxAVOOxQzrWmc+YFSa
        B3JWUcOn5+VljIWwAb3TGecyoTOeX88YdVloXEOucYC2on3U6pQvaPvMKi1O1Zz/
        eS5i0ClM5OXBQI0eTsLePlNt6T6q28WlrCWQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=OseM3UAGGSsiyJwvoFnDpr9ZcWUgPCXl
        e9cokXGbTlf+s1we9eg9jOwLYGtWX57kuQ0VBG/WCzIx1gBTBu2II9CSvZPdinz7
        dWVNAvHC07XrOvFzKhNnfaZ3iFNNFinonikZ5Zd4+laoYD0HZptb1RHChd8Djp6B
        nqqGp1SpZ+4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 42BAD49A98;
        Thu, 27 Oct 2016 12:13:13 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 933B949A97;
        Thu, 27 Oct 2016 12:13:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v1 16/19] read-cache: unlink old sharedindex files
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
        <20161023092648.12086-17-chriscool@tuxfamily.org>
        <CACsJy8C4Qd76LSYxk9BJtN3n3Knv_RCDgBOO-ybkNHFZK61ahQ@mail.gmail.com>
        <CACsJy8BPe085Qu4GpJ3MLTPeZM_7pbVrX31enQrGQn0oyjSrdg@mail.gmail.com>
Date:   Thu, 27 Oct 2016 09:13:10 -0700
In-Reply-To: <CACsJy8BPe085Qu4GpJ3MLTPeZM_7pbVrX31enQrGQn0oyjSrdg@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 27 Oct 2016 17:25:38 +0700")
Message-ID: <xmqq4m3x93e1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 42705644-9C60-11E6-BEDA-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Christian, if we assume to go with Junio's suggestion to disable
> split-index on temporary files, the only files left we have to take
> care of are index and index.lock. I believe pruning here in this code
> will have an advantage over in "git gc --auto" because when this is
> executed, we know we're holding index.lock, so nobody else is updating
> the index, it's race-free.
>
> All we need to do is peek in $GIT_DIR/index
> to see what shared index file it requires and keep it alive too, the
> remaining of shared index files can be deleted safely. We don't even
> need to fall back to mtime.

Yes, that exactly was why I wondered if we can afford to limit
splitting only to the primary index, because it makes things a
lot simpler.

But I suspect that temporary index is where split-index shines most,
e.g. while creating a partial commit.  The mechanism penalizes the
read performance by making the format more complex in order to favor
the write performance, which is very much suited for temporary one
that is read only once after it is written before it gets discarded
(on the other hand, splitting the primary index will penalize reads
that happen a lot more than writes).

While I still find it attractive at the conceptual level to limit
splitting only to the primary index for the resulting simplicity,
I doubt it is a good way to go, as I meant to say in
<xmqqeg33ccjj.fsf@gitster.mtv.corp.google.com>

> git-gc just can't match this because while it's running, somebody else
> may be updating $GIT_DIR/index. Handling races would be a lot harder.

It could attempt to take a lock on the primary index while it runs,
and refrain to do anything if it can't take the lock ("gc --auto"
may want to silently retry), and then the race is no longer an
issue, no?
