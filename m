Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF25841760
	for <git@vger.kernel.org>; Wed,  8 Apr 2026 23:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775690118; cv=none; b=NQN/v9r5q9UANqZ4xv50tfypFAd29JFu1Ey8cSI4pGAPOldiMqdC6ZhBE7UB+k6vh/Y3Rn6o8TvnO6aad5teG728OrxQoP7XRqyE2J8BNJLxkLY+TQgpixVE9abX75pBC23xPgJJdzX4sDUqbAaYnrct6kcDep5I6qq3YO1Nhs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775690118; c=relaxed/simple;
	bh=INAsO4J9WTQyvthw8ocK/rDAi50ThFbjg1WTT6x4COw=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=joiG/ZigLdEe0bwgmQqlznbHCH0wkKaK4Zn9YXCDagmNk9lt8b1Vv9OIaGwgeVJDacERTYSbNgNIH2y9GIe52Te6NeIHZNLCI6haWK87ANjfdAyXf3VrdeL/gzou+IPpfhbmY+qDe1Rmpwu7W5IE5hHvJqfpBMjNl8gLswHhHHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 638NFASS3385422
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 8 Apr 2026 23:15:11 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Junio C Hamano'" <gitster@pobox.com>, "'Patrick Steinhardt'" <ps@pks.im>
Cc: "'Jeff King'" <peff@peff.net>, <git@vger.kernel.org>
References: <00f401dcc6e6$7183c0f0$548b42d0$@nexbridge.com>	<20260408041716.GA1324339@coredump.intra.peff.net>	<011701dcc767$8c2ab400$a4801c00$@nexbridge.com>	<013301dcc774$5e9fffb0$1bdfff10$@nexbridge.com>	<20260408173949.GB2850002@coredump.intra.peff.net>	<xmqq4illz5g9.fsf@gitster.g>	<014e01dcc793$8a9bab90$9fd302b0$@nexbridge.com>	<xmqqqzopxkxa.fsf@gitster.g>	<016b01dcc79e$87472860$95d57920$@nexbridge.com>	<xmqqcy09xh53.fsf@gitster.g> <xmqqzf3dw0o8.fsf@gitster.g> <xmqqv7e1w05u.fsf@gitster.g>
In-Reply-To: <xmqqv7e1w05u.fsf@gitster.g>
Subject: RE: Git 2.54.0-rc1, subtests of t5310, t5326, t5327
Date: Wed, 8 Apr 2026 19:15:05 -0400
Organization: Nexbridge Inc.
Message-ID: <018701dcc7ad$8c3addd0$a4b09970$@nexbridge.com>
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
Thread-Index: AQIImllt8JGdGqh7Bu9hfV8wd5a54AFtvwh7AomCUMsCTyy1LAGZ2yzlAlGDzHcBlyeC0wIgPQjWAstiUjQB3KW4kAFISRoMAX2ghZO002uk4A==
X-Antivirus: Norton (VPS 260408-8, 4/8/2026), Outbound message
X-Antivirus-Status: Clean

On April 8, 2026 6:35 PM, Junio C Hamano wrote
>Junio C Hamano <gitster@pobox.com> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> To be quite honest, I am not sure if it is even worth using writev()
>>> if we need a loop that protects against shrot writes, so unless I am
>>> grossly mistaken (e.g., perhaps there is some guarantee that there
>>> won't be any short writes for writev() that sends data smaller than
>>> 64k that I missed in the docs), the best course of action might be to
>>> revert the change to use writev() and use the two write(2)s as
>>> before, *if* we actually observe that the current code is broken by
>>> short writes.
>>
>> Ah, sorry, I should have double checked the actual code.  We already
>> use a looping writev_in_full() that wraps writev(), so there is
>> nothing extra that we still need to do to prepare for short writes.
>>
>> Unfortunately, comparing write_in_full() vs writev_in_full(), there is
>> nothing that corresponds to xwrite() that can be used to hide the
>> short writes and chomps an originally larger I/O into smaller pieces.
>
>Oops, the beauty of having xwrite() is *not* that it hides short writes (it
doesn't),
>but it can be used to pretend that short writes happened on platforms with
>unreasonably small I/O limit by setting MAX_IO_SIZE to unusually low.  But
the
>point that ...
>
>> Unlike write() that we may receive a single linear large sequence of
>> bytes, which we can choose to chomp into artificially smaller pieces
>> and write them out (up to 8MB by default), writev() API lets the
>> caller to prepare chunks of memory and I do not think there is a good
>> way for the writev_in_full() at the lower layer to chomp these into
>> smaller pieces, and even if we could, that would defeat the whole
>> reason why we rewrote the original code that used
>> write_in_full() into using writev(), i.e., to avoid extra allocation
>> (and extra system calls---but if your I/O layer is limited to very
>> small writes, no matter how we chop it, you will have to issue extra
>> system calls to flush all of the data out).
>>
>> So, I dunno.
>
>... I doubt that there exists a good way to have xwritev() that wraps
around writev()
>and pretend that a short write happened, instead of issuing a large I/O,
still stands.

I am partial to Peff's runtime approach, personally.

If it helps (probably does not), the limit is due to the DMA/VMM limits on
the
hardware. The NonStop Message system is blindingly fast when sending
messages around between processes on other CPUs - far faster than I have
seen
on most other platforms. But there are physical limits in the chipset. It is
interesting
to use it in an abstracted way, like hacking the TCP/IP stack to pass
handles around.

