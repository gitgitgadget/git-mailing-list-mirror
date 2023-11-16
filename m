Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bFJBNzFe"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E866192
	for <git@vger.kernel.org>; Wed, 15 Nov 2023 21:29:34 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id B69531D112F;
	Thu, 16 Nov 2023 00:29:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=P6F3Kx9uonf/RA3jdNZvXhZYJjjt5gBmfuwP8R
	R0M88=; b=bFJBNzFepUvxBZHFHhKg1BWHVnKNZ+w4HATCvBcxDYX8t9X5nS7u6z
	V5UE7i5+Jve6tKSYxmE8JFrx6l9uMzvLXNj/WVxHvxqDcrAjYFGrhPuIeFVWnBFE
	RGW58IRwJ+dCj1DV9TPqgvk7c9YlfQpORVHe+NehrxjuD21zsIEFU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AE2131D112E;
	Thu, 16 Nov 2023 00:29:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1CDA81D112B;
	Thu, 16 Nov 2023 00:29:30 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,
  =?utf-8?Q?=C3=98ystein?= Walle
 <oystwa@gmail.com>,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH v2 01/10] ref-filter.c: really don't sort when using
 --no-sort
In-Reply-To: <074da1ff3e85927324c42a3fa65e4239f051cd70.1699991638.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Tue, 14 Nov 2023 19:53:49
	+0000")
References: <pull.1609.git.1699320361.gitgitgadget@gmail.com>
	<pull.1609.v2.git.1699991638.gitgitgadget@gmail.com>
	<074da1ff3e85927324c42a3fa65e4239f051cd70.1699991638.git.gitgitgadget@gmail.com>
Date: Thu, 16 Nov 2023 14:29:29 +0900
Message-ID: <xmqqcywas1ty.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1DB730EA-8441-11EE-9C67-25B3960A682E-77302942!pb-smtp2.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> When '--no-sort' is passed to 'for-each-ref', 'tag', and 'branch', the
> printed refs are still sorted by ascending refname. Change the handling of
> sort options in these commands so that '--no-sort' to truly disables
> sorting.

"to truly disables" -> "truly disables" I think?

> '--no-sort' does not disable sorting in these commands is because their

"'--no-sort' does not" -> "The reason why '--no-sort' does not", or
"is because" -> "because".

> option parsing does not distinguish between "the absence of '--sort'"
> (and/or values for tag.sort & branch.sort) and '--no-sort'. Both result in
> an empty 'sorting_options' string list, which is parsed by
> 'ref_sorting_options()' to create the 'struct ref_sorting *' for the
> command. If the string list is empty, 'ref_sorting_options()' interprets
> that as "the absence of '--sort'" and returns the default ref sorting
> structure (equivalent to "refname" sort).
>
> To handle '--no-sort' properly while preserving the "refname" sort in the
> "absence of --sort'" case, first explicitly add "refname" to the string list
> *before* parsing options. This alone doesn't actually change any behavior,
> since 'compare_refs()' already falls back on comparing refnames if two refs
> are equal w.r.t all other sort keys.
>
> Now that the string list is populated by default, '--no-sort' is the only
> way to empty the 'sorting_options' string list. Update
> 'ref_sorting_options()' to return a NULL 'struct ref_sorting *' if the
> string list is empty, and add a condition to 'ref_array_sort()' to skip the
> sort altogether if the sort structure is NULL. Note that other functions
> using 'struct ref_sorting *' do not need any changes because they already
> ignore NULL values.

Nice.

> Finally, remove the condition around sorting in 'ls-remote', since it's no
> longer necessary. Unlike 'for-each-ref' et. al., it does *not* do any
> sorting by default. This default is preserved by simply leaving its sort key
> string list empty before parsing options; if no additional sort keys are
> set, 'struct ref_sorting *' is NULL and sorting is skipped.

Doubly nice.

> diff --git a/ref-filter.c b/ref-filter.c
> index e4d3510e28e..7250089b7c6 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -3142,7 +3142,8 @@ void ref_sorting_set_sort_flags_all(struct ref_sorting *sorting,
>  
>  void ref_array_sort(struct ref_sorting *sorting, struct ref_array *array)
>  {
> -	QSORT_S(array->items, array->nr, compare_refs, sorting);
> +	if (sorting)
> +		QSORT_S(array->items, array->nr, compare_refs, sorting);
>  }

Nice.  We do allow passing NULL to ref_sorting_release(), and we can
return NULL from ref_sorting_options(), and allowing NULL to be
passed to this function makes it easier for the callers to deal with
the case where no sorting is specified.

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index 3182abde27f..9918ba05dec 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -1570,9 +1570,10 @@ test_expect_success 'tracking with unexpected .fetch refspec' '
>  
>  test_expect_success 'configured committerdate sort' '
>  	git init -b main sort &&
> +	test_config -C sort branch.sort "committerdate" &&
> +
>  	(
>  		cd sort &&
> -		git config branch.sort committerdate &&
>  		test_commit initial &&
>  		git checkout -b a &&
>  		test_commit a &&
> @@ -1592,9 +1593,10 @@ test_expect_success 'configured committerdate sort' '
>  '
>  
>  test_expect_success 'option override configured sort' '
> +	test_config -C sort branch.sort "committerdate" &&
> +
>  	(
>  		cd sort &&
> -		git config branch.sort committerdate &&
>  		git branch --sort=refname >actual &&
>  		cat >expect <<-\EOF &&
>  		  a

The above two are not strictly necessary for the purpose of this
patch, in that the tests that come after these tests do not care if
the branch.sort configuration variable is set in the "sort"
repository, as they set their own value before doing their test.

But of course, cleaning up after yourself with test_config and
friends is a good idea regardless, and a handful of new tests added
after this point follow the same pattern.  Good.

> @@ -1606,10 +1608,70 @@ test_expect_success 'option override configured sort' '
>  	)
>  '
>  
> +test_expect_success '--no-sort cancels config sort keys' '
> +	test_config -C sort branch.sort "-refname" &&
> +
> +	(
> +		cd sort &&
> +
> +		# objecttype is identical for all of them, so sort falls back on
> +		# default (ascending refname)

Interesting.

> +		git branch \
> +			--no-sort \
> +			--sort="objecttype" >actual &&
> +		cat >expect <<-\EOF &&
> +		  a
> +		* b
> +		  c
> +		  main
> +		EOF
> +		test_cmp expect actual
> +	)
> +
> +'
> +
> +test_expect_success '--no-sort cancels command line sort keys' '
> +	(
> +		cd sort &&
> +
> +		# objecttype is identical for all of them, so sort falls back on
> +		# default (ascending refname)
> +		git branch \
> +			--sort="-refname" \
> +			--no-sort \
> +			--sort="objecttype" >actual &&

OK, this exercises the same "--no-sort cleans the slate" as before,
and for this one it is essential that we lack branch.sort after the
previous step is done, which is ensured thanks to the use of
test_config in the previous one.  Nice.

> +		cat >expect <<-\EOF &&
> +		  a
> +		* b
> +		  c
> +		  main
> +		EOF
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success '--no-sort without subsequent --sort prints expected branches' '
> +	(
> +		cd sort &&
> +
> +		# Sort the results with `sort` for a consistent comparison
> +		# against expected
> +		git branch --no-sort | sort >actual &&
> +		cat >expect <<-\EOF &&
> +		  a
> +		  c
> +		  main
> +		* b
> +		EOF
> +		test_cmp expect actual
> +	)
> +'
> +
>  test_expect_success 'invalid sort parameter in configuration' '
> +	test_config -C sort branch.sort "v:notvalid" &&
> +
>  	(
>  		cd sort &&
> -		git config branch.sort "v:notvalid" &&
>  
>  		# this works in the "listing" mode, so bad sort key
>  		# is a dying offence.

With such an invalid configuration value set, running the command
with "--no-sort" would stop the command from failing?  Is that worth
protecting with a new test, I wonder.

Overall very nicely done.

Thanks.
