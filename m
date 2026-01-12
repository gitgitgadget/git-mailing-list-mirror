Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B32F82BD5BB
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 15:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768230970; cv=none; b=DHNcIF1eXO9oD759LqIwEnRh0Z5vmsC3SwvrxGHaqzPiHDlJC8JLX5LtwmklO1+8r3WgCLS5GH42+AJlbkEst7VYQKCiBf31DE/dmWTWqlqeCN2PKulTGbchJyFe14C0UQtKXdW2w7FytyXAlxQnOhBvAuGuxa25YJP6bW8ylSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768230970; c=relaxed/simple;
	bh=p7Otwsvg7FXMnINvxw45hh+aYhdmGS777mVtKNbIb3A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=l4vvTHD0SvBeoiCMqERr6TvrziN8O0e9Ns66KM4JYvFpYCk8r3r2kCn1+X4PbwJERoiHcY3pFR8rAcVLRN8mmHm9SXFFX79bNN3YmbLbZMH/lPbEqXMeBofYqt3iAtgdaYfQKEv4CeKx+SBPg/EUwk1yc5NQIn3ZijIhuNAqLqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=l7NUUt+a; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="l7NUUt+a"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1768230964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pT1okK1TO4WascjC+KiCpjjDZbQUv9bEMnomz/Twgg0=;
	b=l7NUUt+aDQFS+4b4HrFWnr42xPCqmDUqZd+TMgaIhAQYhytCwyxSNpFfuHOCIINcVNgc2k
	Q+XoCHa+2zLsWb4+xvP65sIkYrDXDn2ApL8CA4TlZ3rtycbl4qsMhMd0MPT2e6Wvu+j+Nz
	sqL2BIYI7oobXDmUAUSgPKq1i5Xf06k=
From: Toon Claes <toon@iotcl.com>
To: Gusted <gusted@codeberg.org>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>
Subject: Re: git-last-modified on bare repository
In-Reply-To: <aVvSwkK7RdpFDaVv@pks.im>
References: <09870987-ae2f-44ec-b8a0-1654f598b5fd@codeberg.org>
 <aVvSwkK7RdpFDaVv@pks.im>
Date: Mon, 12 Jan 2026 16:15:47 +0100
Message-ID: <87v7h6kgkc.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> On Mon, Jan 05, 2026 at 02:35:56PM +0100, Gusted wrote:
>> Because it was talking about revision, I quickly checked a refspec as input
>> and it looks like I found another way to trigger a BUG.
>> 
>> $ git last-modified -- HEAD:LICENSES
>> BUG: builtin/last-modified.c:456: paths remaining beyond boundary in
>> last-modified
>> [1]    202076 IOT instruction (core dumped)  git last-modified --
>> HEAD:LICENSES
>> 
>> On the bare and non-bare repository.
>
> This looks like a bug to me indeed. Cc'ing Toon.

Okay, there are various things going on.

First. If you do:

    $ git last-modified -- HEAD:LICENSES

On Git 2.52.0, then you're getting the BUG. On 'master' you'll get
simply no output.

But if you do:

    $ git last-modified HEAD:LICENSES

Then you actually trigger the same bug as you've reported before.
"HEAD:LICENSES" resolves to a tree oid. So that command is basically the
same as:

    $ git last-modified b79c618f6a11fc6f550dc98ef3227ef77b3132aa

In both situation you get a BUG. And I'm still working on a fix.

-- 
Cheers,
Toon
