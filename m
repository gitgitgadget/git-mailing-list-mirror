Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28E02572
	for <git@vger.kernel.org>; Fri,  2 Aug 2024 01:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722563492; cv=none; b=jSxj4WnpnLlVzzkgPCvWyiJDYkmzgjFWWlUiXmlLZecaJGxHXdNxsqj/BwEloeMNYqyC/j5dYH5LsSMOABitI1n/ip4bW9w+FDeKA+8pgBNRRcq5aG3C5AWEEVHjgnMnEnmTqNRZ593YyNiAQZSQ4mQHv82kNfw22nprB9Zw0sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722563492; c=relaxed/simple;
	bh=nTjLJ9a4AIrkOiHRZnU3Bi/QMaKN6rUKdKsQ/wD7UMk=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ajh81vchaBa+8aVynHhVkqTq+eZqRgehI37I793M3YyDR5cNNAAczMvOZnn4bGbvhI0YEMh/G1OCJFkouAjJfdG1NLrHRKePpGtdWGt82xnleOWrWA1KW0Knn+UOicafWgrjwPtwB14ctSR7d04nlbp3JtlQyK9tk5AaH9X6tbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 4721pRTl3567430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 2 Aug 2024 01:51:28 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Taylor Blau'" <me@ttaylorr.com>
Cc: <git@vger.kernel.org>
References: <02d301dae43d$2202fc90$6608f5b0$@nexbridge.com> <ZqvgmYl8BTYvsSa0@nand.local> <032201dae461$c7bcc9d0$57365d70$@nexbridge.com> <ZqwvQUAqVozGHG/t@nand.local>
In-Reply-To: <ZqwvQUAqVozGHG/t@nand.local>
Subject: RE: [BUG] 2.46.0 t7701.09 fails on NonStop ia64
Date: Thu, 1 Aug 2024 21:51:21 -0400
Organization: Nexbridge Inc.
Message-ID: <033801dae47e$7d3a5cc0$77af1640$@nexbridge.com>
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
Thread-Index: AQIp93LlMAXo5OzQ9HEGtsfRK+e3MwGmTwJBAbmv8+0Ce5iwkLFGMKeg

On Thursday, August 1, 2024 8:59 PM, Taylor Blau wrote:
>On Thu, Aug 01, 2024 at 06:25:51PM -0400, rsbecker@nexbridge.com wrote:
>> ls output with second resolution is here - the file system does not =
have
>nanosecond resolution despite showing zeros:
>>
>> /home/ituglib/randall/git/t/trash
>> directory.t7704-repack-cruft/max-cruft-size-prune/.git/objects/pack:
>> ls -la --full-time total 11 drwxrwxrwx 1 ITUGLIB.RANDALL ITUGLIB 4096 =
2024-08-
>01 16:18:55.000000000 -0600 .
>> drwxrwxrwx 1 ITUGLIB.RANDALL ITUGLIB 4096 2024-08-01
>16:18:48.000000000 -0600 ..
>> -r--r--r-- 1 ITUGLIB.RANDALL ITUGLIB 1156 2024-08-01
>> 16:18:52.000000000 -0600
>> pack-68c6c8c8538900694c32380ac1484201c8b60d8d.idx
>> -r--r--r-- 1 ITUGLIB.RANDALL ITUGLIB  217 2024-08-01 =
16:18:52.000000000 -
>0600 pack-68c6c8c8538900694c32380ac1484201c8b60d8d.pack
>> -r--r--r-- 1 ITUGLIB.RANDALL ITUGLIB   64 2024-08-01 =
16:18:52.000000000 -
>0600 pack-68c6c8c8538900694c32380ac1484201c8b60d8d.rev
>
>Ah, I suspect that this is even less interesting than imprecise mtime =
resolution. The
>test expects that the packs are larger than 1M so that we can exercise =
writing
>multiple cruft packs as part of the setup.
>
>But that pack is only 217 bytes, which wouldn't trigger the split. I'm =
suspicious that
>it's even packing the cruft objects at all, so I'm curious if you can =
find $foo, $bar,
>and $baz in the cruft pack's .idx file(s, if multiple) after the first =
'git repack -d --cruft'.
>
>Assuming they are there, it's possible that setting repack.cruftWindow =
in the test
>repository would do the trick.
>
>But I'm suspicious that that's even what's going on since =
generate_random_blob()'s
>first argument is a seed, and all three objects have different seeds, =
so I don't think
>they would even be considered good delta candidates for one another. =
But it's also
>possible that your
>generate_random_blob() behaves differently from my own.

I will try to look tomorrow for $foo, $bar, and $baz. On =
generate_random_blob(), from OpenSSL's standpoint, on ia64, we use =
PRNGD. It should be of the same order of magnitude as anywhere else, but =
depends on the randomness measure - we are able to start it, so =
randomness is proper. On my x86 machine, I use the hardware randomizer, =
which is better (and FIPS compatible) and might be why we don't see it =
there.

