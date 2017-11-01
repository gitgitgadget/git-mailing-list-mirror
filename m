Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C59D20450
	for <e@80x24.org>; Wed,  1 Nov 2017 03:50:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752575AbdKADu5 (ORCPT <rfc822;e@80x24.org>);
        Tue, 31 Oct 2017 23:50:57 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52567 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751390AbdKADu4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Oct 2017 23:50:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id D7F53BA9CF;
        Tue, 31 Oct 2017 23:50:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QyVZC9vviZRlsInjD2+4sWF+kL4=; b=r3YDir
        w/57wln1X3pISghU4sd7tCHHvmwTMjfqHGhVyGnY6yM1H14JvAIEeFmEjx8Qzabm
        Mr5Xx70vX8hkvC00sEqTYqYpObsQ9c+XqkMkE/R/Ug/TNoXKmfhJ0bnCwAFt5aNz
        GWMit1kI3sw5IgXIsJOpeCiddBQJLgwqMbNPs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=j/+I3Y8EQXhaeKWq9jCyp1tjaKNMnhgP
        eCFkyd5La5GkjD25S+ihPNmXS5kd58rM/w3sl8xsp9VlNDTfAzT7WypiTIIxsOX0
        QY3R7BDHHY107ZM9O8l6KRCZSl87CHMzpymRsUZN2P3GR7/1t1og9eylKv+Uh6sD
        Sr3e8mKCGHw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id CFC7ABA9CE;
        Tue, 31 Oct 2017 23:50:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 47F60BA9CD;
        Tue, 31 Oct 2017 23:50:55 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        jacob.keller@gmail.com, me@ikke.info
Subject: Re: [PATCHv2 2/7] revision.h: introduce blob/tree walking in order of the commits
References: <20171031003351.22341-1-sbeller@google.com>
        <20171031211852.13001-1-sbeller@google.com>
        <20171031211852.13001-3-sbeller@google.com>
Date:   Wed, 01 Nov 2017 12:50:54 +0900
In-Reply-To: <20171031211852.13001-3-sbeller@google.com> (Stefan Beller's
        message of "Tue, 31 Oct 2017 14:18:47 -0700")
Message-ID: <xmqqr2tiveqp.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCF01E00-BEB7-11E7-A305-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> diff --git a/t/t6100-rev-list-in-order.sh b/t/t6100-rev-list-in-order.sh
> new file mode 100755
> index 0000000000..651666979b
> --- /dev/null
> +++ b/t/t6100-rev-list-in-order.sh
> @@ -0,0 +1,46 @@
> +#!/bin/sh
> +
> +test_description='miscellaneous rev-list tests'
> +
> +. ./test-lib.sh
> +
> +
> +test_expect_success 'setup' '
> +	for x in one two three four
> +	do
> +		echo $x >$x &&
> +		git add $x &&
> +		git commit -m "add file $x"
> +	done &&
> +	for x in four three
> +	do
> +		git rm $x &&
> +		git commit -m "remove $x"
> +	done &&

When "git commit -m 'remove four'" fails, this loop would still
continue, so the &&-chain in "done &&" would still be rendered
ineffetive.

> +	git rev-list --in-commit-order --objects HEAD >actual.raw &&
> +	cut -c 1-40 >actual <actual.raw &&
> +
> +	git cat-file --batch-check="%(objectname)" >expect.raw <<-\EOF &&
> +		HEAD^{commit}
> +		HEAD^{tree}
> +		HEAD^{tree}:one
> +		HEAD^{tree}:two
> +		HEAD~1^{commit}
> +		HEAD~1^{tree}
> +		HEAD~1^{tree}:three
> +		HEAD~2^{commit}
> +		HEAD~2^{tree}
> +		HEAD~2^{tree}:four
> +		HEAD~3^{commit}
> +		# HEAD~3^{tree} skipped
> +		HEAD~4^{commit}
> +		# HEAD~4^{tree} skipped
> +		HEAD~5^{commit}
> +		HEAD~5^{tree}
> +	EOF
> +	grep -v "#" >expect <expect.raw &&

Hmm, that is unfortunate that we still have to filter them out, but
these have documentation values, so perhaps this is as good as it
would get.

These "skipped" are shorthand for "not shown here, because it was
already shown as X"; it would be good to come up with a phrasing to
force us show what X is for each of them.  

"already shown as X", perhaps?

> +
> +	test_cmp expect actual
> +'
> +
> +test_done
