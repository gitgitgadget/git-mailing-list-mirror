Received: from bsmtp3.bon.at (bsmtp3.bon.at [213.33.87.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87CD2475E3
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 18:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784398305; cv=none; b=ikpkFtib/lSSFl1yuDnGmkDbuSyFioTW60rnfzAR1c8UZC1X5WbXqZlo75N45nxZl/DCStC/mRyXkb6p1g0Hk5UQiQAo4nvpRYlMQpfo0P042RwirpP69FGyeIR5xVQpN8BjfBbzR53Jz2SAGpGUD237f4X8zqCYbfQIUK6os8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784398305; c=relaxed/simple;
	bh=vfzZ0mKtl5mL8a4nH16PYtO5lEcAZjh/7ePer5jLRjo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FgIhzkS8cL/lhmMu2iqdHJ2FmuLEFjZVccs9zV1vMy2IPPFzbo2hB9o09eOQZmEFkKXLt+YO8Fmb8hiIojMkuh1HAMM2xl+oIHWLof1vuwGp0DRitbRYffgP8vWFX0KT23/Iy4kv++8h4Hzk0+rq03/l5O1L+0r3GYFxjh8iCSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.1.102] (213-147-165-249.nat.highway.webapn.at [213.147.165.249])
	by bsmtp3.bon.at (Postfix) with ESMTPSA id 4h2Zbl4KzjzRnlX;
	Sat, 18 Jul 2026 20:11:31 +0200 (CEST)
Message-ID: <2a3a73c5-5e90-44a3-bf6a-6e98ce5e5a59@kdbg.org>
Date: Sat, 18 Jul 2026 20:11:30 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] userdiff: add support for Swift
Content-Language: en-US
To: Shlok Kulshreshtha <diy2903@gmail.com>
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, Junio C Hamano
 <gitster@pobox.com>, =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
 Eric Sunshine <sunshine@sunshineco.com>,
 "Scott L. Burson" <Scott@sympoiesis.com>, git@vger.kernel.org
References: <20260717140232.6722-1-diy2903@gmail.com>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <20260717140232.6722-1-diy2903@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 17.07.26 um 16:02 schrieb Shlok Kulshreshtha:
> Add a built-in userdiff driver for the Swift programming language so that
> diff hunk headers and word diffs work out of the box for ".swift" files.
> 
> The funcname pattern is built for Swift's own declaration grammar: an
> optional run of attributes ("@objc", "@available(iOS 13, *)", ...),
> followed by an optional run of lowercase modifiers ("public", "static",
> "final", ...), followed by a declaration keyword (func, class, struct,
> enum, protocol, extension, actor, init, deinit, subscript). The keyword
> is followed by a boundary that allows whitespace, "(" (init/subscript),
> "?" or "!" (failable init), or "<" (generics), while still acting as a
> word boundary so e.g. "initialize(" does not match.
> 
> The word regex recognizes Swift identifiers, hexadecimal, octal, binary,
> integer and floating-point literals, and the language's operators.
> 
> Signed-off-by: Shlok Kulshreshtha <diy2903@gmail.com>
> ---
> This addresses the "add a userdiff driver for a language" microproject.

I am mildly surprised that userdiff drivers can count as microproject.
At a minimum, they are on the challenging side of the spectrum.

> Swift is not covered by a built-in driver yet, and I did not find an
> in-flight patch adding one on the list; please let me know if one exists.
> 
> Motivation: without a Swift driver, ".swift" files use the generic
> funcname heuristic, so "git diff" hunk headers name the enclosing type
> instead of the changed function.
> 
> The pattern is built directly from Swift's declaration grammar rather
> than adapted from another language's driver, so it covers a few things
> that a straight port would miss:
> 
>  - attributes, with or without arguments, whether on their own line
>    ("@objc" above a "func") or inline with the declaration
>    ("@objc func foo()", "@available(iOS 13, *) public func bar()");

AFAIC, the regular expression does not match attributes on their own
line. What relevance does this statement have?

>  - modifiers ("public", "static", "override", "mutating", ...) in any
>    combination, before or after attributes;
>  - failable initializers, "init?" and "init!";
>  - generics, "init<T>" and "subscript<T>";
>  - the keyword boundary still acts as a word boundary, so e.g.
>    "initialize(" is not mistaken for "init".
> 
> I verified all of the above against a built binary, including generic
> functions with "where" clauses, multi-line signatures, and operator
> functions such as "static func ==". I did not find a real case this
> pattern misses; the ones I intentionally left out are one-line
> declarations ("typealias", "associatedtype") and rarer forms
> ("operator", "precedencegroup", "macro"), which would not make useful
> section headers anyway.
> 
> The word regex covers Swift identifiers; hexadecimal, octal, binary,
> integer and floating-point literals; and operators including "<<=" /
> ">>=", "??" and the range operators. All of t4018 passes, including the
> sorted builtin_drivers check and the new swift-* fixtures.
> 
>  Documentation/gitattributes.adoc  |  2 ++
>  t/t4018/swift-actor               |  5 +++++
>  t/t4018/swift-attribute-with-args |  7 +++++++
>  t/t4018/swift-class               |  5 +++++
>  t/t4018/swift-enum                |  5 +++++
>  t/t4018/swift-extension           |  5 +++++
>  t/t4018/swift-failable-init       |  7 +++++++
>  t/t4018/swift-func                |  5 +++++
>  t/t4018/swift-generic-subscript   |  7 +++++++
>  t/t4018/swift-init                |  7 +++++++
>  t/t4018/swift-inline-attribute    |  7 +++++++
>  t/t4018/swift-modifiers           |  4 ++++
>  t/t4018/swift-protocol            |  5 +++++
>  t/t4018/swift-struct              |  5 +++++
>  userdiff.c                        | 10 ++++++++++
>  15 files changed, 86 insertions(+)
>  create mode 100644 t/t4018/swift-actor
>  create mode 100644 t/t4018/swift-attribute-with-args
>  create mode 100644 t/t4018/swift-class
>  create mode 100644 t/t4018/swift-enum
>  create mode 100644 t/t4018/swift-extension
>  create mode 100644 t/t4018/swift-failable-init
>  create mode 100644 t/t4018/swift-func
>  create mode 100644 t/t4018/swift-generic-subscript
>  create mode 100644 t/t4018/swift-init
>  create mode 100644 t/t4018/swift-inline-attribute
>  create mode 100644 t/t4018/swift-modifiers
>  create mode 100644 t/t4018/swift-protocol
>  create mode 100644 t/t4018/swift-struct
> 
> diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
> index bd76167a45..9fea75f96f 100644
> --- a/Documentation/gitattributes.adoc
> +++ b/Documentation/gitattributes.adoc
> @@ -914,6 +914,8 @@ patterns are available:
>  - `scheme` suitable for source code in most Lisp dialects,
>    including Scheme, Emacs Lisp, Common Lisp, and Clojure.
>  
> +- `swift` suitable for source code in the Swift language.
> +
>  - `tex` suitable for source code for LaTeX documents.
>  
>  
> diff --git a/t/t4018/swift-actor b/t/t4018/swift-actor
> new file mode 100644
> index 0000000000..e4852f40a7
> --- /dev/null
> +++ b/t/t4018/swift-actor
> @@ -0,0 +1,5 @@
> +actor RIGHT {
> +    let a = 1
> +    // a comment
> +    let b = ChangeMe
> +}
> diff --git a/t/t4018/swift-attribute-with-args b/t/t4018/swift-attribute-with-args
> new file mode 100644
> index 0000000000..22b1ee32f1
> --- /dev/null
> +++ b/t/t4018/swift-attribute-with-args
> @@ -0,0 +1,7 @@
> +struct View {
> +    @available(iOS 13, *) public func RIGHT() {
> +        let a = 1
> +        // a comment
> +        print(ChangeMe)
> +    }
> +}

So, this doesn't pick up the "struct View {" line, but the line below.
Good test.

> diff --git a/t/t4018/swift-failable-init b/t/t4018/swift-failable-init
> new file mode 100644
> index 0000000000..5e4091d97c
> --- /dev/null
> +++ b/t/t4018/swift-failable-init
> @@ -0,0 +1,7 @@
> +class Bar {
> +    init?(RIGHT: Int) {
> +        let value = RIGHT
> +        // a comment
> +        print(ChangeMe)
> +    }
> +}

This test contains "RIGHT" twice. This is not good, because we do not
know which one is picked.

> diff --git a/t/t4018/swift-generic-subscript b/t/t4018/swift-generic-subscript
> new file mode 100644
> index 0000000000..565f93cd6c
> --- /dev/null
> +++ b/t/t4018/swift-generic-subscript
> @@ -0,0 +1,7 @@
> +struct Container {
> +    subscript<RIGHT>(index: RIGHT) -> Int {
> +        let a = 0
> +        // a comment
> +        return ChangeMe
> +    }
> +}

It is strange to have "RIGHT" twice on the same line, but it does no
harm. Still, there should be only one for consistency.

> diff --git a/t/t4018/swift-init b/t/t4018/swift-init
> new file mode 100644
> index 0000000000..f683e74794
> --- /dev/null
> +++ b/t/t4018/swift-init
> @@ -0,0 +1,7 @@
> +class Foo {
> +    init(RIGHT: Int) {
> +        let value = RIGHT
> +        // a comment
> +        print(ChangeMe)
> +    }
> +}

Again "RIGHT" twice in a harmful way.

All other test cases look good.

> diff --git a/userdiff.c b/userdiff.c
> index b5412e6bc3..df37dd78a6 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -362,6 +362,16 @@ PATTERNS("scheme",
>  	 "\\|([^|\\\\]|\\\\.)*\\|"
>  	 /* All other words should be delimited by spaces or parentheses. */
>  	 "|([^][)(}{ \t])+"),
> +PATTERNS("swift",
> +	 "^[ \t]*((@[A-Za-z_][A-Za-z0-9_]*(\\([^()]*\\))?[ \t]+)*([a-z]+[ \t]+)*(func|init|deinit|subscript|class|struct|enum|protocol|extension|actor)[ \t(?!<].*)$",

This looks good.

Notice, however, how the regular expression matcher has to backtrack on
even simple lines such as

class foo {

On the first attempt, [a-z]+ matches "class", but then "foo" does not
match. On the next attempt, the clause with [a-z]+ matches zero times
and the next clause matches "class" and, in total, successfully.

It may be worth considering to enumerate all keywords and permit any run
of them:

	(public|final|etc.|func|init|...|actor)[ \t(?!<]+)+

It does not matter that this would match any assemblement of keywords;
they wouldn't occur in correct Swift code anyway. (Or would they?)

> +	 /* -- */
> +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> +	 /* hexadecimal, octal, and binary literals */
> +	 "|0[xX][0-9a-fA-F_]+|0[oO][0-7_]+|0[bB][01_]+"

You could just throw all of them into a single pattern like this:

	0[xXoObB][0-9a-fA-F_]+

except when, for example,

	0b1_abc

can occur in correct Swift code (perhaps the token 0b1 followd by the
token _abc).

> +	 /* integers and floating-point numbers */
> +	 "|[0-9][0-9_]*([.][0-9_]+)?([eE][-+]?[0-9]+)?"

Ok. Is ".5" a correct floating-point number? If so, it would not be
caught by this regular expression? But it wouldn't be particularly
harmful, either, to leave it as is. The ".5" would just be parsed as two
tokens, "." and "5".

> +	 /* unary and binary operators */
> +	 "|[-+*/%<>=!&|^~?]=?|&&|\\|\\||<<=?|>>=?|\\?\\?|\\.\\.[.<]|->"),

You do not have to account for single-character operators; they are
automatic. Drop the "?" from the first "=?".

These are my comments on the technical side. Since I do not speak Swift,
I cannot comment on how reasonable your choice which lines to pick out is.

-- Hannes

