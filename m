Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A6C202A2
	for <e@80x24.org>; Tue, 17 Oct 2017 03:19:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754964AbdJQDTY (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Oct 2017 23:19:24 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63052 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753664AbdJQDTX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Oct 2017 23:19:23 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B6DC1B0E3F;
        Mon, 16 Oct 2017 23:19:22 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=kQPrYCZPG4Z35hib3MElNmKtXm4=; b=TJfxov
        CnoYF4UuJmT7rxNg0srwulsMS3mwynAj/azaypbpER6nD71BOhwR93B+Yv068cZf
        WP23re5NzogxbFA8QRFgDZ/4j7gRga34qqcQlq+uMjm4HQiiQxy9RmjkmhVLVAQL
        VXca3kMO+41wdjQUQzXunMwKptxVPhHUulgPw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YG8bkm+eNyXD60LMYzRNImNG7WQvn0Ua
        4ravVY3sBcl0R8F2KsqcOF9+Osk4QQc/AZgWogM8qDxjJ8LyS+ntsJ6Gis6WN85n
        nlYZXkoq1rW4iRKDc+NP1DuzD6aG7ONTufHg8LHA9nLIsfP4sHfCxOCtsCj1wdac
        11R7nOPDY9I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AD93DB0E3E;
        Mon, 16 Oct 2017 23:19:22 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1D091B0E3D;
        Mon, 16 Oct 2017 23:19:22 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org,
        Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2] column: show auto columns when pager is active
References: <20171011172310.2932-1-me@ikke.info>
        <20171016183511.12528-1-me@ikke.info>
Date:   Tue, 17 Oct 2017 12:19:20 +0900
In-Reply-To: <20171016183511.12528-1-me@ikke.info> (Kevin Daudt's message of
        "Mon, 16 Oct 2017 20:35:11 +0200")
Message-ID: <xmqqtvyypikn.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F85BA12A-B2E9-11E7-8EC0-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> When columns are set to automatic for git tag and the output is
> paginated by git, the output is a single column instead of multiple
> columns.
>
> Standard behaviour in git is to honor auto values when the pager is
> active, which happens for example with commands like git log showing
> colors when being paged.
>
> Since ff1e72483 (tag: change default of `pager.tag` to "on",
> 2017-08-02), the pager has been enabled by default, exposing this
> problem to more people.
>
> finalize_colopts in column.c only checks whether the output is a TTY to
> determine if columns should be enabled with columns set to auto. Also
> check if the pager is active.
>
> Adding a test for git column is possible but requires some care to work
> around a race on stdin. See commit 18d8c2693 (test_terminal: redirect
> child process' stdin to a pty, 2015-08-04). Test git tag instead, since
> that does not involve stdin, and since that was the original motivation
> for this patch.

Nicely done.

> +test_expect_success TTY 'git tag with auto-columns ' '
> +	test_commit one &&
> +	test_commit two &&
> +	test_commit three &&
> +	test_commit four &&
> +	test_commit five &&
> +	cat >expected <<\EOF &&
> +initial  one      two      three    four     five
> +EOF
> +	test_terminal env PAGER="cat >actual.tag" COLUMNS=80 \
> +		git -c column.ui=auto tag --sort=authordate &&
> +	test_cmp expected actual.tag
> +'

I'd use <<-\EOF so that here document can be intended like other
tests, and also use expect vs actual that are used in the other
tests in the same script, instead of suddenly becoming creative
in only this single test.  I can do these clean-ups locally when
queuing so no need to resend only to collect these.

Thanks, will queue.


