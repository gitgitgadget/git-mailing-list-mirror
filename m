Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45400204594
	for <git@vger.kernel.org>; Thu, 10 Apr 2025 08:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744275470; cv=none; b=DH9UG2mIMQB4P9rYP0fDgGdJxtlFaBhe36khnftDXrru+qJ1KNrVWkW78pOLVvvAjXldIVVNobL57rzIh1FeGnz0xP5mQgHiwmGgIK7hmj+4hb0HiTetJ6GP45gxJdb9HnF1+kR2N+g0csyvmLtIDNJbjfR/EkuOvgTATM1xrf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744275470; c=relaxed/simple;
	bh=OlNibsdnV3vHNXFaz6lwH9hXQVdnJsA1T8gvuYEfPXE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FZaVYUM0tgVQALhrxRnowUg843kgcnxJbVVRvW8oRAfK/pghBsHZjnKbBIE+mx2ycPmJ7BDKG3y/F7MU6XySmLxFiqGUWjGuY97s/VpvnnMsE7XTh+xmOjz4qv5XudGxTLyQlzxlKkRO0c872XKmEIWRD2YhwvhNacMiEKCs6MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=lxrlOdes; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="lxrlOdes"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1744275462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YsqMjfV8SdbhK/xmB0XkNgEWz3L/uR9p06MGe9qltPM=;
	b=lxrlOdesw+4+/R3+9HI81L4NqnXEJVXjs2m0VfPjx+CWEv5+pgEU+riS8r/XcTpCbtbXv1
	g0EGqSFdXh+WVFpI8j6wCjt5nHuAxwDQPAiP4+vuFIMbrh7nqIP0M6V6koDiBu6xqfprGB
	3+TUyvtQKsGY/BUyBPB2E+7palV7U7s=
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: jltobler@gmail.com, ps@pks.im, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 2/2] bundle: fix non-linear performance scaling with
 refs
In-Reply-To: <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-2-0802fc36a23d@gmail.com>
References: <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-0-0802fc36a23d@gmail.com>
 <20250408-488-generating-bundles-with-many-references-has-non-linear-performance-v2-2-0802fc36a23d@gmail.com>
Date: Thu, 10 Apr 2025 10:57:29 +0200
Message-ID: <871pu0fl6u.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

Karthik Nayak <karthik.188@gmail.com> writes:

> The 'git bundle create' command has non-linear performance with the
> number of refs in the repository. Benchmarking the command shows that
> a large portion of the time (~75%) is spent in the
> `object_array_remove_duplicates()` function.
>
> The `object_array_remove_duplicates()` function was added in
> b2a6d1c686 (bundle: allow the same ref to be given more than once,
> 2009-01-17) to skip duplicate refs provided by the user from being
> written to the bundle. Since this is an O(N^2) algorithm, in repos with
> large number of references, this can take up a large amount of time.
>
> Let's instead use a 'strset' to skip duplicates inside
> `write_bundle_refs()`. This improves the performance by around 6 times
> when tested against in repository with 100000 refs:
>
> Benchmark 1: bundle (refcount =3D 100000, revision =3D master)
>   Time (mean =C2=B1 =CF=83):     14.653 s =C2=B1  0.203 s    [User: 13.94=
0 s, System: 0.762 s]
>   Range (min =E2=80=A6 max):   14.237 s =E2=80=A6 14.920 s    10 runs
>
> Benchmark 2: bundle (refcount =3D 100000, revision =3D HEAD)
>   Time (mean =C2=B1 =CF=83):      2.394 s =C2=B1  0.023 s    [User: 1.684=
 s, System: 0.798 s]
>   Range (min =E2=80=A6 max):    2.364 s =E2=80=A6  2.425 s    10 runs
>
> Summary
>   bundle (refcount =3D 100000, revision =3D HEAD) ran
>     6.12 =C2=B1 0.10 times faster than bundle (refcount =3D 100000, revis=
ion =3D master)

I've done some benchmarking with some "real life" repositories, which
only have a couple of thousand refs and there the difference
(expectedly) barely noticable. Which is good to know there also isn't
any regression.

This version looks good to me, I approve.

--
Toon
