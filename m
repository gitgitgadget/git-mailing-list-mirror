Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C023A8475
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 18:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711824574; cv=none; b=O0OX0xqD0vt5qof/R+A37rkqDi97K+coLtY8yUKtF14ObRTuG2dO8P34sM5O+8bNohdas5Jbw/QHBqJ8Gwd9CStOzNVw6nVBpxV5AeKL8Nd/UVu0wb2FZcs9L6mgqV6ZjtLhNfAmmgtlfYJttRWxcobWgDBMs8Xy2EP8Atb4yCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711824574; c=relaxed/simple;
	bh=KjXBO4Oqx483V6IttiA7jJUnZU7hBjllUz5jAuNXK6Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J2ALfRErKTY1/n4XISU9jP0sEZiuO4maJGDdcyKxXoQnAwAZMEZikLw7qOqoC98SbNTv1bSslCt61qRq3PLeWIPTIL8a+oK1AlkS1KiHAVUMNW1JplceOV8l7YIttvVbZqJTWd2EjevNUAUBQ9MEFJHn/pILdWctmKUVdDG/d6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp3.bon.at (unknown [192.168.181.107])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4V6RBw62yTz5vTP
	for <git@vger.kernel.org>; Sat, 30 Mar 2024 19:49:12 +0100 (CET)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4V6RBk5WRtz5tl9;
	Sat, 30 Mar 2024 19:49:02 +0100 (CET)
Message-ID: <bb4fe56f-f45d-404a-834e-31ba877641c7@kdbg.org>
Date: Sat, 30 Mar 2024 19:49:02 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] userdiff: better method/property matching for C#
To: Steven Jeuris via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Jeff King <peff@peff.net>, Linus Arver <linusa@google.com>,
 Steven Jeuris <steven.jeuris@gmail.com>,
 Steven Jeuris <steven.jeuris@3shape.com>
References: <pull.1682.v3.git.git.1711613220277.gitgitgadget@gmail.com>
 <pull.1682.v4.git.git.1711653257043.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1682.v4.git.git.1711653257043.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 28.03.24 um 20:14 schrieb Steven Jeuris via GitGitGadget:
> diff --git a/userdiff.c b/userdiff.c
> index e399543823b..35e0e1183f7 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -89,12 +89,46 @@ PATTERNS("cpp",
>  	 "|\\.[0-9][0-9]*([Ee][-+]?[0-9]+)?[fFlL]?"
>  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*|<=>"),
>  PATTERNS("csharp",
> -	 /* Keywords */
> -	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
> -	 /* Methods and constructors */
> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
> -	 /* Properties */
> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
> +	 /*
> +	  * Jump over reserved keywords which are illegal method names, but which
> +	  * can be followed by parentheses without special characters in between,
> +	  * making them look like methods.
> +	  */
> +	 "!(^|[ \t]+)" /* Start of line or whitespace. */
> +		"(do|while|for|foreach|if|else|new|default|return|switch|case|throw"
> +		"|catch|using|lock|fixed)"
> +		"([ \t(]+|$)\n" /* Whitespace, "(", or end of line. */
> +	 /*
> +	  * Methods/constructors:
> +	  * The strategy is to identify a minimum of two groups (any combination
> +	  * of keywords/type/name) before the opening parenthesis, and without
> +	  * final unexpected characters, normally only used in ordinary statements.
> +	  */
> +	 "^[ \t]*" /* Remove leading whitespace. */
> +		"(" /* Start chunk header capture. */
> +		"(" /* Group of keywords/type/names. */
> +		"([][[:alnum:]@_<>.]|, [ |\t]*)+" /* Space only allowed after ",". */

Mental note: This pattern means:

   a sequence of at least one of
   (
       one character of a certain set
       OR
       a comma
          followed by SP
          optionally followed by whitespace or |
   )

> +		"[ \t]+" /* One required space forces a minimum of two items. */

OK.

> +		"([][[:alnum:]@_<>.]|, [ |\t]*)+"

Same here.

Is it the case of t4018/csharp-method-generics?

    Example<int, string> Method<TA, TB>(TA RIGHT, TB b)

Let me see if I make sense of this. The idea is to treat the ', '
sequence as a single "character" so that the SP in this sequence does
not count as the word separator that we otherwise have between two plain
words.

I am unsure whether this is a workable solution. The set of symbols that
can occur before a method definition overlaps too much with the symbols
that can occur elsewhere. For example, if you have these lines of code:

    something(arg,
        meth, func(x),
        prop, y,
        more);

you have a false positive in the lines in the middle.

I have the feeling that it is impossible to distinguish method
definitions from other code reliably. We can go back and forth a while,
but at some point we have to stop and accept that there are false
positives. Where that point is, I cannot tell, because I do not know
what is common and what is uncommon in typical C# code. It is your call.

> +		"[ \t]*" /* Optional space before parameters start. */
> +		")+"
> +		"\\(" /* Start of method parameters. */
> +		"[^;]*" /* Allow complex parameters, but exclude statements (;). */
> +		")$\n" /* Close chunk header capture. */
> +	 /*
> +	  * Properties:
> +	  * As with methods, expect a minimum of two groups. But, more trivial than
> +	  * methods, the vast majority of properties long enough to be worth
> +	  * showing a chunk header for don't include "=:;,()" on the line they are
> +	  * defined, since they don't have a parameter list.
> +	  */
> +	 "^[ \t]*("
> +		"("
> +		"([][[:alnum:]@_<>.]|, [ |\t]*)+[ \t]+"
> +		"([][[:alnum:]@_<>.]|, [ |\t]*)+[ \t]*"
> +		")+" /* Up to here, same as methods regex. */

Is the intent to match pairs of words? Or is the intent to find at least
two words? If the latter, then the preceding 4 lines are better written as

		       "([][[:alnum:]@_<>.]|,[ \t]+)+"
		"([ \t]+([][[:alnum:]@_<>.]|,[ \t]+)+)+"

If the former, then the space after the second word must not be
optional, because it would match

    a bc d

as two pairs

    (a b)(c d)

BTW that there is an | symbol in the potential space after the comma is
certainly an oversight, right? And, why is a tab after the comma not
permitted?

When you construct regular expressions, make sure that repeated parts
always begin with a mandatory part and that this mandatory part cannot
be an optional part at the end of the preceding or the repeated pattern.
Otherwise, in a non-matching case you send the matcher into an expensive
backtracking loop.

> +		"[^;=:,()]*" /* Compared to methods, no parameter list allowed. */
> +		")$\n"
>  	 /* Type definitions */
>  	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct|record)[ \t]+.*)$\n"
>  	 /* Namespace */
> 
> base-commit: f41f85c9ec8d4d46de0fd5fded88db94d3ec8c11
