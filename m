Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0546584D25
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 21:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723066839; cv=none; b=rUfmJrcZWYAGCACFywxVX4vSUjAFAgKeJdBZSjBIWUSuGRIszV0LyphYO6AgslJA5h2c8CdlRo/A2hIhmRO1uscWoDhGvMvaeu25QrDlhY94Xzu7/xr9NVky1agFNXHFnWHGhHmA9gfDGUZdblStIH4pcE++nN5IZFSUmC6q1U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723066839; c=relaxed/simple;
	bh=BZckS5Jdn+G3cU3/giZv/iWkmdSYtSxHDIylZeSgAWQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=dGytKwNzsFuUASlv2dACCqzWEaeZN8lhdF1R4yQ9SsiKRhztD9l/MJt+lfZhS1hJ2O2gaBcWKnRhGTFqA+WA1yrmf91WfjkucdlJn9qV0OZLrrECRkLZQf26z59q10puoHSGsiGdJFoI5LlPWFKtuALDgsVGdY7jyHOoqib4CZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 477LeN5t514381
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Aug 2024 21:40:23 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Josh Steadmon'" <steadmon@google.com>
Cc: <git@vger.kernel.org>, <calvinwan@google.com>, <spectral@google.com>,
        <emilyshaffer@google.com>, <emrass@google.com>
References: <cover.1723054623.git.steadmon@google.com> <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com> <ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net>
In-Reply-To: <ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net>
Subject: RE: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for libgit.a
Date: Wed, 7 Aug 2024 17:40:17 -0400
Organization: Nexbridge Inc.
Message-ID: <0a4601dae912$68d8e920$3a8abb60$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFCbSOmiEaObceWJ7X+ogZKpSpqSAGPn9K4AelD3emzMYKC8A==

On Wednesday, August 7, 2024 5:21 PM, brian m. carlson wrote:
>On 2024-08-07 at 18:21:28, Josh Steadmon wrote:
>> Introduce cgit-rs, a Rust wrapper crate that allows Rust code to call
>> functions in libgit.a. This initial patch defines build rules and an
>> interface that exposes user agent string getter functions as a proof
>> of concept. A proof-of-concept library consumer is provided in
>> contrib/cgit-rs/src/main.rs. This executable can be run with `cargo
>> run`
>>
>> Symbols in cgit can collide with symbols from other libraries such as
>> libgit2. We avoid this by first exposing library symbols in
>> public_symbol_export.[ch]. These symbols are prepended with "libgit_"
>> to avoid collisions and set to visible using a visibility pragma. In
>> build.rs, Rust builds contrib/cgit-rs/libcgit.a, which also contains
>> libgit.a and other dependent libraries, with -fvisibility=3Dhidden to
>> hide all symbols within those libraries that haven't been exposed =
with
>> a visibility pragma.
>
>I think this is a good idea.  It's optional and it allows us to add =
functionality as we go
>along.  Platforms that don't have Rust can just omit building it.
>
>> +[dependencies]
>> +libc =3D "0.2.155"
>
>I don't love that we're using libc here.  It would be better to use =
rustix because that
>provides safe APIs that are compatible with POSIX, but I think for now =
we need this
>because rustix doesn't offer memory management like free(3).  I'd =
really prefer that
>we didn't have to do memory management in Rust, but maybe that can come =
in
>with a future series.

This is a good point. Libc is not portable, but because I can't build =
with RUST anyway,
I hope that libc is restricted to this facility if used. It should not =
be included in the
git C build. It is probably moot for me anyway for this series, but I =
have to mention it
in case anyone else gets the idea to include it as a dependency for git =
C.

>libc also comes with the downside that it calls the actual libc =
functions, so you have
>to write things like stat64 on Linux if you want a 64-bit stat, but =
that doesn't exist
>on some of the BSDs, so you have to write something else and compile it
>conditionally, and all of that makes the portability of it worse than =
with C.
>
>In any event, I have the intention to send a patch to replace libc with =
rustix in the
>future if this series lands.
>
>> diff --git a/contrib/cgit-rs/public_symbol_export.c
>> b/contrib/cgit-rs/public_symbol_export.c
>> new file mode 100644
>> index 0000000000..3d1cd6cc4f
>> --- /dev/null
>> +++ b/contrib/cgit-rs/public_symbol_export.c
>> @@ -0,0 +1,20 @@
>> +// Shim to publicly export Git symbols. These must be renamed so =
that
>> +the // original symbols can be hidden. Renaming these with a
>> +"libgit_" prefix also // avoid conflicts with other libraries such =
as libgit2.
>> +
>> +#include "contrib/cgit-rs/public_symbol_export.h"
>> +#include "version.h"
>> +
>> +#pragma GCC visibility push(default)
>
>I assume this also works in clang?
>--
>brian m. carlson (they/them or he/him)
>Toronto, Ontario, CA

