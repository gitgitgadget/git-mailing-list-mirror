Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68CD8173
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 00:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729469513; cv=none; b=glY0STz08Kp8aB2GukWWpAzsZX/NKyErTHuREFVWrutn2ie5xw64bzoOOUxSl2TYfT9rdraadkkmmOZVwPeqxqCf9+CdVXE6Mb0BJStlfJyrqTXbfCDSumrIU27ALrb6DH6+woJZnE6OpKiROC1C+1a5RXvYvh3kPRcpVoJpZMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729469513; c=relaxed/simple;
	bh=+ALLAPaIvMkuRowR+GIX5O2BNsWphCROSWh9Vxdsks8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oIi3D8EXF/xSGG2k8Iz6WvHb05niMXxSbR+SvYPqnSexXOcPJ6QqnmbNLZe0aKY03go04jCBhSjlOpUY7T2VqpRZfUH9YN4cRNWZlE0CAyGrwQt2eL/G2Y9DNhErz9TAGseNuLMHCWd1V7kgo17PQM7/6dIRraFmUSgnnH0sUzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=dA8ux1Nq; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="dA8ux1Nq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=2s44w7ermrdupo7hxefo773xsy.protonmail; t=1729469496; x=1729728696;
	bh=+ALLAPaIvMkuRowR+GIX5O2BNsWphCROSWh9Vxdsks8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=dA8ux1Nq1iYYssyPin/Pi7u2OcbyK4ZhbLp4TwOmZImEdm98lZog/lW9Htz5x3rfq
	 4Xywxnii+LfRY9BvqEVht/nBHPUFfk1yVRPK3cSsQ6taB/1PZfG7QExoi1d/aIWsym
	 KYSrA/w6qPY+njt8Vy/u01vcut19z4/xzLZGwi28UXhLuSa3EUbydHOAutBA62emHh
	 Ouw1wDKyIVrGklvDf/PIhqa4B/Ygtsh2yysTTedPZIxd9dxSrk5rMasqI6yUcenq+7
	 +8sSdOEK6KU8nYS2PFpNnc+b87Jzngkk9zzAs4BcRsBzTtvVFhiMRJLUO9X2bsMHZ1
	 +zWuAsI3IJ3Og==
Date: Mon, 21 Oct 2024 00:11:33 +0000
To: Jeff King <peff@peff.net>
From: Philip Yung <y5c4l3@proton.me>
Cc: Y5 via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH] diff: setup pager only before diff contents truly ready
Message-ID: <UZMh2lyzbLOgsf0PXfMnq6HnWVnCK3y36jY3IMKUykPi74ztNucf8bgywoeO0DdeApq31JDDGMZiEya99zAcI3l8y_zcVqiN8FpEnT1DRZU=@proton.me>
In-Reply-To: <20241019211938.GA589728@coredump.intra.peff.net>
References: <pull.1817.git.git.1729370390416.gitgitgadget@gmail.com> <20241019211938.GA589728@coredump.intra.peff.net>
Feedback-ID: 50531228:user:proton
X-Pm-Message-ID: b716af7e4d3a448479cd23a13d73b3444dcd4a56
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

> errors will likewise go to the pager. E.g., try "git log --foo".

Hope that I didn't take it the wrong way, but I don't think `git log --foo`
starts a pager, where the routine `setup_pager()` is put after argv parsing=
.
(checked by `strace`)

> So I dunno. I'm not strictly opposed to making things nicer when we can
> do so easily. But the endgame of this is probably getting rid of
> USE_PAGER entirely and asking each builtin to decide when to commit to
> using the pager (presumably after option parsing).
>=20
> And even then, it wouldn't apply to commands implemented as an external
> process. And of course we can still die(), etc, after starting the
> pager. So it would never be totally consistent.

Despite the example, it is overall convincing since currently there is no d=
esign
to ensure the pager consistency. However, it's something we can do right no=
w to
make, at least our own builtins, more consistent.

> We usually ask for something approaching a legal name, as this sign-off
> is supposed to be certifying the DCO (see the "dco" section in
> Documentation/SubmittingPatches).

Sorry if my first GitGitGadget experience bothers the mailing list, thanks =
for
the reminder. :)

> would be missing a spot that needed a new setup_diff_pager() call, and I
> suspect we don't have good test coverage here.

This is actually my concern as well when I was naively testing the coverage
using GDB, which turned out to be quite tedious. Would you consider it's fi=
ne to
add a pager consistency test for builtins, probably in another patch with r=
egard
to `t7006-pager.sh` OR a new test `t7007`?

I'll reword and re-signoff this patch as soon as it looks really fine to yo=
u.

Philip Yung
Best Regards
