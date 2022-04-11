Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FFAFC433EF
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 19:09:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349421AbiDKTLs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 15:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348877AbiDKTLq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 15:11:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C4C3617F
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 12:09:30 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C174711058D;
        Mon, 11 Apr 2022 15:09:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=UkY0ZxGJ7Xmb7h2SjXp8Jpau7oBopkH4kAd0vh
        KjHJA=; b=JVpQs2O6kCk6hB2z9Bmww02gClbdsQJQKHg9Bx5pEgvbzdA1iry2EM
        9DlIYO20AbjgUbAFrm315XAVIn0II73Q010W0oVOriJSJzrlnPntFjF6bDVucq9p
        SDbb7ZTVcC+81zeKBZV32vW2FseetfU39WL698tE3hAain9RBvee0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B963011058C;
        Mon, 11 Apr 2022 15:09:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2AFF411058B;
        Mon, 11 Apr 2022 15:09:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Siddharth Asthana <siddharthasthana31@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [GSoC] [PATCH] t1011: replace test -f with test_path_is_file
References: <20220409114458.23435-1-siddharthasthana31@gmail.com>
Date:   Mon, 11 Apr 2022 12:09:28 -0700
In-Reply-To: <20220409114458.23435-1-siddharthasthana31@gmail.com> (Siddharth
        Asthana's message of "Sat, 9 Apr 2022 17:14:56 +0530")
Message-ID: <xmqq1qy3igif.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E965BF60-B9CA-11EC-8EF6-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> Use test_path_is_file() instead of 'test -f' for better debugging
> information.
> ---

missing Sign-off.

>  	test_cmp expected.swt result &&
> -	! test -f init.t &&
> -	! test -f sub/added
> +	! test_path_is_file init.t &&
> +	! test_path_is_file sub/added
>  '

Given the definition of the helper function, i.e.

        test_path_is_file () {
                test "$#" -ne 1 && BUG "1 param"
                if ! test -f "$1"
                then
                        echo "File $1 doesn't exist"
                        false
                fi
        }

the new test will _complain_ "init.t doesn't exist" when we have
successfully run the test, while it will be _silent_ when init.t
that _should_ not exist is there.

Which is the complete opposite of the spirit of why we want to use
the helper when we expect the path "$1" to exist, i.e. loudly fail
when our expectation is _not_ met.

$ git grep '! test_path_is' t/

shows that we already have such a misuse of test_path_is_dir in one
place, but luckily we do not have any for test_path_is_file or other
similar helpers.  test_path_is_hidden is sort-of OK as that is not
about verbosity.

In these two test, we do not expect init.t or sub/added to _exist_
at all.  It's not like we are happy if we see init.d exist as a
directory (which is not a file).  test_path_is_missing is probably
the right helper to use.

It is not very plausible that we'd want to assert that existence of
a path as a file the only bad condition (i.e. we are happy if the
path did not exist or it is a directory, symlink, or a socket), so I
think the simple 

	Never use '! test_path_is_file'; test_path_is_missing may be
	what you are looking for.

is a good enough rule.

If not, we could allow the caller to write such a convoluted "only
existence of a path as a file is unacceptable and everything else is
good" assertion as

    test_path_is_file ! init.d

with something like

        test_path_is_file () {
		expecting_file=true
		if test "$1" = "!"
		then
			expecting_file=false
			shift
		fi
                test "$#" -ne 1 && BUG "1 param"
                if test -f "$1"
                then
                	$expecting_file || echo "File $1 exists"
                        $expecting_file
		else
			$expecting_file && echo "File $1 doesn't exist"
                        ! $expecting_file
                fi
        }

but I do not think we want to go that way.
