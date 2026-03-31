Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A6427F754
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774944555; cv=none; b=QTW8Upsyw1gq9oEfCRKdUL+CvUinQWeGY5iFaetuMUnzvqgPXfhS2pFsfyIaUCHBxkqT5yQmzSjkLhCBfdZInFK8VxqD8915lLLLeWESpb1L0SFH1cdJpHDX/AbrF5/QoL12p6twUPkUm/f8ZNtQuOY0YD9JKGqj6bU/cw2XkJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774944555; c=relaxed/simple;
	bh=JrKRiqOO4Mi1/noen85bWlnnRfbAhZnqGh7UjsVhEs0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qwHtdxA8aoCJgXKG6pNboiApEZ737jovTXeJBRV9a9amtTYCxs9ltanwAOYRSMU8g4zqPvkcoov4Irg04tTo2qFaRbaOIpAVq9kLIr/7BJXKxugNZBBgaKvHty2UrVdFq5a/jj/1meVTBU17ytBUesVJ/B9bixAMDkEJpd704kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=3lSBEsbg; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="3lSBEsbg"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774944551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JrKRiqOO4Mi1/noen85bWlnnRfbAhZnqGh7UjsVhEs0=;
	b=3lSBEsbghQg9he4Bnp8tJ1aPcZy9j2S9Nq02ydxqSMCxfevBW9dJruhUatEsMr6+8QKbia
	V2Exz8+q8aW6shwRTuz8Gnqc2RaXeoxRl9a1cZs/AA6TN4PGEwsPGK8Ii5q5f/qbi0yYTR
	rdUQXkjHk3OdJ3LJuZKw4qocCKqoEAY=
From: Toon Claes <toon@iotcl.com>
To: Tian Yuchen <a3205153416@gmail.com>, Siddharth Asthana
 <siddharthasthana31@gmail.com>, git@vger.kernel.org
Cc: christian.couder@gmail.com, ps@pks.im, newren@gmail.com,
 gitster@pobox.com, phillip.wood123@gmail.com, karthik.188@gmail.com,
 johannes.schindelin@gmx.de
Subject: Re: [PATCH v6 2/2] replay: add --revert mode to reverse commit changes
In-Reply-To: <1cf080ba-61a1-43b0-abff-c7c156c1c4b1@gmail.com>
References: <20260324220401.47040-1-siddharthasthana31@gmail.com>
 <20260325202354.10628-1-siddharthasthana31@gmail.com>
 <20260325202354.10628-3-siddharthasthana31@gmail.com>
 <05959eb8-4b8a-421e-bf5f-9e6f0b59a313@gmail.com>
 <6427d088-e41c-47ff-ab6e-4d7679e85d3c@gmail.com>
 <1cf080ba-61a1-43b0-abff-c7c156c1c4b1@gmail.com>
Date: Tue, 31 Mar 2026 10:08:59 +0200
Message-ID: <87o6k4l8tg.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Tian Yuchen <a3205153416@gmail.com> writes:

> On 3/30/26 00:17, Siddharth Asthana wrote:
>
>>>
>>> This is a fail-safe design intended to prevent users from entering=20
>>> commands like:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git replay --revert main f1 f2
>>>
>>> This operation is indeed undefined which should be intercepted.=20
>>> However, considering:
>>>
>>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0git replay --revert main HEAD~5..HEAD~3 H=
EAD~1..HEAD
>>>
>>> Is this operation also intercepted? I think the reason is that the=20
>>> condition 'rinfo->positive_refexprs > 1' is a bit too simplistic.
>>=20
>>=20
>> Yes -- positive_refexprs counts each position tip, so that gives 2 and=20
>> the > 1 check catches it.
>>=20
>>=20
>
> What I mean is, this operation shouldn't be intercepted, right? In my=20
> view, it is valid to select and operate two (and more) periods from the=20
> same linear commit history, but that is blocked here.

So you want that command to replay the first revision range onto `main`
and on top of that the second revision range?

For what it's worth, I think `--advance` suffers from the same issue. So
I think this can be addressed after these patches land.

--=20
Cheers,
Toon
