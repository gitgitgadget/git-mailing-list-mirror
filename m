Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C39C20A17
	for <e@80x24.org>; Thu, 19 Jan 2017 21:07:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751076AbdASVHl (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 16:07:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60322 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751231AbdASVHi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 16:07:38 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 153415F4CE;
        Thu, 19 Jan 2017 16:03:35 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=56WNLW/NyjSXrE3sA7c/adQl9g8=; b=w8ez1L
        qKmj8TS72u4GVthoRmf88RuZZqyyDF8UaPkytJK97AQijkD65DGO8QeFjcwcbSN9
        k6ZPe4WKFBvhFfKjPB+ZPJXwk4LruH5BD9DhiITGAQPcJ1h8D99YvpVdA+rY3fkM
        jdDccJk/hVyiLiE+5Qovgw3bbbJvhF6vLRsaM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pIZceac625mYfjginfwJQu12FWYemzZX
        s3J/FVLHJR4/kswLF1y8pTwi6qzFnBGGe3hd/C52Cauxr+PMdAwkf7iGDrKRuh4p
        YChoddM0KiQHfOE96QVCI6A4IiHWNCuhCemPTU81bWJtKMzy0LAJL42QLUF2uLYA
        X5hSlfrcL58=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0AD0E5F4CB;
        Thu, 19 Jan 2017 16:03:35 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5BDAC5F4CA;
        Thu, 19 Jan 2017 16:03:34 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jacob Keller <jacob.e.keller@intel.com>
Cc:     git@vger.kernel.org, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH v4 2/5] name-rev: extend --refs to accept multiple patterns
References: <20170118230608.28030-1-jacob.e.keller@intel.com>
        <20170118230608.28030-3-jacob.e.keller@intel.com>
Date:   Thu, 19 Jan 2017 13:03:33 -0800
In-Reply-To: <20170118230608.28030-3-jacob.e.keller@intel.com> (Jacob Keller's
        message of "Wed, 18 Jan 2017 15:06:05 -0800")
Message-ID: <xmqqk29qzrru.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD493A9A-DE8A-11E6-9F91-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jacob Keller <jacob.e.keller@intel.com> writes:

> +	if (data->ref_filters.nr) {
> +		struct string_list_item *item;
> +		int matched = 0;
> +
> +		/* See if any of the patterns match. */
> +		for_each_string_list_item(item, &data->ref_filters) {
> +			/* Check every pattern even after we found a match so
> +			 * that we can determine when we should abbreviate the
> +			 * output. We will abbreviate the output when any of
> +			 * the patterns match a subpath, even if one of the
> +			 * patterns matches fully.
> +			 */

This describe "what" we do, which we can read from the code.  What I
asked you to mention was "why", which cannot be read from the code.

	/*
	 * Check all patterns even after finding a match, 
	 * so that we can see if a match with a subpath exists.
	 * When a user asked for 'refs/tags/v*' and 'v1.*', both
	 * of which match, the user is showing her willingness
	 * to accept a shortened output by having the 'v1.*' in
	 * the acceptable refnames, so we shouldn't stop when seeing
	 * 'refs/tags/v1.4' matches 'refs/tags/v*'.  We should show
	 * it as 'v1.4'.
	 */

or something like that, perhaps?
