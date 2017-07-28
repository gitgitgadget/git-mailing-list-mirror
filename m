Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE5672089D
	for <e@80x24.org>; Fri, 28 Jul 2017 22:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752945AbdG1WOw (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jul 2017 18:14:52 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50148 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752762AbdG1WOv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2017 18:14:51 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3A4E496B15;
        Fri, 28 Jul 2017 18:14:51 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uiej6nBPjmouom/Q3ZC2Y4o+WdE=; b=ZAFE7Q
        7fcTUJPhfD8HXAylzuUsDz32GDX3HpYDVaeZ0M375KlsWAxqAAomyQimUNiNbPBj
        E+Yt+QQuxMRYlm5RjJgEK29ayC8ErsaNzhnVBru39jE/aENONipBE8mpoynbrZof
        vohLL5Kyk9mdfSq8RfwPZA3TVCKy/y2Ykl8co=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=btzyxQv2Et23xprIl/0malqtwaaFE7KX
        utZDm85PL9Z21YNDyTua1G5q24RKVneG45tcLn016bZTdDDYEBLdiF4TrQD7tFca
        nVozFYvZLbYfutnegqXhUIbDphM32FN8r+xZGkwmqsVWVDvNWfC6vDxCGpr0W3aL
        zZ3S7W8MyVg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 32BB496B12;
        Fri, 28 Jul 2017 18:14:51 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99A1896B0A;
        Fri, 28 Jul 2017 18:14:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/2] t6500: mark tests as SHA1 reliant
References: <20170728171817.21458-1-sbeller@google.com>
        <20170728171817.21458-3-sbeller@google.com>
Date:   Fri, 28 Jul 2017 15:14:49 -0700
In-Reply-To: <20170728171817.21458-3-sbeller@google.com> (Stefan Beller's
        message of "Fri, 28 Jul 2017 10:18:17 -0700")
Message-ID: <xmqq379gmco6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2C9DA2CC-73E2-11E7-BD6A-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The first test marked relies on hard coded sha1:
>
> 	# We need to create two object whose sha1s start with 17
> 	# since this is what git gc counts.  As it happens, these
> 	# two blobs will do so.
> 	test_commit 263 &&
> 	test_commit 410 &&
>
> The next two seem to rely on state from the first one, I did not
> investigate.

I am moderately negative on this approach, if it is meant to suggest
the final shape of our test suite patch 1/2 started.

This script may be a good example you can use to demonstrate a much
better approach.  As the above comment in the test shows, we want to
create two objects whose object names begin with "17", and running
test_commit with 263 and 410 at this point in the test was a way to
achieve that when Git uses SHA-1 as its hash.

When we use a hash different from SHA-1, the exact strings 263 and
410 may change, but we should be able to find two other strings that
has the same property (i.e. they results in objects that share the
prefix "17").  Perhaps a better way forward for this kind of test is
to parameterize these hardcoded constants and make it easier to use
different values without having to change the rest of the script
when we switch the hash function?  So perhaps have something like

	case "$GIT_HASH_FUNCTION" in
	SHA-1)	
		TEST_17_1="263 410" ;;
	CORRUPT-SHA-1)	
		TEST_17_1="something else" ;;
        esac

near the top of the script and update the above two with:

	for token in $TEST_17_1
	do
		test_commit "$token" || return 1
	done &&

would prepare us to switch to SHA-256 or whatever hash function we
choose to use in the future?

t1512 is another example with full of such tests that we would want
to keep moral equivalents in the world with a different hash,
instead of reducing the test coverage.
