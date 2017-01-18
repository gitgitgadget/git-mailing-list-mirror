Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9E61F89C
	for <e@80x24.org>; Wed, 18 Jan 2017 21:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753552AbdARVwN (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jan 2017 16:52:13 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51280 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752659AbdARVwM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2017 16:52:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7AC4160BCC;
        Wed, 18 Jan 2017 15:57:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=i64d+mGooVg1edMD2bYT/umc+Ls=; b=AZ8yqC
        VGv/7e401o645ZBWSro+dIBR5ezlFk0imCe5Mu9zgSqVmCaFNIc6FbqO+25ISeCu
        bj0kgjxBZXyw5NmzqPjinTYCsopBDd4TTen6ZwVAu7Y+LGuY1JgXvjweVnGYqhiX
        xlhiSGmxk56d4haMDc0tF/uVp4YhEO+1iZdIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JUhtKFJ6Cqun9hTmrEC8+xbwkUmIWEAO
        l6QhG3xVuufHdXv+1108pGE51SzKbb7y4H9s8QPy2njJjQKE/XwacJliWnjSSlBD
        VzQvtF/6AQZyLfXsQxZxvurDIJK7nfYz4dKp5IVl2s1WwMxrw0P0gzfNSC+Fpwk9
        HjfAH62DQ2c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6FAA860BCB;
        Wed, 18 Jan 2017 15:57:14 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D35CE60BCA;
        Wed, 18 Jan 2017 15:57:13 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Matt McCutchen <matt@mattmccutchen.net>, git@vger.kernel.org
Subject: Re: "git diff --ignore-space-change --stat" lists files with only whitespace differences as "changed"
References: <1484704915.2096.16.camel@mattmccutchen.net>
        <20170118111705.6bqzkklluikda3r5@sigill.intra.peff.net>
Date:   Wed, 18 Jan 2017 12:57:12 -0800
In-Reply-To: <20170118111705.6bqzkklluikda3r5@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 18 Jan 2017 06:17:05 -0500")
Message-ID: <xmqqvatc3x3r.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B012C2DA-DDC0-11E6-8B73-A7617B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> So I dunno. A sensible rule to me is "iff -p would show a diff header,
> then --stat should mention it".

True but tricky (you need a better definition of "a diff header").

In addition to a new and deleted file, does a file whose executable
bit was flipped need mention?  If so, then "diff --git" is the diff
header in the above.  Otherwise "@@ ... @@", iow, "iff -p would show
any hunk".

I think the patch implements the latter, which I think is sensible.

> +		/*
> +		 * Omit diffstats where nothing changed. Even if
> +		 * !same_contents, this might be the case due to ignoring
> +		 * whitespace changes, etc.
> +		 *
> +		 * But note that we special-case additions and deletions,
> +		 * as adding an empty file, for example, is still of interest.
> +		 */
> +		if (DIFF_FILE_VALID(one) && DIFF_FILE_VALID(two)) {
> +			struct diffstat_file *file =
> +				diffstat->files[diffstat->nr - 1];
> +			if (!file->added && !file->deleted) {
> +				free_diffstat_file(file);
> +				diffstat->nr--;
> +			}
> +		}
>  	}
