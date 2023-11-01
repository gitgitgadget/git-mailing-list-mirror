Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEB37A32
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 03:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gSGjb4mr"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C9CA4
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 20:14:47 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 976DC1D6E43;
	Tue, 31 Oct 2023 23:14:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ByknGmshU3R0t1bYmN9r5gmglI7e/ZZAzVKSuy
	ix6QM=; b=gSGjb4mrg5BBUsWJE3EUVWdIvSCiIkEuNvsk0YI139lsTH+EtUnL9e
	5zt09GRZHjPndSeOQp7FOJ2RE9UWha+v1DX5MK+tEAkAiibjSzKCf8L5lFq5xhFw
	DuVNo9vjkEHYUQsNJ7iOe4pluBzBcr0WGdBxtHW2kK/fhI9SQOQtQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 903041D6E42;
	Tue, 31 Oct 2023 23:14:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A7AD1D6E41;
	Tue, 31 Oct 2023 23:14:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>,  Victoria Dye <vdye@github.com>
Cc: git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Oswald Buddenhagen
 <oswald.buddenhagen@gmx.de>
Subject: Re: [PATCH v4 5/8] ci: unify setup of some environment variables
In-Reply-To: <31ebe4c9-84aa-4d42-9aeb-712e2a6cece3@github.com> (Victoria Dye's
	message of "Tue, 31 Oct 2023 10:06:24 -0700")
References: <cover.1698305961.git.ps@pks.im> <cover.1698742590.git.ps@pks.im>
	<a64799b6e25d05e5d5fc7fe3c5602b5ce256d8b9.1698742590.git.ps@pks.im>
	<31ebe4c9-84aa-4d42-9aeb-712e2a6cece3@github.com>
Date: Wed, 01 Nov 2023 12:14:42 +0900
Message-ID: <xmqqttq6w4f1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CDD7CBBC-7864-11EE-9E70-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Victoria Dye <vdye@github.com> writes:

>> +MAKEFLAGS="$MAKEFLAGS --jobs=10"
>> +GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
>> +
>> +GIT_TEST_OPTS="$GIT_TEST_OPTS --verbose-log -x"
>> +if test windows = "$CI_OS_NAME"
>
> Based on the deleted lines above, I think this would need to be:
>
> 	if test windows = "$CI_OS_NAME" || test windows_nt = "$CI_OS_NAME"
>
> I believe these settings are required on all Windows builds, though, so you could 
> instead match on the first 7 characters of $CI_OS_NAME:
>
> 	if test windows = "$(echo "$CI_OS_NAME" | cut -c1-7)"
>
> (full disclosure: I'm not 100% confident in the correctness of that shell syntax)
>> +then
>> +	GIT_TEST_OPTS="$GIT_TEST_OPTS --no-chain-lint --no-bin-wrappers"
>> +fi

Either

	case "$CI_OS_NAME" in
	windows*)
		GIT_TEST_OPTS=...
	esac

or if we want to be more selective, for documentation purposes
especially when it is unlikely for us to gain the third variant of
windows build:

	case ... in
	windows | windows_nt)
		GIT_TEST_OPTS=...
	esac



>> +
>> +export GIT_TEST_OPTS
>> +export GIT_PROVE_OPTS
>> +
>>  good_trees_file="$cache_dir/good-trees"
>>  
>>  mkdir -p "$cache_dir"
