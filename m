Return-Path: <SRS0=iiTG=ZM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C7FC432C0
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 04:13:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D3B72245F
	for <git@archiver.kernel.org>; Wed, 20 Nov 2019 04:13:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LywJ+IRf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727575AbfKTENC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Nov 2019 23:13:02 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:57628 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727264AbfKTENC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Nov 2019 23:13:02 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C6B61A2D68;
        Tue, 19 Nov 2019 23:12:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hAz77yDId6bSNbP0RMSmp4zMHSw=; b=LywJ+I
        Rfql8MUUJqD4BcnWX8Xsvb6ep9DIxB8KgLyKk0PjTfx9a/aj/CGVgzDOoyW+3tc1
        rOFsKd9H2j4ohFwSEERfG4y++9p2iE0l67Z6c6qblTSaMpLTis4M2LT3FITza6oG
        8PokHqvVH74AfZWUTDM904gVXu5TBlADYUj4s=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VB+xsr0wgpRKI0MGTyz/se71QPcoL4Wa
        ivbo9rg7idvoh3OZkMLx0t/6QGorpqxMXfXnvRzjXvX7YtTl3IrrcXBq/wg6iOKS
        WEXX4rQ+DvJOkox1A3XqEytThAe+QHx2Wu6iWd56FG5QO5oLWLmPlqchXZAAz32R
        9WfTl0+VVxY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B065CA2D67;
        Tue, 19 Nov 2019 23:12:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D0D98A2D66;
        Tue, 19 Nov 2019 23:12:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] perf-lib: remove old result files before running tests
References: <20191119185047.8550-1-t.gummerer@gmail.com>
Date:   Wed, 20 Nov 2019 13:12:54 +0900
In-Reply-To: <20191119185047.8550-1-t.gummerer@gmail.com> (Thomas Gummerer's
        message of "Tue, 19 Nov 2019 18:50:47 +0000")
Message-ID: <xmqq5zjfchix.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 080C92FC-0B4C-11EA-9582-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> @@ -178,10 +178,11 @@ test_wrapper_ () {
>  	export test_prereq
>  	if ! test_skip "$@"
>  	then

> -		base=$(basename "$0" .sh)

So we used to use $base to hold the number and the filename here

> -		echo "$test_count" >>"$perf_results_dir"/$base.subtests
> -		echo "$1" >"$perf_results_dir"/$base.$test_count.descr
>  		base="$perf_results_dir"/"$PERF_RESULTS_PREFIX$(basename "$0" .sh)"."$test_count"

and then redefined it to be the results-prefix specific one.


> +		rm -f "$base".*

you now remove those results-prefix specific one for the $test_count
(I guess that is as specific you can go) before writing the count
and the description.  

So this "rm -f" is a no-op when perf-results-prefix is not empty?

> +		no_prefix_base="$perf_results_dir"/$(basename "$0" .sh)
> +		echo "$test_count" >>$no_prefix_base.subtests
> +		echo "$1" >$no_prefix_base.$test_count.descr
>  		"$test_wrapper_func_" "$@"
>  	fi
