Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33DEF191F7A
	for <git@vger.kernel.org>; Wed,  5 Feb 2025 16:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738772963; cv=none; b=GocOxZSUD2qsM8awRgQ/NyAQkgl0bnl3hz9NQyTl8cvP28+XzwfK/nTiFeEw4LU4ZZlxOqyDdvVQMWwfw7nV+LyBz7C37T88ZXF0MmtgUsMGFCkInuB0Zx1IlKv+nOjjoIS4FVJaKyJmiMrJLtqPaB8M7wSrk8y8g2xnUvLpLug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738772963; c=relaxed/simple;
	bh=p4Kejt9suVPgMUtR9N+qEJ/lYLq0K0YCnO0g9yKcCG0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FyuCa0JMFMTF9pzcFnJeSgnDGjDYVnB8HW3fO+gPmgUZuR5b19uB8yfuRDNHpaX8I04IPR5QP8SCIa6Zcb4O3IG9pRivxh2nzkSVIgoXMLQeMyOtruWmydRzOtLH05Ihm1K8kDcXmXCCr2oHEFCV8TDYWBqiCHkW2A3nBgovImE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=gnTl+WLc; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="gnTl+WLc"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1738772954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kGJqkrOfioQkjR/zAPS+VM4W2xSQluc48V+7cdQRUJc=;
	b=gnTl+WLc7b7SqWOXDBF5Iz3SLctPXJPnJSxhHesFvnFRgp4U47MTEcEuaJ10MHNEwvGH8x
	wlxO22NJqL41o6vi8P7AChc5X6gN7Uqbn7NWxNQcJ0I4mZxa/THbaJGKtJRAV3hNwm0mcY
	mkKKa2qMhlHehBSXfBRoT/EHjQMH3l0=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Michal =?utf-8?Q?Such=C3=A1nek?=
 <msuchanek@suse.de>,
 Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
 =?utf-8?Q?Jean-No=C3=ABl?=
 AVILA <jn.avila@free.fr>
Subject: Re: [PATCH v5 2/7] clone: make it possible to specify --tags
In-Reply-To: <Z6MbSXQ3O476bpfZ@pks.im>
References: <20250204-toon-clone-refs-v5-0-37e34af283c8@iotcl.com>
 <20250204-toon-clone-refs-v5-2-37e34af283c8@iotcl.com>
 <Z6MbSXQ3O476bpfZ@pks.im>
Date: Wed, 05 Feb 2025 17:29:05 +0100
Message-ID: <87ikpo4apa.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Tue, Feb 04, 2025 at 10:34:01PM +0100, Toon Claes wrote:
>> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
>> index de8d8f58930ecff305f79480b13ddce10cd96c60..e89ae2e8c664f4d4e15e5f05=
264c8df988295e3d 100644
>> --- a/Documentation/git-clone.txt
>> +++ b/Documentation/git-clone.txt
>> @@ -273,12 +273,13 @@ corresponding `--mirror` and `--no-tags` options i=
nstead.
>>  	branch when `--single-branch` clone was made, no remote-tracking
>>  	branch is created.
>>=20=20
>> -`--no-tags`::
>> -	Don't clone any tags, and set
>> +`--[no-]tags`::
>> +	With `--no-tags`, no tags are cloned, and set
>>  	`remote.<remote>.tagOpt=3D--no-tags` in the config, ensuring
>
> This reads a bit awkward now. How about:
>
>     Control whether or not tags will be cloned. When `--no-tags` is
>     given, the option will be become permanent by setting the
>     `remote.<remote>.tagOpt=3D--no-tags` configuration. This ensures that
>     future `git pull` and `git fetch` won't follow any tags. Subsequent
>     explicit tag fetches will still work (see linkgit:git-fetch[1]).
>
>     By default, tags are cloned and passing `--tags` is thus typically a
>     no-op, unless it cancels out a previous `--no-tags`.

Sounds good to me, I'll amend my commit.

I'm Cc'ing Jean-No=C3=ABl to hear their opinion as well.

--=20
Toon
