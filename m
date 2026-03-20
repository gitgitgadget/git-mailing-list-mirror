Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC083B0AE3
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774010239; cv=none; b=MbLkCjkUcCtowWG5rqxDZZvSpjfQwdmGJsDxF2YsVjvvz3zWLBTbvZKFnpRw9HTOlvHPfiN5l7Sbc5Y2+hUl6IM5S3E8nX9HSy8XvvBzuaTZen2MH5Dv45E9uSNpANf+nw7knCvUe1pzHUOrsCki/J4ZocTm9qoKABS8P2PLY9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774010239; c=relaxed/simple;
	bh=SPlZunmb2eFTm5/6lO3rGWxjoj0PjDncJ2FipMCSvnA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kSc/Q2WlWkHX8Ogf6bnjlP564oHkXD1R1z1s+rbHTipPfk/YhZi0J77XLLPft548jaK/Qv9RSMwdIMdSO26CA3VXk2popTU8GHWmX08t4gZhuIMCqWvrB+7W7Emvl/zX+vDJLtKJ12RLo93rEwizpF6BG8RBmAfj+JcUnnMAdUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=kmKVacOw; arc=none smtp.client-ip=95.215.58.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="kmKVacOw"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1774010231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P7a4CcjkjFOOMio8/7wGXkKA1P4EY04adV8lTkIgctM=;
	b=kmKVacOwJd+sqmmbkrEU7yT/vLyW++b/FE4nDdcdcfB3IvZnRbrgw1yhMx88srRuBeINBF
	LOV9VHt3Wz2IbMsZzIWd/JtAUMGEzdVK1vXPONTf6FwqIesrDmt0fOq0YHBR/wKYrUVhEt
	KfFcllhbPD55T8EA+G1YDbaYVmxqudw=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>, Junio C Hamano
 <gitster@pobox.com>,
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 8/8] meson: precompile "git-compat-util.h"
In-Reply-To: <20260319-b4-pks-build-infra-improvements-v3-8-82f5fb3edc3f@pks.im>
References: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
 <20260319-b4-pks-build-infra-improvements-v3-8-82f5fb3edc3f@pks.im>
Date: Fri, 20 Mar 2026 13:37:05 +0100
Message-ID: <87v7eq1xu6.fsf@iotcl.com>
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

> Every compilation unit in Git is expected to include "git-compat-util.h"
> first, either directly or indirectly via "builtin.h". This header papers
> over differences between platforms so that we can expect the typical
> POSIX functions to exist. Furthermore, it provides functionality that we
> end up using everywhere.
>
> This header is thus quite heavy as a consequence. Preprocessing it as a
> standalone unit via `clang -E git-compat-util.h` yields over 23,000
> lines of code overall. Naturally, it takes quite some time to compile
> all of this.
>
> Luckily, this is exactly the kind of use case that precompiled headers
> aim to solve: instead of recompiling it every single time, we compile it
> once and then link the result into the executable. If include guards are
> set up properly it means that the file won't need to be reprocessed.
>
> Set up such a precompiled header for "git-compat-util.h" and wire it up
> via Meson. This causes Meson to implicitly include the precompiled
> header in all compilation units. With GCC and Clang for example this is
> done via the "-include" statement [1].
>
> This leads to a significant speedup when performing full builds:
>
>   Benchmark 1: ninja (rev =3D HEAD~)
>   Time (mean =C2=B1 =CF=83):     14.467 s =C2=B1  0.126 s    [User: 248.1=
33 s, System: 31.298 s]
>   Range (min =E2=80=A6 max):   14.195 s =E2=80=A6 14.633 s    10 runs
>
>   Benchmark 2: ninja (rev =3D HEAD)
>     Time (mean =C2=B1 =CF=83):     10.307 s =C2=B1  0.111 s    [User: 173=
.290 s, System: 23.998 s]
>     Range (min =E2=80=A6 max):   10.030 s =E2=80=A6 10.433 s    10 runs
>
>   Summary
>     ninja (rev =3D HEAD) ran
>       1.40 =C2=B1 0.02 times faster than ninja (rev =3D HEAD~)
>

Quite cool! The only nit I would have about this, this optimization is
not applied to building with Makefiles. While that isn't an issue, I
wouldn't have hurt if it was mentioned in the commit message.

Anyway, overall I got nothing that's holding back this series from
merging. Looks good!

--=20
Cheers,
Toon
