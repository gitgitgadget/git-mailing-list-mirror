Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0D1314D00
	for <git@vger.kernel.org>; Fri, 17 Oct 2025 10:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760697930; cv=none; b=AUNePMnsXmaDZe2DUoo7i76eToXWt0k7lENDQX2WQt91/PTmc1qFokMxon1c0uGJ92yT5K/y4bEkemGrWFJtN6BWK2vhtx+5jbije338ksMljj/L1SlM0TDxSG8hVTbKaJV1dXpusHjA8aov7N23WZrHKrzakCEUsSTixo9MU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760697930; c=relaxed/simple;
	bh=2uecdb1m+jTMXAku9+YQ+OIqZuN4k1W4XuhjiRInBws=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=phY9xvt7ZjATQL24TdN50g7GPLZDH+KrSvNtsRjQcT+8QteMQvfTWYna2abimPrhUQI3v6uHNMDJaGQpVFFQECR627ZjEGxyctoOenW8ayKmXrWKsoo5TV7O2U7wQlFbLsDYrYcnek1OdeAuoe8o652OWqWj1u/EHrSF2fjXkB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=zwP455de; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="zwP455de"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1760697925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DYsl03CVPxl3iClpYvsnIVIsjyJrMv9tHWKg3pSBdpY=;
	b=zwP455deHnUcSDBJ1LEtJwQrICwxYcGc/MNdpIKxxT/uH49JRbaVZQpb/HqX+X1HVD7NxN
	v3EGAp9zSxuitZ77yvudBZJj2be1Mf7ErCTtPdrsLR/IKzrQ/N0VwCwivzI8HVP1I9kACf
	4Roh9mPTN6UVnQIFJYDHxGhBQzM1sWI=
From: Toon Claes <toon@iotcl.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Justin
 Tobler <jltobler@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH] last-modified: implement faster algorithm
In-Reply-To: <CALnO6CBwuAdBFjESZSYZkChNdU9R17OXDc+CY=Z96QoACPgrpQ@mail.gmail.com>
References: <20251016-b4-toon-last-modified-faster-v1-1-85dca8a29e5c@iotcl.com>
 <CALnO6CBwuAdBFjESZSYZkChNdU9R17OXDc+CY=Z96QoACPgrpQ@mail.gmail.com>
Date: Fri, 17 Oct 2025 12:45:16 +0200
Message-ID: <87plalu7r7.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> On Thu, Oct 16, 2025 at 4:39=E2=80=AFAM Toon Claes <toon@iotcl.com> wrote:
>> As an added benefit, this implementation gives more correct results. For
>> example implementation in 'master' gives:
>
> "More correct" is a bit of an oxymoron, no? It's either correct or
> it's not :)

I can rephrase to "more accurate" or something that's better suited.

>>     $ git log --max-count=3D1 --format=3D%H -- pkt-line.h
>>     15df15fe07ef66b51302bb77e393f3c5502629de
>>
>>     $ git last-modified -- pkt-line.h
>>     15df15fe07ef66b51302bb77e393f3c5502629de    pkt-line.h
>>
>>     $ git last-modified | grep pkt-line.h
>>     5b49c1af03e600c286f63d9d9c9fb01403230b9f    pkt-line.h
>
> It seems this commit is the merge to a maintenance branch, which was
> authored and committed after the mainline merge but topologically we'd
> probably consider it "earlier," at least starting from master? Anyway,
> I'm not clear why this result was produced.

Yeah, me neither. But it's a nice side-effect this behavior result goes
away with this patch.

--=20
Cheers,
Toon
