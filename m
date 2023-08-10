Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CD1AC001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 21:36:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjHJVgM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 17:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjHJVgL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 17:36:11 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4972712
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 14:36:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id AC42F2C24A;
        Thu, 10 Aug 2023 17:36:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K25azRd1/yfqIiJ43X4VAyUW0SmEP3BIieSXJt
        yNKgg=; b=HKzMflatqpGUotOjb4hfc/FXJgVj7cywhv9i5sAFulR204lp43WST1
        z03YsOs5Zs+uvIJosDgMA3qSxdAq7hflGwPzPhdBwlnHstOhOwjxpKJ5Ee1Hp2sH
        wOjhirRquJbKqu6fjEO6UI2XHbWW/GuNMJunQUAbbcP0LeM5PyoG8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A55262C248;
        Thu, 10 Aug 2023 17:36:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 53A922C247;
        Thu, 10 Aug 2023 17:36:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/4] commit-graph: verify swapped zero/non-zero
 generation cases
References: <ZNUiEXF5CP6WMk9A@nand.local>
        <cover.1691699851.git.me@ttaylorr.com>
        <9b9483893c072961c5871bd0bae17a7098d73c06.1691699851.git.me@ttaylorr.com>
Date:   Thu, 10 Aug 2023 14:36:06 -0700
In-Reply-To: <9b9483893c072961c5871bd0bae17a7098d73c06.1691699851.git.me@ttaylorr.com>
        (Taylor Blau's message of "Thu, 10 Aug 2023 16:37:37 -0400")
Message-ID: <xmqqleeir35l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EA457A2C-37C5-11EE-B714-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> diff --git a/commit-graph.c b/commit-graph.c
> index c68f5c6b3a..acca753ce8 100644
> --- a/commit-graph.c
> +++ b/commit-graph.c
> @@ -2686,9 +2686,12 @@ static int verify_one_commit_graph(struct repository *r,
>  				graph_report(_("commit-graph has generation number zero for commit %s, but non-zero elsewhere"),
>  					     oid_to_hex(&cur_oid));
>  			generation_zero = GENERATION_ZERO_EXISTS;
> -		} else if (generation_zero == GENERATION_ZERO_EXISTS)
> -			graph_report(_("commit-graph has non-zero generation number for commit %s, but zero elsewhere"),
> -				     oid_to_hex(&cur_oid));
> +		} else {
> +			if (generation_zero == GENERATION_ZERO_EXISTS)
> +				graph_report(_("commit-graph has non-zero generation number for commit %s, but zero elsewhere"),
> +					     oid_to_hex(&cur_oid));
> +			generation_zero = GENERATION_NUMBER_EXISTS;
> +		}

Hmph, doesn't this potentially cause us to emit the two reports
alternating, if we are unlucky enough to see a commit with 0
generation first (which will silently set gz to ZERO_EXISTS), then
another commit with non-zero generation (which will complain we saw
non-zero for the current one and earlier we saw zero elsewhere, and
then set gz to NUM_EXISTS), and then another commit with 0
generation (which will complain the other way, and set gz back again
to ZERO_EXISTS)?

I am tempted to say this gz business should be done with two bits
(seen zero bit and seen non-zero bit), and immediately after we see
both kinds, we should report once and stop making further reports,
but ...

>  		if (generation_zero == GENERATION_ZERO_EXISTS)
>  			continue;

... as I do not see what this "continue" is doing, I'd stop at
expressing my puzzlement ;-)

Thanks.

