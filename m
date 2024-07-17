Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B1E17F378
	for <git@vger.kernel.org>; Wed, 17 Jul 2024 13:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721221927; cv=none; b=odowQ2i/FOYyfm18OORhjJws5ZkpynudR2pR6OLsP4iZFGEgyplkkN6GvSmBsdAuZdJMGB4ICw/MHuLeapsfqS8VIRVGCujaCWDwHOJfhqoj1u+C5OaUDk1aMi/AExBeGZgDuaLy4rLohcOQlC+3BJYzOZxOPBEDzH0Y8GYZ/90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721221927; c=relaxed/simple;
	bh=DhR9ChggrCvrgiocpmZQFahGJqWNtSTzqfTXgYujOos=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=qEVhozDuKe5w691YxUHEbHadwhxRznECBI056owfJ69QVX3J3NIA39iws/EF7tJ6RK73wiOVCbbPxC0C3emXUfItwH99W6/VXLE4TSGGml0PMY8UyYCh4ovn98YvUtPZ3XwRwpktNubvdnGToXhS17ijw5XqBfiNTazS2gjlwZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-12-196.cpe.net.cable.rogers.com [99.228.12.196])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 46HDBxAt820491
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jul 2024 13:12:00 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Jeff King'" <peff@peff.net>, "'Junio C Hamano'" <gitster@pobox.com>
Cc: <git@vger.kernel.org>
References: <024201dad543$877221e0$965665a0$@nexbridge.com> <xmqqv818aezm.fsf@gitster.g> <20240714070558.GA575927@coredump.intra.peff.net> <20240717070050.GG547635@coredump.intra.peff.net>
In-Reply-To: <20240717070050.GG547635@coredump.intra.peff.net>
Subject: RE: [PATCH] t4153: stop redirecting input from /dev/zero
Date: Wed, 17 Jul 2024 09:11:53 -0400
Organization: Nexbridge Inc.
Message-ID: <01f501dad84a$e8e014f0$baa03ed0$@nexbridge.com>
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
Thread-Index: AQJckAmmCZK41Ze1gwmoqh/WdA7U+QGrrguYATpsQYwBWg9fDbDVdBGA

On Wednesday, July 17, 2024 3:01 AM, Jeff King wrote:
>On Sun, Jul 14, 2024 at 03:05:58AM -0400, Jeff King wrote:
>
>> With --retry I think we would not actually read stdin at all, so we
>> could just remove the mention of /dev/zero entirely. But if we wanted
>> to be sure it did not read and choke on any input provided, I think =
just:
>>
>> diff --git a/t/t4153-am-resume-override-opts.sh
>> b/t/t4153-am-resume-override-opts.sh
>> index a4d0c03ca6..76783bdd67 100755
>> --- a/t/t4153-am-resume-override-opts.sh
>> +++ b/t/t4153-am-resume-override-opts.sh
>> @@ -45,6 +45,7 @@ test_expect_success '--3way overrides --no-3way' '
>>
>>  	# Applying side1 with am --3way will succeed due to the =
threeway-merge.
>>  	# Applying side2 will fail as --3way does not apply to it.
>> +	echo garbage |
>>  	test_must_fail git am --retry --3way &&
>>  	test_path_is_dir .git/rebase-apply &&
>>  	test side1 =3D "$(cat file2)"
>> @@ -99,7 +100,8 @@ test_expect_success '--reject overrides =
--no-reject' '
>>  	test_path_is_dir .git/rebase-apply &&
>>  	test_path_is_missing file.rej &&
>>
>> -	test_must_fail git am --retry --reject </dev/zero &&
>> +	echo garbage |
>> +	test_must_fail git am --retry --reject &&
>>  	test_path_is_dir .git/rebase-apply &&
>>  	test_path_is_file file.rej
>>  '
>
>Looking at the history, the use of /dev/zero was not here to simulate =
garbage on
>stdin. It really was just meant to be a descriptor which never ran out =
of input, as a
>workaround for test_terminal. This is described in the commit mentioned =
below.
>
>So I think we should just do this, which can go on top of jk/am-retry. =
I still do not
>think it is super-urgent, but given the simplicity of the fix is =
probably worth doing
>for the upcoming v2.46, which exposes these tests to more platforms.

Might not be urgent but without this we cannot pass this test on NonStop =
and I'm assuming other non-linux systems.
Thanks,
--Randall

