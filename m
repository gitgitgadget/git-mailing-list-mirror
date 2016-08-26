Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0C041FD99
	for <e@80x24.org>; Fri, 26 Aug 2016 20:10:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753133AbcHZUKS (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Aug 2016 16:10:18 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53388 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752420AbcHZUKR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Aug 2016 16:10:17 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 686FB38B55;
        Fri, 26 Aug 2016 16:03:53 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sChAhDUV1fxYUv9PYuRPsKEOxDc=; b=aZjPlw
        fzjzmf+tTHPeAat5DU/jq8Ct4QMUXUGXsefMNWPRQw47VfPqiSiVGKRlHpXx9SBH
        +CZaAhDIjLvg4d774IxGRv6kVw9V0Y2PW/f8L2JbXBYAPsDJOFsFfe2EIjImg8zi
        3EmCkhF3vnPdR1s1FJsbc4uif9E20/jHwhmc0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=J1uv4tDEaWGp8xHHrdgD2S7uxSL38PeB
        LmpBnLUMe92jDJ25Wfn4yw8OB9yyemw8u1KDBnAHDxqpN4i3EUCJH9Yaw6xlJkJ8
        JsvKqVuP7TJkCAJhqcH/gmBfDr6KdkQ3cG+Gd0SsZD838pIpjqo8Kygw57ICX/oU
        +WKxHcgV+7M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60F6038B54;
        Fri, 26 Aug 2016 16:03:53 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D7AA538B53;
        Fri, 26 Aug 2016 16:03:52 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     larsxschneider@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com
Subject: Re: [PATCH v6 09/13] convert: modernize tests
References: <20160825110752.31581-1-larsxschneider@gmail.com>
        <20160825110752.31581-10-larsxschneider@gmail.com>
Date:   Fri, 26 Aug 2016 13:03:50 -0700
In-Reply-To: <20160825110752.31581-10-larsxschneider@gmail.com>
        (larsxschneider@gmail.com's message of "Thu, 25 Aug 2016 13:07:48
        +0200")
Message-ID: <xmqqk2f3fgbd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36467826-6BC8-11E6-83B5-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

larsxschneider@gmail.com writes:

> From: Lars Schneider <larsxschneider@gmail.com>
>
> Use `test_config` to set the config, check that files are empty with
> `test_must_be_empty`, compare files with `test_cmp`, and remove spaces
> after ">" and "<".

All of the above are good things to do, but the first one needs to
be done a bit carefully.

It is unclear in the above description if you made sure that no
subsequent test depends on the settings left by earlier test before
replacing "git config" with "test_config".

> diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
> index 7bac2bc..7b45136 100755
> --- a/t/t0021-conversion.sh
> +++ b/t/t0021-conversion.sh
> @@ -13,8 +13,8 @@ EOF
>  chmod +x rot13.sh
>  
>  test_expect_success setup '
> -	git config filter.rot13.smudge ./rot13.sh &&
> -	git config filter.rot13.clean ./rot13.sh &&
> +	test_config filter.rot13.smudge ./rot13.sh &&
> +	test_config filter.rot13.clean ./rot13.sh &&
>  
>  	{
>  	    echo "*.t filter=rot13"

For example, after this conversion, filter.rot13.* will be reverted
back to unconfigured once setup is done.

>  test_expect_success check '
>  
> -	cmp test.o test &&
> -	cmp test.o test.t &&
> +	test_cmp test.o test &&
> +	test_cmp test.o test.t &&
>  
>  	# ident should be stripped in the repository
>  	git diff --raw --exit-code :test :test.i &&

It happens to be true that this subsequent test does not do any
operation to cause data come from and go into the object database
for any path that match the pattern "*.t", because for whatever
reason the previous "setup" step happens to do more than just
"setup".  It already exercised the filtering by doing "git add" and
"git checkout".

If we were writing the script t0021 from scratch today, we would
have used test_config *AND* squashed there two tests into one
(i.e. making it a single "the filter and ident operation" test).
Then it is crystal clear that additional tests on commands that may
involve filtering will always be added to that combined test
(e.g. we may try "cat-file --filters" to ensure that rot13 filter is
excercised).

But because we are not doing that, it may become tempting to add
test for a new command that pays attention to a filter to either of
the test, and it would have worked OK if this patch weren't there.
Such an addition will break the test, because in the second "check"
test, the filter commands are no longer active with this patch.

So while I do appreciate the change for the longer term, I am not
quite happy with it.  It just looks like an invitation for future
mistakes.

> @@ -130,7 +130,7 @@ test_expect_success 'filter shell-escaped filenames' '
>  
>  	# delete the files and check them out again, using a smudge filter
>  	# that will count the args and echo the command-line back to us
> -	git config filter.argc.smudge "sh ./argc.sh %f" &&
> +	test_config filter.argc.smudge "sh ./argc.sh %f" &&
>  	rm "$normal" "$special" &&
>  	git checkout -- "$normal" "$special" &&

This one is clearly OK.  Anything related to argc filter only
appears in this single test so it is not just OK to use test_config,
but it makes our intention very clear that nobody else would use the
argc filter.  I think similar reasoning would apply to the test_config
conversion in the remainder of the script.

As to other types of changes you did in this, I see no problem with
them.

Thanks.
