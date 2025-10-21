Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11512F1FC0
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 13:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761051622; cv=none; b=TgqWUcqNg7qOoVBeLwdfPHixGTqL6bB5aAhHqB609Wz43oRKQWKCppU2swClOTzgME1zGHJiCtcdH6YnFC2BW4XtPKaY7r1w2lMy+7R9GxAKmb3m9kNbrVXmrMQzTXfHcsrBHIhjAb4TV4qioS1aqjiLRT1UsfvX3rkq0kOvnao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761051622; c=relaxed/simple;
	bh=gbDwCK6dZnp1EfihhiOGmZgfKX+Tc2pSVbJGGRr4Bko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WLQhTGQ6O/0fFkQ+8DbYfYMQc8S2Q8GaZVicXhpc/PfWeIdH48SPXTp7k70hVVNkUiwx2ngRFhMf25kkaqIWpazB1apSrWvnuqzzw6Y0sffW4uyEaiFmIEaQdZcCVh/TxEYsCVSz+UYy4LPX9f8y20X9kYUOo05oPEcrszImlvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=cQFSW/PM; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="cQFSW/PM"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1761051616;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WO7/VS5JUDIc3eyno/b/jE5CJAFDTOh6+e1/Y8sLJd8=;
	b=cQFSW/PMRe8jJ0Q25mLLJDPbsis2dP3QwIyyXCuFpFIw7hJbPiZ2Zu9uK3dTRWFd7bhn6d
	mdcm1wvU1Ujzw77XXFJKCEvdCLMLxTLQ27+9Fx1ek43W2I99AxQZt9IE1ZN4biBd7/ZDac
	mu0MtJc0vLH4fDe80/8ETiGmFf600+g=
From: Toon Claes <toon@iotcl.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Justin
 Tobler <jltobler@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH] last-modified: implement faster algorithm
In-Reply-To: <87jz0tu3yh.fsf@iotcl.com>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <aPGB/FJtjDmyNLvG@nand.local> <87jz0tu3yh.fsf@iotcl.com>
Date: Tue, 21 Oct 2025 15:00:06 +0200
Message-ID: <878qh4tnop.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

> Taylor Blau <me@ttaylorr.com> writes:

>> I'd suggest including those benchmarks as well, and potentially running
>> them on linux.git, or another comparably larger open-source repository.
>> git.git is large enough to show some interesting behavior, but I always
>> have found it useful to compare the results against a larger repository
>> as well.

I've submitted v2 of my patch. In that version I included the benchmark
for a repo without and with Bloom filters. But I didn't include
benchmarks on linux.git. So for the record I'm sharing it here:

    Benchmark 1: master   no bloom
      Time (mean =C2=B1 =CF=83):     12.290 s =C2=B1  0.105 s    [User: 11.=
893 s, System: 0.370 s]
      Range (min =E2=80=A6 max):   12.089 s =E2=80=A6 12.461 s    10 runs

    Benchmark 2: master with bloom
      Time (mean =C2=B1 =CF=83):      1.536 s =C2=B1  0.072 s    [User: 1.4=
18 s, System: 0.114 s]
      Range (min =E2=80=A6 max):    1.500 s =E2=80=A6  1.740 s    10 runs

    Benchmark 3: HEAD     no bloom
      Time (mean =C2=B1 =CF=83):     868.7 ms =C2=B1   3.0 ms    [User: 810=
.7 ms, System: 56.1 ms]
      Range (min =E2=80=A6 max):   863.1 ms =E2=80=A6 873.5 ms    10 runs

    Benchmark 4: HEAD   with bloom
      Time (mean =C2=B1 =CF=83):     110.0 ms =C2=B1   1.8 ms    [User: 89.=
3 ms, System: 20.3 ms]
      Range (min =E2=80=A6 max):   106.6 ms =E2=80=A6 114.2 ms    27 runs

    Summary
      HEAD   with bloom ran
        7.90 =C2=B1 0.13 times faster than HEAD     no bloom
       13.96 =C2=B1 0.69 times faster than master with bloom
      111.73 =C2=B1 2.02 times faster than master   no bloom

--=20
Cheers,
Toon
