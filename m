Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 024DB1F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 17:21:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932553AbcH3RVB (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 13:21:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52501 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1758540AbcH3RVA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 13:21:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CB373A3F1;
        Tue, 30 Aug 2016 13:20:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=IAOvRgXZ+ugQUGeN1ZAQ3sseVFQ=; b=kI9Y2v
        oz6sTk2gFwnLaXQc2T7Ualc4ghrg8z1Bn2l+SeLM1S0pYNIkm7xdWAG6dchtwQH2
        nzU31HY4oV4rdlQQV7XTsnHeJVy77oTFatwHIgswoqoYYSRT6+New5h+fg5i5gIu
        t9GomQw2dZVyMd5NOV7l943VNPZW4dLtZPV08=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LCWpohjbbveIN9RI2O4aNj2HgDLKVJzZ
        EkLtgaRxHAD2l6abm3i4meDF1jZjeBwjvQNLaJbCqw+Xp1iEUOWAw7wFZwypAUkn
        BUttgK5ZlK4GPJMBqhTqlF2u64xi1zWwf7eI7oiAUTc4TXFdvnYItr1m2T4w6Ucz
        GO8f0QUniJo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 842473A3EF;
        Tue, 30 Aug 2016 13:20:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0BFF43A3EE;
        Tue, 30 Aug 2016 13:20:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 08/14] sequencer: lib'ify read_and_refresh_cache()
References: <cover.1471968378.git.johannes.schindelin@gmx.de>
        <cover.1472219214.git.johannes.schindelin@gmx.de>
        <99f3ab3a30a469b271300ff61309ac4c4a8af448.1472219214.git.johannes.schindelin@gmx.de>
        <xmqq7faz9ufi.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1608301106220.129229@virtualbox>
Date:   Tue, 30 Aug 2016 10:20:51 -0700
In-Reply-To: <alpine.DEB.2.20.1608301106220.129229@virtualbox> (Johannes
        Schindelin's message of "Tue, 30 Aug 2016 11:09:31 +0200 (CEST)")
Message-ID: <xmqqoa4a5g24.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1AA79148-6ED6-11E6-9F27-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> With the current set of callers, a caller that notices an error from
>> this function will immediately exit without doing any further
>> damage.
>> 
>> So in that sense, this is a "safe" conversion.
>> 
>> But is it a sensible conversion?  When the caller wants to do
>> anything else (e.g. clean-up and try something else, perhaps read
>> the index again), the caller can't, as the index is still locked,
>> because even though the code knows that the lock will not be
>> released until the process exit, it chose to return error without
>> releasing the lock.
>
> It depends what the caller wants to do. The case about which I care most
> is when some helpful advice should be printed (see e.g. 3be18b4 (t5520:
> verify that `pull --rebase` shows the helpful advice when failing,
> 2016-07-26)). Those callers do not need to care, as the atexit() handler
> will clean up the lock file.
>
> However, I am sympathetic to your angle, even if I do not expect any such
> caller to arise anytime soon.

We just fixed a similar "why are we allowing the 'if the_index
hasn't been read, read unconditionally from $GIT_INDEX_FILE" that is
reached by a codepath that is specifically designed to read from a
temporary index file while reviewing a separate topic, and that is
where my reaction "this is not very helpful for other callers" comes
from.
