Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CEDCC433E0
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 02:11:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0658238EC
	for <git@archiver.kernel.org>; Sat,  9 Jan 2021 02:11:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726525AbhAICLn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jan 2021 21:11:43 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:54787 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbhAICLm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jan 2021 21:11:42 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id ADC1E109053;
        Fri,  8 Jan 2021 21:10:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=cirkx8Tdgg6hJx0Y2d65pBfEiPM=; b=Sgt9/g
        vb/zXUef/1bHTk0piUxMSVdwN2hjdRXu9Jy9uSpdji371QGzLg6StpUu0BI84Y2A
        bMYwvy2ZWYEP0HfmRTr5SC3gq5b8TNZkJErWL2RJeEL8/KIvvjU9HoPhLglCfobE
        SZGQJFj2ABulmIXUnTkrj/kmU/GJJUJTQlvUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PX6PL12FYB2VnHRZdJX5OWP9sXTh/D+h
        i5xZjqH5E4p4AmIHEHRJY0K9xeTQIZictjHO1vV3vi09BUtC9FfZbHBJ6RuVegyV
        Tj0oejrUmmoE0z8tfipCmZBnmQ8GSD2fqzFt8jS1wiZsIuYiTUG4ArbRSfNQ4Gnb
        ksPHhhji264=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id A697B109052;
        Fri,  8 Jan 2021 21:10:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F149810904E;
        Fri,  8 Jan 2021 21:10:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jiang Xin <worldhello.net@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7Ru?= =?utf-8?B?Zw==?= Danh 
        <congdanhqx@gmail.com>, Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v4 1/2] bundle: lost objects when removing duplicate
 pendings
References: <X/cqrTgilKAW9P9G@danh.dev>
        <20210108144514.24805-2-worldhello.net@gmail.com>
Date:   Fri, 08 Jan 2021 18:10:55 -0800
In-Reply-To: <20210108144514.24805-2-worldhello.net@gmail.com> (Jiang Xin's
        message of "Fri, 8 Jan 2021 09:45:13 -0500")
Message-ID: <xmqqv9c6g8r4.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E8E9F786-521F-11EB-90F7-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jiang Xin <worldhello.net@gmail.com> writes:

> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
> new file mode 100755
> index 0000000000..c4447ca88f
> --- /dev/null
> +++ b/t/t6020-bundle-misc.sh
> @@ -0,0 +1,477 @@
> +#!/bin/sh
> +#
> +# Copyright (c) 2021 Jiang Xin
> +#
> +
> +test_description='Test git-bundle'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +. ./test-lib.sh
> +
> +# Check count of objects in a bundle file.
> +# We can use "--thin" opiton to check thin pack, which must be fixed by
> +# command `git-index-pack --fix-thin --stdin`.
> +test_bundle_object_count () {
> +	thin= &&
> +	if test "$1" = "--thin"
> +	then
> +		thin=yes
> +		shift
> +	fi &&
> +	if test $# -ne 2
> +	then
> +		echo >&2 "args should be: <bundle> <count>"
> +		return 1
> +	fi
> +	bundle=$1 &&
> +	pack=${bundle%.bdl}.pack &&
> +	convert_bundle_to_pack <"$bundle" >"$pack" &&
> +	if test -n "$thin"
> +	then
> +		test_must_fail git index-pack "$pack" &&

This is overly strict, isn't it?  

Imagine a case where the objects newer revisions introduce have *no*
resemblance to the objects in the prerequisites' trees---the
resulting pack will have no object that is expressed as a delta
against anything outside the pack, and the above "index-pack" would
succeed.

Besides, "git pack-objects --thin" is *not* obligated to create a
pack that lacks one or more objects.  The "--thin" option merely
*allows* pack-objects to omit base objects if it is convenient to do
so.

> +		mv "$pack" "$pack"-thin &&
> +		cat "$pack"-thin |
> +			git index-pack --stdin --fix-thin "$pack"

This side is good, but do not cat a single file into a pipe.
The whole "then" clause would become

	then
		mv "$pack" "$pack-thin" &&
		git index-pack --stdin --fix-thin "$pack" <"$pack-thin"
	else

I would think.

> +	else
> +		git index-pack "$pack"
> +	fi &&
> +	git verify-pack -v "$pack" >verify.out
> +	if test $? -ne 0
> +	then
> +		echo >&2 "error: fail to convert $bundle to $pack"
> +		return 1
> +	fi

At this point, we are not testing the bundle subcommand, but is
testing "git index-pack --fix-thin" that we run ourselves.  Is it
essential to ensure $pack is sane here?  I doubt it.

> +	count=$(grep -c "^$OID_REGEX " verify.out) &&

And if there is no need to run verify-pack, then we can do
count=$(git show-index "${pack%pack}idx" | wc -l) instead, perhaps?

> +	test $2 = $count && return 0
> +	echo >&2 "error: object count for $bundle is $count, not $2"
> +	return 1
> +}
> +
> +# Display the pack data contained in the bundle file, bypassing the
> +# header that contains the signature, prerequisites and references.
> +convert_bundle_to_pack () {
> +	while read x && test -n "$x"
> +	do
> +		:;
> +	done
> +	cat
> +}

This looks somewhat familiar.  Perhaps extract out necessary helpers
including this one into t/test-bundle-lib or something similar in a
preparatory step before this patch?

> +# Create a commit or tag and set the variable with the object ID.
> +test_commit_setvar () {
> +	notick= &&
> +	signoff= &&
> +	indir= &&
> +	merge= &&
> +	tag= &&
> +	var= &&
> +	while test $# != 0
> +	do
> +		case "$1" in
> +		--merge)
> +			merge=yes
> +			;;
> +		--tag)
> +			tag=yes
> +			;;
> +		--notick)
> +			notick=yes
> +			;;
> +		--signoff)
> +			signoff="$1"
> +			;;
> +		-C)
> +			indir="$2"
> +			shift
> +			;;
> +		-*)
> +			echo >&2 "error: unknown option $1"
> +			return 1
> +			;;
> +		*)
> +			test -n "$var" && break
> +			var=$1
> +			;;
> +		esac
> +		shift
> +	done &&

At this point, if $var is still empty, the caller is buggy, and ...

> +	indir=${indir:+"$indir"/} &&
> +	if test $# -eq 0
> +	then
> +		echo >&2 "no args provided"
> +		return 1
> +	fi &&
> +	if test -z "$notick"
> +	then
> +		test_tick
> +	fi &&
> +	if test -n "$merge"
> +	then
> +		git ${indir:+ -C "$indir"} merge --no-edit --no-ff \
> +			${2:+-m "$2"} "$1" &&
> +		oid=$(git ${indir:+ -C "$indir"} rev-parse HEAD)
> +	elif test -n "$tag"
> +	then
> +		git ${indir:+ -C "$indir"} tag -m "$1" "$1" &&
> +		oid=$(git ${indir:+ -C "$indir"} rev-parse "$1")
> +	else
> +		file=${2:-"$1.t"} &&
> +		echo "${3-$1}" > "$indir$file" &&
> +		git ${indir:+ -C "$indir"} add "$file" &&
> +		git ${indir:+ -C "$indir"} commit $signoff -m "$1" &&
> +		oid=$(git ${indir:+ -C "$indir"} rev-parse HEAD)
> +	fi &&
> +	eval $var=$oid
> +}

... it will cause a failure in 'eval' we have here.  Not good.

> +# Format the output of git commands to make a user-friendly and stable
> +# text.  We can easily prepare the expect text without having to worry
> +# about future changes of the commit ID and spaces of the output.

Hmph.  This relies on 7 hexdigits being sufficient to uniquely
identify all objects involved in the test?  It should be OK in
practice.

Is there a point in having both <COMMIT-A> and <OID-A>?  I would
have expected that all these "full object name" conversions are
unneeded.

> +make_user_friendly_and_stable_output () {
> +	sed \
> +		-e "s/$A/<COMMIT-A>/" \
> +		-e "s/$B/<COMMIT-B>/" \
> +		-e "s/$C/<COMMIT-C>/" \
> +		-e "s/$D/<COMMIT-D>/" \
> +		-e "s/$E/<COMMIT-E>/" \
> +		-e "s/$F/<COMMIT-F>/" \
> +		-e "s/$G/<COMMIT-G>/" \
> +		-e "s/$H/<COMMIT-H>/" \
> +		-e "s/$I/<COMMIT-I>/" \
> +		-e "s/$J/<COMMIT-J>/" \
> +		-e "s/$K/<COMMIT-K>/" \
> +		-e "s/$L/<COMMIT-L>/" \
> +		-e "s/$M/<COMMIT-M>/" \
> +		-e "s/$N/<COMMIT-N>/" \
> +		-e "s/$O/<COMMIT-O>/" \
> +		-e "s/$P/<COMMIT-P>/" \
> +		-e "s/$TAG1/<TAG-1>/" \
> +		-e "s/$TAG2/<TAG-2>/" \
> +		-e "s/$TAG3/<TAG-3>/" \
> +		-e "s/$(echo $A | cut -c1-7)[0-9a-f]*/<OID-A>/g" \
> +		-e "s/$(echo $B | cut -c1-7)[0-9a-f]*/<OID-B>/g" \
> +		-e "s/$(echo $C | cut -c1-7)[0-9a-f]*/<OID-C>/g" \
> +		-e "s/$(echo $D | cut -c1-7)[0-9a-f]*/<OID-D>/g" \
> +		-e "s/$(echo $E | cut -c1-7)[0-9a-f]*/<OID-E>/g" \
> +		-e "s/$(echo $F | cut -c1-7)[0-9a-f]*/<OID-F>/g" \
> +		-e "s/$(echo $G | cut -c1-7)[0-9a-f]*/<OID-G>/g" \
> +		-e "s/$(echo $H | cut -c1-7)[0-9a-f]*/<OID-H>/g" \
> +		-e "s/$(echo $I | cut -c1-7)[0-9a-f]*/<OID-I>/g" \
> +		-e "s/$(echo $J | cut -c1-7)[0-9a-f]*/<OID-J>/g" \
> +		-e "s/$(echo $K | cut -c1-7)[0-9a-f]*/<OID-K>/g" \
> +		-e "s/$(echo $L | cut -c1-7)[0-9a-f]*/<OID-L>/g" \
> +		-e "s/$(echo $M | cut -c1-7)[0-9a-f]*/<OID-M>/g" \
> +		-e "s/$(echo $N | cut -c1-7)[0-9a-f]*/<OID-N>/g" \
> +		-e "s/$(echo $O | cut -c1-7)[0-9a-f]*/<OID-O>/g" \
> +		-e "s/$(echo $P | cut -c1-7)[0-9a-f]*/<OID-P>/g" \
> +		-e "s/$(echo $TAG1 | cut -c1-7)[0-9a-f]*/<OID-TAG-1>/g" \
> +		-e "s/$(echo $TAG2 | cut -c1-7)[0-9a-f]*/<OID-TAG-2>/g" \
> +		-e "s/$(echo $TAG3 | cut -c1-7)[0-9a-f]*/<OID-TAG-3>/g" \
> +		-e "s/ *\$//"
> +}
> ...
> +test_expect_success 'create bundle from special rev: main^!' '
> +	git bundle create special-rev.bdl "main^!" &&
> +
> +	git bundle list-heads special-rev.bdl |
> +		make_user_friendly_and_stable_output >actual &&
> +	cat >expect <<-EOF &&
> +		<COMMIT-P> refs/heads/main
> +		EOF

We prefer to indent these more like so:

	cat >expect <<-\EOF &&
	<COMMIT-P> refs/heads/main
	EOF

i.e. the indent of the line with <<EOF on it and the indent of the
line with the matching EOF are the same.  Also, quote EOF to signal
that the body of the here text should be taken as-is without $var
substitution.

