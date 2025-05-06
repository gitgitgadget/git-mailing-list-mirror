Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1CD52472AE
	for <git@vger.kernel.org>; Tue,  6 May 2025 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746549024; cv=none; b=DDCHzfqof41ECywfyOc33IzB7snOnhnkqq0AH2nF3wVTbKnQiWevS8Cs+j56o3SBuv2C64iqe9CoD705RH5blnfAqoOr2EwHvedtRzMa3Vd3IsMSw9YjB2ozdsz5iVCrxKyHz503BSGTTHjAe4f47+XK+XZOisSxjtGi0lom7rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746549024; c=relaxed/simple;
	bh=UZnFeec7TznkMGkSMwyd4YLFMygK//w38gPGYklmS/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P0o6ClOXkSB7bwAtxJOo8EZUs7U/mPlqqV09xdL15vo/CvFCoGejjFeHSKm0Zh5hF93O4K4COCIOzYRz5oB+6WvIJ5CiBewoLGctFBn78VWLmQ1UQ0iynOxqmQmQEI4d2xo1NdV8EInyHYHN/YPVbSwlh5HZA5O9CNSatbC+TdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp.bon.at (unknown [192.168.181.101])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4ZsP504WZZz7Sxlr
	for <git@vger.kernel.org>; Tue,  6 May 2025 18:30:12 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTPSA id 4ZsP4r26mhzRq25;
	Tue,  6 May 2025 18:30:04 +0200 (CEST)
Message-ID: <9d548d94-eed8-434a-a9ef-67df694c5c79@kdbg.org>
Date: Tue, 6 May 2025 18:30:04 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1][GSOC] userdiff: extend Bash pattern to cover more
 shell function forms
Content-Language: en-US
To: Moumita <dhar61595@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 Junio C Hamano <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?=
 <l.s.r@web.de>, Atharva Raykar <raykar.ath@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org
References: <20250328200525.4437-1-dhar61595@gmail.com>
 <20250330134018.9662-1-dhar61595@gmail.com>
 <20250330134018.9662-2-dhar61595@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250330134018.9662-2-dhar61595@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 30.03.25 um 15:39 schrieb Moumita:
> From: Moumita Dhar <dhar61595@gmail.com>
> 
> The previous function regex required explicit matching of function
> bodies using `{`, `(`, `((`, or `[[`, which caused several issues:
> 
> - It failed to capture valid functions where `{` was on the next line
>   due to line continuation (`\`).
> - It did not recognize functions with single  command body, such as
>   `x () echo hello`.

Good.

> Replacing the function body matching logic with `.*$`, ensures
> that everything on the function definition line is captured,
> aligning with other userdiff drivers and improving hunk headers in
> `git diff`.

Personally, I am a bit allergic against marketing speak. *Of course* do
we intend improve the code. No need to mention it.

> Additionally, the word regex is refined to better recognize shell
> syntax, including additional parameter expansion operators and
> command-line options, improving syntax-aware diffs.

Good. (But see above about "improving".)

> 
> Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
> ---

> diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
> index f51d3557f1..0be647c2fb 100755
> --- a/t/t4034-diff-words.sh
> +++ b/t/t4034-diff-words.sh
> @@ -320,6 +320,7 @@ test_expect_success 'unset default driver' '
>  
>  test_language_driver ada
>  test_language_driver bibtex
> +test_language_driver bash
>  test_language_driver cpp
>  test_language_driver csharp
>  test_language_driver css

Including a test for word-diff is very much appreciated!

> diff --git a/t/t4034/bash/expect b/t/t4034/bash/expect
> new file mode 100644
> index 0000000000..a0f7cbd5a3
> --- /dev/null
> +++ b/t/t4034/bash/expect
> @@ -0,0 +1,30 @@
> +<BOLD>diff --git a/pre b/post<RESET>
> +<BOLD>index 09ac008..60ba6a2 100644<RESET>
> +<BOLD>--- a/pre<RESET>
> +<BOLD>+++ b/post<RESET>
> +<CYAN>@@ -1,25 +1,25 @@<RESET>
> +<RED>my_var<RESET><GREEN>new_var<RESET>=10
> +x=<RED>123<RESET><GREEN>456<RESET>
> +y=<RED>3.14<RESET><GREEN>2.71<RESET>
> +z=<RED>.5<RESET><GREEN>.75<RESET>

OK.

> +echo <RED>$USER<RESET><GREEN>$USERNAME<RESET>

This tests a typical variable expansion. Good.

> +${<RED>HOME<RESET><GREEN>HOMEDIR<RESET>}

A more elaborate variable expansion does not include the surrounding ${
}. Good.

> +if [ "<RED>$a<RESET><GREEN>$x<RESET>" == "<RED>$b<RESET><GREEN>$y<RESET>" ] || [ "<RED>$c<RESET><GREEN>$x<RESET>" != "<RED>$d<RESET><GREEN>$y<RESET>" ]; then echo "OK"; fi

This line also only tests variable expansions and is quite redundant. It
could test the operators that we see, but it doesn't. See below for
ideas how to do that.

And all from here...

> +((<RED>a<RESET><GREEN>x<RESET>+=<RED>b<RESET><GREEN>y<RESET>))
> +((<RED>a<RESET><GREEN>x<RESET>-=<RED>b<RESET><GREEN>y<RESET>))
> +$((<RED>a<RESET><GREEN>x<RESET><<<RED>b<RESET><GREEN>y<RESET>))
> +$((<RED>a<RESET><GREEN>x<RESET>>><RED>b<RESET><GREEN>y<RESET>))
> +${<RED>a<RESET><GREEN>x<RESET>:-<RED>b<RESET><GREEN>y<RESET>}
> +${<RED>a<RESET><GREEN>x<RESET>:=<RED>b<RESET><GREEN>y<RESET>}
> +${<RED>a<RESET><GREEN>x<RESET>##*/}
> +${<RED>a<RESET><GREEN>x<RESET>%.*}
> +${<RED>a<RESET><GREEN>x<RESET>%%.*}
> +${<RED>a<RESET><GREEN>x<RESET>^^}
> +${<RED>a<RESET><GREEN>x<RESET>,}
> +${<RED>a<RESET><GREEN>x<RESET>,,}

... to here also only test variable expansions, but not the operators.
As written, they are totally redundant and should be dropped or improved.

To test, for example, that '##' is kept together as an operator, you
have to have

   ${x#*/}

in the pre-image and

   ${x##*/}

in the post-image, so that we see

   ${x<RED>#<RESET><GREEN>##<RESET>*/}

in the result. If '##' were two tokens (due to a bug in the pattern), we
would see

   ${x#<GREEN>#<RESET>*/}

in the result.

You should go through all not-single-character operators and have a
pre-image and a post-image where one characters is added or removed. The
following is not a correct test:

pre:    ((x+=b))
post:   ((x-=b))
result: ((x<RED>+=<RESET><GREEN>-=<RESET>))

because we would see this result even if the pattern has a bug that
recognizes only one of += or -=, but would split the other one. A
correct test would be:

pre:    ((x+b))
post:   ((x+=b))
result: ((x<RED>+<RESET><GREEN>+=<RESET>))

> +${!<RED>a<RESET><GREEN>x<RESET>}

Here, you should have no '!' in the pre-image and the '!' in the post
image and not change the name. Then the test demonstrates that '!' is
its own token and not merged with '${' (if that is the intent of the
test; otherwise it is a redunant test).

> +${<RED>a<RESET><GREEN>x<RESET>[@]}

If you want to test that '@' is not merged with the brackets, then you
can have, for example '*' in the pre-image and '@' in the post image.

> +${<RED>a<RESET><GREEN>x<RESET>:?error message}

Either redundant or another two-character operator to test.

> +${<RED>a<RESET><GREEN>x<RESET>:2:3}

Redundant.

> +ls <RED>-a<RESET><GREEN>-x<RESET>
> +ls <RED>--a<RESET><GREEN>--x<RESET>

Both are good tests.

> diff --git a/userdiff.c b/userdiff.c
> index 340c4eb4f7..4c77c7e0f6 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -64,15 +64,27 @@ PATTERNS("bash",
>  	     /* Bashism identifier with optional parentheses */
>  	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
>  	 ")"
> -	 /* Optional whitespace */
> -	 "[ \t]*"
> -	 /* Compound command starting with `{`, `(`, `((` or `[[` */
> -	 "(\\{|\\(\\(?|\\[\\[)"
> +	 /* Everything after the function header is captured  */
> +	 ".*$"

I remember suggesting to capture everything after the function header.
However, If I am not mistaken, this does not do what I intended (and as
written it means that a pointless matching operation happens). The hunk
header shows everything that is in the outermost parentheses (group).
This catch-all, however, is even outside the outermost group and not
captured. It should be above the closing parenthesis that we see in the
context.

To test for this, you can have one test where "RIGHT" is not the
function name, but in the comment on the function header line.

>  	 /* End of captured text */
>  	 ")",
>  	 /* -- */
> -	 /* Characters not in the default $IFS value */
> -	 "[^ \t]+"),
> +	 /* Identifiers: variable and function names */
> +	  "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 /* Numeric constants: integers and decimals */
> +	  "|[0-9]+(\\.[0-9]*)?|[-+]?\\.[0-9]+"
> +	 /* Shell variables: $VAR, ${VAR} */
> +	  "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{"
> +	  /* Logical and comparison operators */
> +	 "|\\|\\||&&|<<|>>|==|!=|<=|>="
> +	 /* Assignment and arithmetic operators */
> +	 "|[-+*/%&|^!=<>]=?"
> +	 /* Additional parameter expansion operators */
> +	 "|:?=|:-|:\\+|:\\?|:|#|##|%|%%|/[a-zA-Z0-9_-]+|\\^\\^?|,|,,?|!|@|:[0-9]+(:[0-9]+)?"

What is the purpose of this "/[a-zA-Z0-9_-]+"? It would mean, for
example that changes in alphanumeric path names would include the slash
in the changed part. I don't think this should be here.

> +	 /* Command-line options (to avoid splitting -option) */
> +	 "|--?[a-zA-Z0-9_-]+"
> +	 /* Brackets and grouping symbols */
> +	 "|\\(|\\)|\\{|\\}|\\[|\\]"),
>  PATTERNS("bibtex",
>  	 "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
>  	 /* -- */

-- Hannes

