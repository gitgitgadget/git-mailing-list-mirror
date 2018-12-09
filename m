Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8583E20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 04:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbeLIEBd (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 23:01:33 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51597 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbeLIEBd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 23:01:33 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E22CA11930D;
        Sat,  8 Dec 2018 23:01:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3RPY1TYT+7nYfLGcbPaUhTdWpKs=; b=bi9eSb
        D5j1M3ultlCRpjdoj0SHlZUUufIpRFcAl5MhePEM6fvu519Szs+5RG8tddD99L16
        juX0AFd56bj0RKJZIauC8E0bKC3VfnXHl25Bqn6zM+l++GDtUw5DAxxulgJ1Equk
        e+gnn5MMTvU0u0DBoalGVrCCK51EnNaAByCPc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KiKAJl6OeDsORVbYHdvO6H7fJ1zjSgaG
        tXXGiKonawax5Td2RkizQ57EhP8h9afnN9B9r1OMxg331/ZpfiVS14GwNPy4aETh
        iEsvz3Oib8vXtZ/tvMl1ZHUPygtxzBniTw/OqDdE8+l1n/nOWX/aBlaqzEGdqH9R
        TWIrvftSOIQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D65F611930C;
        Sat,  8 Dec 2018 23:01:30 -0500 (EST)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4B22411930B;
        Sat,  8 Dec 2018 23:01:30 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net
Subject: Re: [PATCH v3 2/3] commit-graph: fix buffer read-overflow
References: <cover.1544127439.git.steadmon@google.com>
        <cover.1544221121.git.steadmon@google.com>
        <675d58ecea2f315bd05d2a21f6a473e9de1105a0.1544221121.git.steadmon@google.com>
Date:   Sun, 09 Dec 2018 13:01:29 +0900
In-Reply-To: <675d58ecea2f315bd05d2a21f6a473e9de1105a0.1544221121.git.steadmon@google.com>
        (Josh Steadmon's message of "Fri, 7 Dec 2018 14:27:23 -0800")
Message-ID: <xmqqsgz74acm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BE80FD6-FB67-11E8-A0C5-063AD72159A7-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Steadmon <steadmon@google.com> writes:

> diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
> index 5fe21db99f..5b6b44b78e 100755
> --- a/t/t5318-commit-graph.sh
> +++ b/t/t5318-commit-graph.sh
> @@ -366,24 +366,30 @@ GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
>  GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
>  GRAPH_BYTE_FOOTER=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4 * $NUM_OCTOPUS_EDGES))
>  
> -# usage: corrupt_graph_and_verify <position> <data> <string>
> +# usage: corrupt_graph_and_verify <position> <data> <string> [<zero_pos>]
>  # Manipulates the commit-graph file at the position
> -# by inserting the data, then runs 'git commit-graph verify'
> +# by inserting the data, optionally zeroing the file
> +# starting at <zero_pos>, then runs 'git commit-graph verify'
>  # and places the output in the file 'err'. Test 'err' for
>  # the given string.
>  corrupt_graph_and_verify() {
>  	pos=$1
>  	data="${2:-\0}"
>  	grepstr=$3
> +	orig_size=$(stat --format=%s $objdir/info/commit-graph)

"stat(1)" is not so portable, so you'll get complaints from minority
platform users later.  So is "truncate(1)".

> +	zero_pos=${4:-${orig_size}}
>  	cd "$TRASH_DIRECTORY/full" &&
>  	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
>  	cp $objdir/info/commit-graph commit-graph-backup &&
>  	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
> +	truncate --size=$zero_pos $objdir/info/commit-graph &&
> +	truncate --size=$orig_size $objdir/info/commit-graph &&
>  	test_must_fail git commit-graph verify 2>test_err &&
>  	grep -v "^+" test_err >err
>  	test_i18ngrep "$grepstr" err
>  }
>  
> +
>  test_expect_success 'detect bad signature' '
>  	corrupt_graph_and_verify 0 "\0" \
>  		"graph signature"
> @@ -484,6 +490,11 @@ test_expect_success 'detect invalid checksum hash' '
>  		"incorrect checksum"
>  '
>  
> +test_expect_success 'detect incorrect chunk count' '
> +	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\xff" \

Implementations of printf(1) may not grok "\xff" as a valid
representation of "\377".  The shell built-in of dash(1) for example
would not work with this.

> +		"chunk lookup table entry missing" $GRAPH_CHUNK_LOOKUP_OFFSET
> +'
> +
>  test_expect_success 'git fsck (checks commit-graph)' '
>  	cd "$TRASH_DIRECTORY/full" &&
>  	git fsck &&
