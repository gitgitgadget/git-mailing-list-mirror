Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5F61A29A
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 07:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742802982; cv=none; b=iMUZWXFQdSQDICwu91tSkN64jJE5ooxCy/3jEs3djVSb+/FCK4tvF5MrH64fp0uLqMZKA17leFP4xjBe8Nt6MFa1vaT0ou9AhZjbL1M8zg+DKzPGTz9CxZ3Iff8PfWwH3Ly5VxNo0xIWE0o/byP0IHjo/hpdjEglEHml075/bq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742802982; c=relaxed/simple;
	bh=AXt2Zioq9u1EpyqNH4ydSD/O+Ks8R0lz5s0V7caScI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2trRAaecndbtIoHqnQnmqgNRz6dqoVzO+SmGgmbGFLCS9GMwzlYusOtywsk0BKPLfYBa9ddD7g+tViLxoQYwIOH2ZR4/P5juxpM0/d8pMu7Fng0DYU9kOL2jEE2/4ii3nQXy0/gqEy7ZkGQTot+BB8lw7Y2NjrFwHVE+mry5sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.104])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4ZLktw4K5Pz7QZsJ
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 08:19:04 +0100 (CET)
Received: from [192.168.0.106] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4ZLktl5YY8zRpKr;
	Mon, 24 Mar 2025 08:18:55 +0100 (CET)
Message-ID: <d4c0c9a4-0402-4456-9fa0-3102b5bcc3dc@kdbg.org>
Date: Mon, 24 Mar 2025 08:18:55 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [GSoC PATCH v2] userdiff: add builtin driver for gitconfig syntax
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, "D . Ben Knoble" <ben.knoble@gmail.com>,
 git@vger.kernel.org
References: <20250324021101.7483-1-lucasseikioshiro@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250324021101.7483-1-lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 24.03.25 um 03:11 schrieb Lucas Seiki Oshiro:
> From Documentation/config.adoc:
> 
> Add a new builtin driver for gitconfig files, where:
> 
> - the funcname regular expression matches sections and subsections,
>   i. e. the pattern [SECTION] or [SECTION "SUBSECTION"], where the
>   section is composed by alphanumeric numbers, `-` and `.`, and
>   subsection names may be composed by any characters;
> 
> - word_regex is more permissive than the syntax specification, matching
>   any word with one or more non-whitespace characters without checking
>   if it is a valid variable name or value.
> 
> A more detailed description on the format of gitconfig syntax can be
> seen by running `git show cfd409:Documentation/config.txt`.

Can we please have a more recent reference? The difference of config.txt
here and config.adoc above is very surprising.

> Also add tests for the new userdiff driver. These files define sections
> and subsections, with and without indentation.
> 
> Helped-by: Patrick Steinhardt <ps@pks.im>
> Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
> Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>

Thank you for your contribution.

The file format of .git/config files isn't specific to .git/config; it's
called "ini-file" and is already very old. Wouldn't it make sense to
generalize the format? It would be just a matter of choosing a different
name; the regular expressions would not have to change.

> diff --git a/t/t4018/gitconfig-section b/t/t4018/gitconfig-section
> new file mode 100644
> index 0000000000..18c85eb613
> --- /dev/null
> +++ b/t/t4018/gitconfig-section
> @@ -0,0 +1,6 @@
> +[RIGHT]
> +        # comment
> +        ; comment
> +        name = value
> +        ChangeMe
> +

This could test two sections in a row and ensure that the later one is
chosen.

You have now managed to avoid the "No newline at end of file", but have
added a blank line instead. Not a big deal, but unconventional.

> diff --git a/t/t4018/gitconfig-section-noindent b/t/t4018/gitconfig-section-noindent
> new file mode 100644
> index 0000000000..5c58a7ac92
> --- /dev/null
> +++ b/t/t4018/gitconfig-section-noindent
> @@ -0,0 +1,6 @@
> +[RIGHT]
> +# comment
> +; comment
> +name = value
> +ChangeMe
> +
> diff --git a/t/t4018/gitconfig-subsection b/t/t4018/gitconfig-subsection
> new file mode 100644
> index 0000000000..569be04a32
> --- /dev/null
> +++ b/t/t4018/gitconfig-subsection
> @@ -0,0 +1,8 @@
> +[LEFT]
> +
> +[LEFT "RIGHT"]
> +      # comment
> +      ; comment
> +      name = value
> +      ChangeMe
> +

This could test two sub-sections in a row and ensure that the later one
is chosen.

What happens if there is an *indented* header after the "RIGHT" one?
Should it be chosen or not? Can this happen in a valid file?

> diff --git a/t/t4018/gitconfig-subsection-noindent b/t/t4018/gitconfig-subsection-noindent
> new file mode 100644
> index 0000000000..85c5074f47
> --- /dev/null
> +++ b/t/t4018/gitconfig-subsection-noindent
> @@ -0,0 +1,8 @@
> +[LEFT]
> +
> +[LEFT "RIGHT"]
> +# comment
> +; comment
> +name = value
> +ChangeMe
> +
> diff --git a/userdiff.c b/userdiff.c
> index 340c4eb4f7..5bbcc2b690 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -198,6 +198,10 @@ IPATTERN("fountain",
>  	 "^((\\.[^.]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$",
>  	 /* -- */
>  	 "[^ \t-]+"),
> +PATTERNS("gitconfig",
> +         "^\\[[a-zA-Z0-9]+\\]|\\[[a-zA-Z0-9]+[ \t]+\".+\"\\]$",

The regular expression can assume that the syntax of the processed file
is correct. For example,

   [!not a section!]

cannot be a section header and will not occur in a valid file. Or can it?

Therefore, it would be sufficient to just take everything after the '['
at the beginning of the line without further inspection.

Furthermore, a valid file can look like this:

[section] key = value
  another_key = more values

but your pattern would not pick up this header, because it insists in
that the closing bracket is at the end of the line. Having a test for
this case would be great.

> +         /* -- */
> +         "[^ \t]+"),
>  PATTERNS("golang",
>  	 /* Functions */
>  	 "^[ \t]*(func[ \t]*.*(\\{[ \t]*)?)\n"

-- Hannes

