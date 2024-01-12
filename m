Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F900168AD
	for <git@vger.kernel.org>; Fri, 12 Jan 2024 23:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fw4NCRab"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 120311E5BCC;
	Fri, 12 Jan 2024 18:10:29 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=67jHi0OSqI6vUewc/oZFLF9mTyOr8UVTSr7Bzq
	3+izM=; b=Fw4NCRabAzmBD3yIy+NWXVHUyqnnBM/yiiu52/HNjGYfHdwnesJZgX
	LqI/pEAZ1xPF0HYHsRh/T7X8JD98LgZl3txicmhWaXdiPTe0f3afmC9yYdlEm71l
	VtiE7SFb9WiIiTehvaIt16OKPyr9eAaAJIMYmCBoUbqzbV9smizCg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 095351E5BCB;
	Fri, 12 Jan 2024 18:10:29 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D5C41E5BCA;
	Fri, 12 Jan 2024 18:10:28 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com
Subject: Re: [PATCH v4 1/2] t7501: add tests for --include and --only
In-Reply-To: <20240112180109.59350-2-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Fri, 12 Jan 2024 23:30:16 +0530")
References: <20240110163622.51182-2-shyamthakkar001@gmail.com>
	<20240112180109.59350-1-shyamthakkar001@gmail.com>
	<20240112180109.59350-2-shyamthakkar001@gmail.com>
Date: Fri, 12 Jan 2024 15:10:27 -0800
Message-ID: <xmqqbk9q6tcs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C6950616-B19F-11EE-8C36-25B3960A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> @@ -92,6 +92,19 @@ test_expect_success '--long fails with nothing to commit' '
>  	test_must_fail git commit -m initial --long
>  '
>  
> +test_expect_success 'fail to commit untracked file' '
> +	echo content >baz &&
> +	test_must_fail git commit -m "baz" baz
> +'
> +
> +test_expect_success '--only also fail to commit untracked file' '
> +	test_must_fail git commit --only -m "baz" baz
> +'
> +
> +test_expect_success '--include also fail to commit untracked file' '
> +	test_must_fail git commit --include -m "baz" baz
> +'

As the latter two depends on the first one's side effect of leaving
an untracked 'baz' file in the working tree, I do not know if it is
sensible to split these into three tests.  An obvious alternative is
to have a single test

	test_expect_success 'pathspec that do not match any tracked path' '
		echo content >baz &&
		test_must_fail git commit -m baz baz &&
		test_must_fail git commit -o -m baz baz &&
		test_must_fail git commit -i -m baz baz
	'

By the way, I do not think presence of 'baz' in the working tree
matters in the failures from these tests all that much, as the
reason they fail is because the pathspec does not match any tracked
file, whose contents in the index to be updated before made into a
commit.

> @@ -117,6 +130,70 @@ test_expect_success '--long with stuff to commit returns ok' '
>  	git commit -m next -a --long
>  '
>  
> +test_expect_success 'only commit given path (also excluding additional staged changes)' '
> +	echo content >file &&
> +	echo content >baz &&
> +	git add baz &&
> +	git commit -m "file" file &&
> +
> +	git diff --name-only >actual &&
> +	test_must_be_empty actual &&
> +
> +	git diff --name-only --staged >actual &&
> +	test_cmp - actual <<-EOF &&
> +	baz
> +	EOF
> +
> +	git diff --name-only HEAD^ HEAD >actual &&
> +	test_cmp - actual <<-EOF
> +	file
> +	EOF
> +'

OK.  The change to baz is already in the index, but "commit file"
will skip over it and record only the changes to file in the commit.
Very much makes sense.

> +test_expect_success 'same as above with -o/--only' '
> +	echo change >file &&
> +	echo change >baz &&
> +	git add baz &&
> +	git commit --only -m "file" file &&
> +
> +	git diff --name-only >actual &&
> +	test_must_be_empty actual &&
> +
> +	git diff --name-only --staged >actual &&
> +	test_cmp - actual <<-EOF &&
> +	baz
> +	EOF
> +
> +	git diff --name-only HEAD^ HEAD >actual &&
> +	test_cmp - actual <<-EOF
> +	file
> +	EOF
> +'

Likewise.  An obvious thing to notice is that this cannot use the
same "contents" text as before, even though it claims to be "same as
above".  If the final contents of "file" and "baz" does not matter,
but it matters more that these files have been changed, it often is
a good idea to append to the file.  That way, you can ensure that
you will be making them different, no matter what the initial
condition was, i.e.,

	for opt in "" "-o" "--only"
	do
		test_expect_success 'skip over already added change' '
			echo more >>file &&
			echo more >>baz &&
			git add baz &&
			git commit $opt -m "file" file &&

			... ensure that changes to file are committed
			... and changes to baz is only in the index
		'
	done

let's you test all three combinations.

Thanks.
