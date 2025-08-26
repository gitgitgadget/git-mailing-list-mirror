Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB7B3208
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231529; cv=none; b=Lhk/2NJGcFLKOCvW4pqYNVZ/oGoCNM50bZMXZ7qIBYOT0lnogBHQwYl6JNdPg2ZJ0K/7NV2yEpt4FoNZ64MQDNMeB+OPhLCEwKsd5N+fDU+5NNqxl+UxP3eF0lS9ta55R0aNU6LbaxYQArjySZTPX8h39ykNXvZGK6ULhvjfY3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231529; c=relaxed/simple;
	bh=vsl4RZ1pUSRPnebMwM6J2yIzBxDZFhHRZgWev/iOnV8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=WIU4uQf4A9ZlOFdy+Gl2JgW1YJhRgcTwj+L1f8DP+4+jH/MWWA7uuXNjsYsEIXC4o1w1Z4mFmdg2U497u3f25A4VnyhZLMOKu5ZPPVkEDgv0fCgTyZ0OTcVIimi6O9j4/qC6rp7Ik3/DADzZIXJqauohcjlONZMwvC5NXylifL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 57QI5LWS4054998
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Aug 2025 18:05:21 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Kyle Lippincott'" <spectral@google.com>
Cc: "'David Aguilar'" <davvid@gmail.com>,
        "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>,
        "'Ezekiel Newren'" <ezekielnewren@gmail.com>,
        "'Josh Steadmon'" <steadmon@google.com>,
        "'Calvin Wan'" <calvinwan@google.com>
References: <20250826160437.2539113-1-davvid@gmail.com> <CAO_smVjviMdpZyHFp4zJc62DJYAZxLAc5yw68C3U+c5wbwRziA@mail.gmail.com> <014b01dc16b2$4a1dd0d0$de597270$@nexbridge.com> <CAO_smViKBsfzvqAfu587V_FXp=OPgu3yeO-P8qw19jgwizuUhg@mail.gmail.com>
In-Reply-To: <CAO_smViKBsfzvqAfu587V_FXp=OPgu3yeO-P8qw19jgwizuUhg@mail.gmail.com>
Subject: RE: [PATCH] Makefile: build libgit-rs and libgit-sys serially
Date: Tue, 26 Aug 2025 14:05:16 -0400
Organization: Nexbridge Inc.
Message-ID: <014f01dc16b3$fdcc8b70$f965a250$@nexbridge.com>
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
Thread-Index: AQFwjz3pQA+GbovpDjmi3ET08E4BLgKAL7GiAd+7DAoCZiUUj7UWGNfg
X-Antivirus: Norton (VPS 250826-4, 8/26/2025), Outbound message
X-Antivirus-Status: Clean

On August 26, 2025 2:03 PM, Kyle Lippincott wrote:
>On Tue, Aug 26, 2025 at 10:53=E2=80=AFAM <rsbecker@nexbridge.com> =
wrote:
>>
>> On August 26, 2025 1:45 PM, Kyle Lippincott wrote:
>> >On Tue, Aug 26, 2025 at 9:04=E2=80=AFAM David Aguilar =
<davvid@gmail.com> wrote:
>> >>
>> >> The "cargo build" invocations in contrib/ cannot be run in =
parallel.
>> >>
>> >> "make -JN" with INCLUDE_LIBGIT_RS enabled causes cargo lock
>> >> warnings and can trigger ld errors during the build.
>> >>
>> >> The build errors are caused by two inner "make" invocations =
getting
>> >> triggered concurrently: once inside of libgit-sys and another
>> >> inside of libgit-rs.
>> >>
>> >> Signed-off-by: David Aguilar <davvid@gmail.com>
>> >> ---
>> >>  Makefile | 2 +-
>> >>  1 file changed, 1 insertion(+), 1 deletion(-)
>> >>
>> >> diff --git a/Makefile b/Makefile
>> >> index 29a53520fd..286d3ba3b2 100644
>> >> --- a/Makefile
>> >> +++ b/Makefile
>> >> @@ -3989,7 +3989,7 @@ libgit-sys libgit-rs:
>> >>                 cargo build \
>> >>         )
>> >>  ifdef INCLUDE_LIBGIT_RS
>> >> -all:: libgit-sys libgit-rs
>> >> +all:: libgit-sys .WAIT libgit-rs
>> >
>> >I'm not familiar enough with make or with rust, but do we need to
>> >depend on both of these here? Wouldn't it be sufficient to say
>> >libgit-rs depends on libgit-sys, and only explicitly depend on =
libgit-rs in `all::`?
>>
>> Not all platforms can build libgit-rs, so inserting it into as a
>> required component is not a particularly friendly idea.
>>
>
>That's not what I was suggesting. This is already in an `ifdef`, and =
the line I was
>quoting was changing `all:: libgit-sys libgit-rs` to
>`all:: libgit-sys .WAIT libgit-rs`. I'm wondering if we can instead =
split the `libgit-sys
>libgit-rs:` from a few lines earlier into `libgit-sys:` and `libgit-rs: =
libgit-sys` and then
>change this all line to `all:: libgit-rs` (still behind `ifdef =
INCLUDE_LIBGIT_RS`).

Thank you. I appreciate this and the clarity it provides.

Randall

