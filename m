Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E8121F991
	for <e@80x24.org>; Mon, 31 Jul 2017 16:37:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752692AbdGaQhc (ORCPT <rfc822;e@80x24.org>);
        Mon, 31 Jul 2017 12:37:32 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64069 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752690AbdGaQh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Jul 2017 12:37:29 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A1E55A0A2E;
        Mon, 31 Jul 2017 12:37:28 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=sWDbnfvELycy9qekEI0kM8q7IDc=; b=Ef9peV
        QKC4/YXVi3aQRXRxhvkYxS+d1+I9riLFsL31lg0Lo4m4x9zGi19x6l046oThB6tN
        Ag5HRtuJS6FiePYItlYxJhU5aoCKl8oDm6FxSX0Jp+UokPcDJUBNQx9uWoQsMCKp
        g/i+0nCCDlaCbALKj5tXViCVo0bqKGDkTJ5fI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lIki9Wg/uLBhTdjll5iX8xqKeV99SLZu
        5VvAxRKAHk4rr2sTor1sLTCNZZm/RDqxDLGZ39SNq9070JxEQrwqar70O9glytpV
        wpyV4JSbViHirR53dvI8fjWu5cN6m6qdBYousMZnMho1qcZme5ATCvmVPj+phPim
        vzRLp58rzO0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 992D3A0A2D;
        Mon, 31 Jul 2017 12:37:28 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E2B3AA0A2C;
        Mon, 31 Jul 2017 12:37:27 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        git@vger.kernel.org, Brandon Williams <bmwill@google.com>
Subject: Re: [PATCH v2 06/10] t7006: add tests for how git tag paginates
References: <cover.1499723297.git.martin.agren@gmail.com>
        <cover.1500321657.git.martin.agren@gmail.com>
        <f4334503b677bbbeb19660e501ad2d7213428953.1500321658.git.martin.agren@gmail.com>
        <20170731033812.tvclfckx3ascxa2m@sigill.intra.peff.net>
Date:   Mon, 31 Jul 2017 09:37:26 -0700
In-Reply-To: <20170731033812.tvclfckx3ascxa2m@sigill.intra.peff.net> (Jeff
        King's message of "Sun, 30 Jul 2017 23:38:12 -0400")
Message-ID: <xmqq379ck1fd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8A4468D8-760E-11E7-8033-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> But here...
>
>> +test_expect_success TTY 'git tag -a respects pager.tag' '
>> +	test_when_finished "git tag -d newtag" &&
>> +	rm -f paginated.out &&
>> +	test_terminal git -c pager.tag tag -am message newtag &&
>> +	test -e paginated.out
>> +'
>
> I think this behavior is just buggy, and it might be better introduced
> as a test_expect_failure on "git tag -a does not respect pager.tag".
>
> Kind of a minor nit, as the series should end up in the right place
> either way, but it can be helpful if you end up digging back in history
> to the introduction of the test.

Yes, I think that is essentially the same reaction I had to patches
7 and 8, where it carries the "buggy" behaviour forward and then
fixes it.  The way the series lays groundwork to introduce a
mechanism that can be used to address this behaviour in its earlier
patches strongly suggests to the users that this is considered a bug
by the author of the series to the user from early on, so adding
this as "expect failure" and then flip it to "expect success" when
the bug is fixed would be a more natural sequence of changes.

Thanks.
