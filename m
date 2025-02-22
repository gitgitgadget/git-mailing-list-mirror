Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91F41F866B
	for <git@vger.kernel.org>; Sat, 22 Feb 2025 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740248061; cv=none; b=a7wJE4Thz6OCSAMbyAVch+ZjnJu3EuVfwvra5Kg/fbA8UkUJVHAydKMhbOvSilkWE0pAMrmzOjvsg3ZlyjmzaaG5/7p+iEqEhXLOCJhUHheHtOsjaSExVWAYFhs4DvkyNhfOsXhawHxO6LLVRYEPiMOBkkiTsQo5+VbfkFuUwvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740248061; c=relaxed/simple;
	bh=wbNLhDahX5aXQ08fCLjCItGB3G1dQREIpibIEgxSmws=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:Cc:
	 In-Reply-To:Content-Type; b=ZB1eqzn1XwQ4iKim/0OIhen63mCVEwPKOrrhdY8nUaUwE7Eu55F9sWF83i7bqcQaEvbQb+xZb/AcJHvD8yy/nbxLsqp9bKgbzAL/vfMC8OGx9Wo5v4fW0MaN1yy+GuFc7Ikb9faDFmIDi/l7IQnBGjvomU4MXp7NWTBgSLcmvUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.108])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4Z0Zrg6QZ0z7QPvr
	for <git@vger.kernel.org>; Sat, 22 Feb 2025 19:14:11 +0100 (CET)
Received: from [192.168.0.112] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4Z0ZrX1NClzRnmP;
	Sat, 22 Feb 2025 19:14:03 +0100 (CET)
Message-ID: <e5e0c54d-1e71-49e9-9581-134880996e4a@kdbg.org>
Date: Sat, 22 Feb 2025 19:14:03 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] userdiff: extend Bash pattern to cover more shell
 function forms
Content-Language: en-US
To: Moumita <dhar61595@gmail.com>
References: <20250211114611.9334-1-dhar61595@gmail.com>
 <20250218153537.16320-1-dhar61595@gmail.com>
 <20250218153537.16320-2-dhar61595@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
Cc: git@vger.kernel.org
In-Reply-To: <20250218153537.16320-2-dhar61595@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thank you for this follow-up.

After reviewing my text below I find that the words may sound harsh.
Please don't let you turn down by the lack of friendlyness. In technical
reviews I (and very likely many other reviewers on this list) prefer to
get to the point right away and not waste our time by talking in circles.

I also do not repeat what others have said in their review.

Am 18.02.25 um 16:35 schrieb Moumita:
> From: Moumita Dhar <dhar61595@gmail.com>
> 
> The existing Bash userdiff pattern misses some shell function forms, such as
> `function foo()`, multi-line definitions, and extra whitespace.
> 
> Extend the pattern to:
> - Support `function foo()` syntax.
> - Allow spaces in `foo ( )` definitions.
> - Recognize multi-line definitions with backslashes.
> - Broaden function body detection.

Please be accurate what you mention here. The first two are already
present and not new, the third one I cannot find, and the last one is
not immediately visible if not wrong (you are removing the '((' introducer).

> 
> Signed-off-by: Moumita Dhar <dhar61595@gmail.com>
> ---
>  userdiff.c | 34 +++++++++++++++++++++++-----------
>  1 file changed, 23 insertions(+), 11 deletions(-)
> 
> diff --git a/userdiff.c b/userdiff.c
> index 340c4eb4f7..194e28883d 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -53,26 +53,38 @@ IPATTERN("ada",
>  	 "|[-+]?[0-9][0-9#_.aAbBcCdDeEfF]*([eE][+-]?[0-9_]+)?"
>  	 "|=>|\\.\\.|\\*\\*|:=|/=|>=|<=|<<|>>|<>"),
>  PATTERNS("bash",
> -	 /* Optional leading indentation */
> +     /* Optional leading indentation */
>  	 "^[ \t]*"
> -	 /* Start of captured text */
> +	 /* Start of captured function name */
>  	 "("
>  	 "("
> -	     /* POSIX identifier with mandatory parentheses */
> -	     "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\))"
> +		 /* POSIX identifier with mandatory parentheses (allow spaces inside) */
> +		 "[a-zA-Z_][a-zA-Z0-9_]*[ \t]*\\([ \t]*\\)"
>  	 "|"
> -	     /* Bashism identifier with optional parentheses */
> -	     "(function[ \t]+[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))"
> +		 /* Bash-style function definitions, allowing optional `function` keyword */
> +		 "(?:function[ \t]+(?=[a-zA-Z_]))?[a-zA-Z_][a-zA-Z0-9_]*(([ \t]*\\([ \t]*\\))|([ \t]+))?"
>  	 ")"

You inserted (?=[a-zA-Z_]) after the function. What does this do? Then
you made 'function identifier' optional. Why?

You also added a ? at the end. Is that to make the parenthesis optional?
But look closely: they are already optional, because we already have

  ( space_opt "(" space_opt ")" | space_opt )

It would be a minor improvement to turn this into

  space_opt ( "(" space_opt ")" )?

Make a mental bookmark here.

>  	 /* Optional whitespace */
>  	 "[ \t]*"
> -	 /* Compound command starting with `{`, `(`, `((` or `[[` */
> -	 "(\\{|\\(\\(?|\\[\\[)"
> -	 /* End of captured text */
> +	 /* Allow function body to start with `{`, `(` (subshell), `[[` */
> +	 "(\\{|\\(|\\[\\[)"
> +	 /* End of captured function name */

What is the justification that you removed "((" as introduction of the
function body?

>  	 ")",

So, we capture only what we expect to be a function header in typical cases.

Let me make a suggestion. What if we replaced everything from the mental
bookmark above up to the closing parenthesis by .*$ like we do in all
other builtin drivers? Then everything on the line that contains the
function header would be used as hunk header, and we do not care what
the function body looks like. It would also cover the case mentioned by
Eric elsewhere where the body is just a simple command.

If that leads to new cases that are detected, it would be really nice to
add corresponding test cases in t/t4018/.

>  	 /* -- */
> -	 /* Characters not in the default $IFS value */
> -	 "[^ \t]+"),
> +	 /* Identifiers: variable and function names */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 /* Numeric constants: integers and decimals */
> +	 "|[-+]?[0-9]+(\\.[0-9]*)?|[-+]?\\.[0-9]+"
> +	 /* Shell variables: `$VAR`, `${VAR}` */
> +	 "|\\$[a-zA-Z_][a-zA-Z0-9_]*|\\$\\{[^}]+\\}"
> +	 /* Logical and comparison operators */
> +	 "|\\|\\||&&|<<|>>|==|!=|<=|>="
> +	 /* Assignment and arithmetic operators */
> +	 "|[-+*/%&|^!=<>]=?"
> +	 /* Command-line options (to avoid splitting `-option`) */
> +	 "|--?[a-zA-Z0-9_-]+"
> +	 /* Brackets and grouping symbols */
> +	 "|\\(|\\)|\\{|\\}|\\[|\\]"),

As far as I can see, you introduced a pattern for options, but otherwise
left the patterns the same as in the earlier round. Of course, you are
not obliged to integrate every suggestion that is made by a reviewer,
but it is good tone that you leave a comment explaining why you
dismissed a suggestion.

To expand on my suggestion how to treat ${var} substitution:

- Replace \\$\\{[^}]+\\} by just \\$\\{ to match only the introducer.
(The closing brace is already matched by a later pattern.)
- Add operators := :- :+ :? # ## %% that are used frequently in these
complex expansions.
- Have a look at section "Shell Parameter Expansion" in the bash
manual[1] about the multitude of operators that can occur after ${.
Maybe you want to add more of them.

[1]
https://www.gnu.org/software/bash/manual/bash.html#Shell-Parameter-Expansion

-- Hannes

