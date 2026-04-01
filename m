Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F453F8DE5
	for <git@vger.kernel.org>; Wed,  1 Apr 2026 13:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775051252; cv=none; b=tzoD8pql+ki//OPPdwkPEcYa4e8ft/3J0mHXOBFBdq03clDBrDzwqiMag1k2YuF8wplmscMiIw//nty37xd9kB2EJoEhV8dtfQWSRJyuw8MS2WRzjXLd5snb1lxVBSxRY75oeMv5h2U+lhRnhVvPEywpxiPBnDzbKeg/SVkJtRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775051252; c=relaxed/simple;
	bh=Iqc4tnwLiYDSEm5A4Fv6N03C3LT/f+lH2B+f8QzDG4I=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VRjPQJDo3eoSpc/mG7elKs26nJMW/3ewWDTMtbIZLTXAmGE6qKKOZmeYem34muqNqH6xETPsZCGJh2vZZevc2tpuHsaojilKdCnKthvMPveGeLZB/9czZF0+an5oCLTENX7plm1NCzajNzZCeUl3behcTyD2Rv5+2u6EJBboUwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=I7ab683m; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="I7ab683m"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1775051245;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U5hESXEpghGlRYTgQvBhdPh3EbixP6XgRmsKYkFJDwM=;
	b=I7ab683mDXfOvoHGoqJNhZIAcF9asRBlORwFTombv4DLJaTmDHqaqb1HZ4RpyWXIU5JqUD
	1hxW+sCskEUD8GzsAaWJciUrtTNm4UQwwUn8hKgSBb48qBxxjJ8czKBakUYo0/IE5WdCh/
	ZLsPwyhtbE6YFeqV47mzc9S/KPP0ZhM=
From: Toon Claes <toon@iotcl.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick
 Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH] hash: introduce support for the MD5 hash algorithm
In-Reply-To: <67f10f21-121b-426d-abee-32d034f84fe7@app.fastmail.com>
References: <20260401-pks-object-format-md5-v1-1-1b8f0be23713@pks.im>
 <67f10f21-121b-426d-abee-32d034f84fe7@app.fastmail.com>
Date: Wed, 01 Apr 2026 15:47:17 +0200
Message-ID: <875x6aeqsa.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Wed, Apr 1, 2026, at 12:42, Patrick Steinhardt wrote:
>> We are currently in the process of migrating to SHA256 as the
>> alternative to SHA1. But we believe that proposal is misguided.
>>
>> When Linus first announced Git in April 2005, he was explicit about the
>> role of SHA1 in the design: the hash is used for content integrity, not
>> for cryptographic security [1]. Given this foundational principle, the
>> collision resistance of the underlying hash algorithm is essentially
>> irrelevant. What matters is that identical content always produces the
>> same name, and that any corruption of stored data is detectable.
>>
>> While SHA256 technically provides stronger collision resistance than
>> SHA1, it does so at the cost of 64-byte object names instead of 40, a
>> 60% increase in verbosity for no practical benefit.
>>
>> As an alternative, MD5 satisfies the requirements of collision
>> resistance and deterministic checksums perfectly well. At a length of 32
>> hex characters they are shorter than SHA1, roll off the tongue more
>> easily, and have been a beloved companion to the software engineer for
>> decades. Furthermore, it remains in active use throughout the ecosystem,
>> in checksums on download pages, filesystem integrity tools, and
>> countless systems out there, which overall proves the point that they
>> aren't inherently broken.
>>
>> Quoting Linus in [1]:
>>
>>   In other words, I think we could have used md5's as the hash, if we
>>   just make sure we have good practices. And it wouldn't have been
>>   "insecure".
>>
>> Let's do so and wire up MD5 as a new alternatitve hash algorithm next to
>> SHA1 and SHA256. Repositories can easily be initialized with MD5 by
>> saying `git init --object-format=3Dmd5`, and tests can be executed with
>> the new hash by setting the `GIT_TEST_DEFAULT_HASH_ALGO=3Dmd5` environme=
nt
>> variable.
>>
>> [1]:
>> https://lore.kernel.org/git/Pine.LNX.4.58.0504160913180.7211@ppc970.osdl=
.org/
>>
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>> Hi,
>>
>> I guess the title says it all. Let's correct course!
>>
>> Patrick
>
> I=E2=80=99ve been waiting years for this! Thank you so much!!!

I can't believe we'd have MD5 before GTA6.

--=20
Cheers,
Toon
