Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F1B63203E2
	for <e@80x24.org>; Fri, 19 Aug 2016 00:52:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752696AbcHSAv4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Aug 2016 20:51:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64208 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754073AbcHSAt6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Aug 2016 20:49:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 93DD434FC9;
        Thu, 18 Aug 2016 16:25:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=10s72cKUrgy6/SYVuypSP+DyMOw=; b=Ulk8s1
        9+iSMZI3A7WRvKRt4QHSdLv/ckVM+YpIs9wxz07E4Po+IZHYbTm5CNj8D8FgCB/o
        8o0TvJwk1EEwA4/Ucz6kx2Hg9poOjDtkgZQBlh2DyA3Es54NK7ecPC3ASwQnFxbG
        vSK3+t9tSCOQEsVV5Pqb/0Fwxz/BTWIpO7AzE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=JTmswQOC6YBzDEMkLfH5FC0JAalRE2e9
        g6jj4G9YVrUwYYj4u+UQ6ucWzOgXdPBMYcP/w5O6/3rpJLRnWlGJ0MbySfw68tOf
        xzEgQEHW/WFSmD/RwXbTlxyfdjSUc/DANlCig/QwtoeeQV71AJDRzlyvOTI5h4Qc
        3AwgrjA0BRg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 887BE34FC7;
        Thu, 18 Aug 2016 16:25:46 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id F070C34FC6;
        Thu, 18 Aug 2016 16:25:45 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v2 3/3] receive-pack: allow a maximum input size to be specified
References: <20160818131553.22580-1-chriscool@tuxfamily.org>
        <20160818131553.22580-4-chriscool@tuxfamily.org>
Date:   Thu, 18 Aug 2016 13:25:43 -0700
In-Reply-To: <20160818131553.22580-4-chriscool@tuxfamily.org> (Christian
        Couder's message of "Thu, 18 Aug 2016 15:15:53 +0200")
Message-ID: <xmqqpop56czc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F19A4DB6-6581-11E6-B20A-E86612518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> Receive-pack feeds its input to either index-pack or
> unpack-objects, which will happily accept as many bytes as
> a sender is willing to provide. Let's allow an arbitrary
> cutoff point where we will stop writing bytes to disk.
>
> Cleaning up what has already been written to disk is a
> related problem that is not addressed by this patch.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  Documentation/config.txt           |  5 +++++
>  Documentation/git-receive-pack.txt |  3 +++
>  builtin/receive-pack.c             | 12 +++++++++++
>  t/t5546-push-limits.sh             | 42 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 62 insertions(+)
>  create mode 100755 t/t5546-push-limits.sh
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 0bcb679..f5b6061 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -2517,6 +2517,11 @@ receive.unpackLimit::
>  	especially on slow filesystems.  If not set, the value of
>  	`transfer.unpackLimit` is used instead.
>  
> +receive.maxsize::

Shouldn't this be maxInputSize, not just maxSize?  You are limiting
the size of the input, not the size of the resulting pack, right?

> +	If the size of a pack file is larger than this limit, then

So, s/a pack file/the incoming pack stream/ or something?

> diff --git a/t/t5546-push-limits.sh b/t/t5546-push-limits.sh
> new file mode 100755
> index 0000000..09e958f

Technically, that's receive-limits, no?  It is conceivable that the
client side can also grow a feature to limit the size of an outgoing
push, but that is not what this new script is about.

> --- /dev/null
> +++ b/t/t5546-push-limits.sh
> @@ -0,0 +1,42 @@
> +#!/bin/sh
> +
> +test_description='check input limits for pushing'
> +. ./test-lib.sh
> +
> +test_expect_success 'create remote repository' '
> +	git init --bare dest
> +'
> +

> +# Let's run tests with different unpack limits: 1 and 10
> +# When the limit is 1, `git receive-pack` will call `git index-pack`.
> +# When the limit is 10, `git receive-pack` will call `git unpack-objects`.

I agree with Peff that these tests should push into an empty,
pristine destination.  Move the "create remote" step inside the
while loop and prefix its "git init" with "rm -rf dest", or
something like that.

It would make it crystal clear that the produced packstream for our
transfer won't ever be affected by what is leftover in the
destination repository.

Also, I think it would make it far more readable if you made the
body of the while loop into a helper function that runs tests,
keeping "1/10 corresponds to index/unpack" magic hidden inside the
helper, i.e. something like

test_pack_input_limit () {
	size=$2
        case "$1" in
        unpack) unpack_limit=10000 ;;
        index) unpack_limit=1 ;;
	esac

	test_expect_success 'prepare destination repository' '
		rm -fr dest &&
		git --bare init dest
	'

	test_expect_success "set unpacklimit to $unpack_limit" '
		git --git-dir=dest config receive.unpacklimit "$unpack_limit"
	'

	test_expect_success 'setting receive.maxsize to 512 rejects push' '
		git --git-dir=dest config receive.maxsize 512 &&
		test_must_fail git push dest HEAD
	'

	test_expect_success 'bumping limit to 4k allows push' '
		git --git-dir=dest config receive.maxsize 4k &&
		git push dest HEAD
	'

	test_expect_success 'prepare destination repository (again)' '
		rm -fr dest &&
		git --bare init dest
	'

	test_expect_success 'lifting the limit allows push' '
		git --git-dir=dest config receive.maxsize 0 &&
		git push dest HEAD
	'
}

and have the body of the test more like this:

	test_expect_success 'setup' '
		test-genrandom foo 1024 >test-file &&
		git add test-file &&
		test_commit test-file
	'

	test_pack_input_limit unpack 1024 
	test_pack_input_limit index 1024 

Perhaps?
