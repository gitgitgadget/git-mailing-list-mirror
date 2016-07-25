Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBC51203E2
	for <e@80x24.org>; Mon, 25 Jul 2016 21:39:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbcGYVjo (ORCPT <rfc822;e@80x24.org>);
	Mon, 25 Jul 2016 17:39:44 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752790AbcGYVjl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jul 2016 17:39:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 639B931F10;
	Mon, 25 Jul 2016 17:39:40 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Tuz0tOooaGta3xkaAKgA1dt03Ws=; b=u8NvF1
	cFg3Qa8bQnYDOBZNjIZ+DOOYp73/Gyp9L69eLIwUgMjanmJb/fE/ghl9Kt17JUqS
	x0FTXmD39UsZxHts1dh9K2Wf6emDK6m3pBtGE18Vnm/nJAfZ62Lk0nEfMhsNgTpp
	ddFKMDbkCpc/Qgim1fUfdWPzBuJpmhoVMa6f4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JOVTrQ/EOWQjA2fJWB2YCPGtfLekObs/
	Q8aKO27lqJ0R760ZVgmKB+LrZ9rofin3FBJmElVCTflRbeFfLpvilb6AVuW16KEY
	CJVQ8u8aprRdIDB1VSsyA9X7ugJ7U3AKEfBD2L9WZ7fIsD1KYfnvxA8PlP7taRzC
	udAZhUYgrX4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A4ED31F0F;
	Mon, 25 Jul 2016 17:39:40 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D29D031F0E;
	Mon, 25 Jul 2016 17:39:39 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:	git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Subject: Re: [PATCH v4 01/16] Verify that `git pull --rebase` shows the helpful advice when failing
References: <cover.1467902082.git.johannes.schindelin@gmx.de>
	<cover.1469187652.git.johannes.schindelin@gmx.de>
	<37e2f36e4f982261a741e327f1b534cb67b65149.1469187652.git.johannes.schindelin@gmx.de>
Date:	Mon, 25 Jul 2016 14:39:37 -0700
In-Reply-To: <37e2f36e4f982261a741e327f1b534cb67b65149.1469187652.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Fri, 22 Jul 2016 14:24:48 +0200
	(CEST)")
Message-ID: <xmqqk2g94cti.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4A85C980-52B0-11E6-AA00-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> +test_expect_success '--rebase with conflicts shows advice' '
> +	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
> +	git checkout -b seq &&
> +	printf "1\\n2\\n3\\n4\\n5\\n" >seq.txt &&

Make this more readble by using test-write-lines, perhaps?

> +	git add seq.txt &&
> +	test_tick &&
> +	git commit -m "Add seq.txt" &&
> +	printf "6\\n" >>seq.txt &&
> +	test_tick &&
> +	git commit -m "Append to seq.txt" seq.txt &&
> +	git checkout -b with-conflicts HEAD^ &&
> +	printf "conflicting\\n" >>seq.txt &&
> +	test_tick &&
> +	git commit -m "Create conflict" seq.txt &&
> +	test_must_fail git pull --rebase . seq 2>err >out &&
> +	grep "When you have resolved this problem" out
> +'
> +test_expect_success 'failed --rebase shows advice' '

Need a blank line before this one.

> +	test_when_finished "git rebase --abort; git checkout -f to-rebase" &&
> +	git checkout -b diverging &&
> +	test_commit attributes .gitattributes "* text=auto" attrs &&
> +	sha1="$(printf "1\\r\\n" | git hash-object -w --stdin)" &&
> +	git update-index --cacheinfo 0644 $sha1 file &&
> +	git commit -m v1-with-cr &&
> +	git checkout -f -b fails-to-rebase HEAD^ &&

It is unclear what the "-f" is for; is it attempting to clean up a
potential mess previous steps might have left?  We didn't have it in
the previous test above.

> +	test_commit v2-without-cr file "2" file2-lf &&
> +	test_must_fail git pull --rebase . diverging 2>err >out &&
> +	grep "When you have resolved this problem" out
> +'
> +
>  test_expect_success '--rebase fails with multiple branches' '
>  	git reset --hard before-rebase &&
>  	test_must_fail git pull --rebase . copy master 2>err &&

Not worth a reroll but after this series settles we would probably
want to address some of the above up with a follow-up clean-up patch.
