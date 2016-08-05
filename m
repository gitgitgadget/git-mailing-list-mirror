Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 021432018E
	for <e@80x24.org>; Fri,  5 Aug 2016 20:45:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967740AbcHEUpl (ORCPT <rfc822;e@80x24.org>);
	Fri, 5 Aug 2016 16:45:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60368 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S934232AbcHEUpg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2016 16:45:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id ABA8433EC1;
	Fri,  5 Aug 2016 16:45:34 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0vOVacD0EIXZ0WoC3Nq189y+dGI=; b=djuMtF
	eh7Oc50oSDIO2ln4+slm5RFLmPi/EUZMv9I+IvT6ZvaFUVEFmOyDDjKl1eqSXObe
	A+B+9uuWAQug8+IInoIdxjz0tIAJVtcnpRUAPkOH0EEQ83BDJNlJIE72nddkCuzR
	b6W6LTeFR8eZOVNklUYZZRHEXNbQOprFVAI5k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ptpQI31f2eDPfr6XXOhlr2NFLFdoosEk
	DkIThZ6NQzmD8G9n1nzMENwDgykGb/Am0XFSfcCck6wdKIB2tWcq2c+kvvqkObac
	Vj/YemfgtrQ2ZzGOGSTwKFSU0sHzDgAeSii1wCgYLDQTG1ivuBgeDr/LN4MCjVj/
	o33BFOVfB14=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A407B33EC0;
	Fri,  5 Aug 2016 16:45:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1F97B33EBF;
	Fri,  5 Aug 2016 16:45:34 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	git@vger.kernel.org, mst@redhat.com, Jens.Lehmann@web.de
Subject: Re: [PATCH 2/6] t7408: merge short tests, factor out testing method
References: <20160804195159.7788-1-sbeller@google.com>
	<20160804195159.7788-3-sbeller@google.com>
Date:	Fri, 05 Aug 2016 13:45:32 -0700
In-Reply-To: <20160804195159.7788-3-sbeller@google.com> (Stefan Beller's
	message of "Thu, 4 Aug 2016 12:51:55 -0700")
Message-ID: <xmqqeg63vtar.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8E6B585E-5B4D-11E6-B445-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Tests consisting of one line each can be consolidated to have fewer tests
> to run as well as fewer lines of code.
>
> When having just a few git commands, do not create a new shell but
> use the -C flag in Git to execute in the correct directory.

Good motivations.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
>  t/t7408-submodule-reference.sh | 50 +++++++++++++++---------------------------
>  1 file changed, 18 insertions(+), 32 deletions(-)
>
> diff --git a/t/t7408-submodule-reference.sh b/t/t7408-submodule-reference.sh
> index afcc629..1416cbd 100755
> --- a/t/t7408-submodule-reference.sh
> +++ b/t/t7408-submodule-reference.sh
> @@ -10,6 +10,16 @@ base_dir=$(pwd)
>  
>  U=$base_dir/UPLOAD_LOG

Is this line needed anywhere?

We (perhaps unfortunately) still need $base_dir because we want to
give an absolute file:/// URL to "submodule add", but I do not think
we use $U, so let's get rid of it.

> +test_alternate_usage()
> +{

According to Documentation/CodingGuidelines, this should be:

    test_alternate_usage () {

Somehow the helper name sounds as if it is testing if an alternate
is used correctly (i.e. the machinery may attempt to use alternate
but not in a correct way), not testing if an alternate is correctly
used (i.e. the machinery incorrectly forgets to use an alternate at
all), but maybe it is just me.

> +	alternates_file=$1
> +	working_dir=$2

These are good (they can be on a single line), but you would
want &&-chain just as other lines.

> +	test_line_count = 1 $alternates_file &&

This needs to quote "$alternates_file" especially in a helper
function you have no control over future callers of.

I wonder if we want to check the actual contents of the alternate;
it may force us to worry about the infamous "should we expect
$(pwd)/something or $PWD/something" if we did so, so it is not a
strong suggestion.

> +	echo "0 objects, 0 kilobytes" >expect &&
> +	git -C $working_dir count-objects >current &&
> +	diff expect current

It is more customary to name two "expect" vs "actual", and compare
them using "test_cmp" not "diff".

> +}
> +
>  test_expect_success 'preparing first repository' '
>  	test_create_repo A &&
>  	(
> @@ -42,44 +52,20 @@ test_expect_success 'preparing superproject' '
>  	)
>  '
>  
> -test_expect_success 'submodule add --reference' '
> +test_expect_success 'submodule add --reference uses alternates' '
>  	(
>  		cd super &&
>  		git submodule add --reference ../B "file://$base_dir/A" sub &&
>  		git commit -m B-super-added
> -	)
> -'
> -
> -test_expect_success 'after add: existence of info/alternates' '
> -	test_line_count = 1 super/.git/modules/sub/objects/info/alternates
> -'
> -
> -test_expect_success 'that reference gets used with add' '
> -	(
> -		cd super/sub &&
> -		echo "0 objects, 0 kilobytes" > expected &&
> -		git count-objects > current &&
> -		diff expected current
> -	)
> -'

Completely unrelated tangent, but after seeing the "how would we
make a more intelligent choice of the diff boundary" topic, I
wondered if we can notice that at this point there is a logical
boundary and do something intelligent about it.  All the removed
lines above have become "test_alternate" we see below, while all the
removed lines below upto "test_alternate" correspond to the updated
test at the end.

> -test_expect_success 'cloning superproject' '
> -	git clone super super-clone
> -'
> -
> -test_expect_success 'update with reference' '
> -	cd super-clone && git submodule update --init --reference ../B
> -'
> -
> -test_expect_success 'after update: existence of info/alternates' '
> -	test_line_count = 1 super-clone/.git/modules/sub/objects/info/alternates
> +	) &&
> +	test_alternate_usage super/.git/modules/sub/objects/info/alternates super/sub
>  '
>  
> -test_expect_success 'that reference gets used with update' '
> -	cd super-clone/sub &&
> -	echo "0 objects, 0 kilobytes" > expected &&
> -	git count-objects > current &&
> -	diff expected current
> +test_expect_success 'updating superproject keeps alternates' '
> +	test_when_finished "rm -rf super-clone" &&

This one is new; we do not remove A, B or super.  Does it matter if
we leave super-clone behind?  Is super-clone so special?

> +	git clone super super-clone &&
> +	git -C super-clone submodule update --init --reference ../B &&
> +	test_alternate_usage super-clone/.git/modules/sub/objects/info/alternates super-clone/sub
>  '
>  
>  test_done
