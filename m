Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFE42EB5CC
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 15:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753197272; cv=none; b=GFMQ8oVmLq1JRJfTG+W+CcFd4u/BRpcjs2F/+JSj69CHbuCG5+VVQwP4GxuTA2S+kBe0suyo8Jzhr0rD/uFAGUbmtWm8L5SbwM3C6Y8babsuPRshv74KiBME7nwcrh8VqkWh4yR0xjnF29yXiuPl/h2Ay4SjJ39a7o2Q3qTEePg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753197272; c=relaxed/simple;
	bh=wV7W8iG0umpLLGLBcOTZk++Dp32iJVPUS41jACsHDgU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kumEVlNpE1iNYadm4l/RR6x9RiKmHjCu4H7lgg4Me4O2f53NFxWSlnAuWmk9dIuZgv5vwO5uy09qf2+ZNoAx0ch5Dz1QmIl3yLSbqo43t31KsjWvqVxh9qtkuLgZN2GTXnkk7S2AzB8KH9R+5rO217aUxaw8SZ0Om1XfJH83mrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from [IPV6:2603:6011:3f0:6f00::12ac] (unknown [IPv6:2603:6011:3f0:6f00::12ac])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: eschwartz)
	by smtp.gentoo.org (Postfix) with ESMTPSA id C0BC6340E0F;
	Tue, 22 Jul 2025 15:14:25 +0000 (UTC)
Message-ID: <4bb0e99a-0c0d-49e4-82f8-02443a7f6783@gentoo.org>
Date: Tue, 22 Jul 2025 11:14:21 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 Edward Thomson <ethomson@edwardthomson.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Taylor Blau <me@ttaylorr.com>
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <f439958d-64ce-417f-8175-720f69387d48@gmail.com>
 <79c1b3ab-af2e-4c93-b033-349221d82ad9@gentoo.org> <aH-fDEX7gdpALJ6w@pks.im>
Content-Language: en-US
From: Eli Schwartz <eschwartz@gentoo.org>
Autocrypt: addr=eschwartz@gentoo.org; keydata=
 xjMEZmeRNBYJKwYBBAHaRw8BAQdAYNZ7pUDWhx1i2f3p6L2ZLu4FcY18UoeGC04Gq/khqwfN
 I0VsaSBTY2h3YXJ0eiA8ZXNjaHdhcnR6QGdlbnRvby5vcmc+wpYEExYKAD4WIQTvUdMIsc4j
 CIi+DYTqQj6ToWND8QUCZoRL+gIbAwUJBKKGAAULCQgHAwUVCgkICwUWAgMBAAIeBQIXgAAK
 CRDqQj6ToWND8aB5AP9r4kB691nNtNwKkdRiOdl7/k6WYzokvHvDamXxRJ0I+gEAjZqR5V8y
 mfR3fy2Z+r2Joeqdt3CIv5IwPs64spBvigLOOARmZ5E0EgorBgEEAZdVAQUBAQdATT46Z06b
 1X9xjXFCYFxmq/Tj3tSEKZInDWTpoHQp4l8DAQgHwn4EGBYKACYWIQTvUdMIsc4jCIi+DYTq
 Qj6ToWND8QUCZmeRNAIbDAUJBKKGAAAKCRDqQj6ToWND8a2RAP40KPfbfoiZAJW5boFmFJ3G
 TUBDJRh9CWHyaPqq2PN+0wD/R07oLzfnJUN209mzi9TuTuHjeZybysyqXSw4MAxkMAY=
In-Reply-To: <aH-fDEX7gdpALJ6w@pks.im>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------8VQT0HM4N7QAqzuzCDq7AGkx"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------8VQT0HM4N7QAqzuzCDq7AGkx
Content-Type: multipart/mixed; boundary="------------zMc0f2ucVXMXI6IqRIDxCIum";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@gentoo.org>
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood <phillip.wood123@gmail.com>,
 Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
 git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
 Ezekiel Newren <ezekielnewren@gmail.com>,
 Edward Thomson <ethomson@edwardthomson.com>,
 "brian m. carlson" <sandals@crustytoothpaste.net>,
 Taylor Blau <me@ttaylorr.com>
Message-ID: <4bb0e99a-0c0d-49e4-82f8-02443a7f6783@gentoo.org>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <f439958d-64ce-417f-8175-720f69387d48@gmail.com>
 <79c1b3ab-af2e-4c93-b033-349221d82ad9@gentoo.org> <aH-fDEX7gdpALJ6w@pks.im>
In-Reply-To: <aH-fDEX7gdpALJ6w@pks.im>

--------------zMc0f2ucVXMXI6IqRIDxCIum
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 7/22/25 10:24 AM, Patrick Steinhardt wrote:
> On Fri, Jul 18, 2025 at 05:25:01PM -0400, Eli Schwartz wrote:

>> For Gentoo HPPA, Alpha, m68k it will simply mean the removal (or end o=
f
>> life and staying forever on 2.50, perhaps) of Git. There is no rust
>> compiler there.
>>
>> Even s390 support for rust is limited to a precompiled version not
>> everyone is willing to use.
>>
>> GCC-rs will probably fix this general issue.
>=20
> Hm. It would be nice to assemble a list of common or semi-common
> distributions that do not have proper support for Rust for all or at
> least some platforms. Should we maybe consider reaching out to other
> distros (e.g. Debian, Fedora, BSDs) before we commit to any change that=

> has an outsized impact on the larger ecosystem?
>=20
> I would really love to start adopting Rust, and if it's only going to b=
e
> architectures that are extremely niche I'm probably fine with that. But=

> if there are many small systems that are impacted by such a change we
> might have to reconsider.
>=20
> Meh :/


To elaborate a bit w.r.t. Gentooo.

Gentoo Prefix-on-macOS and Prefix-on-Solaris don't support rust either.
I think at least macOS is reasonably popular. Obviously Rust supports
macOS, and the Prefix maintainer would like it to work but hasn't been
able to -- no idea why. Arguably you can tell these users "install a
better OS so you can use git".

musl has lots of issues with rust, and is disabled for Gentoo musl
editions on arm (not arm64), ppc, i686, m68k, mips. Arguably you can
tell these users "musl sucks, why are you using it, use glibc like a
sensible person".

i486 is entirely disabled due to mandatory sse2. Hopefully those users
are rare even compared to i686 users. ;)

s390 only works on s390x

sparc 64ul works, but 32ul does not.

riscv rv64gc works, rv32imac does not.

A general trend here is 32-bit issues.


For alpha/hppa, no references at all -- not even tier 3 support -- on
https://doc.rust-lang.org/beta/rustc/platform-support.html, and Gentoo
doesn't support LLVM there either. ;) In general, porting rustc to a new
arch means *first* porting LLVM, and then after that, *also* porting
rustc, so who's going to try the latter before the former? ;)

Hence the interest in GCC-rs, which already has a backend supporting all
this for C/C++/Fortran plus interest by users of these arches in a
portable rust compiler.

If rust is added and doesn't have a fallback C impl, all this becomes a
relevant topic for consideration. (I don't have strong opinions on
optional rust.)


=2E..


See

$ git clone https://github.com/gentoo/gentoo && cd gentoo
$ git grep --name-only features/wd40 profiles/| grep -v 17.0


(wd40 is the inheritance tree for disabling all features in any package
that rely on a rust compiler. See README at
https://github.com/gentoo/gentoo/tree/master/profiles/features/wd40 for
details)

--=20
Eli Schwartz

--------------zMc0f2ucVXMXI6IqRIDxCIum--

--------------8VQT0HM4N7QAqzuzCDq7AGkx
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQTnFNnmK0TPZHnXm3qEp9ErcA0vVwUCaH+qzgUDAAAAAAAKCRCEp9ErcA0vV8Sp
AP9+xtlub7zwE/WE5nJlPylhTVelAyT2HGbXa+o7Sscz0gD/V7rLqtUnET3WSha6u/jBf1fTVZia
SKHmLSur+EUIUgw=
=Vz8t
-----END PGP SIGNATURE-----

--------------8VQT0HM4N7QAqzuzCDq7AGkx--
