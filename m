Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC6FB661
	for <git@vger.kernel.org>; Tue,  4 Nov 2025 15:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762268954; cv=none; b=JISvrDu4x/QRgKGvRW6AsfutPB5JkKE2051XNpl69FTGlkJ366PkNbpsukzBiHKQtV3VRNxhmmtJHAA6mkcgowQ+TfJYOijUl2WzgQ/H07vACk/hPTvVOkOe3oGRmngUpC6QGiEOjjbBsHCfX9ve6eeBXtDr7nYNGpzINY6kPGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762268954; c=relaxed/simple;
	bh=OPC8bx5ZUBSc6FvUwq3HXfzMDQackq9+JIuBFsfImAg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Yi8VSUc7H8gEyAeCIGCq2YjNktd4PvnfIiPCKiVFRL7o7yQPkmdpPJGXtVIxw6zAz2UGZ/NQr48HI7WO/GzwBfWE43Qn14wUskY1xJxjeQN/+DPvcb8DB/mF31C9VLWuKk25NgsuFjjw2MwUb08LLR3Q0v2kRIR3swvSQkMKuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=HaW9CTFn; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="HaW9CTFn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1762268946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xTsYioEkkmBDY/5RYU1vC4SIBbRalYRecdVNm7Bchks=;
	b=HaW9CTFnt3vxJrGNlbOWoCfiXyf8hJ7PiVuuDTSQI4l2INQqmFzM5dSjDLVu45muSyzerA
	3HoyE61/owqkozrafqHkHaZ6TCM3rlw5F6+uF2Y/2/95Z2TmQNBneQBujIe+qPDJZORBvr
	ZwMfDaVjuu5uaY19ix8ZDEuHAryCZG0=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, Justin
 Tobler <jltobler@gmail.com>, Taylor Blau <me@ttaylorr.com>, "D. Ben
 Knoble" <ben.knoble@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v4] last-modified: implement faster algorithm
In-Reply-To: <xmqq7bw7ukvj.fsf@gitster.g>
References: <20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com>
 <20251103154726.26592-1-toon@iotcl.com> <xmqq7bw7ukvj.fsf@gitster.g>
Date: Tue, 04 Nov 2025 16:08:43 +0100
Message-ID: <87ms51esxw.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Toon Claes <toon@iotcl.com> writes:
>
>> Changes in v4:
>> - Use CALLOC_ARRAY() instead of xcalloc() as identified by Junio using
>>   'make coccicheck'.
>> - Small formatting changes.
>> - Link to v3: https://lore.kernel.org/all/20251023-b4-toon-last-modified-faster-v3-1-40a4ddbbadec@iotcl.com
>
> Sorry, but this came way after I started today's integration cycle,

No worries.

> which included merging the fixed-up version to 'next'.

Well, thank you.

> I saw some
> "let's drop {} around the body of if/for with a single statement"
> changes but each of these single statements was not a simple
> statement but an if-statement, and personally I feel that it is
> clearer to enclose them in {} (in other words, once the code is
> written in that way, it is not worth the patch noise to go and fix
> them).

Understood.

> The only regrettable thing without v4 is the double space
> between ") {" in the second hunk below X-<, but perhaps it is minor
> enough to leave it to the next person who touches the vicinity of
> this code ;-). If you feel strongly about them, please send in an
> incremental updates, but as I said, I do not think it is necessary.

It remained undiscovered by various reviewers and myself. I only noticed
because I saw CI style-check mention this (also the reason I touched the
{} on the for loops). So I don't mind leaving it this way.

> Thanks.

<3

-- 
Cheers,
Toon
