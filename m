Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B6E31F406
	for <e@80x24.org>; Fri, 12 Jan 2018 22:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965296AbeALWHq (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Jan 2018 17:07:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54869 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965183AbeALWHo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jan 2018 17:07:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2ED7FD72F3;
        Fri, 12 Jan 2018 17:07:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ofV/P4lNCUrWh1hniIKbVdhtGWs=; b=wk3P7g
        LnwYBHr8fG8xpQvjC23YZ+Yw2YtzWYPEeQPpFAQQmnG4SD37ng91txP45ob+5afa
        luZ7RHol5RGS96YbcVn/2zionzTNtvhk/STQZkEBNV8H7Y5N/9TY6hlADPJx7gvx
        mxoYYM4Hh0kOKX4PHfFXvw0h3lfH23FKFXHn4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=KsVRnixp6unjGLkINaUPX85Ao35kf0oZ
        OBe9oLEO+uQMQXr27jFUUKLdDFngYgONccmVoTBOe2ZcYZYIZNqV7rLkQlXL+e97
        mMSVdk2x6FWiHL2kciwRFv0CUvpMuLf6yisnPL4R8HGK9gUy0Gqs3RM0Yu60CqDy
        TrCLC26szu0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 254BCD72F2;
        Fri, 12 Jan 2018 17:07:42 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9F33DD72F1;
        Fri, 12 Jan 2018 17:07:41 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>, Tanay Abhra <tanayabh@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Subject: Re: [ANNOUNCE] Git v2.16.0-rc2 - breakages in t1308 and 1404
References: <004b01d38bdd$7a11da60$6e358f20$@nexbridge.com>
Date:   Fri, 12 Jan 2018 14:07:40 -0800
In-Reply-To: <004b01d38bdd$7a11da60$6e358f20$@nexbridge.com> (Randall
        S. Becker's message of "Fri, 12 Jan 2018 14:42:21 -0500")
Message-ID: <xmqqd12ewx1v.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0253BB1E-F7E5-11E7-9892-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> It looks like the exit code is coming back as 1 not 2. There is
> also a file except vs expect.
> ./trash directory.t1308-config-set: ls
> a-directory  actual  config2  except  expect  output  result

The test that leaves "except" does look wrong.  The relevant part
looks like this:

    test_expect_success 'find value with highest priority from a configset' '
            echo hask >expect &&
            test-config configset_get_value case.baz config2 .git/config >actual &&
            test_cmp expect actual
    '

    test_expect_success 'find value_list for a key from a configset' '
            cat >except <<-\EOF &&
            sam
            ...
            EOF
            test-config configset_get_value case.baz config2 .git/config >actual &&
            test_cmp expect actual
    '

The invocations of test-config in these two tests look exactly the
same, at least to me, so whatever comes out of the command and
stored in 'actual' must match what the first test stored in 'expect'
and compared the same as 'actual' in that test.

So the second test is probably asking a wrong question to test-config
but because it prepares an expected answer in a wrong file, it did
not even notice that it is asking a wrong question X-<.

The wrong test comes from 4c715ebb ("test-config: add tests for the
config_set API", 2014-07-28); I do not know offhand if the author of
that change is still around.

Having said all that, I suspect that the "except" thing may not have
anything to do with what you are observing; sorry for not ending up
to be very helpful X-<.




