Received: from out-188.mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57CD1F1937
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737463063; cv=none; b=hSfHp8F2updjw4rTBOivYwZrlHPAfOTyxKL1kXSbeUOb+XPNxBzXhfcKF0QV+Yh1JWOkyIsK8gsjBiyHWp/Qd8GDvHRQ1MBqJ/MNHD7QKo0BCppuDC5G57xp/dNzBVKBoMSCtMoBhJDIWd7ksaOCe4uv2fikIbW3ha0dSq//5b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737463063; c=relaxed/simple;
	bh=xOh3npxCuWavOJYE2/HHe/BEMMbjVkEjl7kAABUOh1U=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iiuCj1VDILG0J+OCy2FzehHwFIFvWPagX8CAa0xaCM8/1MoKOFeGh+fVcpQY65iXbH30ht8cwgw+nyX/lH8SoOYie4AZoi1y49VCw9Mt5+ndv6JwPtqQut2t6BqnhHt7zMqDr1NpYZXHHTyBv3Ie1vpjoMMSDRkECZRqL8EQPNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=oECYbHcW; arc=none smtp.client-ip=95.215.58.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="oECYbHcW"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1737463055;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QblvnwnT5dtEOlJutyY8HkgKfIzJ9v3h1Fw1wew6/ak=;
	b=oECYbHcWeb3NBcoUQOr5kyCl0i6yEvxJ+Y+2ycAx+mq6gjg7dRQhbFmBqylRtA+L4yWmtH
	KBj4GJn/wg8E5oW9zAcLzG7PgONvRzKgKkAf0t76CEqAOpNzC0caEcebO+VvrizA3/lPiZ
	RxHBREotA+bVoQ+qZ2L3jzkrs86AREE=
From: Toon Claes <toon@iotcl.com>
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Evan Martin <evan.martin@gmail.com>, Eli Schwartz
 <eschwartz@gentoo.org>, Junio C Hamano <gitster@pobox.com>, M Hickford
 <mirth.hickford@gmail.com>
Subject: Re: [PATCH v2 06/11] meson: wire up generation of distribution archive
In-Reply-To: <20250114-b4-pks-meson-additions-v2-6-8d7ec676cfd9@pks.im>
References: <20250114-b4-pks-meson-additions-v2-0-8d7ec676cfd9@pks.im>
 <20250114-b4-pks-meson-additions-v2-6-8d7ec676cfd9@pks.im>
Date: Tue, 21 Jan 2025 13:37:23 +0100
Message-ID: <87plkgibr0.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Patrick Steinhardt <ps@pks.im> writes:

> Meson knows to generate distribution archives via `meson dist`. In
> addition to generating the archive itself, this target also knows to
> compile and execute tests from that archive, which helps to ensure that
> the result is an adequate drop-in replacement for the versioned project.
>
> While this already works as-is, one omission is that we don't propagate
> the commit that this is built from into the resulting archive. This can
> be fixed though by adding a distribution script that propagates the
> version into the "version" file, which GIT-VERSION-GEN knows to read if
> present.
>
> Use GIT-VERSION-GEN to populate that file. As the script is executed in
> the build directory, not in the directory where we generate the archive,
> we have adapt it to honor the "MESON_DIST_ROOT" environment variable.

I failed to understand why you couldn't pass the absolute path of the
output file to GIT-VERSION-GEN. So I looked at the previous version of
this patch, and it seems you explain better over there.

I was testing things locally and tried this line for the last argument
to the script:

  run_command(shell, '-c', 'echo $MESON_DIST_ROOT', capture: true, check: true).stdout().strip() / 'version',

And I think I understand it better now. Meson does not execute this when
you run `meson dist`, but when it (re)generates it's build files. At
that stage $MESON_DIST_ROOT is not set.

It's unfortunate we have to learn GIT-VERSION-GEN about the
$MESON_DIST_ROOT environment variable, but I don't see any other way.


--
Toon
