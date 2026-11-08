Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.33.87.16
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794128075;
	b=4m/xHLbmWNZCFiW3CRUxqYUNYkYTWTND2shLRvM0gUtdHSOlVLnA7FSndXdJpLAojOzL
	 zVegOtqxKwaQXxBWyt2bdZ+cz375ZwY496+bkIf1BTzlveVav/oX9DifDhjDaRmT/bBDi
	 aQWTq7/K+EeYizJ4NkI1OzV4t9yfsxiPwNx9+Vd8xuj1ev42rhfIk0wFm7TlocIcOyYQw
	 jBIyrYHQWIYEwpfO162sv15f6KS7SbdznONlvPtJPKisRXWkVPoWaVBjc9cX3RJM4Ypur
	 IAuvrBRXLT/6j6nfxNTaPDMwCTkLb0q92c2pVpBkMm9iAH2oeySaDJyJkvxaWV4ibWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794128075;
	h=DMARC-Filter:Received:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Ru433nnsNfgFBEI1XD/hY0WzuaSIIehrpx6T5HJnOkU=;
	b=Gl62A7z5yzRvgpRM9hFHQqsrS9ZDkfTBgGtMg5KFGAuUDmva+EOh3g7pIp9atxGu5eNi
	 Hmg2zAEWbjlugKLi2auXOb4YgJXEIt+RGyUKQhcvc10NOO1+eGtkzkUj7DXAlaqrGF4HJ
	 b0sIkmwf7sPhqpyI6UF6xPNkUVJBNKRaxXudzyUgXHFGl+bAsxueb/TUcLpBwygFCVjyG
	 pN3y8B/HeSBKZJ0BLNBGnQPhc/a71NCOh41gOqg719FEswKGBrA370IXjxuOWqmGSOkKY
	 cVSDrh7RBCqPzOTs0ToeWyHSqBDM+o7EFk3qIj3pT2nXOrM1678O5DbcmJc/vB3Nygg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=kdbg.org;
	spf=pass smtp.mailfrom=kdbg.org;
	arc=none smtp.remote-ip=213.33.87.16
Received: from bsmtp2.bon.at (bsmtp2.bon.at [213.33.87.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F067606A320
	for <git@vger.kernel.org>; Sun,  8 Nov 2026 08:54:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3F067606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kdbg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kdbg.org
Received: from [192.168.0.102] (unknown [93.83.142.38])
	by bsmtp2.bon.at (Postfix) with ESMTPSA id 4jMmtm3L9WzRnlJ;
	Sun,  8 Nov 2026 09:54:24 +0100 (CET)
Message-ID: <50b6c35f-e9c3-47ef-8fca-aebd2620623a@kdbg.org>
Date: Sun, 8 Nov 2026 09:54:23 +0100
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] t: add "test-tool genbytes" to avoid slow tr(1) on
 macOS
To: Kristofer Karlsson <krka@spotify.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
 Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>
References: <pull.2301.git.1794063565.gitgitgadget@gmail.com>
 <4c02ada9b85028f26f7e7bcc62e2ac12443da9c5.1794063565.git.gitgitgadget@gmail.com>
Content-Language: en-US
From: Johannes Sixt <j6t@kdbg.org>
In-Reply-To: <4c02ada9b85028f26f7e7bcc62e2ac12443da9c5.1794063565.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 07.11.26 um 15:59 schrieb Kristofer Karlsson via GitGitGadget:
> Several tests create fixture data consisting of a single repeated
> character with "test-tool genzeros <count> | tr '\000' <char>".  This
> works well on platforms where tr(1) is implemented efficiently.
> 
> The implementation of tr(1) on macOS supports multi-byte characters,
> and processes its input one character at a time through
> getwchar() and putwchar(), even in the C locale.  For small inputs
> that does not matter, but t4205 generates more than 2GB of data this
> way, which makes that test much slower on macOS than on Linux: on the
> macOS CI runners, tr(1) alone spends 95 to 123 seconds of CPU time on
> it, compared to about 6 seconds on Linux.
> 
> Fix this by adding "test-tool genbytes <byte> [<count>]", which writes
> the requested byte directly, and turn "genzeros" into a thin
> wrapper around the same code.

All cases that do not need a particular character can use

	printf %0.500d 0

Though, on my Linux box,

	printf %0.2147483649d 0

produces nothing, but

	printf 000000000%0.2147483640d 0

has 2147483649 bytes of output.

If this isn't insanely slow on macOS, use this pattern instead of a
highly engineered helper program? ;-)

-- Hannes

