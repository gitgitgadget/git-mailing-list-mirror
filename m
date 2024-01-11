Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [172.105.110.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B28110C
	for <git@vger.kernel.org>; Thu, 11 Jan 2024 01:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ecKnhgfg"
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (3072 bits) server-digest SHA256)
	(No client certificate requested)
	by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 02F585A3A1;
	Thu, 11 Jan 2024 01:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1704938199;
	bh=6lD08WYZ549pElwtN+iZ9es2SZascfLLNZ18WcgtACc=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ecKnhgfgJIoRM42J53XJD8prfGXJOPBTT294N891wGHQ5n/5EChOHcwZcKCjH8Yyp
	 BawAonJYJ6JHRV0lwiiIbqyWJd+zFIVlxMBxSDE1uA6JNTNqGO1TfTiBefeMdyompy
	 k8lvXmTv/KkTij9jAp1iAk5PHQ1Q3JgXgepqDlKrdLAQfhN5IJforLgcHjUqYbnEjP
	 5BtbYOPWMjhmQgdnfGO+hq6nmWu9Uy1AuId6ue2GFcmR984C9QXen+bgvGekGtzwOg
	 2Wnm4V0LoV6VFpQ6dAHBYT52TIxvU/HX22UI0Efc19RuhrgvvNzPOcxbSHA6LyFafx
	 0lx9p6HzqVZHfheA+8fOsAU4ZYmDQrwlnEbBFsGGQiVyBOM/E0U90JPVxKN0jozymE
	 xi0MTH4I8MMmCkNbgRrtdQx6N7e+FY+VAo05u3DOT2FruN+ZmNLKifYrO1b9zh2dbk
	 Nlh0RssyWDg8bWjeOxBs7pAJ161uLWFMr66MVJuNIKCMnX07oY5
Date: Thu, 11 Jan 2024 01:56:36 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [DISCUSS] Introducing Rust into the Git project
Message-ID: <ZZ9K1CVBKdij4tG0@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
References: <ZZ77NQkSuiRxRDwt@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XsOTL3VjFAa8IWyV"
Content-Disposition: inline
In-Reply-To: <ZZ77NQkSuiRxRDwt@nand.local>
User-Agent: Mutt/2.2.12 (2023-09-09)


--XsOTL3VjFAa8IWyV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-01-10 at 20:16:53, Taylor Blau wrote:
> Over the holiday break at the end of last year I spent some time
> thinking on what it would take to introduce Rust into the Git project.
>=20
> There is significant work underway to introduce Rust into the Linux
> kernel (see [1], [2]). Among their stated goals, I think there are a few
> which could be potentially relevant to the Git project:
>=20
>   - Lower risk of memory safety bugs, data races, memory leaks, etc.
>     thanks to the language's safety guarantees.
>=20
>   - Easier to gain confidence when refactoring or introducing new code
>     in Rust (assuming little to no use of the language's `unsafe`
>     feature).

I agree with both of these points.  We've found that making our code
thread safe in Git is hard and it's much easier in Rust, because, for
the most part, the code doesn't compile if it would have a data race.
Unit tests are also easy and built-in, and I think that's a major
advantage.

We also get nice things for free, like sets, maps, lists, and a variety
of other collections that are all type-safe.  Error handling is also a
huge benefit: we'll get typed errors with the ability to pass data back.

>   - Contributing to Git becomes easier and accessible to a broader group
>     of programmers by relying on a more modern language.

I think this can't be understated.  One of the biggest hurdles for
people contributing is that our code requires expert knowledge of C.  We
do all sorts of weird things with pointer arithmetic that even I have
trouble understanding, and I'd really appreciate not having to worry
about memory leaks or freeing resources.[0]  Rust has nice things like the
Drop trait that make resource management easy.

Rust is also a language that people _want_ to use.  I really like it and
would probably contribute more if Git were in it.  I don't really want
to write more C, and outside of Git, won't use it on more than a de
minimis basis unless paid.

I can confirm that, having partially ported our service that serves Git
traffic to Rust from C (without the public having noticed), it's a much
nicer environment to work in.  I'm also much more efficient at making
changes as well.

> Given the allure of these benefits, I think it's at least worth
> considering and discussing how Rust might make its way into Junio's
> tree.

A couple of things which I think are worth discussing are as follows:

The Rust project emits a new release every six weeks and doesn't provide
LTS versions.  What versions of Rust are supported by crates vary
widely, and we'll absolutely need to choose our dependencies wisely.  We
may also want to ask crate authors if they'll be willing to commit to
our version policy before using them; oftentimes, that can work.

The approach that I aim for is supporting the version of Rust in the
latest Debian stable, plus the version in Debian's previous stable
release until the latest stable has been out for a year.  (Thus, if
Debian 12 was released on 2023-06-10, then I'd support Rust 1.48, Debian
11's version, until 2024-06-10, and then support would move to 1.63,
Debian 12's version.)  This provides about three years of support for a
compiler version, which I think is fair.

Note that none of this means that we're dropping support for older
systems; newer versions of Rust will be available for most targets,
even often after OSes go end of life.

We'll also probably need to continue to rely on some C libraries.  For
example, reqwest, the main Rust HTTP client, doesn't support any
authentication other than Basic, and I assure you from my experience as
the Git LFS maintainer, we don't want to implement things like NTLM and
Kerberos on our own.  libcurl is almost certainly going to continue to
be a dependency, as will PCRE.  The Rust regex crate doesn't support
backreferences, and we've basically tied lots of our regexes to POSIX,
so we'll need to either rely on PCRE or some call out to a
POSIX-compatible interface.  gettext is likely to be another issue,
although its thread-safety is potentially a problem; we could try using
the `tr` crate instead, which also provides a Rust-specific string
ripper.

> I imagine that the transition state would involve some parts of the
> project being built in C and calling into Rust code via FFI (and perhaps
> vice-versa, with Rust code calling back into the existing C codebase).
> Luckily for us, Rust's FFI provides a zero-cost abstraction [3], meaning
> there is no performance impact when calling code from one language in
> the other.

Moreover, there are even ways to generate Rust bindings for C code and C
headers for Rust code automatically.  (These are cbindgen and bindgen,
respectively.)  I've used both, and while it's clearly an FFI case, it's
still very ergonomic.

> Some open questions from me, at least to get the discussion going are:
>=20
>   1. Platform support. The Rust compiler (rustc) does not enjoy the same
>      widespread availability that C compilers do. For instance, I
>      suspect that NonStop, AIX, Solaris, among others may not be
>      supported.
>=20
>      One possible alternative is to have those platforms use a Rust
>      front-end for a compiler that they do support. The gccrs [4]
>      project would allow us to compile Rust anywhere where GCC is
>      available. The rustc_codegen_gcc [5] project uses GCC's libgccjit
>      API to target GCC from rustc itself.

I think this is probably the biggest stumbling point.  I know GCC is
highly portable and works on AIX, as well as virtually every
architecture.  gccrs is still incomplete, but I believe
rustc_codegen_gcc is mature, and should be a viable option for most
platforms.  (Solaris is already supported on Rust[1].)

My main concerns are with NonStop, since the Rust standard library
requires threading and a CSPRNG (although that can definitely be RDRAND,
and is for some targets).  I seem to recall that neither GCC nor LLVM
are present there, although I see no reason why GCC could not be ported
(LLVM lacks support for ia64, I believe, which would make it a bigger
lift)

I suspect that if we go forward, though, a lot of the work for
architecture support in Rust upstream will already have been done, since
I'm pretty sure the Debian porters for architectures like alpha, hppa,
and ia64 are going to want to continue to use Git.  NetBSD porters may
also have useful patches in pkgsrc.

I am also very sympathetic to the difficulties of running on less common
systems, having had a PowerPC Mac running Linux as my first laptop and
several UltraSPARC machines.  I have sent in numerous patches to a wide
variety of code so that it works gracefully on lots of architectures,
and I've also dealt with lots of broken software.  I do, however, think
it's up to the porters of an OS to keep it running and healthy, and that
means making sure it has suitable compiler toolchains for building,
including for modern, extremely popular languages like Rust and Go.  I'm
okay with dropping support for systems where nobody upstream wants to or
is capable of maintaining that tooling.

I actually feel that once Rust is running on a system, it's actually
easier to write portable code, since you don't have alignment issues and
endianness must be handled explicitly, and most safe Rust code just
works out of the box.

>   2. Migration. What parts of Git are easiest to convert to Rust? My
>      hunch is that the answer is any stand-alone libraries, like
>      strbuf.h. I'm not sure how we should identify these, though, and in
>      what order we would want to move them over.

strbuf.h is tricky because it uses variadic arguments, which are not
stable in Rust.  My approach would be to start by getting the main
function up and running, and then we can incrementally port things over.

We could, for example, use the `sha256` crate for our SHA-256 code
(which would also dynamically use accelerated hardware implementations
where available).  There are other things which are libraries which
could well work, though.  Porting over our hashmap implementation might
be a thing to do, for example.  The repository structure might also be
a good idea, since that will allow us to write safe wrappers for its
contents.

>   3. Interaction with the lib-ification effort. There is lots of work
>      going on in an effort to lib-ify much of the Git codebase done by
>      Google. I'm not sure how this would interact with that effort, but
>      we should make sure that one isn't a blocker for the other.

I think it's going to work together nicely.  We can and should consider
building a C library from Rust to expose a lot of what we write.

Also, in my view, the biggest enemy to libification in our codebase is
our copious and improvident use of globals.  Mutating static variables
in Rust is unsafe, so as part of the port, we'll need to get rid of
them, which seems like a nice common goal.

> I'm curious to hear what others think about this. I think that this
> would be an exciting and worthwhile direction for the project. Let's
> see!

I'm very much in favour of this.  I think I brought it up at the
contributor's summit and it caught some attention, but I don't think it
should be too controversial and it will offer us a lot of advantages.

[0] And before people say, "Well, you just need to spend more time with
C," I've been writing it since I was 10 and I think we can all agree
that with the SHA-256 work I've spent plenty of time with it.
[1] rustc --print target-list is a great way to see what's supported.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--XsOTL3VjFAa8IWyV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.3 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZZ9K1AAKCRB8DEliiIei
gQMiAQCqYTZypAw6P8FaRBANf/S40T5/UZepD0fumqGXtLrd4AEA+LrA+XpOXJVQ
xs6kBZxJCAXMb2PFO4Wpff71soKrOQQ=
=C5aA
-----END PGP SIGNATURE-----

--XsOTL3VjFAa8IWyV--
