Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9EA51BDE0
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 15:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KuBWiqeV"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 519781D779D;
	Tue, 16 Jan 2024 10:56:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MZncvnby6P1ttUMsds8bRTaWEWaE7mvClysC8S
	e6aMM=; b=KuBWiqeVJLfylZpYHDstCc8OZiCgptdomG+bYnp6EzvEnHnRfboqXE
	4pVDsUfPfWWVKQx6bRWrPuzhUJqq5nxUkuwSkwHhdI7B/Ye+bokwjXSjQw776pYz
	HkzglswHYmMCg+vD09fIWYQ7UmC+qvfz1DIWLASEgbY12EmWewojQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 483B01D779C;
	Tue, 16 Jan 2024 10:56:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9AC661D779B;
	Tue, 16 Jan 2024 10:56:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com
Subject: Re: [PATCH v5 1/2] t7501: add tests for --include and --only
In-Reply-To: <20240113042254.38602-2-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Sat, 13 Jan 2024 09:51:54 +0530")
References: <20240112180109.59350-1-shyamthakkar001@gmail.com>
	<20240113042254.38602-1-shyamthakkar001@gmail.com>
	<20240113042254.38602-2-shyamthakkar001@gmail.com>
Date: Tue, 16 Jan 2024 07:56:07 -0800
Message-ID: <xmqq1qah46i0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C360EFC4-B487-11EE-9872-25B3960A682E-77302942!pb-smtp2.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> +test_expect_success 'fail to commit untracked pathspec (even with --include/--only)' '

"untracked pathspec" is a nonsense word.  We do not track pathspec;
you may use pathspec to specify which path(s) to work on.  I think
this is more about untracked files being ignored for the purpose of
"-i" and "-o".

You used to call this "untracked file", which probably makes more
sense.

> +	# TODO: as for --include, the below command will fail because nothing is
> +	# staged. If something was staged, it would not fail even if the
> +	# pathspec was untracked (however, pathspec will remain untracked and
> +	# staged changes would be committed.) In either cases, no error is

Both uses of "pathspec" here are nonsense.  Saying "even though the
pathspec does not match any tracked path" is OK.  "(however, the
untracked path that match the pathspec are not added and only the
changes in the index gets commit)" is also OK.

> +	# returned to stderr like in (-o and without -o/-i) cases. In a
> +	# similar manner, "git add -u baz" also does not error out.
> +	# 
> +	# Therefore, the below test is just to document the current behavior
> +	# and is not an endorsement to the current behavior, and we may 
> +	# want to fix this. And when that happens, this test should be
> +	# updated accordingly.

OK.

> @@ -117,6 +143,55 @@ test_expect_success '--long with stuff to commit returns ok' '
>  	git commit -m next -a --long
>  '
>  
> +for opt in "" "-o" "--only"
> +do 
> +	test_expect_success 'exclude additional staged changes when given pathspec' '
> +		echo content >>file &&
> +		echo content >>baz &&
> +		git add baz &&
> +		git commit $opt -m "file" file &&
> +
> +		git diff --name-only >actual &&
> +		test_must_be_empty actual &&
> +
> +		git diff --name-only --staged >actual &&
> +		test_cmp - actual <<-EOF &&
> +		baz
> +		EOF

It is probably more common to say

		test_write_lines baz >expect &&
		git diff --name-only --cached >actual &&
		test_cmp expect actual

especially when the expected pattern is a file with short lines,
instead of here-text.  It makes it easier to debug tests, too,
because after "sh t7501-*.sh -i" fails, you can go to the trash
directory and the expectation as well as the actual output are
there in files.

> +		git diff --name-only HEAD^ HEAD >actual &&
> +		test_cmp - actual <<-EOF
> +		file
> +		EOF

Ditto.

This tests the most important aspect of "-o"; even when the index
has other changes relative to HEAD already, they are skipped over
and only the changes to paths that match the given pathspec are
committed, and this test demonstrates it.  Well done.

> +test_expect_success '-i/--include includes staged changes' '
> +	echo content >>file &&
> +	echo content >>baz &&
> +	git add file &&
> +	
> +	# baz is in the index, therefore, it will be committed
> +	git commit --include -m "file and baz" baz  &&
> +
> +	git diff --name-only HEAD >remaining &&
> +	test_must_be_empty remaining &&
> +
> +	git diff --name-only HEAD^ HEAD >changes &&
> +	test_cmp - changes <<-EOF
> +	baz
> +	file
> +	EOF

Again with "test_write_lines baz file >expect", this test becomes a
bit shorter.

This tests the most important aspect of "-i"; changes to the paths
that match the given pathspec are added to the index, and recorded
together with changes added to the index already to the commit.
Well done.

> +'
> +
> +test_expect_success '--include and --only do not mix' '
> +	test_when_finished "git reset --hard" &&
> +	echo content >>file &&
> +	echo content >>baz &&
> +	test_must_fail git commit --include --only -m "file baz" file baz 2>actual &&
> +	test_grep -e "fatal: options .-i/--include. and .-o/--only. cannot be used together" actual
> +'
> +
>  test_expect_success 'commit message from non-existing file' '
>  	echo more bongo: bongo bongo bongo bongo >file &&
>  	test_must_fail git commit -F gah -a

Very nicely done.

Thanks.
