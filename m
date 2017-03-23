Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2840920958
	for <e@80x24.org>; Thu, 23 Mar 2017 17:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965223AbdCWRwi (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 13:52:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57174 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933925AbdCWRwh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 13:52:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 045258B2F8;
        Thu, 23 Mar 2017 13:52:36 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RUiaVjACQuFH+8R2xK8EP7tSGIM=; b=HFGQ9I
        dt++WW1+qOXNoYb1YeixXHu9vluy8kktUG68lRn1MOa9q4qSZVexI8sDTKXo+uSb
        Eed8kLXZtueBW38y41dy9HpAWK7SWe0SAjZaultwTCatsahyirHnI9JqndremlRW
        jqGjJNNcTzYOq/peu8+sxGOjN+gqZHILWr6tY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KHXRX6uzeauKF0O1r1bbcwhDKncJ/CnG
        tN1T3jYRsTtnSfMPs1WJoWNqpV5EcLM9Z+KmUeVBjH1o+nKlfmrsjIjAx87mjHbV
        0ogyTMo9emvGLexzmGFl1rsJ7aEKaHbtzkS6UCvYTLWGW+I8RMaUHB5bT04cncNi
        XEDvDNHgm0I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F197A8B2F7;
        Thu, 23 Mar 2017 13:52:35 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 502B18B2F6;
        Thu, 23 Mar 2017 13:52:35 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v2 0/7] thread lazy_init_name_hash
References: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
Date:   Thu, 23 Mar 2017 10:52:34 -0700
In-Reply-To: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
        (git@jeffhostetler.com's message of "Thu, 23 Mar 2017 13:46:58 +0000")
Message-ID: <xmqqh92jev8d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7F2F43B0-0FF1-11E7-AAB2-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git@jeffhostetler.com writes:

> From: Jeff Hostetler <jeffhost@microsoft.com>
>
> Version 2 of this patch series addresses the coding
> style issues, compile errors in non-threaded builds,
> and updated API documentation.
>
>
> This patch series is a performance optimization for
> lazy_init_name_hash() in name-hash.c on very large
> repositories.
>
> This change allows lazy_init_name_hash() to optionally
> use multiple threads when building the the_index.dir_hash
> and the_index.name_hash hashmaps.  The original code path
> has been preserved and is used when the repo is small or
> the system does not have sufficient CPUs.
>
> A helper command (t/helper/test-lazy-init-name-hash) was
> created to demonstrate performance differences and validate
> output.  For example, use the '-p' option to compare both
> code paths on a large repo.
>
> During our testing on the Windows source tree (3.1M
> files, 500K folders, 450MB index) with an 8 (logical)
> core machine, we reduced the runtime of lazy_init_name_hash()
> from 1.4 to 0.27 seconds.
>
> This patch series replaces my earlier
>      * jh/memihash-opt (2017-02-17) 5 commits
> patch series.  This series is an improvement over the
> original proposal because it completely isolates the changes
> in name name-hash.c (rather than having parts in preload-index.c)
> and eliminates the need to update/invalidate precomputed hash
> values as cache_entries are changed.

Having the above helps readers by giving them what to expect to see
to prepare them before they dive into the patches ;-)

The API document update in 4/7 is a nice addition and it comes at
the right spot in the series, just after API enhancement is done.  I
gave a quick reading on it twice, and all looked reasonable.  Nicely
done.

I queued the sparse things Ramsay pointed out in the form of
"SQUASH???" immediately that follows your original patch while
applying the series, so please check what I push out (when it
happens) and if there is no further change needed, just tell me to
actually squash them in, if you think these SQUASH??? patches are
good.  That way we do not have to have another reroll only to fix
these up ;-)

I'll need to re-read "name-hash: perf improvement for lazy_init_name_hash"
later again to convince myself, but during my initial read (from the
last round) I didn't spot anything wrong there.

Thanks.
