Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9031914EC55
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 23:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723074727; cv=none; b=Fv3GLq/FBm0/bv0znrNNajEDci7FHVDFe2wvUrGlDblFp4solwLTRE4z2CbidTcQUtuFbO227xIswlIuQ20/uedCrYrSti9dfuMWv/gXQkRoBVf5CNydla/hdNnKoeBa76XFsgyydC73YDbgvI2BkTavzG3e8iQNwdDljzZMg5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723074727; c=relaxed/simple;
	bh=5yKUzS9FZp7twHnVWXC9B0Go+ZwJXbZg44P70ClVmKI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=D+h0g68cjv6f/hqwVdpddb7bQ8oLFSp2ioz0X7Cq4jsoJBQsxjnn8XNRO/0RD0rt7rrAY+l4DJtBmMJRZNGeYpb7g4AeMgmlV7rmEdW2QXrjF9q0oITKpxwuV3OZVLaRrdq0RzcGcjP/9tESNyfYBlFR09GlAUzE1nI+V63iQqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 477NpudJ534958
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 7 Aug 2024 23:51:57 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Josh Steadmon'" <steadmon@google.com>
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>, <git@vger.kernel.org>,
        <calvinwan@google.com>, <spectral@google.com>,
        <emilyshaffer@google.com>, <emrass@google.com>
References: <cover.1723054623.git.steadmon@google.com> <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com> <ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net> <0a4601dae912$68d8e920$3a8abb60$@nexbridge.com> <zrbylipleb7fd7jrlnsampufeiuyiw2suwvd3tuxqoukhz6h52@dnjr7urrwzn3>
In-Reply-To: <zrbylipleb7fd7jrlnsampufeiuyiw2suwvd3tuxqoukhz6h52@dnjr7urrwzn3>
Subject: RE: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for libgit.a
Date: Wed, 7 Aug 2024 19:51:51 -0400
Organization: Nexbridge Inc.
Message-ID: <0a8401dae924$c9e8e9b0$5dbabd10$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFCbSOmiEaObceWJ7X+ogZKpSpqSAGPn9K4AelD3ekBSZ9iqwHkOcN8sxg5OtA=

On Wednesday, August 7, 2024 7:08 PM, Josh Steadmon wrote:
>On 2024.08.07 17:40, rsbecker@nexbridge.com wrote:
>> On Wednesday, August 7, 2024 5:21 PM, brian m. carlson wrote:
>> >On 2024-08-07 at 18:21:28, Josh Steadmon wrote:
>> >> Introduce cgit-rs, a Rust wrapper crate that allows Rust code to
>> >> call functions in libgit.a. This initial patch defines build rules
>> >> and an interface that exposes user agent string getter functions as
>> >> a proof of concept. A proof-of-concept library consumer is provided
>> >> in contrib/cgit-rs/src/main.rs. This executable can be run with
>> >> `cargo run`
>> >>
>> >> Symbols in cgit can collide with symbols from other libraries such
>> >> as libgit2. We avoid this by first exposing library symbols in
>> >> public_symbol_export.[ch]. These symbols are prepended with "libgit_"
>> >> to avoid collisions and set to visible using a visibility pragma.
>> >> In build.rs, Rust builds contrib/cgit-rs/libcgit.a, which also
>> >> contains libgit.a and other dependent libraries, with
>> >> -fvisibility=hidden to hide all symbols within those libraries that
>> >> haven't been exposed with a visibility pragma.
>> >
>> >I think this is a good idea.  It's optional and it allows us to add
>> >functionality as we go along.  Platforms that don't have Rust can just
omit
>building it.
>> >
>> >> +[dependencies]
>> >> +libc = "0.2.155"
>> >
>> >I don't love that we're using libc here.  It would be better to use
>> >rustix because that provides safe APIs that are compatible with
>> >POSIX, but I think for now we need this because rustix doesn't offer
>> >memory management like free(3).  I'd really prefer that we didn't
>> >have to do memory management in Rust, but maybe that can come in with a
>future series.
>>
>> This is a good point. Libc is not portable, but because I can't build
>> with RUST anyway, I hope that libc is restricted to this facility if
>> used. It should not be included in the git C build. It is probably
>> moot for me anyway for this series, but I have to mention it in case
anyone else
>gets the idea to include it as a dependency for git C.
>
>I know you don't have access to Rust, but would you be able to test the
symbol
>visibility steps with `make contrib/cgit-rs/libcgit.a`?

Of course. Branch? URI?

