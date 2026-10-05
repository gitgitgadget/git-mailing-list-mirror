Received: from mta1.migadu.com (out-199.mta1.migadu.com [95.215.58.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94A746D560
	for <git@vger.kernel.org>; Mon,  5 Oct 2026 18:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791225283; cv=none; b=lqHfpfPpr7lfEr1mXXvAyYSVXqce4YfK8KVxIRFUZiPTKbJhi/kVNw5A+y1Ym08hdo1nDdI/kSzW/3L2Mj5N1IvPb2Liux9VbG88PZelARldMxF24txog7eM49V/2TlJtXfJIH2S7sLzvAVQGwxmu+Qm+ifhWoU+OyqYjWJrhXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791225283; c=relaxed/simple;
	bh=eymMPSY41UUVWaETMJmOIBUoYZonON+6BvgeaDWPYgY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JhWqzYDwm1Im8GLNi7LtuQBAuq8T3We9KCctuO2Md6+PgjtjNbH56UNM4CEIZKdWjlY80DXZlZjbRqS2i1XdQvXo9+qtAnbHynPZsRXmkPOHgUXxziCrqMJGU8RJa9DNF6hyEnqkhGpGZN6XyoJO78hEO4ykeTS7x0msUowORJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=yLvwBWRO; arc=none smtp.client-ip=95.215.58.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="yLvwBWRO"
X-Envelope-To: git@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=eymMPSY41UUVWaETMJmOIBUoYZonON+6BvgeaDWPYgY=;
 c=simple/simple; d=iotcl.com;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791225275; v=1; x=1791830075;
 b=yLvwBWROUKtjUUODxfXc3JrYsRShthPy7drM/5SqSN53RXb/H3MO6xHEZYf4qq2pkNhGIxqN
 Z13gGXh5GSJlsXoitZ6/dehCXRPQE0ubZwYT+jvB5rl8JID+Ud/ic/hGkxvPYoAhdCCcAEVNmEn
 dkexLT+1hcip2xNiMDaPHESg=
X-Envelope-To: git@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 1461063d32b90678;
	Mon, 05 Oct 2026 18:34:35 +0000
X-Mizu-Trace-ID: 1461063d32b90678
X-Migadu-Flow: FLOW_OUT
From: Toon Claes <toon@iotcl.com>
To: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2] packed-refs: use `fwrite()` when passing refs verbatim
In-Reply-To: <20261002-kn-speedup-packed-refs-v2-1-2ae75772ebc1@gmail.com>
References: <20260930-kn-speedup-packed-refs-v1-1-111cd03d9b0e@gmail.com>
 <20261002-kn-speedup-packed-refs-v2-1-2ae75772ebc1@gmail.com>
Date: Mon, 05 Oct 2026 20:34:32 +0200
Message-ID: <87zewsf13b.fsf@dev.null.iotcl.com.invalid>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Karthik Nayak <karthik.188@gmail.com> writes:

> The `write_with_updates()` function uses a `struct ref_iterator` to
> iterate over all refs to write to the temporary packed-refs file. It
> receives the iterator from `packed_ref_iterator_begin()` which takes a
> snapshot of the 'packed-refs' file.
>
> While writing to the new packed-refs file, writes are routed via
> `write_packed_entry()` which uses `fprintf()`. Even for references which
> haven't changed, we use the same mechanism. Instead, let's track the
> position of unchanged references in the snapshot iterator and directly
> use `fwrite()`.
>
> With this, any sanitation which was happening as a side of reformatting

s/side/side effect/ ?

> is now lost. But that was never the job of this section of the code,
> since the main intention is to simply rewrite the remaining refs post
> deletion of the selective few.

Agreed.

>
> This removes the unnecessary formatting operation involved. We can see a
> consistent ~20% performance improvement when deleting from packed
> references.
>
> Benchmark 1: update-ref: delete ref (refcount =3D 100000, revision =3D ma=
ster)
>   Time (mean =C2=B1 =CF=83):      28.7 ms =C2=B1   1.7 ms    [User: 22.5 =
ms, System: 5.9 ms]
>   Range (min =E2=80=A6 max):    26.7 ms =E2=80=A6  33.3 ms    46 runs
>
> Benchmark 2: update-ref: delete ref (refcount =3D 100000, revision =3D b4=
/kn-speedup-packed-refs)
>   Time (mean =C2=B1 =CF=83):      23.8 ms =C2=B1   1.2 ms    [User: 17.5 =
ms, System: 6.0 ms]
>   Range (min =E2=80=A6 max):    22.1 ms =E2=80=A6  27.7 ms    56 runs
>
> Summary
>   update-ref: delete ref (refcount =3D 100000, revision =3D b4/kn-speedup=
-packed-refs) ran
>     1.21 =C2=B1 0.09 times faster than update-ref: delete ref (refformat =
=3D files, refcount =3D 100000, revision =3D master)
>
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
> Changes in v2:
> - Instead of using the existing function, introduce a new
>   `write_packed_entry_raw()`.
> - Modify the commit to also note that we lose sanitization.

s/commit/commit message/

> - Link to v1: https://patch.msgid.link/20260930-kn-speedup-packed-refs-v1=
-1-111cd03d9b0e@gmail.com

Okay, I'm okay with this version.

--=20
Laters,
Toon
