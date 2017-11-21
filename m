Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03DD9202F2
	for <e@80x24.org>; Tue, 21 Nov 2017 01:24:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751920AbdKUBYK (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 20:24:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57224 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751389AbdKUBYJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 20:24:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 634F6A3A8B;
        Mon, 20 Nov 2017 20:24:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DhWx9UmstdYa13h3Y3XIARXs4wM=; b=rn5+U7
        ooJUKIi6eGEQtWM5xl3do2kS/oOThUxZZNqTB2ODBvri7e/sSZ+ObA5Ytq82IdAA
        kgnEDHuaxjVkhmjKPjOu9c6jbtawWkeVV919uDhpU3DtHUqJGpxGeFaouDT/Goks
        5BZjL88ppw3b+iLKJuGflTfHBO2y7Y72uYjss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=E2q0EJK99jGvnz4yz4W2TebT2EfOwkXC
        VPLZf2yu+7JOcG5pW65I822oVNmB0cp4OYudSYmpKUBMtTlX0iai0TFNKtQx15lN
        tsQ3rh3uNwsE/2TUmz26peH36AY9IWUkPi6RPri0dahJXXNNXhpGsKX43u8Ishs3
        vPDS18xeH8o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 59EE1A3A8A;
        Mon, 20 Nov 2017 20:24:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B9201A3A88;
        Mon, 20 Nov 2017 20:24:07 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Segev Finer <segev208@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/8] ssh test: make copy_ssh_wrapper_as clean up after itself
References: <20171120212134.lh2l4drdzu6fh5g2@aiede.mtv.corp.google.com>
        <20171120212223.wquyxbmz34foynrk@aiede.mtv.corp.google.com>
Date:   Tue, 21 Nov 2017 10:24:06 +0900
In-Reply-To: <20171120212223.wquyxbmz34foynrk@aiede.mtv.corp.google.com>
        (Jonathan Nieder's message of "Mon, 20 Nov 2017 13:22:23 -0800")
Message-ID: <xmqqtvxojufd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: AB862118-CE5A-11E7-8B3A-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> +test_expect_success 'set up ssh wrapper' '
> +	cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" \
> +		"$TRASH_DIRECTORY/ssh$X" &&
> +	GIT_SSH="$TRASH_DIRECTORY/ssh$X" &&
> +	export GIT_SSH &&
> +	export TRASH_DIRECTORY &&
> +	>"$TRASH_DIRECTORY"/ssh-output
> +'
>  
>  copy_ssh_wrapper_as () {
>  	cp "$TRASH_DIRECTORY/ssh$X" "${1%$X}$X" &&
> +	test_when_finished "rm -f ${1%$X}$X" &&
>  	GIT_SSH="${1%$X}$X" &&

As we can clearly see in the context, this is not a new issue, but I
find the users of this helper that benefit from the "${1%$X}$X"
magic somewhat iffy.

There are callers of this helper that pass "somedir/plink" and
"somedir/plink.exe", but behind these callers that _think_ they are
testing the variant with and without the trailing ".exe", the helper
always add ".exe" (after stripping an existing one) on $X=.exe
platforms, ending up in testing the same thing twice.  On platforms
with $X='', testing two different command names may have "some"
value, but I wonder if it is cleaner to use a much less magical
"$1$X" here, and skip the test with a caller that gives ".exe"
variant using a test prerequisite on $X=.exe platforms to avoid
redundant tests?

This is totally outside the scope of this series; I mention this
only because this may be a possible #leftoverbits.

Thanks.
