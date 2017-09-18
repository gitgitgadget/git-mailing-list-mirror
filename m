Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 378EB2047F
	for <e@80x24.org>; Mon, 18 Sep 2017 00:51:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751429AbdIRAvl (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 20:51:41 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53973 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751295AbdIRAvk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Sep 2017 20:51:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EC89297194;
        Sun, 17 Sep 2017 20:51:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5XR47pBhW5aodDf3MgvWjHqfU9U=; b=tWLQHT
        sJPbES/W0TDyQdE+BMm6JPnN+rbigTM4my8L++odi9W1yRcTcyujVhjOZf+YTMEt
        snfNbiYioKDkyy1kJbwlZ7UesYW6HeHDcBwykolSO+d70SEQs8bzxj2xo9FeGYhd
        JTJLjNg+nWQpfPEnuRPXtXUECz8ZRmwhVAOMQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jXbu5gjkKqZF2FH1x5nBavgZHLXESkmV
        JAMBPR7YMwWXPr/L+bKkYhGquD9N9xV30h+eGHiDd+GsmbPrBrAxlqMvPf3LSPMi
        V6RZoPnU5jyC9had7C2jNp27pETat+55l6/nmr27TY/IYviXdgFxq0r/paQKshze
        H6V1dOQPyCk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E373297193;
        Sun, 17 Sep 2017 20:51:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 51CA797192;
        Sun, 17 Sep 2017 20:51:39 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <dstolee@microsoft.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        git@jeffhostetler.com, kewillf@microsoft.com
Subject: Re: [PATCH 1/3] sha1_name: Create perf test for find_unique_abbrev()
References: <20170915165750.198201-1-dstolee@microsoft.com>
        <20170915165750.198201-2-dstolee@microsoft.com>
Date:   Mon, 18 Sep 2017 09:51:38 +0900
In-Reply-To: <20170915165750.198201-2-dstolee@microsoft.com> (Derrick Stolee's
        message of "Fri, 15 Sep 2017 12:57:48 -0400")
Message-ID: <xmqqa81su8v9.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 87B5C4F4-9C0B-11E7-B756-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <dstolee@microsoft.com> writes:

> +int cmd_main(int ac, const char **av)
> +{
> +	setup_git_directory();

As far as I recall, we do not (yet) allow declaration after
statement in our codebase.  Move this down to make it after all
decls.

> +
> +	unsigned int hash_delt = 0x13579BDF;
> +	unsigned int hash_base = 0x01020304;
> +	struct object_id oid;
> +
> +	int i, count = 0;
> +	int n = sizeof(struct object_id) / sizeof(int);

It probably is technically OK to assume sizeof(int) always equals to
sizeof(unsigned), but because you use 'n' _only_ to work with uint
and never with int, it would make more sense to match.  

But I do not think we want this "clever" optimization that involves
'n' in the first place.

> +	while (count++ < 100000) {
> +		for (i = 0; i < n; i++)
> +			((unsigned int*)oid.hash)[i] = hash_base;

Does it make sense to assume that uint is always 4-byte (so this
code won't work if it is 8-byte on your platform) and doing this is
faster than using platform-optimized memcpy()?

> +		find_unique_abbrev(oid.hash, MINIMUM_ABBREV);
> +
> +		hash_base += hash_delt;
> +	}

I also wonder if this is measuring the right thing.  I am guessing
that by making many queries for a unique abbreviation of "random"
(well, it is deterministic, but my point is these queries are not
based on the names of objects that exist in the repository) hashes,
this test measures how much time it takes for us to decide that such
a random hash does not exist.  In the real life use, we make the
opposite query far more frequently: we have an object that we _know_
exists in the repository and we try to find a sufficient length to
disambiguate it from others, and I suspect that these two use
different logic.  Don't you need to be measuring the time it takes
to compute the shortest abbreviation of an object that exists
instead?

> +	exit(0);
> +}
> diff --git a/t/perf/p0008-abbrev.sh b/t/perf/p0008-abbrev.sh
> new file mode 100755
> index 000000000..7c3fad807
> --- /dev/null
> +++ b/t/perf/p0008-abbrev.sh
> @@ -0,0 +1,12 @@
> +#!/bin/sh
> +
> +test_description='Test object disambiguation through abbreviations'
> +. ./perf-lib.sh
> +
> +test_perf_large_repo
> +
> +test_perf 'find_unique_abbrev()' '
> +	test-abbrev
> +'
> +
> +test_done
