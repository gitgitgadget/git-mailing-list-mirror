Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 68F8A20798
	for <e@80x24.org>; Wed, 11 Jan 2017 23:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757368AbdAKX21 (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 18:28:27 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56699 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755342AbdAKX20 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 18:28:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 424A75F7F2;
        Wed, 11 Jan 2017 18:28:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YW/Whpa5K92YUcjlyiGL5w0JzYw=; b=NOy0gs
        QKPrS8iy7smQU47+KMUJxO2pFU9lT3eWfchuBi0F7EXH5m4slYXyizKfkXPbsd1L
        xkjPbot7sHUECbuOW4jd/qiX6DXPdn3nfrU7qxVjFv5A4dpKMuSkL+qfufK7tnhG
        aF0pbRGFmEs3JT+Hnp7a4mYzrA2FGEaFhNEQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EZOvoPkB+8FLJeKVF7H9CDSPnNqDhAfh
        hBlP+wnRpklCj8KTw/z1k9vNnoVc3npT7Zt7pKfc3GMcOgCx6xCHN9jDa8bmL3py
        VsrKgdReaiwbFW6+SsDjJSb7fWmTuf847NQ1EC7EL963+WW2J5IUnycwj72O1c8Z
        TXN+yMiJxeE=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3A6575F7EF;
        Wed, 11 Jan 2017 18:28:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4FC25F7EC;
        Wed, 11 Jan 2017 18:28:19 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        David Turner <novalis@novalis.org>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] unpack-trees: support super-prefix option
References: <20170110014542.19352-1-sbeller@google.com>
        <20170110014542.19352-5-sbeller@google.com>
        <xmqq37gpnuyi.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaHDnVLQr8WLoaD5KKs7EqeW=KbkptF=iHpU5t054Xcdw@mail.gmail.com>
Date:   Wed, 11 Jan 2017 15:28:18 -0800
In-Reply-To: <CAGZ79kaHDnVLQr8WLoaD5KKs7EqeW=KbkptF=iHpU5t054Xcdw@mail.gmail.com>
        (Stefan Beller's message of "Wed, 11 Jan 2017 14:12:12 -0800")
Message-ID: <xmqqh955mb1p.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A2D27BBC-D855-11E6-A2D8-FE3F13518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> Preparing the expected output "expect" outside test_expect_success
>> block is also old-school.  Move it inside the new test?
>
> I looked into that. What is our current stance on using single/double quotes?

Using dq around executable part, i.e.

	test_expect_success title "
		echo \"'foo'\"
	"

is a million-times more grave sin even if the test initially does
not refer to any variable in its body.  Somebody will eventually
need to add a line that refers to a variable and either forgets to
quote \$ in front or properly quotes it.  The former makes the
variable interpolated while the arguments to the test_expect_success
is prepared (which is a bug) and the latter makes the result quite
ugly, like so:

	test_expect_success title "
		sq=\' var=foo &&
		echo \"\${sq}\$value\${sq}\"
	"

Enclosing the body always in sq-pair does mean something ugly like
this from the beginning once you need to use sq inside:

	test_expect_success title '
		sq='\'' &&
		echo "${sq}foo${sq}"
	'

or

	test_expect_success title '
		echo "'\''foo'\''"
	'

but the ugliness is localized to places where single quote is
absolutely needed, and '\'' is something eyes soon get used to as an
idiom [*1*].  It does not affect every reference of variables like
enclosing with dq does.


[Footnote]

*1* That "idiom"-ness is the reason why the last example above is
    not written like this:

	test_expect_success title '
		echo "'\'foo\''"
	'

    even though the sq pair surrounding "foo" is not technically
    necessary.  It lets us think of the string as almost always is
    inside sq context, with the single exception that we step
    outside sq context and append a sq by saying bs-sq (\').
