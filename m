Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63F79208CD
	for <e@80x24.org>; Mon, 21 Aug 2017 23:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754049AbdHUXm0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 19:42:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61094 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753790AbdHUXmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 19:42:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E33A09FF42;
        Mon, 21 Aug 2017 19:42:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Y/JKRlJH9LY0j69n2yPkOQ3ABmQ=; b=a68Syv
        NYamlLpweaY6hTk6GJRr4IgdJFPVmvNYxyvPZ7PIton5m3CNmBAJ0AtkvWEn5UJc
        0960kO1WXKRx5ngcmEfgc/hhBzkgrtVJk4vg4FA/3k8RUc3MW794UHIBrc6C3fuN
        KQPNRP/2Zqf42MtiulqCrOGHzKs8KMVCdzwlM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=aiQ1cKhrX69/mxDP0Qq2y8Lb2OivtGhp
        UEQwRNfrBtzXeRnE2sbcbDwp9gmEZ7hOmybGyytOd8HqZ6muLsOy+r2or58HzSKy
        AhPcjOzgO71Hc8s7aWyUbLGgKXWV7uqCbG/QbBEyt47lBgi3KZBqglgNpX5uf4QT
        YsuqwQPqeEk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D96BC9FF41;
        Mon, 21 Aug 2017 19:42:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 45A1E9FF3F;
        Mon, 21 Aug 2017 19:42:17 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Willford <kewillf@microsoft.com>
Cc:     git@vger.kernel.org, peff@peff.net, peartben@gmail.com
Subject: Re: [PATCH 3/3] read-cache: avoid allocating every ondisk entry when writing
References: <20170821212432.47364-1-kewillf@microsoft.com>
        <20170821212432.47364-4-kewillf@microsoft.com>
Date:   Mon, 21 Aug 2017 16:42:16 -0700
In-Reply-To: <20170821212432.47364-4-kewillf@microsoft.com> (Kevin Willford's
        message of "Mon, 21 Aug 2017 15:24:32 -0600")
Message-ID: <xmqqwp5w4hev.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 5DC81850-86CA-11E7-AB9A-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Willford <kewillf@microsoft.com> writes:

> When writing the index for each entry an ondisk struct will be
> allocated and freed in ce_write_entry.  We can do better by
> using a ondisk struct on the stack for each entry.
>
> This is accomplished by using a stack ondisk_cache_entry_extended
> outside looping through the entries in do_write_index.  Only the
> fixed fields of this struct are used when writing and depending on
> whether it is extended or not the flags2 field will be written.
> The name field is not used and instead the cache_entry name field
> is used directly when writing out the name.  Because ce_write is
> using a buffer and memcpy to fill the buffer before flushing to disk,
> we don't have to worry about doing multiple ce_write calls.

The code already heavily assumes that the only difference between
ondisk_cache_entry and its _extended variant are identical in their
earlier parts, so having a single instance of the larger one on the
stack and passing it around makes sense as an optimization.

Multiple chomped calls to ce_write() does make me nervous, not due
to potential I/O cost (which is none) but to potential programming
mistakes for people who touch the code.  The version immediately
after this patch looks correct in that once "result" is set to non
zero to indicate an error nothing is written out, but keeping that
property over time, when a newer index format is eventually invented,
may become an additional burden.

But overall, I think this is a good change.  Will queue all three.

Thanks.

