Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F5C3F9FB
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 03:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758165624; cv=none; b=IONR3JTDs8YlEG6zrAOfAxGh385/a2wxLgYFsUQUTuEnOoR3gI6n01imiUqAg9mxH7VpjxlxeBFoweIDDaNPOEUwESZMtpXODeIiQbLq3hLfGLMc0Y5PuHpJmU1JJgr5J3aodgqGAjptHgoGuXW7Z9UrTHaBaJr//F9O9nbsi3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758165624; c=relaxed/simple;
	bh=qoIbfkOZsc75qe1Gihk6YU3ZZtLu9DugOsNDVWBMCb8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=Te2lsl0cRrfRqLETojXp7byZ9reAwnLeyFO7D68H+J+k5BS3DDwpGZtckOprg96zbiA7k7bySrldYwgdguassoBPGlUdcrbaNbgjb9e0/e+3uU8TV30cnN1w1nJDmQOu0Bz/vvqsG+yphPxatK438eS1oR8afBj0K4/AVZ5dnOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 58I3KAnM949782
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Sep 2025 03:20:10 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>
Cc: "'Patrick Steinhardt'" <ps@pks.im>, <git@vger.kernel.org>
References: <01c101dc2842$38903640$a9b0a2c0$@nexbridge.com> <20250918022912.GA1135133@coredump.intra.peff.net>
In-Reply-To: <20250918022912.GA1135133@coredump.intra.peff.net>
Subject: RE: [Change] Git build issue on NonStop
Date: Wed, 17 Sep 2025 23:20:05 -0400
Organization: Nexbridge Inc.
Message-ID: <01c601dc284b$24496400$6cdc2c00$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQGqevxo+KmTuwcnT1oackIBbO80YQIfRj6EtOqlSNA=
X-Antivirus: Norton (VPS 250917-4, 9/17/2025), Outbound message
X-Antivirus-Status: Clean

On September 17, 2025 10:29 PM, Jeff King wrote:
>On Wed, Sep 17, 2025 at 10:16:13PM -0400, rsbecker@nexbridge.com wrote:
>
>> Just a quick FYI. The addition of uintptr_t in clar tests has broken
>> my CI build on NonStop x86. I will be fixing this locally. It may =
take
>> a patch series unless a quick workaround is possible, which I am
>> hoping.
>>
>> For those on the list from my platform who are monitoring, this looks
>> like -D__NSK_OPTIONAL_TYPES__ is now required for the build. I am
>> unsure what else may be needed.
>
>We use uintptr_t in lots of places in the regular code. I guess this =
bit in
>compat/posix.h is what makes it work:
>
>  #ifdef NO_INTPTR_T
>  /*
>   * On I16LP32, ILP32 and LP64 "long" is the safe bet, however
>   * on LLP86, IL33LLP64 and P64 it needs to be "long long",
>   * while on IP16 and IP16L32 it is "int" (resp. "short")
>   * Size needs to match (or exceed) 'sizeof(void *)'.
>   * We can't take "long long" here as not everybody has it.
>   */
>  typedef long intptr_t;
>  typedef unsigned long uintptr_t;
>  #endif
>
>But clar has its own compatibility layer. So it would need to do =
something similar. I
>see the clar line in question also uses PRIxPTR, which I can imagine =
might not be
>available everywhere either. We don't use that ourselves at all.
>
>I kind of wonder if just:
>
>diff --git a/t/unit-tests/clar/clar.c b/t/unit-tests/clar/clar.c index
>80c5359425..f408af850f 100644
>--- a/t/unit-tests/clar/clar.c
>+++ b/t/unit-tests/clar/clar.c
>@@ -875,8 +875,8 @@ void clar__assert_equal(
> 		void *p1 =3D va_arg(args, void *), *p2 =3D va_arg(args, void *);
> 		is_equal =3D (p1 =3D=3D p2);
> 		if (!is_equal)
>-			p_snprintf(buf, sizeof(buf), "0x%"PRIxPTR" !=3D
>0x%"PRIxPTR,
>-				   (uintptr_t)p1, (uintptr_t)p2);
>+			p_snprintf(buf, sizeof(buf), "0x%"PRIuMAX" !=3D
>0x%"PRIuMAX,
>+				   (uintmax_t)p1, (uintmax_t)p2);
> 	}
> 	else {
> 		int i1 =3D va_arg(args, int), i2 =3D va_arg(args, int);
>
>would be sufficient.

Yes, it would work. uintmax_t is part of the standard set while =
uintptr_t is
considered an extension. Not my decision on this grouping. I'm setting
the -D in CFLAGS to see if that works, I would be fine going that way,=20
although better would be adding it into config.uname.mak in the NONSTOP
section.

