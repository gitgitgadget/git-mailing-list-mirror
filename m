Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF5732D045
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711527527; cv=none; b=k1m1eaXHtP8I0H2J/qsVXuH+hcNFZZHZKrfo+popjOoK38wD5mFCAebdbaICqj2SWSoAYAvY2xe1twubWuQNsMESTgUIawJsQtZuN67UsbHYxqg/hWDR26HGxZaaZSaC4QWB/57f+eMz038/wdPPqFrQMCxooR3Sqm4HotIaz9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711527527; c=relaxed/simple;
	bh=zKYPf3124TurfuQ/wI+3Ju5suZlT0by50VMG90VdoCc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b7zO6/gsFQ3FKKQUEbR86b3TXwb5nkvz5HGY8SGBeRI/kfQT5Id7+dQKX8tUl+VHWSCfkTejaSAmFL1YpVJvIwFsD6JY/oRwA7meUi1Q79cRU1op6u4svA+6fWC80uerjpLuYWMlGP/HX5KeiL/VHJpjQBDnrlMiv9XIrM1Jteo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp1.bon.at (unknown [192.168.181.103])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4V4JHY5Lh6z61B9
	for <git@vger.kernel.org>; Wed, 27 Mar 2024 08:30:49 +0100 (CET)
Received: from [192.168.0.101] (unknown [93.83.142.38])
	by bsmtp1.bon.at (Postfix) with ESMTPSA id 4V4JHP34D6zRpKf;
	Wed, 27 Mar 2024 08:30:41 +0100 (CET)
Message-ID: <1facab70-4c8a-4cf4-b464-b27ab90b1339@kdbg.org>
Date: Wed, 27 Mar 2024 08:30:41 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] userdiff: better method/property matching for C#
To: Steven Jeuris via GitGitGadget <gitgitgadget@gmail.com>
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Jeff King <peff@peff.net>, Steven Jeuris <steven.jeuris@gmail.com>,
 Steven Jeuris <steven.jeuris@3shape.com>, git@vger.kernel.org
References: <pull.1682.git.git.1708882423691.gitgitgadget@gmail.com>
 <pull.1682.v2.git.git.1709756493673.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <pull.1682.v2.git.git.1709756493673.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 06.03.24 um 21:21 schrieb Steven Jeuris via GitGitGadget:
> From: Steven Jeuris <steven.jeuris@3shape.com>
> 
> - Support multi-line methods by not requiring closing parenthesis.
> - Support multiple generics (comma was missing before).
> - Add missing `foreach`, `lock` and  `fixed` keywords to skip over.
> - Remove `instanceof` keyword, which isn't C#.
> - Also detect non-method keywords not positioned at the start of a line.
> - Added tests; none existed before.
> 
> The overall strategy is to focus more on what isn't expected for
> method/property definitions, instead of what is, but is fully optional.
> 
> Signed-off-by: Steven Jeuris <steven.jeuris@gmail.com>
> ---

I like the comprehensive test cases that are added. However, I found one
major point in the patterns that must be considered. See below.

>     userdiff: better method/property matching for C#
>     
>     Change since v1: I removed "from" from the list of keywords to skip.
>     First, I considered adding "await", but I discovered both "await" and
>     "from" are "contextual keywords", which unlike the other keywords
>     currently listed, aren't reserved, and can thus cause false negatives.
>     I.e., it is valid to have a method named "await" or "from". In edge
>     cases, this may lead to false positives, but a different exclusion rule
>     will need to be added to handle these.

So, this patch makes the choice to have some false positives instead of
some false negatives. I have no experience in C#, so I trust your
judgement that users are better served with this choice rather than the
opposite.

> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1682%2FWhathecode%2Fmaster-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1682/Whathecode/master-v2
> Pull-Request: https://github.com/git/git/pull/1682
> 
> Range-diff vs v1:
> 
>  1:  cdd8dd4d871 ! 1:  00315519014 userdiff: better method/property matching for C#
>      @@ Commit message
>       
>           - Support multi-line methods by not requiring closing parenthesis.
>           - Support multiple generics (comma was missing before).
>      -    - Add missing `foreach`, `from`, `lock` and  `fixed` keywords to skip over.
>      +    - Add missing `foreach`, `lock` and  `fixed` keywords to skip over.
>           - Remove `instanceof` keyword, which isn't C#.
>           - Also detect non-method keywords not positioned at the start of a line.
>           - Added tests; none existed before.
>      @@ t/t4018/csharp-method-skip-body (new)
>       +		{
>       +		}
>       +		int[] numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
>      -+		var test =
>      -+			from num in Numbers(
>      -+		 	) select num;
>       +		
>       +		// Control
>       +		if (false)
>      @@ userdiff.c: PATTERNS("cpp",
>       +	  * Jump over keywords not used by methods which can be followed by parentheses without special characters in between,
>       +	  * making them look like methods.
>       +	  */
>      -+	 "!(^|[ \t]+)(do|while|for|foreach|from|if|else|new|default|return|switch|case|throw|catch|using|lock|fixed)([ \t(]+|$)\n"
>      ++	 "!(^|[ \t]+)(do|while|for|foreach|if|else|new|default|return|switch|case|throw|catch|using|lock|fixed)([ \t(]+|$)\n"
>       +	 /* Methods/constructors:
>       +	  * the strategy is to identify a minimum of two groups (any combination of keywords/type/name),
>       +	  * without intermediate or final characters which can't be part of method definitions before the opening parenthesis.
> 
> 
>  t/t4018/csharp-method               |  10 +++
>  t/t4018/csharp-method-explicit      |  12 +++
>  t/t4018/csharp-method-generics      |  11 +++
>  t/t4018/csharp-method-modifiers     |  13 ++++
>  t/t4018/csharp-method-multiline     |  10 +++
>  t/t4018/csharp-method-params        |  10 +++
>  t/t4018/csharp-method-skip-body     | 112 ++++++++++++++++++++++++++++
>  t/t4018/csharp-method-special-chars |  11 +++
>  t/t4018/csharp-method-with-spacing  |  10 +++
>  t/t4018/csharp-property             |  11 +++
>  userdiff.c                          |  16 ++--
>  11 files changed, 221 insertions(+), 5 deletions(-)
>  create mode 100644 t/t4018/csharp-method
>  create mode 100644 t/t4018/csharp-method-explicit
>  create mode 100644 t/t4018/csharp-method-generics
>  create mode 100644 t/t4018/csharp-method-modifiers
>  create mode 100644 t/t4018/csharp-method-multiline
>  create mode 100644 t/t4018/csharp-method-params
>  create mode 100644 t/t4018/csharp-method-skip-body
>  create mode 100644 t/t4018/csharp-method-special-chars
>  create mode 100644 t/t4018/csharp-method-with-spacing
>  create mode 100644 t/t4018/csharp-property
> 
> diff --git a/t/t4018/csharp-method b/t/t4018/csharp-method
> new file mode 100644
> index 00000000000..85ff0cb8b5b
> --- /dev/null
> +++ b/t/t4018/csharp-method
> @@ -0,0 +1,10 @@
> +class Example
> +{
> +	string Method(int RIGHT)
> +	{
> +		// Filler
> +		// Filler
> +		
> +		return "ChangeMe";
> +	}
> +}
> diff --git a/t/t4018/csharp-method-explicit b/t/t4018/csharp-method-explicit
> new file mode 100644
> index 00000000000..083aa094ce2
> --- /dev/null
> +++ b/t/t4018/csharp-method-explicit
> @@ -0,0 +1,12 @@
> +using System;
> +
> +class Example : IDisposable
> +{
> +	void IDisposable.Dispose() // RIGHT
> +	{
> +		// Filler
> +		// Filler
> +		
> +		// ChangeMe
> +	}
> +}
> diff --git a/t/t4018/csharp-method-generics b/t/t4018/csharp-method-generics
> new file mode 100644
> index 00000000000..c472d4a18df
> --- /dev/null
> +++ b/t/t4018/csharp-method-generics
> @@ -0,0 +1,11 @@
> +class Example<T1, T2>
> +{
> +	Example<int, string> Method<TA, TB>(TA RIGHT, TB b)
> +	{
> +		// Filler
> +		// Filler
> +		
> +		// ChangeMe
> +		return null;
> +	}
> +}
> diff --git a/t/t4018/csharp-method-modifiers b/t/t4018/csharp-method-modifiers
> new file mode 100644
> index 00000000000..f1c008a4749
> --- /dev/null
> +++ b/t/t4018/csharp-method-modifiers
> @@ -0,0 +1,13 @@
> +using System.Threading.Tasks;
> +
> +class Example
> +{
> +	static internal async Task Method(int RIGHT)
> +	{
> +		// Filler
> +		// Filler
> +		
> +		// ChangeMe
> +		await Task.Delay(1);
> +	}
> +}
> diff --git a/t/t4018/csharp-method-multiline b/t/t4018/csharp-method-multiline
> new file mode 100644
> index 00000000000..0a20b0cb49c
> --- /dev/null
> +++ b/t/t4018/csharp-method-multiline
> @@ -0,0 +1,10 @@
> +class Example
> +{
> +	string Method_RIGHT(
> +		int a,
> +		int b,
> +		int c)
> +	{
> +		return "ChangeMe";
> +	}
> +}
> diff --git a/t/t4018/csharp-method-params b/t/t4018/csharp-method-params
> new file mode 100644
> index 00000000000..18598449008
> --- /dev/null
> +++ b/t/t4018/csharp-method-params
> @@ -0,0 +1,10 @@
> +class Example
> +{
> +	string Method(int RIGHT, int b, int c = 42)
> +	{
> +		// Filler
> +		// Filler
> +		
> +		return "ChangeMe";
> +	}
> +}
> diff --git a/t/t4018/csharp-method-skip-body b/t/t4018/csharp-method-skip-body
> new file mode 100644
> index 00000000000..c8c9621634d
> --- /dev/null
> +++ b/t/t4018/csharp-method-skip-body
> @@ -0,0 +1,112 @@
> +using System.Linq;
> +using System;
> +
> +class Example : IDisposable
> +{
> +	string Method(int RIGHT)
> +	{
> +		// Method calls
> +		MethodCall();
> +		MethodCall(1, 2);
> +		MethodCall(
> +			1, 2);
> +		
> +		// Assignments
> +		var constantAssignment = "test";
> +		var methodAssignment = MethodCall();
> +		var multiLineMethodAssignment = MethodCall(
> +			);
> +		
> +		// Initializations/disposal
> +		new Example();
> +		new Example(
> +			);
> +		new Example { };
> +		using (this) 
> +		{
> +		}
> +		var def =
> +			this is default(
> +				Example);
> +		
> +		// Iteration statements
> +		do { } while (true);
> +		do MethodCall(
> +			); while (true);
> +		while (true);
> +		while (true) {
> +			break;
> +		}
> +		for (int i = 0; i < 10; ++i)
> +		{
> +		}
> +		foreach (int i in Enumerable.Range(0, 10))
> +		{
> +		}
> +		int[] numbers = [5, 4, 1, 3, 9, 8, 6, 7, 2, 0];
> +		
> +		// Control
> +		if (false)
> +		{
> +			return "out";
> +		}
> +		else { }
> +		if (true) MethodCall(
> +			);
> +		else MethodCall(
> +			);
> +		switch ("test")
> +		{
> +			case "one":
> +				return MethodCall(
> +					);
> +			case "two":
> +				break;
> +		}
> +		(int, int) tuple = (1, 4);
> +		switch (tuple)
> +		{
> +			case (1, 4):
> +				MethodCall();
> +		}
> +		
> +		// Exceptions
> +		try
> +		{
> +			throw new Exception("fail");
> +		}
> +		catch (Exception)
> +		{
> +		}
> +		finally
> +		{
> +		}
> +		try { } catch (Exception) {}
> +		try
> +		{
> +			throw GetException(
> +				);
> +		}
> +		catch (Exception) { }
> +		
> +		// Others
> +		lock (this)
> +		{
> +		}
> +		unsafe
> +		{
> +			byte[] bytes = [1, 2, 3];
> +			fixed (byte* pointerToFirst = bytes)
> +			{
> +			}
> +		}
> +		
> +		return "ChangeMe";
> +	}

Nice! This tests the exlusion patterns.

> +	
> +	public void Dispose() {}
> +	
> +	string MethodCall(int a = 0, int b = 0) => "test";
> +	Exception GetException() => new Exception("fail");
> +	int[] Numbers() => [0, 1];

Are these also patterns that should not be picked up? If so, should the
"ChangeMe" not be later in the file? As written, they would never be
candidates because there is no diff hunk later in the file.

> +}
> diff --git a/t/t4018/csharp-method-special-chars b/t/t4018/csharp-method-special-chars
> new file mode 100644
> index 00000000000..ec3565fd000
> --- /dev/null
> +++ b/t/t4018/csharp-method-special-chars
> @@ -0,0 +1,11 @@
> +class @Some_Type
> +{
> +	@Some_Type @Method_With_Underscore(int RIGHT)
> +	{
> +		// Filler
> +		// Filler
> +		
> +		// ChangeMe
> +		return new @Some_Type();
> +	}
> +}
> diff --git a/t/t4018/csharp-method-with-spacing b/t/t4018/csharp-method-with-spacing
> new file mode 100644
> index 00000000000..4143929a711
> --- /dev/null
> +++ b/t/t4018/csharp-method-with-spacing
> @@ -0,0 +1,10 @@
> +class Example
> +{
> +		string   Method 	( int 	RIGHT )
> +	{
> +		// Filler
> +		// Filler
> +		
> +		return "ChangeMe";
> +	}
> +}
> diff --git a/t/t4018/csharp-property b/t/t4018/csharp-property
> new file mode 100644
> index 00000000000..1792117f964
> --- /dev/null
> +++ b/t/t4018/csharp-property
> @@ -0,0 +1,11 @@
> +class Example
> +{
> +	public bool RIGHT
> +    {
> +        get { return true; }
> +        set
> +        {
> +            // ChangeMe
> +        }
> +    }
> +}
> diff --git a/userdiff.c b/userdiff.c
> index e399543823b..5a9e8a0ef55 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -89,12 +89,18 @@ PATTERNS("cpp",
>  	 "|\\.[0-9][0-9]*([Ee][-+]?[0-9]+)?[fFlL]?"
>  	 "|[-+*/<>%&^|=!]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\||::|->\\*?|\\.\\*|<=>"),
>  PATTERNS("csharp",
> -	 /* Keywords */
> -	 "!^[ \t]*(do|while|for|if|else|instanceof|new|return|switch|case|throw|catch|using)\n"
> -	 /* Methods and constructors */
> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe|async)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[<>@._[:alnum:]]+[ \t]*\\(.*\\))[ \t]*$\n"
> +	 /*
> +	  * Jump over keywords not used by methods which can be followed by parentheses without special characters in between,
> +	  * making them look like methods.
> +	  */
> +	 "!(^|[ \t]+)(do|while|for|foreach|if|else|new|default|return|switch|case|throw|catch|using|lock|fixed)([ \t(]+|$)\n"
> +	 /* Methods/constructors:
> +	  * the strategy is to identify a minimum of two groups (any combination of keywords/type/name),
> +	  * without intermediate or final characters which can't be part of method definitions before the opening parenthesis.
> +	  */

I would have appreciated if the comment lines were not so long. We
already have many long lines of code in this file, but comment lines
generally stay below the 80 character limit. Also watch out for the
multi-line comment style (put the opening /* on a line by itself, like
you did in the comment above).

> +	 "^[ \t]*(([][[:alnum:]@_<>.,]*[^=:{ \t][ \t]+[][[:alnum:]@_<>.,]*)+\\([^;]*)$\n"

I am not 100% sure about the meaning of this expression. But would it
not match this line, which looks like part of a multi-line expression:

	+ func(x)

and produce a false positive? [Testing myself...] Yes it does. I do not
know if it is worth fixing as I do not do C#. But if this were patterns
for C or C++, I would consider it a major problem.

>  	 /* Properties */
> -	 "^[ \t]*(((static|public|internal|private|protected|new|virtual|sealed|override|unsafe)[ \t]+)*[][<>@.~_[:alnum:]]+[ \t]+[@._[:alnum:]]+)[ \t]*$\n"
> +	 "^[ \t]*((([][[:alnum:]@_<>.,]+)[ \t]+[][[:alnum:]@_]*)+[^=:;,()]*)$\n"

OK. Since the second of the two words is optional and almost the same as
the first, I have a gut feeling that the pattern can be expensive to
match. But since I do not have data to back up my suspicion, let's leave
it as it is.

>  	 /* Type definitions */
>  	 "^[ \t]*(((static|public|internal|private|protected|new|unsafe|sealed|abstract|partial)[ \t]+)*(class|enum|interface|struct|record)[ \t]+.*)$\n"
>  	 /* Namespace */>
> base-commit: f41f85c9ec8d4d46de0fd5fded88db94d3ec8c11

-- Hannes

