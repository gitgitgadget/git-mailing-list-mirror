Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D5F44D580
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 18:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DS97CBVT"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C87933F08A;
	Wed, 10 Jan 2024 13:37:12 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=rTSUDCmfqhDi0o8WCFGMIQkguVciefQzqHC8Qg
	TTZzY=; b=DS97CBVTA3zN2nk9DbhV3AKlGZZPETpdzjmKQcSw88LqSmv8DBJLyk
	YyESl0nez8UXzpbAQQqYsxwemXWW1RfSFSO7l4HV3yrtPagFjvmZ/wtaYYf1sN7C
	+f4GyQ/rSuNZ/Gmh6O03SmY1oxjjCwMymD398PHkRaFS/KKy19k/8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C0E513F089;
	Wed, 10 Jan 2024 13:37:12 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 015F53F085;
	Wed, 10 Jan 2024 13:37:08 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  christian.couder@gmail.com
Subject: Re: [PATCH v3 1/2] t7501: add tests for --include and --only
In-Reply-To: <20240110163622.51182-4-shyamthakkar001@gmail.com> (Ghanshyam
	Thakkar's message of "Wed, 10 Jan 2024 22:05:18 +0530")
References: <20240109165304.8027-2-shyamthakkar001@gmail.com>
	<20240110163622.51182-4-shyamthakkar001@gmail.com>
Date: Wed, 10 Jan 2024 10:37:07 -0800
Message-ID: <xmqqil41avcc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 42ED611E-AFE7-11EE-A79E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Ghanshyam Thakkar <shyamthakkar001@gmail.com> writes:

> -# FIXME: Test the various index usages, -i and -o, test reflog,
> +# fixme: test the various index usages, test reflog,
>  # signoff

Why the sudden downcasing?  If this were to turn it to "TODO:"
(110+) or "NEEDSWORK:" (110+) from less often used "FIXME:" (40-),
such a change might be defensible, but there is only one instance
of downcased "fixme:", so I am curious how this happened.

> +test_expect_success '--include fails with untracked files' '
> +	echo content >baz &&
> +	test_must_fail git commit --include -m "initial" baz
> +'

OK, this is because "--allow-empty" is not passed.  This should fail
without -i/-o (which should be the same as passing -o), with -i, or
with -o.

Calling this commit "initial" is highly misleading.  There are bunch
of commits already, but path "baz" has never been used.

> +test_expect_success '--include with staged changes' '
> +	echo newcontent >baz &&
> +	echo newcontent >file &&
> +	git add file &&
> +	git commit --include -m "file baz" baz  &&

I suspect that you found a bug whose behaviour we do not want to
carve into stone with this test.  When this test begins, because the
previous step failed to create the initial commit, we are creating
the root commit, without --allow-empty, with contents in the index
for path "file".  At this point

    $ git commit -m "file baz" baz

(or with "-o", which is the same thing) does error out with

    error: pathspec 'baz' did not match any file(s) known to git

because the "only" thing is to take the changes between HEAD and the
index and limit them further to those paths that match "baz", but
there is no path that matches "baz".

This command

    $ git commit -m "file baz" -i baz

should either error out the same way, or behave more or less[*] like

    $ git add baz && git commit -m "file baz"

and record changes to both "file" and "baz".

    Side note: The "more or less" is we should do "git rm baz"
               instead, if you removed the path.

But it seems that the current code simply ignores the unmatching
pathspec "baz" that is on the command line, hence recording only the
change to the contents of "file".

> +	git diff --name-only >remaining &&
> +	test_must_be_empty remaining &&
> +	git diff --name-only --staged >remaining &&
> +	test_must_be_empty remaining

These two tests to see if the working tree is clean and if the index
is clean are not wrong per-se, but is insufficient.  Judging from
the commit message you used, I think you expected this commit to
contain both changes to 'file' and 'baz'.  That needs to be also
checked with something like "git diff --name-only HEAD^ HEAD".

Now which behaviour between "error out because there is no path in
the index that matches pathspec 'baz'" and "add baz to the index and
commit that addition, together with what is already in the index" we
would want to take is probably open for discussion.  Such a discussion
may decide that the current behaviour is fine.  Until then...

> +test_expect_success '--only fails with untracked files' '
> +	echo content >newfile &&
> +	test_must_fail git commit --only -m "newfile" newfile
> +'

And this should fail the same way without "-o".  Don't we have such
a test that we can just sneak "with -o the same thing happens" test
next to it?

> +test_expect_success '--only excludes staged changes' '
> +	echo content >file &&
> +	echo content >baz &&
> +	git add baz &&
> +	git commit --only -m "file" file &&

This should behave exactly the same way without "-o".

> +	git diff --name-only >actual &&
> +	test_must_be_empty actual &&
> +	git diff --name-only --staged >actual &&
> +	test_grep "baz" actual
> +'
> +
> +test_expect_success '--include and --only do not mix' '
> +	test_when_finished "git reset --hard" &&
> +	echo new >file &&
> +	echo new >baz &&
> +	test_must_fail git commit --include --only -m "bar" bar baz

OK.  If you grep for 'cannot be used together' in t/ directory,
there are many tests that make sure how an invocation like this
should fail, i.e. with an error message that mentions incompatible
options.  Don't we want to do the same?

Thanks.

