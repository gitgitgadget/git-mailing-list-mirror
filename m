Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90A0220281
	for <e@80x24.org>; Thu, 21 Sep 2017 01:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751462AbdIUBqe (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Sep 2017 21:46:34 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59872 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751390AbdIUBqd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2017 21:46:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 65F8892F86;
        Wed, 20 Sep 2017 21:46:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XD/R2NwjCL78wxfzv1U2+dOqzEc=; b=xsWSYt
        b/x7ehMu5xkwN+YYQxpMEv90sw/+0QMDoMQ1G/rEcDpuPgJQJPc1IrVxPYW7I1Da
        HcX12QLZKJ4WCuJD4riDleO+k5JvTJIQYdqgxESr13R00Gg72vJxFafqgBrIdfa1
        B78v/3+4t6PRPbllZc5/M3BFISdynsdFhXE7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AvVEbaCNj4dUkT7x8C3JPSl3Ncd+CnZt
        ObtBHguXY9Ye0AcgO3KVFH1V/ewS+l1gBO0QpG28Nz1dJ0Kjd+aH9aH2dt9cXj9E
        pQupxCArLC+DROUe442f/tvDOuq8ul22VGGIySuxjcFY1oLMP4dzDdjCU39yByz5
        pp/ljo+A8AU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5CB9492F85;
        Wed, 20 Sep 2017 21:46:30 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 89F8892F83;
        Wed, 20 Sep 2017 21:46:29 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Ben Peart <benpeart@microsoft.com>, David.Turner@twosigma.com,
        avarab@gmail.com, christian.couder@gmail.com, git@vger.kernel.org,
        johannes.schindelin@gmx.de, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH v7 03/12] update-index: add a new --force-write-index option
References: <20170915192043.4516-1-benpeart@microsoft.com>
        <20170919192744.19224-1-benpeart@microsoft.com>
        <20170919192744.19224-4-benpeart@microsoft.com>
        <xmqq7ewtor9u.fsf@gitster.mtv.corp.google.com>
        <682237f1-4747-5712-e95b-285379eb1b69@gmail.com>
Date:   Thu, 21 Sep 2017 10:46:28 +0900
In-Reply-To: <682237f1-4747-5712-e95b-285379eb1b69@gmail.com> (Ben Peart's
        message of "Wed, 20 Sep 2017 10:58:11 -0400")
Message-ID: <xmqq8th8n7rf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B01EA6B2-9E6E-11E7-9541-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

> Lets see how my ascii art skills do at describing this:

Your ascii art is fine.  If you said upfront that the capital
letters signify points in time, lower letters are file-touching
events, and time flows from left to right, it would have been
perfect ;-)

> There is no real concern about accumulating too many changes as 1) the
> processing cost for additional modified files is fairly trivial and 2)
> the index ends up getting written out pretty frequently anyway as
> files are added/removed/staged/etc which updates the
> fsmonitor_last_update time.

I still see some impedance mismatch here.  The optimization
described is valid but the code to do the optimization would avoid
writing the index file out when the in-core index is dirty only
because the status reported by fsmonitor changed--if there were
other changes (e.g. the code added a new index entry), even with the
optimization, you would still want to write the index out, right?

With or without the need for forced flush to help debugging, would
that suggest that you need two bits now, instead of just a single
'active-cache-changed' bit?

By keeping track of that new bit that tells us if we have
fsmonitor-only changes that we _could_ flush, this patch can further
reduce the need for forced flushing (i.e. if we know we didn't get
fsmonitor induced dirtyness, force_write can still be no-op), no?

>
> The challenge came when it was time to test that the changes to the
> index were correct.  Since they are lazily written by default, I
> needed a way to force the write so that I could verify the index on
> disk was correct.  Hence, this patch.
>
>
>>>   		OPT_END()
>>>   	};
>>>   @@ -1147,7 +1150,7 @@ int cmd_update_index(int argc, const char
>>> **argv, const char *prefix)
>>>   		die("BUG: bad untracked_cache value: %d", untracked_cache);
>>>   	}
>>>   -	if (active_cache_changed) {
>>> +	if (active_cache_changed || force_write) {
>>>   		if (newfd < 0) {
>>>   			if (refresh_args.flags & REFRESH_QUIET)
>>>   				exit(128);
