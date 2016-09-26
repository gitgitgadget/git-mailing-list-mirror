Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABB26207EC
	for <e@80x24.org>; Mon, 26 Sep 2016 17:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966402AbcIZRax (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Sep 2016 13:30:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57834 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S934866AbcIZRaw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2016 13:30:52 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E61B840F77;
        Mon, 26 Sep 2016 13:30:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=iNNZFvao1N/sPLGC27ocTcmr7k4=; b=P/yCQL
        eyQJhxJGCw7qeKlFQh4tMwIsW9+e/HmvWM4CAADxeooAjscRj4acNdom5Wbgo+kI
        rz5OkLvIWvuqvkNh2tNmbqY1dk02o8Kn1JErLCy2/gVgIVhtWtcKnYXFzwgcUg7M
        boGEtUdN+6n9JP+X7AkKQ4WjSdZE2tSsrgFKo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Hv5JRv4jovZTtaSa62v0Ez49G2BChJwF
        yT9AaKPRMLQq8bGv8vLQpAjJmGQ8jrGmqojk7HRZYaYcKNzAPxT2B6GyW/dWGKS6
        JaRXdc1QPoVb4ZsVn2nGnxx3Co11i/B+kI8/qkOmW9iAJe4mplm8r/YW1j7Am5eD
        DM+J66ibljM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DF3D540F76;
        Mon, 26 Sep 2016 13:30:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6A0A540F75;
        Mon, 26 Sep 2016 13:30:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
        <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net>
Date:   Mon, 26 Sep 2016 10:30:48 -0700
In-Reply-To: <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 26 Sep 2016 08:00:36 -0400")
Message-ID: <xmqqwphytvp3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F7E0BB6E-840E-11E6-98C3-C26412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> We also restrict the list to those that match any
> disambiguation hint. E.g.:
>
>   $ git rev-parse b2e1:foo
>   error: short SHA1 b2e1 is ambiguous
>   hint: The candidates are:
>   hint:   b2e1196 tag v2.8.0-rc1
>   hint:   b2e11d1 tree
>   hint:   b2e1632 commit 2007-11-14 - Merge branch 'bs/maint-commit-options'
>   fatal: Invalid object name 'b2e1'.
>
> does not bother reporting the blobs, because they cannot
> work as a treeish.

That's a nice touch, and it even comes free--how wonderful.

It somehow felt strange to have an expensive (compared to no-op,
anyway) loop whose only externally visible effect is to call
advise(), but there does not appear to be a way to even disable this
advise() output, so it probably is OK, I guess.

>  
> +test_expect_success C_LOCALE_OUTPUT 'ambiguity hints' '
> +	test_must_fail git rev-parse 000000000 2>stderr &&
> +	grep ^hint: stderr >hints &&
> +	# 16 candidates, plus one intro line
> +	test_line_count = 17 hints
> +'
> +
> +test_expect_success C_LOCALE_OUTPUT 'ambiguity hints respect type' '
> +	test_must_fail git rev-parse 000000000^{commit} 2>stderr &&
> +	grep ^hint: stderr >hints &&
> +	# 5 commits, 1 tag (which is a commitish), plus intro line
> +	test_line_count = 7 hints
> +'
> +
> +test_expect_success C_LOCALE_OUTPUT 'failed type-selector still shows hint' '
> +	# these two blobs share the same prefix "ee3d", but neither
> +	# will pass for a commit
> +	echo 851 | git hash-object --stdin -w &&
> +	echo 872 | git hash-object --stdin -w &&
> +	test_must_fail git rev-parse ee3d^{commit} 2>stderr &&
> +	grep ^hint: stderr >hints &&
> +	test_line_count = 3 hints
> +'
> +
>  test_done
