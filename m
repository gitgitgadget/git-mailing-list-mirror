Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E9482047F
	for <e@80x24.org>; Mon,  7 Aug 2017 20:25:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751761AbdHGUZN (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 16:25:13 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57239 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751589AbdHGUZM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 16:25:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8D9EEA4244;
        Mon,  7 Aug 2017 16:25:11 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=kX75Wt6cvu7BcHkDk5pWMoN8M
        eg=; b=qy+5xvUX53Dlw62ZRzt+4wlGu9cCTqeSiKmASDcHhTbQPndsPstQVdY08
        A6rJxyWq4+DAAlpgO7h9x65R8htVDPDaNSqU6tzV8zvtxnm3HZq/XxWrfPvkCJph
        q89JCx3thr2ZBMEXhtCnQYY+1BV5mTQlgfNJnxpPUkOviK66Rc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; q=dns; s=sasl; b=yFH6kQz8+g2LiULx8lI
        UNNyIq5g3tX9QilO3YNzYqTS+rmQAkQhRaKYIgeNSXg0sJgQTH4GuShFPyCF9HqF
        MGs2kqp5zuMhKGWw+3728R9b8EROr6UVEx4qXCnjAG0IXTBtGW6f+LYJkUJ6694j
        K+kW8hod48PptpDsIs0QwXt4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 85307A4243;
        Mon,  7 Aug 2017 16:25:11 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D4D99A4240;
        Mon,  7 Aug 2017 16:25:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Dave Borowitz <dborowitz@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 2/6] t5334: document that git push --signed=1 does not work
References: <cover.1502128418.git.martin.agren@gmail.com>
        <4ac17762106cde543c4c60968946b68263830d61.1502128418.git.martin.agren@gmail.com>
Date:   Mon, 07 Aug 2017 13:25:09 -0700
Message-ID: <xmqqd187p1lm.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 82E8310A-7BAE-11E7-9589-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> When accepting booleans as command-line or config options throughout
> Git, there are several documented synonyms for true and false.
> However, one particular user is slightly broken: `git push --signed=3D.=
.`
> does not understand the integer synonyms for true and false.
>
> This is hardly wanted. The --signed option has a different notion of
> boolean than all other arguments and config options, including the
> config option corresponding to it, push.gpgSign.
>
> Add a test documenting the failure to handle --signed=3D1.

My knee-jerk reaction is that parse_maybe_bool() is broken in that
it should do everything that config_maybe_bool() does.  I wonder why
we do not call git_parse_int() like git_config_maybe_bool() does?

... Ahh, that is because bool_or_int() wants to know that "1" is an
int and not a bool, and parse_maybe_bool() is designed to cater to
the need of that thing, in addition to config_maybe_bool().  And the
"--signed=3D" thing wants parse_bool_or_string(), not bool_or_int(),
so we should treat "1" as true and "0" as false.  There is no way to
do so in the current code and that is why you have the new _text()
thing in patches 3-4/6.

Makes sense.


> diff --git a/t/t5534-push-signed.sh b/t/t5534-push-signed.sh
> index 464ffdd14..5dce55e1d 100755
> --- a/t/t5534-push-signed.sh
> +++ b/t/t5534-push-signed.sh
> @@ -71,6 +71,13 @@ test_expect_success 'push --signed fails with a rece=
iver without push certificat
>  	test_i18ngrep "the receiving end does not support" err
>  '
> =20
> +test_expect_failure 'push --signed=3D1 is accepted' '
> +	prepare_dst &&
n> +	mkdir -p dst/.git/hooks &&
> +	test_must_fail git push --signed=3D1 dst noop ff +noff 2>err &&
> +	test_i18ngrep "the receiving end does not support" err
> +'
> +
>  test_expect_success GPG 'no certificate for a signed push with no upda=
te' '
>  	prepare_dst &&
>  	mkdir -p dst/.git/hooks &&
