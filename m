Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01A081F461
	for <e@80x24.org>; Fri, 28 Jun 2019 17:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbfF1Rxq (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 13:53:46 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50544 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726565AbfF1Rxq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 13:53:46 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E64D154FBA;
        Fri, 28 Jun 2019 13:53:43 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=L5ZECkK9ktAUbCndajN/DRiyQ3k=; b=uZu4Sb
        5nevEW+WRIi/epc/v3NePjaDn188KW+tTRJfAE7t1xVODIu6MYv0fj2bpyMpeLfl
        naob2TkvRAEDi2EAQFqPvogu20kLCppT6sqM1Z2hWgTW5H1q12FZgVZMrg/zJOL/
        mDGz+cSzW3f3nbgzrvf64/et50yc8NvjnUeiU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=X27I0fAZQLvxKSbgbwh5o9UW/rsY/UJW
        vLhUIceHqqbguqG4s14rODLt50e00smS45eEHp45rnTa4bhr5ROXB7Zju35lX11e
        7LiQPL86lSJ14T3rXmRKFfohw/SWCCguTDCqmWC7LrGLjfYzOOYKt+/K3xd7efg3
        c/rx/cuSk+o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 72928154FB9;
        Fri, 28 Jun 2019 13:53:43 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BFD1C154FB8;
        Fri, 28 Jun 2019 13:53:42 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Derrick Stolee <stolee@gmail.com>, Git List <git@vger.kernel.org>
Subject: Re: [PATCH 1/6] test-lib: introduce test_commit_bulk
References: <20190628093751.GA3569@sigill.intra.peff.net>
        <20190628093911.GA27329@sigill.intra.peff.net>
Date:   Fri, 28 Jun 2019 10:53:41 -0700
In-Reply-To: <20190628093911.GA27329@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 28 Jun 2019 05:39:11 -0400")
Message-ID: <xmqqlfxl8ul6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB0401DE-99CD-11E9-806F-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> +# The message, filename, and contents strings are evaluated by the shell inside
> +# double-quotes, with $n set to the current commit number. So you can do:
> +#
> +#   test_commit_bulk --filename=file --contents='modification $n'
> +#
> +# to have every commit touch the same file, but with unique content. Spaces are
> +# OK, but you must escape any metacharacters (like backslashes or
> +# double-quotes) you do not want expanded.

Nice.

> +test_commit_bulk () {
> +	indir=
> + ...
> +	while test $# -gt 0
> +	do
> +		case "$1" in
> +		-C)
> +			indir=$2
> +			shift
> +			;;
> + ...
> +		esac
> +		shift
> +	done
> +	total=$1
> +
> +	in_dir=${indir:+-C "$indir"}

I thought that this assignment to $in_dir would be unnecessary if we
parsed -C directly into it, i.e.

		...
		-C)
			in_dir="-C $indir"
			shift
			;;
		...

but you probably could pass -C '' to defeat an $in_dir that was set
earlier by using a separate variable?

Messages and other stuff are made `eval`-safe, but this one does not
care much about quoting, which made me curious.

Reading further, though, I do not seem to see where this variable is
referred to, and that is the answer to my puzzlement.  This must be
a leftover that was written once before but no longer is used.  We
can remove $in_dir while keeping the initialization and assignment
to $indir as-is, I think.

All uses of $indir in the remainder of the function look $IFS-safe,
which is good.
