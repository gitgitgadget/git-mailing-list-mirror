Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C64219E9E
	for <git@vger.kernel.org>; Thu,  9 Jan 2025 13:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736430215; cv=none; b=uQIkcBrNm06c4g7YMOjQOtE9sE3gr/oxxt3L42mYhHntHLR2ZZKY4cerd3gw9FIf7PgDY8qSDUHYLV9NyxeHwqYXuJwFpDVpDP66Lv1h4eBuWBBiAzWk4r4bSd4HpdIMvFbck6WTYfUfbOJqhMcGgixECW/3TPLrgjQr1Z2yeHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736430215; c=relaxed/simple;
	bh=VPI6J6Ee7u6RJLRKXG54OFMVg/BfZmoUmyD56uayS4g=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=p4NdxhuI3LPog8A8ZpGv2+nwQHu4kREV61nkXcN2m3e8IkDxnyPacTTUQSZIBwy1a5xNIbD2f+e1YkW2cNEHQzE6ve7L4Ywt9jkhb7tChtksSED1Lb/UOE/1Jfpij0cUjY/NuQLTirKVoRw3XPq6UsuHTS/CkQN4/qIpPYVdOIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b=dPOtSPO3; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=johannes.schindelin@gmx.de header.b="dPOtSPO3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1736430206; x=1737035006;
	i=johannes.schindelin@gmx.de;
	bh=ONwQgxBEbtJaCLo5uz1dM4zjjooJTfY0v5agpKls3QY=;
	h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:Message-ID:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=dPOtSPO3b0HtbzY42Miw3YNzl1IprDGFVJ1XQH4vUHOa0qgK5+ClYiWNlZcudPMs
	 O3/L2D05bZ6KM7OipbkPCjq1kFY62Qjg8SdbhKSWZLzBnpevF29VBWB5wEDlxWs/X
	 037610UM3j9VrgPbsSBOV/rvcI610OQOBECWvqDBJlegf45f8S12ZMFEeOLYthQW0
	 F9CZJD6MQg+GB7opMon0gvrQ+PE9W60k46p6ZocmmZLZXCpz1l2oAGVd2LxRJONiJ
	 57sTrVPqwfvmLT90mZEhHcXYeZ0tJF68BrLDFpgLscEeCk1UGM7DtChLoUGHotkXJ
	 gUO7UMyKYK/6mBqEaA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.23.242.68] ([89.1.212.7]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MnJhU-1tv5DO0fvo-00eloJ; Thu, 09
 Jan 2025 14:43:26 +0100
Date: Thu, 9 Jan 2025 14:43:25 +0100 (CET)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Patrick Steinhardt <ps@pks.im>
cc: git@vger.kernel.org, 
    Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v2] builtin/blame: fix out-of-bounds read with excessive
 `--abbrev`
In-Reply-To: <20250109-b4-pks-blame-truncate-hash-length-v2-1-589c81a6ddb0@pks.im>
Message-ID: <b09009f0-c822-f81d-1f79-07610ec20193@gmx.de>
References: <20250109-b4-pks-blame-truncate-hash-length-v1-1-9ad4bb09e059@pks.im> <20250109-b4-pks-blame-truncate-hash-length-v2-1-589c81a6ddb0@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:FAzeqABIhdFD7z9pCz9DgQJQf/RHE3QoF8CqbRhl7q1vhW1usGx
 Wj5vXO5TjZQ377IG3Fjd/KkhjvSqP1tfzM0jsL9zueH1RdEVqWistZRZ+EVLyc+KsOveeDH
 OuxhRC8wH7z626vK9mNLSunseHzBLeaj7jP913LbPIiw/9wmik+NDP4QgI6L59W1KuPntbh
 TjpERabqkxapqrW3hd5kA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:mcZDgaivdO8=;/rvcmhtZx47YO0H8Kr1xRdNniOg
 fwKIwKslaj6BvwMaPLbcNeRkQUHSo3RgA2gvH6nPc3UXzdIaOE3FJB3+L44NtmWqtEVmrOHx6
 D73bK0KWzZOJupM9DnyTFFpEcghIV9Cn3z3aN4t1UtSJ7JJKhs97bVYuQ7eY9MnFhWn85WCGL
 YlRtL1Y78+CV/+WALkTcwmUs2F4ZbBkcwocC5LvqSdTI00aIEaZOM7fmQcrgpScMueGnnKp46
 LRp6klyoBDad41lK3OCmJwCbp0aV4hnQ7MdfAG5vrToQIFP96FKlvofLBvNN0Q6TNkigzcYN7
 pCNjyw+671UpUP9DRA4gQ7KKlaAaiSrKHZNQ4984vvEwiShAWaHzZz6EieWJbNNVKoROW9d+t
 o1MeGsDAQaY1s5dX85aJPM+slgJlpmPPpatcal9MuJKkJpjytGeIRFTqovXXrvf4/cDR8PDOZ
 Rr7S73NE03IrX9yqWlSQBn4G2e6LNqSaGabdvWT9DAmUMvGekHaU9I/RsFo+YYpz+Cs9ehF/g
 v2KrxSQWl9bnJwx2YcIlG6CukknW/6bUM+RU2yqiIx5pftcvpn/mMEGO9+xBYXeT2SDb4kdiu
 MJnU4UjN2HEyHULbFMkFT8xcBXWAorU8ZggSP5oK8hH3sDVPUMNrLHjXF4GcIzD34LcLxh2xV
 +kshkzZlxfpG08Zaruu6kCoHfOfv8aZqnAbVD/BweX4YlYRkxZOrnWRHM3EXFCNZ26e6TLk/I
 O8ynnQBf5T6N0Mh8u5C8XtQ3L4Q7dcwHmqfmr7OLS2qe0Y7JzgW3zbFqRfmNevh6+CRa+p3BM
 lqngvxI0G4iGyTndZQiS1iaDuEFGy+mh8eGWh9bbVvmiAZD6HItdsuJqrbvwv7eliSYGhUa/w
 yFBsxOcnnR0IS81+EZ4Mn1LW0O5d9fG3sLvgRm/qqX0uKpEjwvrpWPvaxKwz9VPpZam9kT8lC
 7RLP7iNPuoENYrkj3Qn7Q5GqtrphSsigjGlM5FYq2V/udczQjF2Z8jXjBuGoOLS6aF0fdGPs7
 rDkwsXb5CDkRyNtNfZBmycOtih4iu1y+GRLircxXuhGpDe7Bh/94gHlumI/izigjqN8VDvSKK
 +3yFvCBTQ3wzX1EhHYW8l/UTPMBHqv
Content-Transfer-Encoding: quoted-printable

Hi Patrick,

On Thu, 9 Jan 2025, Patrick Steinhardt wrote:

> diff --git a/t/t8002-blame.sh b/t/t8002-blame.sh
> index 0147de304b4d104cc7f05ea1f8d68f1a07ceb80d..7cf6e0253a5bbd4d6e438e62=
7dc18b47eac4df66 100755
> --- a/t/t8002-blame.sh
> +++ b/t/t8002-blame.sh
> @@ -126,6 +126,10 @@ test_expect_success '--no-abbrev works like --abbre=
v with full length' '
>  	check_abbrev $hexsz --no-abbrev
>  '
>
> +test_expect_success 'blame --abbrev gets truncated' '
> +	check_abbrev $hexsz --abbrev=3D9000 HEAD

Please note that the patch I proposed had `HEAD..` here, not `HEAD`. The
latter would not have surfaced the problem with boundary commits.

Ciao,
Johannes
