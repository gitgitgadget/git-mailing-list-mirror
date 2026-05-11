Received: from mail.thalheim.io (mail.thalheim.io [135.181.61.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 808412D9ECA
	for <git@vger.kernel.org>; Mon, 11 May 2026 09:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=135.181.61.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778490372; cv=none; b=dqoKK56/BDGfkdPgAukq9/cwzId1aMoLRYYaiAE+zGjwZuE9kYJJ+JSv5aYQuLpKQkSQJbpzCVq40iKOyZm0homOU0BywUBNEFGHv8t/+GlLarGLg6szEbsoR2wEszvq33uQlfX+AKH9BKhng1LCa9MdOCOIXdz810HWlT4Smas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778490372; c=relaxed/simple;
	bh=xP5Yp8g1Mk+0v7wOROQPM8MsojkXN3pcOWeYakAgUZY=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=J+Tuf5JKv2kyA5QFVGDnfpRhJ3Jdf8VgdzBVoF7EHlgtxOZFxmv4wlx2/s0IcQbUDvCxzl7/gy9ncLODmMveYe3+gyXIx9XbDs6fDb+bo5q7+40yDrnlunDysKkS614PVS7JTjiMKOM2XEd3Amt6vaP/FQsCYwc3PF9mPXyUAgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io; spf=pass smtp.mailfrom=thalheim.io; dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b=R8P/kV6T; arc=none smtp.client-ip=135.181.61.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=thalheim.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thalheim.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=thalheim.io header.i=@thalheim.io header.b="R8P/kV6T"
Received: from mail.thalheim.io (eve.i [IPv6:2a01:4f9:4b:4084::1])
	by mail.thalheim.io (Postfix) with ESMTPSA id 52E08BD91FE;
	Mon, 11 May 2026 09:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thalheim.io; s=default;
	t=1778490360;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S1m8wsjRAykO3wnS8V04u5z/fahlJftstvVb2oCPzno=;
	b=R8P/kV6TW3EzdTnZ0Sv4Jk9LGjXvVtb+DCaVkfSbboYpLQ1VKjVh+BggnxcbmXvQxwT/L9
	OZ1MPYzh8YR1kbzVxC0DDkoiMBPjKxm9wXlY8uaiFD5kAt+GYAeWwP2yeuAQVpx+nsvIYn
	1LbeWWseqX2NzQjHCH0ebihaPNm2UEE=
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=joerg@thalheim.io smtp.mailfrom=joerg@thalheim.io
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 11 May 2026 09:06:00 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "=?utf-8?B?SsO2cmcgVGhhbGhlaW0=?=" <joerg@thalheim.io>
Message-ID: <91335804a092b09757331cac72092a3835020b3a@thalheim.io>
TLS-Required: No
Subject: Re: [PATCH] config: retry acquiring config.lock for 100ms
To: "Junio C Hamano" <gitster@pobox.com>, "Patrick Steinhardt" <ps@pks.im>
Cc: git@vger.kernel.org
In-Reply-To: <xmqqcxz2vfpa.fsf@gitster.g>
References: <20260403100135.3901610-1-joerg@thalheim.io>
 <adYvSZeN0ZVqwRhi@pks.im> <xmqqcxz2vfpa.fsf@gitster.g>

I am not really sure what you want me to do here.
I don't see how git can have this value configurable, given it's about re=
ading the configuration itself.
Is the user supposed via command line?

Meanwhile the project I was facing this issue, added the required file lo=
ck in its own code,
which has since then worked perfectly to fix my use case: https://github.=
com/raine/workmux/issues/116



May 11, 2026 at 4:32 AM, "Junio C Hamano" <gitster@pobox.com mailto:gitst=
er@pobox.com?to=3D%22Junio%20C%20Hamano%22%20%3Cgitster%40pobox.com%3E > =
wrote:


>=20
>=20Patrick Steinhardt <ps@pks.im> writes:
>=20
>=20>=20
>=20> >=20
>=20> > This bites in practice when running `git worktree add -b` concurr=
ently
> > >  against the same repository. Each invocation makes several writes =
to
> > >  ".git/config" to set up branch tracking, and tooling that creates
> > >  worktrees in parallel sees intermittent failures. Worse, `git work=
tree
> > >  add` does not propagate the failed config write to its exit code: =
the
> > >  worktree is created and the command exits 0, but tracking
> > >  configuration is silently dropped.
> > >=20
>=20>  This very much sounds like a bug that is worth fixing independentl=
y.
> >=20
>=20> >=20
>=20> > The lock is held only for the duration of rewriting a small file,=
 so
> > >  retrying for 100 ms papers over any realistic contention while sti=
ll
> > >  failing fast if a stale lock has been left behind by a crashed
> > >  process. This mirrors what we already do for individual reference
> > >  locks (4ff0f01cb7 (refs: retry acquiring reference locks for 100ms=
,
> > >  2017-08-21)).
> > >=20
>=20>  Famous last words :) Experience tells me that any timeout value th=
at
> >  isn't excessive will eventually be hit in some production system. Wh=
ich
> >  raises the question whether we want to make the timeout configurable=
,
> >  similar to "core.filesRefLockTimeout" and "core.packedRefsTimeout".
> >  ...
> >  Honestly though, I'm not really sure what to make with this. We coul=
d
> >  of course also add some validation that the configuration we want to=
 set
> >  hasn't been modified meanwhile. But that would now lead to a situati=
on
> >  where we have to update every single caller in our tree to make use =
of
> >  the new mechanism, which would be a bunch of work.
> >=20
>=20>  And adding the timeout doesn't really change the status quo, eithe=
r. We
> >  already have the case that we'll happily overwrite changes made by
> >  concurrent processes. The only thing that changes is that we make it
> >  more likely for concurrent changes to succeed.
> >=20
>=20We haven't heard any response to these points raised in the message
> I am responding to. Should I still keep the patch in my tree,
> hoping that a responses may come some day? I am tempted to discard
> the topic as it has been quite a while since we last looked at it.
>=20
>=20Thanks.
>
