Received: from bsmtp5.bon.at (bsmtp5.bon.at [195.3.86.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2490D7081F
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 08:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.3.86.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768553415; cv=none; b=FfgCc/PVhnHxIw0xouLtBJxVTCVuxkwkERnY2ZVkppfJaiCE6kc7wEJmkRW8Nh+O9He8wacB9Xxe62g6xN22qVcz2cpASagB0Vxw6/5bqqBedHpeVvxt50iKQdvJlPTn/mYQoMiVPXFWdZc3MVlndM1nCOPlgXKE0gv7JkgZ8bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768553415; c=relaxed/simple;
	bh=5QGzlLEDpIEc505KBKAEMZlqbAjIl9aR5qTNQy60Agk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6hDr1r9JzanjQpmhYnGETRJihYpUCAQUgmpAsJVAQNVey+wKixMM7klKersGJ4+f1NbD3vWP/d8fnelEQlixEZJb34cDgnkRkH+SUQ42ky5bYHjnS1OMw+SzKDOgmFKK37ckSraAX0zEZY03BUfgyTXgpqfesapRxzXpzR39FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=195.3.86.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from bsmtp2.bon.at (unknown [192.168.181.105])
	by bsmtp5.bon.at (Postfix) with ESMTPS id 4dstpN5HbBz7Qb4X
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 09:50:04 +0100 (CET)
Received: from [192.168.0.103] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4dstpC370DzRnlX;
	Fri, 16 Jan 2026 09:49:55 +0100 (CET)
Message-ID: <3243b63b-b0c1-42d5-beeb-df42b891f09e@kdbg.org>
Date: Fri, 16 Jan 2026 09:49:54 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] userdiff: extend Scheme support to cover other
 Lisp dialects
To: "Scott L. Burson" <Scott@sympoiesis.com>
Cc: Junio C Hamano <gitster@pobox.com>,
 =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
 Jaydeep P Das <jaydeepjd.8914@gmail.com>,
 "D. Ben Knoble" <ben.knoble@gmail.com>, git@vger.kernel.org,
 "Scott L. Burson via GitGitGadget" <gitgitgadget@gmail.com>
References: <pull.2000.v2.git.1764211096.gitgitgadget@gmail.com>
 <pull.2000.v3.git.1768519120.gitgitgadget@gmail.com>
 <fb4c8dc5d4434deab9c8f1872f309a79351dc799.1768519120.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <fb4c8dc5d4434deab9c8f1872f309a79351dc799.1768519120.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 16.01.26 um 00:18 schrieb Scott L. Burson via GitGitGadget:
> From: "Scott L. Burson" <Scott@sympoiesis.com>
> 
> Common Lisp has top-level forms, such as 'defun' and 'defmacro', that
> are not matched by the current Scheme pattern.  Also, it is more
> common in CL, when defining user macros intended as top-level forms,
> to prefix their names with "def" instead of "define"; such forms are
> also not matched.  And some top-level forms don't even begin with
> "def".
> 
> On the other hand, it is an established formatting convention in the
> Lisp community that only top-level forms start at the left margin.  So
> matching any unindented line starting with an open parenthesis is an
> acceptable heuristic; false positives will be rare.
> 
> However, there are also cases where notionally top-level forms are
> grouped together within some containing form.  At least in the Common
> Lisp community, it is conventional to indent these by two spaces, or
> sometimes one.  But matching just an open parenthesis indented by two
> spaces would be too broad; so the pattern added by this commit
> requires an indented form to start with "(def".  It is believed that
> this strikes a good balance between potential false positives and
> false negatives.

The commit message doesn't mention the changes regarding the word-diff
pattern.  I would have prefered to have them in their own patch; it
would make the patch text less obscure about what it actually changes.

> 
> Signed-off-by: Scott L. Burson <Scott@sympoiesis.com>

> diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
> index f20041a323..a9ce5adef9 100644
> --- a/Documentation/gitattributes.adoc
> +++ b/Documentation/gitattributes.adoc
> @@ -912,6 +912,7 @@ patterns are available:
>  - `rust` suitable for source code in the Rust language.
>  
>  - `scheme` suitable for source code in the Scheme language.
> +Also handles Emacs Lisp, Common Lisp, and most other dialects.

Saying "most dialects" immediately begs the questions "which dialects
are not covered" and "is the dialect that I'm using covered". Let's
write it this way:

- `scheme` suitable for source code in the Lisp dialects including
  Scheme, Emacs Lisp, Common Lisp.

Note the indentation of the continuation line (see the 'bash' entry, for
example).

>  
>  - `tex` suitable for source code for LaTeX documents.
>  
> diff --git a/t/t4018/scheme-lisp-defun-a b/t/t4018/scheme-lisp-defun-a
> new file mode 100644
> index 0000000000..c3c750f76d
> --- /dev/null
> +++ b/t/t4018/scheme-lisp-defun-a
> @@ -0,0 +1,4 @@
> +(defun some-func (x y z) RIGHT
> +  (let ((a x)
> +        (b y))
> +        (ChangeMe a b)))

This also demonstrates that "(let" isn't picked up. Good.

> diff --git a/t/t4018/scheme-lisp-defun-b b/t/t4018/scheme-lisp-defun-b
> new file mode 100644
> index 0000000000..21be305968
> --- /dev/null
> +++ b/t/t4018/scheme-lisp-defun-b
> @@ -0,0 +1,4 @@
> +(macrolet ((foo (x) `(bar ,x)))
> +  (defun mumble (x) ; RIGHT
> +    (when (> x 0)
> +      (foo x)))) ; ChangeMe

Indented "(defun" overrides the earlier structure that begins in the
first column. Good.

> diff --git a/t/t4018/scheme-lisp-eval-when b/t/t4018/scheme-lisp-eval-when
> new file mode 100644
> index 0000000000..5d941d7e0e
> --- /dev/null
> +++ b/t/t4018/scheme-lisp-eval-when
> @@ -0,0 +1,4 @@
> +(eval-when (:compile-toplevel :load-toplevel :execute)  ; RIGHT
> +  (set-macro-character #\?
> +		       (lambda (stream char)
> +			 `(make-pattern-variable ,(read stream)))))  ; ChangeMe

Any structure beginning in the first column is picked up. Good.

> diff --git a/t/t4018/scheme-module b/t/t4018/scheme-module-a
> similarity index 100%
> rename from t/t4018/scheme-module
> rename to t/t4018/scheme-module-a
> diff --git a/t/t4018/scheme-module-b b/t/t4018/scheme-module-b
> new file mode 100644
> index 0000000000..77bc0c5eff
> --- /dev/null
> +++ b/t/t4018/scheme-module-b
> @@ -0,0 +1,6 @@
> +(module A
> +  (export with-display-exception)
> +  (extern (display-exception display-exception))
> +  (def (with-display-exception thunk) RIGHT
> +    (with-catch (lambda (e) (display-exception e (current-error-port)) e)
> +      thunk ChangeMe)))

module-a and module-b are basically the same text. module-b changes the
last line, so that "(def" is picked up, while module-a changes the
"(extern" line, so that "(module" is picked up. Good.

> diff --git a/t/t4034/scheme/expect b/t/t4034/scheme/expect
> index 138abe9f56..72592665f1 100644
> --- a/t/t4034/scheme/expect
> +++ b/t/t4034/scheme/expect
> @@ -6,7 +6,7 @@
>  (define (<RED>myfunc a b<RESET><GREEN>my-func first second<RESET>)
>    ; This is a <RED>really<RESET><GREEN>(moderately)<RESET> cool function.
>    (<RED>this\place<RESET><GREEN>that\place<RESET> (+ 3 4))
> -  (define <RED>|the greeting|<RESET><GREEN>|a greeting|<RESET> "hello")
> +  (define <RED>|the \greeting|<RESET><GREEN>|a \greeting|<RESET> |hello there|)
>    ({<RED>}<RESET>(([<RED>]<RESET>(func-n)<RED>[<RESET>]))<RED>{<RESET>})
>    (let ((c (<RED>+ a b<RESET><GREEN>add1 first<RESET>)))
>      (format "one more than the total is %d" (<RED>add1<RESET><GREEN>+<RESET> c <GREEN>second<RESET>))))

This tests backslash between vertical bars and non-greediness of the
pattern. Good.

Using the identifier "|the \| greeting|" could make the test even more
complete, I think.

> diff --git a/t/t4034/scheme/post b/t/t4034/scheme/post
> index 0e3bab101d..450cc234f7 100644
> --- a/t/t4034/scheme/post
> +++ b/t/t4034/scheme/post
> @@ -1,7 +1,7 @@
>  (define (my-func first second)
>    ; This is a (moderately) cool function.
>    (that\place (+ 3 4))
> -  (define |a greeting| "hello")
> +  (define |a \greeting| |hello there|)
>    ({(([(func-n)]))})
>    (let ((c (add1 first)))
>      (format "one more than the total is %d" (+ c second))))
> diff --git a/t/t4034/scheme/pre b/t/t4034/scheme/pre
> index 03d77c7c43..ba8b8ac0a4 100644
> --- a/t/t4034/scheme/pre
> +++ b/t/t4034/scheme/pre
> @@ -1,7 +1,7 @@
>  (define (myfunc a b)
>    ; This is a really cool function.
>    (this\place (+ 3 4))
> -  (define |the greeting| "hello")
> +  (define |the \greeting| |hello there|)
>    ({}(([](func-n)[])){})
>    (let ((c (+ a b)))
>      (format "one more than the total is %d" (add1 c))))
> diff --git a/userdiff.c b/userdiff.c
> index fe710a68bf..b5412e6bc3 100644
> --- a/userdiff.c
> +++ b/userdiff.c
> @@ -344,14 +344,24 @@ PATTERNS("rust",
>  	 "|[0-9][0-9_a-fA-Fiosuxz]*(\\.([0-9]*[eE][+-]?)?[0-9_fF]*)?"
>  	 "|[-+*\\/<>%&^|=!:]=|<<=?|>>=?|&&|\\|\\||->|=>|\\.{2}=|\\.{3}|::"),
>  PATTERNS("scheme",
> -	 "^[\t ]*(\\(((define|def(struct|syntax|class|method|rules|record|proto|alias)?)[-*/ \t]|(library|module|struct|class)[*+ \t]).*)$",
>  	 /*
> -	  * R7RS valid identifiers include any sequence enclosed
> -	  * within vertical lines having no backslashes
> +	  * An unindented opening parenthesis identifies a top-level
> +	  * expression in all Lisp dialects.
>  	  */
> -	 "\\|([^\\\\]*)\\|"
> -	 /* All other words should be delimited by spaces or parentheses */
> -	 "|([^][)(}{[ \t])+"),
> +	 "^(\\(.*)$\n"
> +	 /* For Scheme: a possibly indented left paren followed by a keyword. */
> +	 "^[\t ]*(\\(((define|def(struct|syntax|class|method|rules|record|proto|alias)?)[-*/ \t]|(library|module|struct|class)[*+ \t]).*)$\n"
> +	 /*
> +	  * For all Lisp dialects: a slightly indented line starting with "(def".
> +	  */
> +	 "^  ?(\\([Dd][Ee][Ff].*)$",
> +	 /*
> +	  * The union of R7RS and Common Lisp symbol syntax: allows arbitrary
> +	  * strings between vertical bars, including any escaped characters.
> +	  */
> +	 "\\|([^|\\\\]|\\\\.)*\\|"
> +	 /* All other words should be delimited by spaces or parentheses. */
> +	 "|([^][)(}{ \t])+"),
>  PATTERNS("tex", "^(\\\\((sub)*section|chapter|part)\\*{0,1}\\{.*)$",
>  	 "\\\\[a-zA-Z@]+|\\\\.|([a-zA-Z0-9]|[^\x01-\x7f])+"),
>  { .name = "default", .binary = -1 },

This change matches my expectations.

-- Hannes

