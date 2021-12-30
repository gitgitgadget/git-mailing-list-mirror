Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 227FFC433F5
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 23:36:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242352AbhL3Xgq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 18:36:46 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60343 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbhL3Xgo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 18:36:44 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4661C10F658;
        Thu, 30 Dec 2021 18:36:44 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type
        :content-transfer-encoding; s=sasl; bh=+SQx6ZdxFekzB2Y/MAm3rKIGU
        WFHhDJPiAtJ1AGXV7I=; b=WLtdAXakoYjQCJedrEWgw3vPZ58to1h5uGd7wx+33
        oRWSmdVR9xhT9oPTqJpG7nclp9IF/MyJB/Ak6X7lJDHXHReMN+L9ge8aFvq4PARd
        OpokO0tGTq31nG4l3YNmPYVYPMPMsU4WGOAGaCeq83vMpi4mJNv64h7e2XjGfDYl
        eo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E72010F657;
        Thu, 30 Dec 2021 18:36:44 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 98ED310F655;
        Thu, 30 Dec 2021 18:36:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Josh Steadmon <steadmon@google.com>
Subject: Re: [PATCH v6 1/6] object-name tests: add tests for ambiguous
 object blind spots
References: <cover-v5-0.6-00000000000-20211125T215529Z-avarab@gmail.com>
        <cover-v6-0.6-00000000000-20211228T143223Z-avarab@gmail.com>
        <patch-v6-1.6-27f267ad555-20211228T143223Z-avarab@gmail.com>
Date:   Thu, 30 Dec 2021 15:36:42 -0800
Message-ID: <xmqqv8z5mzqt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 588A27DE-69C9-11EC-936E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> +test_cmp_failed_rev_parse () {
> +	dir=3D$1
> +	rev=3D$2
> +	shift

What are we shifting away?

> +	test_must_fail git -C "$dir" rev-parse "$rev" 2>actual.raw &&
> +	sed "s/\($rev\)[0-9a-f]*/\1.../g" <actual.raw >actual &&

I wonder if we need to ensure not to mistakenly produce second hit
in an object name that has $rev twice, e.g. "cafe123cafe..."?

> +	test_cmp expect actual
> +}

It is a bit confusing to _depend_ on the caller to prepare a
fixed-name file, like this.  We've avoided such confusion in
different ways in other tests, like (A) make the helper take
the expected output from its standard input, or (B) make the
helper take the name of the file that has expected output as
its argument.

> +test_expect_success 'ambiguous blob output' '
> +	git init --bare blob.prefix &&
> +	(
> +		cd blob.prefix &&
> +
> +		# Both start with "dead..", under both SHA-1 and SHA-256
> +		echo brocdnra | git hash-object -w --stdin &&
> +		echo brigddsv | git hash-object -w --stdin &&
> +
> +		# Both start with "beef.."
> +		echo 1agllotbh | git hash-object -w --stdin &&
> +		echo 1bbfctrkc | git hash-object -w --stdin
> +	) &&
> +
> +	test_must_fail git -C blob.prefix rev-parse dead &&
> +	cat >expect <<-\EOF &&
> +	error: short object ID beef... is ambiguous
> +	hint: The candidates are:
> +	hint:   beef... blob
> +	hint:   beef... blob
> +	fatal: ambiguous argument '\''beef...'\'': unknown revision or path n=
ot in the working tree.
> +	Use '\''--'\'' to separate paths from revisions, like this:
> +	'\''git <command> [<revision>...] -- [<file>...]'\''
> +	EOF
> +	test_cmp_failed_rev_parse blob.prefix beef
> +'
> +
> +test_expect_success 'ambiguous loose blob parsed as OBJ_BAD' '

"loose bad object", as they aren't even blobs, perhaps?

> +	git init --bare blob.bad &&
> +	(
> +		cd blob.bad &&
> +
> +		# Both have the prefix "bad0"
> +		echo xyzfaowcoh | git hash-object -t bad -w --stdin --literally &&
> +		echo xyzhjpyvwl | git hash-object -t bad -w --stdin --literally
> +	) &&
> +
> +	cat >expect <<-\EOF &&
> +	error: short object ID bad0... is ambiguous
> +	hint: The candidates are:
> +	fatal: invalid object type

That indeed is not very nice.

> +	EOF
> +	test_cmp_failed_rev_parse blob.bad bad0
> +'
> +
> +test_expect_success POSIXPERM 'ambigous zlib corrupt loose blob' '
> +	git init --bare blob.corrupt &&
> +	(
> +		cd blob.corrupt &&
> +
> +		# Both have the prefix "cafe"
> +		echo bnkxmdwz | git hash-object -w --stdin &&
> +		oid=3D$(echo bmwsjxzi | git hash-object -w --stdin) &&
> +
> +		oidf=3Dobjects/$(test_oid_to_path "$oid") &&
> +		chmod 755 $oidf &&
> +		echo broken >$oidf
> +	) &&
> +
> +	cat >expect <<-\EOF &&
> +	error: short object ID cafe... is ambiguous
> +	hint: The candidates are:
> +	error: inflate: data stream error (incorrect header check)
> +	error: unable to unpack cafe... header
> +	error: inflate: data stream error (incorrect header check)
> +	error: unable to unpack cafe... header
> +	hint:   cafe... unknown type
> +	hint:   cafe... blob

This is an interesting one.  I _think_ it is clear enough for the
readers that the inflate errors are for the object that immediately
follows them, so as long as we show these hints one by one, the
above output is perfectly fine.  But we'll see.

> +	fatal: ambiguous argument '\''cafe...'\'': unknown revision or path n=
ot in the working tree.
> +	Use '\''--'\'' to separate paths from revisions, like this:
> +	'\''git <command> [<revision>...] -- [<file>...]'\''
> +	EOF
> +	test_cmp_failed_rev_parse blob.corrupt cafe
> +'
> +
>  if ! test_have_prereq SHA1
>  then
>  	skip_all=3D'not using SHA-1 for objects'
