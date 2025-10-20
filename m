Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546BB302777
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 17:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.33.87.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760981100; cv=none; b=eQ+YGihzw3hjNyCN8aDIREeEyxd3SX3++DneUHxsmak5a10jyupsPMsCqpkv0ziPEFfkwROGheg+0wpHJEsQ6ZhYn+6VzDg82iZoAqExNI1i7TI4Gtg+dIfDuEL+wr+N2pUroG2SVoHYk2aj1hHCuYGusoy3K6YYbYO4LGe9K4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760981100; c=relaxed/simple;
	bh=2t/ukAqiPHzbf9yBCOT2AaRD22Uj2XbsBvBzNB/O4nM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HiYL5PuWfebZ4e8ke3/1CohW7sxsge2YcEMs2MHQ8DCud2r3wGMz9qhz9MNrDeALpBnynSygi8NGnGKlrFCn+Qb8c7F8otGfIDau88W0vWWXBahvHWj7LxYz653Iike17iSxgh9ObHeGv2k7dMoY4OcVVdaKl0lNPcZ4in0tIJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org; spf=pass smtp.mailfrom=kdbg.org; arc=none smtp.client-ip=213.33.87.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.104] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4cr2Nw2GqjzRpKq;
	Mon, 20 Oct 2025 19:24:48 +0200 (CEST)
Message-ID: <01e65d25-33de-4025-b3c1-52dc7d58fc27@kdbg.org>
Date: Mon, 20 Oct 2025 19:24:47 +0200
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] t7500: fix tests with absolute path following
 ":(optional)" on Windows
Content-Language: en-US
To: Junio C Hamano <gitster@pobox.com>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
 Noah Pendleton <noah.pendleton@gmail.com>, Patrick Steinhardt <ps@pks.im>,
 Phillip Wood <phillip.wood123@gmail.com>, Thranur Andul <thranur@gmail.com>,
 Michael Grosser <grosser.michael@gmail.com>,
 Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
References: <20250501214057.371711-1-gitster@pobox.com>
 <cover.1759094936.git.ben.knoble+github@gmail.com>
 <6a83c7d1-7cd4-432e-a0ab-7b18ce3af08d@kdbg.org> <xmqqh5vt1rb0.fsf@gitster.g>
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <xmqqh5vt1rb0.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 20.10.25 um 18:17 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Existing test cases that expect that the specified file does not exist
>> are not incorrect (after all, git.exe will not find /c/dir/template).
>> Yet, they are conceptually incorrect.
> 
> Wow, if I am counting correctly, the oldest one is from July 2007,
> and we have been running these tests without anybody noticing?
> That's just ... wow.

Obviously, I didn't do a great job in explaining the situation. It isn't
*that* bad.

Before the invention of the ":(optional)" prefix, the tests are totally
fine, because /c/dir/template or /c/dir/notexist always appear as an
isolated command line argument. Then they are translated to
C:/dir/template and C:/dir/notexist as expected.

The tests become wrong-in-spirit only in combination with the
":(optional)" prefix, because now the MSYS layer sees
":(optional)/c/dir/notexist", which is not an absolute path. Yet, all
tests with the ":(optional)" prefix before this patch still work as
expected, because all expect the path to not exist. And from git.exe's
point of view, /c/dir/notexist does not exist.

The new test case would fail if $PWD was used, because it expects that
the file exists, but MSYS does not translate
":(optional)/c/dir/template" to ":(optional)C:/dir/template". So, we
must do the translation in the test script itself by using $(pwd). For
consistency, all other test cases with the ":(optional)" should then use
$(pwd), too. All remaining test cases could keep using $PWD, but I
changed them to $(pwd) for even more consistency.

-- Hannes

