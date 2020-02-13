Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2191DC352A3
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 19:14:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF5B320656
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 19:14:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jA2uFvap"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727991AbgBMTOK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 14:14:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65340 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgBMTOK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 14:14:10 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9929E54270;
        Thu, 13 Feb 2020 14:14:08 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LBzNaVObUHIkbVrT3Y7njd3YtV0=; b=jA2uFv
        apLT4MD0DKyOC4xQuK2v0mDkr4PiKwsdq1XV0qcTQUCLNFexmUm31aklraTvOPOb
        kHkGi6Ecw7xWje4XCMDkaoo1/xKsUadMxbICLO9rOwEAOxJbfCWJeDfUUZVb2G3p
        IAhxvvt6friq1cEkoycoHeHhNyG6wPXxj/YzY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=czrztitYMS/xwUXGem0vqwQnDPJ4zEh/
        vKeqUUS5MkDb4YOKjPqIgKARHPOkv3U+62YbUDEVp23J6KI6EiIv8N5Bd3MsPJVw
        ZA1/FjZbpK8lQAggeaitgyS5NOqAe5Ll6bELIcDQCQh0uxWfg4XSHG4bLHKw6zO0
        gdqt1yTgj2U=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B2895426F;
        Thu, 13 Feb 2020 14:14:08 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9ED675426E;
        Thu, 13 Feb 2020 14:14:07 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 06/13] rev-list: make --count work with --objects
References: <20200213021506.GA1124607@coredump.intra.peff.net>
        <20200213021929.GF1126038@coredump.intra.peff.net>
Date:   Thu, 13 Feb 2020 11:14:06 -0800
In-Reply-To: <20200213021929.GF1126038@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 12 Feb 2020 21:19:29 -0500")
Message-ID: <xmqqwo8qqozl.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 01DE3D7C-4E95-11EA-9FEC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The current behavior from "rev-list --count --objects" is nonsensical:
> we enumerate all of the objects except commits, but then give a count of
> commits. This wasn't planned, and is just what the code happens to do.
>
> Instead, let's give the answer the user almost certainly wanted: the
> full count of objects.
>
> Note that there are more complicated cases around cherry-marking, etc.
> We'll punt on those for now, but let the user know that we can't produce
> an answer (rather than giving them something useless).

Now, finally we start changing the behaviour.  

Is the reason why --left-right and --objects do not work well
together because same trees and blobs can be shared between commits
on both sides?

> diff --git a/t/t6000-rev-list-misc.sh b/t/t6000-rev-list-misc.sh
> index b8cf82349b..383f2c457d 100755
> --- a/t/t6000-rev-list-misc.sh
> +++ b/t/t6000-rev-list-misc.sh
> @@ -148,4 +148,16 @@ test_expect_success 'rev-list --end-of-options' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'rev-list --count' '
> +	count=$(git rev-list --count HEAD) &&
> +	git rev-list HEAD >actual &&
> +	test_line_count = $count actual
> +'
> +
> +test_expect_success 'rev-list --count --objects' '
> +	count=$(git rev-list --count --objects HEAD) &&
> +	git rev-list --objects HEAD >actual &&
> +	test_line_count = $count actual
> +'

Makes sense to define --count as the same as number of objects
shown and verify it.


