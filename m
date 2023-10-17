Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401112D024
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 16:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="TZXaNf2p"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E408DF1
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 09:42:36 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 875062C918;
	Tue, 17 Oct 2023 12:42:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=E1AMQCQdctHoG4fzRC3SKqVWOJZbAFF4F4/xlu
	EiybE=; b=TZXaNf2pvooAh54KqweS+ACxty+A3IkiyVK4fX6lANwsD5cF29NfZI
	ECI7kDXMs7VMDcZ+IS4nhR5a1GSm2UaGV7NLBwfWTNoXjrqHpZ4mTo6wHLrcexjy
	pcO22qKla9kKsSDT1ip0fkSiGlEbH4U+LbCWC6B4F3On+aYQBXZW8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7E6B32C917;
	Tue, 17 Oct 2023 12:42:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AA3752C916;
	Tue, 17 Oct 2023 12:42:32 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: git@vger.kernel.org,  ks1322@gmail.com
Subject: Re: [PATCH] grep: die gracefully when outside repository
In-Reply-To: <087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
	(Kristoffer Haugsbakk's message of "Sat, 14 Oct 2023 23:02:38 +0200")
References: <6bb48aac-460c-4d7f-9057-40c3df0c807d@app.fastmail.com>
	<087c92e3904dd774f672373727c300bf7f5f6369.1697317276.git.code@khaugsbakk.name>
Date: Tue, 17 Oct 2023 09:42:31 -0700
Message-ID: <xmqqmswhjj48.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2B37675E-6D0C-11EE-8823-A19503B9AAD1-77302942!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Kristoffer Haugsbakk <code@khaugsbakk.name> writes:

> diff --git a/pathspec.c b/pathspec.c
> index 3a3a5724c44..e115832f17a 100644
> --- a/pathspec.c
> +++ b/pathspec.c
> @@ -468,6 +468,9 @@ static void init_pathspec_item(struct pathspec_item *item, unsigned flags,
>  					   &prefixlen, copyfrom);
>  		if (!match) {
>  			const char *hint_path = get_git_work_tree();
> +			if (!have_git_dir())
> +				die(_("'%s' is outside the directory tree"),
> +				    copyfrom);
>  			if (!hint_path)
>  				hint_path = get_git_dir();
>  			die(_("%s: '%s' is outside repository at '%s'"), elt,

It is curious that the original has two sources of hint_path (i.e.,
get_git_dir() is used as a fallback for get_git_work_tree()).  Are
we certain that the check is at the right place?  If we do not have
a repository, then both would fail by returning NULL, so it should
not matter if we add the new check before we check either or both,
or even after we checked both before dying.

I wonder if

	const char *hint_path = get_git_work_tree();

	if (!hint_path)
	        hint_path = get_git_dir();
	if (hint_path)
		die(_("%s: '%s' is outside repository at '%s'"),
		    elt, copyfrom, absolute_path(hint_path));
	else
		die(_("%s: '%s' is outside the directory tree"),
		    elt, copyfrom);

makes the intent of the code clearer.  We want to hint the location
of the repository by computing hint_path, and if we can compute it,
we use it in the error message, but otherwise we don't add hint.  And
we apply that conditional whether we have repository or not---what we
care about is the NULL-ness of the hint string we computed.

> diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
> index 39d6d713ecb..b976f81a166 100755
> --- a/t/t7810-grep.sh
> +++ b/t/t7810-grep.sh
> @@ -1234,6 +1234,19 @@ test_expect_success 'outside of git repository with fallbackToNoIndex' '
>  	)
>  '
>  
> +test_expect_success 'outside of git repository with pathspec outside the directory tree' '
> +	test_when_finished rm -fr non &&
> +	rm -fr non &&
> +	mkdir -p non/git/sub &&
> +	(
> +		GIT_CEILING_DIRECTORIES="$(pwd)/non" &&
> +		export GIT_CEILING_DIRECTORIES &&
> +		cd non/git &&
> +		test_expect_code 128 git grep --no-index search .. 2>error &&
> +		grep "is outside the directory tree" error

Excellent.  This is a very good use of the GIT_CEILING_DIRECTORIES
facility.

> +	)
> +'
> +
>  test_expect_success 'inside git repository but with --no-index' '
>  	rm -fr is &&
>  	mkdir -p is/git/sub &&
>
> base-commit: 43c8a30d150ecede9709c1f2527c8fba92c65f40
