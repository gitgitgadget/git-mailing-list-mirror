Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94D4C145A11
	for <git@vger.kernel.org>; Thu,  8 Aug 2024 18:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142620; cv=none; b=KiZy3ib01V8PsC3G4dQ22A4ZaAKN9Mg3iIi8n3F0mQwiE9YjgLUCXbU2eBgL60RMT2n+UkG5ZAZfHmbbUCmhmLyzzqaNdkgf8ytJWdPfVtgmc7T+wTO9ZyGf7dpeptHjKU8/4DSszf3wug/IREfbzTtr5jcVb44JqHEhUsC7AQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142620; c=relaxed/simple;
	bh=AUeePISR6uqeqIhj7hgTOfnLU6S2+zYhjfF18FBscJI=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=VuwzfgifmDsyI/6HzkQS54uep4xCpVD3zVufTbKPXilBDdtg6NQnDISLP0bMI6/OYwnSjLXcGVDHaVGKqh6WR6vpBUBZaLqkI8l5OHyqgaatdTG/qVRu3LLbANjaII80xfrBUms8zlMPb1YjYZwIWhhJG6Ng/3/5yo9JUUHe6V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 478IhSFn723356
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 8 Aug 2024 18:43:29 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Josh Steadmon'" <steadmon@google.com>
Cc: "'brian m. carlson'" <sandals@crustytoothpaste.net>, <git@vger.kernel.org>,
        <calvinwan@google.com>, <spectral@google.com>,
        <emilyshaffer@google.com>, <emrass@google.com>
References: <cover.1723054623.git.steadmon@google.com> <9a846c17c891e17566a9907b3627210a6a08ea76.1723054623.git.steadmon@google.com> <ZrPlQRAGQDMnVGjo@tapette.crustytoothpaste.net> <0a4601dae912$68d8e920$3a8abb60$@nexbridge.com> <zrbylipleb7fd7jrlnsampufeiuyiw2suwvd3tuxqoukhz6h52@dnjr7urrwzn3> <0a8401dae924$c9e8e9b0$5dbabd10$@nexbridge.com> <bs36iyp3yzb5l52t6yw5364odvugrt22jfeypqohtzdwp22ecj@kurf4p62qibu>
In-Reply-To: <bs36iyp3yzb5l52t6yw5364odvugrt22jfeypqohtzdwp22ecj@kurf4p62qibu>
Subject: RE: [RFC PATCH 3/6] contrib/cgit-rs: introduce Rust wrapper for libgit.a
Date: Thu, 8 Aug 2024 14:43:23 -0400
Organization: Nexbridge Inc.
Message-ID: <00d901dae9c2$dc9c29c0$95d47d40$@nexbridge.com>
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
Thread-Index: AQFCbSOmiEaObceWJ7X+ogZKpSpqSAGPn9K4AelD3ekBSZ9iqwHkOcN8AlLsGwwBugQaPLL5Da7Q
Content-Language: en-ca

On Thursday, August 8, 2024 1:13 PM, Josh Steadmon wrote:
>On 2024.08.07 19:51, rsbecker@nexbridge.com wrote:
>> On Wednesday, August 7, 2024 7:08 PM, Josh Steadmon wrote:
>> >On 2024.08.07 17:40, rsbecker@nexbridge.com wrote:
>> >> On Wednesday, August 7, 2024 5:21 PM, brian m. carlson wrote:
>> >> >On 2024-08-07 at 18:21:28, Josh Steadmon wrote:
>> >> >> Introduce cgit-rs, a Rust wrapper crate that allows Rust code to
>> >> >> call functions in libgit.a. This initial patch defines build
>> >> >> rules and an interface that exposes user agent string getter
>> >> >> functions as a proof of concept. A proof-of-concept library
>> >> >> consumer is provided in contrib/cgit-rs/src/main.rs. This
>> >> >> executable can be run with `cargo run`
>> >> >>
>> >> >> Symbols in cgit can collide with symbols from other libraries
>> >> >> such as libgit2. We avoid this by first exposing library symbols
>> >> >> in public_symbol_export.[ch]. These symbols are prepended with
"libgit_"
>> >> >> to avoid collisions and set to visible using a visibility pragma.
>> >> >> In build.rs, Rust builds contrib/cgit-rs/libcgit.a, which also
>> >> >> contains libgit.a and other dependent libraries, with
>> >> >> -fvisibility=hidden to hide all symbols within those libraries
>> >> >> that haven't been exposed with a visibility pragma.
>> >> >
>> >> >I think this is a good idea.  It's optional and it allows us to
>> >> >add functionality as we go along.  Platforms that don't have Rust
>> >> >can just
>> omit
>> >building it.
>> >> >
>> >> >> +[dependencies]
>> >> >> +libc = "0.2.155"
>> >> >
>> >> >I don't love that we're using libc here.  It would be better to
>> >> >use rustix because that provides safe APIs that are compatible
>> >> >with POSIX, but I think for now we need this because rustix
>> >> >doesn't offer memory management like free(3).  I'd really prefer
>> >> >that we didn't have to do memory management in Rust, but maybe
>> >> >that can come in with a
>> >future series.
>> >>
>> >> This is a good point. Libc is not portable, but because I can't
>> >> build with RUST anyway, I hope that libc is restricted to this
>> >> facility if used. It should not be included in the git C build. It
>> >> is probably moot for me anyway for this series, but I have to
>> >> mention it in case
>> anyone else
>> >gets the idea to include it as a dependency for git C.
>> >
>> >I know you don't have access to Rust, but would you be able to test
>> >the
>> symbol
>> >visibility steps with `make contrib/cgit-rs/libcgit.a`?
>>
>> Of course. Branch? URI?
>
>https://github.com/steadmon/git/tree/cgit-dev

I got to:

ld -r contrib/cgit-rs/public_symbol_export.o libgit.a reftable/libreftable.a
xdiff/lib.a -o contrib/cgit-rs/partial_symbol_export.o
/usr/bin/c89: illegal option -- r

The -r option is not supported on NonStop. I think we had discussed this.

