Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABC65CD4935
	for <git@archiver.kernel.org>; Wed, 20 Sep 2023 22:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjITW4k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Sep 2023 18:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjITW4j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Sep 2023 18:56:39 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA23DAB
        for <git@vger.kernel.org>; Wed, 20 Sep 2023 15:56:33 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 93D7A19BCA;
        Wed, 20 Sep 2023 18:56:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=7Aqkt7GMtx2F9ao8uaP9NROAIgSmLxqhdAxAKb
        dedg8=; b=Ir9D0xYe+YR+S/4QRgad4TkAl8UnTmv90MQxQscZDwjKFRPAMMfdiv
        r69vTUtAWk9YVna5mjv3UvL6n5283QjUczIaaZi+oH3VUnBGQCvYbL4ZvSsbk+wz
        ffLygx4ERrQtn78f8XDyzFLxyGHRgXZlzvY7Ra8/kpEc9l0eFl00w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8C68619BC9;
        Wed, 20 Sep 2023 18:56:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2AB8119BC8;
        Wed, 20 Sep 2023 18:56:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kousik Sanagavarapu <five231003@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/2] t/t6300: introduce test_bad_atom()
In-Reply-To: <20230920191654.6133-2-five231003@gmail.com> (Kousik
        Sanagavarapu's message of "Thu, 21 Sep 2023 00:35:41 +0530")
References: <20230920191654.6133-1-five231003@gmail.com>
        <20230920191654.6133-2-five231003@gmail.com>
Date:   Wed, 20 Sep 2023 15:56:28 -0700
Message-ID: <xmqqy1h078tf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFD7476E-5808-11EE-AA9F-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kousik Sanagavarapu <five231003@gmail.com> writes:

> Introduce a new function "test_bad_atom()", which is similar to
> "test_atom()" but should be used to check whether the correct error
> message is shown on stderr.
>
> Like "test_atom()", the new function takes three arguments. The three
> arguments specify the ref, the format and the expected error message
> respectively, with an optional fourth argument for tweaking
> "test_expect_*" (which is by default "success").
>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored-by: Hariom Verma <hariom18599@gmail.com>
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---
>  t/t6300-for-each-ref.sh | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> index 7b943fd34c..15b4622f57 100755
> --- a/t/t6300-for-each-ref.sh
> +++ b/t/t6300-for-each-ref.sh
> @@ -267,6 +267,26 @@ test_expect_success 'arguments to %(objectname:short=) must be positive integers
>  	test_must_fail git for-each-ref --format="%(objectname:short=foo)"
>  '
>  
> +test_bad_atom() {

Style: have SP on both sides of "()".

> +	case "$1" in
> +	head) ref=refs/heads/main ;;
> +	 tag) ref=refs/tags/testtag ;;
> +	 sym) ref=refs/heads/sym ;;
> +	   *) ref=$1 ;;
> +	esac

Somehow this indirection makes the two examples we see below harder
to understand.  Why shouldn't we just write the full refname on th
command line of test_bad_atom?  That would make it crystal clear
which ref each test works on.  It does not help that both 'head' and
'sym' refer to a local branch (if the former referred to .git/HEAD
or .git/remotes/origin/HEAD it may have been an excellent choice of
the name, but that is not what is going on).

> +	printf '%s\n' "$3">expect

Style: need SP before (but not after) '>'.

> +	test_expect_${4:-success} $PREREQ "err basic atom: $1 $2" "
> +		test_must_fail git for-each-ref --format='%($2)' $ref 2>actual &&
> +		test_cmp expect actual
> +	"

It is error prone to have the executable part of test_expect_{success,failure}
inside a pair of double quotes and have $variable interpolated
_before_ even the arguments to test_expect_{success,failure} are
formed.  It is much more preferrable to write

	test_bad_atom () {
		ref=$1 format=$2
		printf '%s\n' "$3" >expect
		$test_do=test_expect_${4:-success}

		$test_do $PREREQ "err basic atom: $ref $format" '
			test_must_fail git for-each-ref \
				--format="%($format)" "$ref" 2>error &&
			test_cmp expect error
		'
	}

This is primarily because you cannot control what is in "$2" to
ensure the correctness of the test we see above locally (i.e. if
your caller has a single-quote in "$2", the shell script you create
for running test_expect_{success,failure} would be syntactically
incorrect).  By enclosing the executable part inside a pair of
single quotes, and having the $variables interpolated when that
executable part is `eval`ed when test_expect_{success,failure} runs,
you will avoid such problems, and those reading the above can locally
know that you are aware of and correctly avoiding such problems.

I guess three among four problems I just pointed out you blindly
copied from test_atom.  But let's not spread badness (preliminary
clean-up to existing badness would be welcome instead).

> +}
> +
> +test_bad_atom head 'authoremail:foo' \
> +	'fatal: unrecognized %(authoremail) argument: foo'
> +
> +test_bad_atom tag 'taggeremail:localpart trim' \
> +	'fatal: unrecognized %(taggeremail) argument:  trim'

It is strange to see double SP before 'trim' in this error message.
Are we etching a code mistake in stone here?  Wouldn't the error
message say "...argument: localpart trim" instead, perhaps?

>  test_date () {
>  	f=$1 &&
>  	committer_date=$2 &&
