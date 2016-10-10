Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7587020989
	for <e@80x24.org>; Mon, 10 Oct 2016 19:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751521AbcJJT6I (ORCPT <rfc822;e@80x24.org>);
        Mon, 10 Oct 2016 15:58:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53134 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751154AbcJJT6H (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Oct 2016 15:58:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D5E9B44E7B;
        Mon, 10 Oct 2016 15:58:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EIVrYDkEh7HDUwgXzoPhzUgYmbU=; b=m1QHhz
        fMmkI79XCvRXMQwCussioSMYBaG7Jc7zh6Nc9wnb5/fcdgrOoncvgRxaLfSgRwfq
        bWj1mohXmqG1avyFwY+Ji9iJdl6Fmm+cfMXMvqrxRPSWD1DHE1z/2a/vjdUB4tZT
        3gltewn0BhrKaB25LdCsdkZwnaqKlsgzrirfM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XLdueFiN0kZOq7Me7aLzsLpDNZTYPcXG
        eDr2s2ymPYqaM0V7ZcsFjv9Xi/fX6GW5DNI6kQ6Z1VeiOlatnUWjvx4F7/micEKg
        gd2CXvq/Dv/97bfItpQZW/1iegUjIPilN1EQl8sYz3agMm9DH1wkf+h3jDmcQToX
        6DBRBxmLdBE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC66C44E7A;
        Mon, 10 Oct 2016 15:58:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A26144E79;
        Mon, 10 Oct 2016 15:58:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, jnareb@gmail.com, peff@peff.net
Subject: Re: [PATCH v10 13/14] convert: add filter.<driver>.process option
References: <20161008112530.15506-1-larsxschneider@gmail.com>
        <20161008112530.15506-14-larsxschneider@gmail.com>
Date:   Mon, 10 Oct 2016 12:58:03 -0700
In-Reply-To: <20161008112530.15506-14-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Sat, 8 Oct 2016 13:25:29
        +0200")
Message-ID: <xmqqint0dlis.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DBA782F0-8F23-11E6-87C2-5F377B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> +# Count unique lines in two files and compare them.
> +test_cmp_count () {
> +	for FILE in $@
> +	do
> +		sort $FILE | uniq -c | sed "s/^[ ]*//" >$FILE.tmp
> +		cat $FILE.tmp >$FILE

Unquoted references to $FILE bothers me.  Are you relying on them
getting split at IFS boundaries?  Otherwise write this (and other
similar ones) like so:

	for FILE in "$@"
	do
		do-this-to "$FILE" | ... >"$FILE.tmp" &&
		cat "$FILE.tmp" >"$FILE" &&
		rm -f "$FILE.tmp"

> +	done &&
> +	test_cmp $@

The use of "$@" here is quite pointless, as you _know_ all of them
are filenames, and you _know_ that test_cmp takes only two
filenames.  Be explicit and say

	test_cmp "$1" "$2"

or even

	test_cmp_count () {
	expect=$1 actual=$2
	for FILE in "$expect" "$actual"
	do
		...
	done &&
	test_cmp "$expect" "$actual"

> +# Count unique lines except clean invocations in two files and compare
> +# them. Clean invocations are not counted because their number can vary.
> +# c.f. http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
> +test_cmp_count_except_clean () {
> +	for FILE in $@
> +	do
> +		sort $FILE | uniq -c | sed "s/^[ ]*//" |
> +			sed "s/^\([0-9]\) IN: clean/x IN: clean/" >$FILE.tmp
> +		cat $FILE.tmp >$FILE
> +	done &&
> +	test_cmp $@
> +}

Why do you even _care_ about the number of invocations?  While I
told you why "clean" could be called multiple times under racy Git
as an example, that was not meant to be an exhaustive example.  I
wouldn't be surprised if we needed to run smudge twice, for example,
in some weirdly racy cases in the future.

Can we just have the correctness (i.e. "we expect that the working
tree file gets this as the result of checking it out, and we made
sure that is the case") test without getting into such an
implementation detail?

Thanks.
