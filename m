Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9120E482E4
	for <git@vger.kernel.org>; Wed, 10 Jan 2024 21:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="TO2RMcl6"
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1704923841;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dh6P2Tiombn4g07vf+3Vo31HSUH83u2cZEKUvJqIuaI=;
	b=TO2RMcl6n2IAdIt0CvunZEM+TQzQ3+8P3+Ztrt4oJmJ0y+5LYQenl5tCvmfDcAtlvMvqRq
	d4BYGKLVYdpLv+J1rfYmCOtywr1TA0yhHvnpYZzVaN533Lb8IOtxCWA5aXCoEpeml4gMqW
	5CPabqQWZuTsEO9DmfMGXaXlPnLHQiwAL1JBrcXR9D4Zs5QIjmGZUHK3lkmnver7Oqkz2q
	t1GsX8cAmH8WiYaA4+QGdskxk/00QEqgDsFokr0QevzDYhGZvYc6sdHDMSE7mVDc0Bp6eM
	iwJk8DCEZdazsHDMeZdTfJubbD0sDIQX/RsQuhbOD+mWZUnUmYIQJiw/uHkB9A==
Date: Wed, 10 Jan 2024 22:57:21 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [DISCUSS] Introducing Rust into the Git project
In-Reply-To: <ZZ77NQkSuiRxRDwt@nand.local>
References: <ZZ77NQkSuiRxRDwt@nand.local>
Message-ID: <b2651b38a4f7edaf1c5ffee72af00e46@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

On 2024-01-10 21:16, Taylor Blau wrote:
> Over the holiday break at the end of last year I spent some time
> thinking on what it would take to introduce Rust into the Git project.
> 
> There is significant work underway to introduce Rust into the Linux
> kernel (see [1], [2]). Among their stated goals, I think there are a 
> few
> which could be potentially relevant to the Git project:
> 
>   - Lower risk of memory safety bugs, data races, memory leaks, etc.
>     thanks to the language's safety guarantees.
> 
>   - Easier to gain confidence when refactoring or introducing new code
>     in Rust (assuming little to no use of the language's `unsafe`
>     feature).
> 
>   - Contributing to Git becomes easier and accessible to a broader 
> group
>     of programmers by relying on a more modern language.
> 
> Given the allure of these benefits, I think it's at least worth
> considering and discussing how Rust might make its way into Junio's
> tree.

Quite frankly, that would only complicate things and cause 
fragmentation.  The goal of introducing Rust into the Linux kernel is 
to, possibly, have some new "leafs" written in Rust, such as some new 
device drivers.  No existing kernel code, AFAIK, has been planned to be 
rewritten in Rust.

Thus, Git should probably follow the same approach of not converting the 
already existing code, but frankly, I don't see what would actually be 
the "new leafs" written in Rust.

> I imagine that the transition state would involve some parts of the
> project being built in C and calling into Rust code via FFI (and 
> perhaps
> vice-versa, with Rust code calling back into the existing C codebase).
> Luckily for us, Rust's FFI provides a zero-cost abstraction [3], 
> meaning
> there is no performance impact when calling code from one language in
> the other.
> 
> Some open questions from me, at least to get the discussion going are:
> 
>   1. Platform support. The Rust compiler (rustc) does not enjoy the 
> same
>      widespread availability that C compilers do. For instance, I
>      suspect that NonStop, AIX, Solaris, among others may not be
>      supported.
> 
>      One possible alternative is to have those platforms use a Rust
>      front-end for a compiler that they do support. The gccrs [4]
>      project would allow us to compile Rust anywhere where GCC is
>      available. The rustc_codegen_gcc [5] project uses GCC's libgccjit
>      API to target GCC from rustc itself.
> 
>   2. Migration. What parts of Git are easiest to convert to Rust? My
>      hunch is that the answer is any stand-alone libraries, like
>      strbuf.h. I'm not sure how we should identify these, though, and 
> in
>      what order we would want to move them over.
> 
>   3. Interaction with the lib-ification effort. There is lots of work
>      going on in an effort to lib-ify much of the Git codebase done by
>      Google. I'm not sure how this would interact with that effort, but
>      we should make sure that one isn't a blocker for the other.
> 
> I'm curious to hear what others think about this. I think that this
> would be an exciting and worthwhile direction for the project. Let's
> see!
> 
> Thanks,
> Taylor
> 
> [1]: https://rust-for-linux.com/
> [2]:
> https://lore.kernel.org/rust-for-linux/20210414184604.23473-1-ojeda@kernel.org/
> [3]:
> https://blog.rust-lang.org/2015/04/24/Rust-Once-Run-Everywhere.html#c-talking-to-rust
> [4]: https://github.com/Rust-GCC/gccrs
> [5]: https://github.com/rust-lang/rustc_codegen_gcc
