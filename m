Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3D261FA26
	for <e@80x24.org>; Tue, 18 Apr 2017 04:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbdDREhv (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 00:37:51 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63202 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751050AbdDREhu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 00:37:50 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C73B76416;
        Tue, 18 Apr 2017 00:37:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yv8QyDQH331N0INiCiDdlrR7GiI=; b=mKDD1+
        kdDkqQtpposuM7Uc5Zb7kJgEv5SZ/rAjDioEEeykCEQLiRe/RM2KBdhfWsZDBxwe
        1gXpGl3XMhn02KsoAPq+w5CdYtVfC/o3IS9hfqd8ImsdhzSr4Ko75EltjigRBlWa
        PKjXWgYwT9Jv1fVdDFUPZV09NTLSiJZvG3Lv0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EXFyjB71RuEfkxaK2kNwJvH/03f5xrzh
        9RB4LSx8AqgQxvTMgve/9sSwA/jQZGm2vQHaJ4Xg9i15+8NRSh71mESx2Y4KSTvq
        FN4MClnLCLrmy0h6XzCLz3IxvJB+jY49Ll6Qm36TLTpxi8/ugH2/lubcvm6XNrq/
        YjVQR82h7BY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 048BF76415;
        Tue, 18 Apr 2017 00:37:49 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C72D76414;
        Tue, 18 Apr 2017 00:37:48 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Daniel Ferreira <bnmvco@gmail.com>
Cc:     git@vger.kernel.org, sbeller@google.com, pclouds@gmail.com,
        mhagger@alum.mit.edu
Subject: Re: [PATCH v9 1/5] dir_iterator: add tests for dir_iterator API
References: <1492462296-4990-1-git-send-email-bnmvco@gmail.com>
        <1492462296-4990-2-git-send-email-bnmvco@gmail.com>
Date:   Mon, 17 Apr 2017 21:37:47 -0700
In-Reply-To: <1492462296-4990-2-git-send-email-bnmvco@gmail.com> (Daniel
        Ferreira's message of "Mon, 17 Apr 2017 17:51:32 -0300")
Message-ID: <xmqqzifee3fo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C653FCB4-23F0-11E7-8712-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Daniel Ferreira <bnmvco@gmail.com> writes:

> +cat >expect-sorted-output <<-\EOF &&
> +[d] (a) [a] ./dir/a
> +[d] (a/b) [b] ./dir/a/b
> +[d] (a/b/c) [c] ./dir/a/b/c
> +[d] (d) [d] ./dir/d
> +[d] (d/e) [e] ./dir/d/e
> +[d] (d/e/d) [d] ./dir/d/e/d
> +[f] (a/b/c/d) [d] ./dir/a/b/c/d
> +[f] (a/e) [e] ./dir/a/e
> +[f] (b) [b] ./dir/b
> +[f] (c) [c] ./dir/c
> +[f] (d/e/d/a) [a] ./dir/d/e/d/a
> +EOF
> +
> +test_expect_success 'dir-iterator should iterate through all files' '
> +	test-dir-iterator ./dir >out &&
> +	sort <out >./actual-pre-order-sorted-output &&
> +
> +	test_cmp expect-sorted-output actual-pre-order-sorted-output
> +'

Modern tests create these test vectors inside test_expect_success
block, like so:

test_expect_success 'dir-iterator should iterate through all files' '
        cat >expect-sorted-output <<-\EOF &&
        [d] (a) [a] ./dir/a
        [d] (a/b) [b] ./dir/a/b
        [d] (a/b/c) [c] ./dir/a/b/c
        [d] (d) [d] ./dir/d
        [d] (d/e) [e] ./dir/d/e
        [d] (d/e/d) [d] ./dir/d/e/d
        [f] (a/b/c/d) [d] ./dir/a/b/c/d
        [f] (a/e) [e] ./dir/a/e
        [f] (b) [b] ./dir/b
        [f] (c) [c] ./dir/c
        [f] (d/e/d/a) [a] ./dir/d/e/d/a
        EOF

	test-dir-iterator ./dir >out &&
	sort <out >./actual-pre-order-sorted-output &&

	test_cmp expect-sorted-output actual-pre-order-sorted-output
'
