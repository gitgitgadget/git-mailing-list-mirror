Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE84222592
	for <git@vger.kernel.org>; Fri, 16 May 2025 07:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747380362; cv=none; b=qI/JSZC00eXLKoK+PzmadODEHu/0lhgh1iWUayiECFm3t/oK3YBDi/4M+HoILD08PXsm6bd7QVoMNsp70B3MsOvw3ssmqYVJSxRpdTnlcVCHspFbgMt5gW/CXYxJm8D+ocS+mwfn9V+YmVWvSmvbf+jCmhXlHz3PD3ixRX9oVzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747380362; c=relaxed/simple;
	bh=a2k38XqyIBMp1mfyldUeqe82lsyzc5+uqeqsf7GsyKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B5qMv6mmiN4CL/+k8DQ8n4sujzdVOxN/uMaKKA3sgHMKkAOrvsWpnmOoezFf7qEkxKU6nKEH4y2v0MnDMzVurHb9e2wsoHlVsHfV42DVapTs8X1aS5jZyKiQ7dkfdZCkZXPpYdTO1LuCADc/1ofu7jXqIW0GUtd0J5kn0rzXNv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.106])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4ZzJXJ1yBqz7QtcW
	for <git@vger.kernel.org>; Fri, 16 May 2025 09:25:52 +0200 (CEST)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4ZzJX72W6xzRnmF;
	Fri, 16 May 2025 09:25:43 +0200 (CEST)
Message-ID: <8343694f-6e05-43c5-862a-63702314760e@kdbg.org>
Date: Fri, 16 May 2025 09:25:43 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] userdiff: extend Bash pattern to cover more shell
 function forms
To: Moumita <dhar61595@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
 Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20250511125809.14180-1-dhar61595@gmail.com>
 <20250511141101.18450-1-dhar61595@gmail.com>
 <20250511141101.18450-2-dhar61595@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20250511141101.18450-2-dhar61595@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 11.05.25 um 16:11 schrieb Moumita:
> From: Moumita Dhar <dhar61595@gmail.com>
> 
> The previous function regex required explicit matching of function
> bodies using `{`, `(`, `((`, or `[[`, which caused several issues:
> 
> - It failed to capture valid functions where `{` was on the next line
>   due to line continuation (`\`).
> - It did not recognize functions with single  command body, such as
>   `x () echo hello`.
> 
> Replacing the function body matching logic with `.*$`, ensures
> that everything on the function definition line is captured.
> 
> Additionally, the word regex is refined to better recognize shell
> syntax, including additional parameter expansion operators and
> command-line options.
> 
> Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
> ---

Function patterns are looking good now. Let's focus on the worddiff
pattern now.

> diff --git a/t/t4034/bash/expect b/t/t4034/bash/expect
> new file mode 100644
> index 0000000000..17755e455f
> --- /dev/null
> +++ b/t/t4034/bash/expect
> @@ -0,0 +1,38 @@
> +<BOLD>diff --git a/pre b/post<RESET>
> +<BOLD>index 09ac008..60ba6a2 100644<RESET>
> +<BOLD>--- a/pre<RESET>
> +<BOLD>+++ b/post<RESET>
> +<CYAN>@@ -1,33 +1,33 @@<RESET>
> +<RED>my_var<RESET><GREEN>new_var<RESET>=10
> +x=<RED>123<RESET><GREEN>456<RESET>
> +y=<RED>3.14<RESET><GREEN>2.71<RESET>
> +z=<RED>.5<RESET><GREEN>.75<RESET>

When do decimal numbers occur in shell scripts? Wouldn't it be more
often the case that a fullstop is part of a regular expression or a file
name or version number that happens to be surrounded by numbers? In that
case, we would prefer to capture the digit sequences as separate words.

> +echo <RED>$USER<RESET><GREEN>$USERNAME<RESET>
> +${<RED>HOME<RESET><GREEN>HOMEDIR<RESET>}
> +((a<RED>+<RESET><GREEN>+=<RESET>b))
> +((a<RED>*<RESET><GREEN>*=<RESET>b))
> +((a<RED>/<RESET><GREEN>/=<RESET>b))
> +((a<RED>%<RESET><GREEN>%=<RESET>b))
> +((a<RED>|<RESET><GREEN>|=<RESET>b))
> +((a<RED>^<RESET><GREEN>^=<RESET>b))
> +((a<RED>=<RESET><GREEN>==<RESET>b))
> +((a<RED>!<RESET><GREEN>!=<RESET>b))
> +((a<RED><<RESET><GREEN><=<RESET>b))
> +((a<RED>><RESET><GREEN>>=<RESET>b))
> +$((a<RED><<RESET><GREEN><<<RESET>b))
> +$((a<RED>><RESET><GREEN>>><RESET>b))
> +$((a<RED>&<RESET><GREEN>&&<RESET>b))
> +$((a<RED>|<RESET><GREEN>||<RESET>b))
> +${a<RED>:<RESET><GREEN>:-<RESET>b}
> +${a<RED>:<RESET><GREEN>:=<RESET>b}
> +${a<RED>:<RESET><GREEN>:+<RESET>b}
> +${a<RED>:<RESET><GREEN>:?<RESET>b}
> +${a<RED>#<RESET><GREEN>##<RESET>*/}
> +${a<RED>%<RESET><GREEN>%%<RESET>.*}
> +${a<RED>^<RESET><GREEN>^^<RESET>}
> +${a<RED>,<RESET><GREEN>,,<RESET>}
> +${<GREEN>!<RESET>a}
> +${a[<RED>*<RESET><GREEN>@<RESET>]}

All good tests!

All of | || & && would more often than not occur in commands rather than
expressions. But the way these operators are tested here is fine, too.

> +${a<RED>:2:3<RESET><GREEN>:4:6<RESET>}

I am surprised to see :2:3 as a single token. It's bash's substring
expansion. It would not be matched anyway in practice because these
numbers are often variables or more complicated expressions, I would
think, not integer constants.

> +ls <RED>-a<RESET><GREEN>-x<RESET>
> +ls <RED>--a<RESET><GREEN>--x<RESET>

Can we extend the second of these two to have a multi-letter option?

> diff --git a/userdiff.c b/userdiff.c
> index 340c4eb4f7..655c8fe0b1 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -59,20 +59,32 @@ PATTERNS("bash",
>  	 "("
>  	 "("
>  	     /* POSIX identifier with mandatory parentheses */
> -	     "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
> +	     "([a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
>  	 "|"
>  	     /* Bashism identifier with optional parentheses */
> -	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
> +	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+)))"
>  	 ")"
> -	 /* Optional whitespace */
> -	 "[ \t]*"
> -	 /* Compound command starting with `{`, `(`, `((` or `[[` */
> -	 "(\\{|\\(\\(?|\\[\\[)"
> +	 /* Everything after the function header is captured  */
> +	 ".*$"
>  	 /* End of captured text */
>  	 ")",
>  	 /* -- */

In the operator patterns that follow, it is not necessary to match
operators that are just a single punctuation character. They are matched
automatically, IIRC (but please correct me if I am wrong). Only
multi-character operators should be matched. That means that in all
patterns where one character is optional due to the '?' in a
two-character-operator, you should drop the '?'.

> -	 /* Characters not in the default $IFS value */
> -	 "[^ \t]+"),
> +	 /* Identifiers: variable and function names */
> +	  "[a-zA-Z_][a-zA-Z0-9_]*"

OK. But see below.

> +	 /* Numeric constants: integers and decimals */
> +	  "|[0-9]+(\\.[0-9]*)?|[-+]?\\.[0-9]+"

I would recommend not to match decimal numbers and instead have them as
three words: integer-fullstop-integer.

Generally, I advise to not include a sign in the word pattern of a
number, because the sign is usually its own operator. But we do have
numeric options, i.e., integers with a leading dash. But see below.

> +	 /* Shell variables: $VAR, ${VAR} */
> +	  "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{"

Shell variables do not have to begin with a letter. We have $0, $1 etc.
Just do not require the first character after the $ to be a letter.

> +	  /* Logical and comparison operators */
> +	 "|\\|\\||&&|<<|>>|==|!=|<=|>="

I'd call || and && "Command list separators" in the context of shell
language.

> +	 /* Assignment and arithmetic operators */
> +	 "|[-+*/%&|^!=<>]=?"

These would then be only compund assignment operators. These patterns
also match <= >= == != again. How about having all those (from this line
and from the line above) that end in '=' into a single case?

> +	 /* Additional parameter expansion operators */
> +	 "|:?=|:-|:\\+|:\\?|:|#|##|%|%%|\\^\\^?|,|,,?|!|@|:[0-9]+(:[0-9]+)?"

Remove all single-character operators.

Also, the :digits:digits word is strange. What is your rationale that
you included it?

> +	 /* Command-line options (to avoid splitting -option) */
> +	 "|--?[a-zA-Z0-9_-]+"

This pattern is a beast for the matcher.Would it match the text "-----"?
Yes, in more than one way! Would it match "--"? Yes! Would it match
"-1000"? Yes!

None of these are a problem, but actually desired. But it would not need
the optional '-' in the second position. The '-' included in the range
would match "--foo" just as well.

This patter also matches negative numbers. So, here's the idea: Just
turn this into

	"|[-a-zA-Z0-9_]+"

And we have a pattern that matches identifiers, function names,
integers, short options, long options, numeric options a.k.a. negative
integers.

It might match more and I hope that I do not miss a case that we do
*not* want to match. If you do, let me know. Until then I'd leave it at
that and fix it up when we encounter an important case that is
mishandled by this pattern.

> +	 /* Brackets and grouping symbols */
> +	 "|\\(|\\)|\\{|\\}|\\[|\\]"),

OK.

>  PATTERNS("bibtex",
>  	 "(@[a-zA-Z]{1,}[ \t]*\\{{0,1}[ \t]*[^ \t\"@',\\#}{~%]*).*$",
>  	 /* -- */

-- Hannes

