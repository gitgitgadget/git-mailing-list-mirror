Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 799AF51C4C
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 21:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709067972; cv=none; b=fBAQN9d2Mai5eQPQFssWPnIBfYZcUHiJ6BM97zt0CtpM35uKkUBBFXQ/fLwcOiyZyOAIQsBL2We+vJd7ghbKMgIWF6rczx87YyFjKURvSGJIKVGv9GnaTWQfO0MtXTI/JuX4CE0rplT+zudRlze5gFGl4sF+b7rS8r/UFBY7X5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709067972; c=relaxed/simple;
	bh=Zs/mIdj1f8eF8rIQCfP/3SCqeOIRl9PVk3r/3lUgPqQ=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=X5hEp67g1nq28lHCnfjGepLiolJ2uR4X9Jj263mFjt6pwWALPXm+SdjFUuD0ZWUDAAEbPzu6cWqee35coI55h/l513kRTbjOEarFZICfFPdGK1vvdjiyQLjlj4wfjkuwx+MsZZuP6PC5b+HLvsBzUQR1Zb93Mi+IY9WHt+pviDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 41RL5wnr2442683
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Feb 2024 21:05:58 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>
Cc: "'Junio C Hamano'" <gitster@pobox.com>,
        "'Randall S. Becker'" <the.n.e.key@gmail.com>, <git@vger.kernel.org>
References: <20240227150934.7950-1-randall.becker@nexbridge.ca> <20240227150934.7950-4-randall.becker@nexbridge.ca> <xmqq1q8xspht.fsf@gitster.g> <03be01da69af$d8366e10$88a34a30$@nexbridge.com> <20240227192530.GD3784114@coredump.intra.peff.net>
In-Reply-To: <20240227192530.GD3784114@coredump.intra.peff.net>
Subject: RE: [PATCH v2 3/3] builtin/unpack-objects.c: change xwrite to write_in_full avoid truncation.
Date: Tue, 27 Feb 2024 16:05:53 -0500
Organization: Nexbridge Inc.
Message-ID: <03d701da69c0$c3430e80$49c92b80$@nexbridge.com>
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
Thread-Index: AQGTtmWLBzH5H5YYc4gTr69qQSdMrgGN4n36AkbyxfoCMiicNgKbFmsPsWbqctA=

On Tuesday, February 27, 2024 2:26 PM, Peff wrote:
>To: rsbecker@nexbridge.com
>Cc: 'Junio C Hamano' <gitster@pobox.com>; 'Randall S. Becker' =
<the.n.e.key@gmail.com>; git@vger.kernel.org
>Subject: Re: [PATCH v2 3/3] builtin/unpack-objects.c: change xwrite to =
write_in_full avoid truncation.
>
>On Tue, Feb 27, 2024 at 02:04:46PM -0500, rsbecker@nexbridge.com wrote:
>
>> >> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
>> >> index e0a701f2b3..6935c4574e 100644
>> >> --- a/builtin/unpack-objects.c
>> >> +++ b/builtin/unpack-objects.c
>> >> @@ -680,7 +680,7 @@ int cmd_unpack_objects(int argc, const char
>> >> **argv, const char *prefix UNUSED)
>> >>
>> >>  	/* Write the last part of the buffer to stdout */
>> >>  	while (len) {
>> >> -		int ret =3D xwrite(1, buffer + offset, len);
>> >> +		int ret =3D write_in_full(1, buffer + offset, len);
>> >>  		if (ret <=3D 0)
>> >>  			break;
>> >>  		len -=3D ret;
>> [...]
>> I experimented with using write_in_full vs. keeping xwrite. With
>> xwrite in this loop, t7704.9 consistently fails as described in the
>> other thread. With write_in_full, the code works correctly. I assume
>> there are side-effects that are present. This change is critical to
>> having the code work on NonStop. Otherwise git seems to be at risk of
>> actually being seriously broken if unpack does not work correctly. I
>> am happy to have my series ignored as long as the problem is =
otherwise corrected.
>
>I'm somewhat skeptical that this code is to blame, as it should be run =
very rarely at all; it is just dumping any content in the pack stream
>after the end of the checksum to stdout. But in normal use by Git, =
there is no such content in the first place.
>
>If I do this:
>
>diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c index =
e0a701f2b3..affe55035d 100644
>--- a/builtin/unpack-objects.c
>+++ b/builtin/unpack-objects.c
>@@ -680,11 +680,7 @@ int cmd_unpack_objects(int argc, const char =
**argv, const char *prefix UNUSED)
>
> 	/* Write the last part of the buffer to stdout */
> 	while (len) {
>-		int ret =3D xwrite(1, buffer + offset, len);
>-		if (ret <=3D 0)
>-			break;
>-		len -=3D ret;
>-		offset +=3D ret;
>+		BUG("cruft at the end of the pack!");
> 	}
>
> 	/* All done */
>
>then t7704 still passes, as it does not run this code at all. In fact, =
nothing in the test suite fails. Which is not to say we should get rid =
of
>those code. If we were writing today we might flag it as an error, but =
we should keep it for historical compatibility.
>
>But I do not see any bug in the code, and nor do I think it could =
contribute to a test failure.

I have obviously gone down the wrong path trying to resolve this =
situation. Please consider this entire series dropped with my apologies =
for the time-waste.

Unfortunately, I do not have sufficient knowledge of the code to resolve =
the originally reported problem without further assistance to determine =
the root case (assuming it still is a problem). Changes in master =
post-2.44.0 appear to have contributed to resolving the situation, so I =
am now getting random pass/fail on the test. I'm going to hold 2.44.0 on =
ia64 and wait for a subsequent release at retest at that time.

Sadly,
--Randall

