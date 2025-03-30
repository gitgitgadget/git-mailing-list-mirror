Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E8F524F
	for <git@vger.kernel.org>; Sun, 30 Mar 2025 10:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743332051; cv=none; b=JmiN19MlfaYBeAvN4UV4jz3ALlOk/IIm40lpRgqa21Naq3/J51hwI4krVEqCOkGVu7J4sMqHykDRclCwx5WQjewxZhKcnurvqyjvVdwErdXmHoLhGduBnq9OWPd4ezjkFKZsznuJ73J+StJafxVJzdvM1aOMp0YwqF2pXK6SiTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743332051; c=relaxed/simple;
	bh=J8rw/YWdmYYLgnoyBt2wa849rJtcYG6Bnn+prXBAE/Q=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=h4DKBrMKz/rse9Oscp0r0GW1y6S+xW4RJL83GHStgmEM40BEXv/s3XHsXRQ+AINbz6uRmbrnIkWu4u4a9MKEprEhGcav8JBf0ZdvHpsumbwSdUFjRNn1Y2bMEFL3idJE8LopPYuoY7K8KrWclGbicOWq/smxysErDfqKTTkaqJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=UzDAllnk; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="UzDAllnk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1743332048; bh=J8rw/YWdmYYLgnoyBt2wa849rJtcYG6Bnn+prXBAE/Q=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=UzDAllnkhVr4PTbD0NxzDMOueaChjoKPYBFmMRatomQF3LAH5Z1dqzFzDUjP98lVu
	 w2oC8OVxeSycwZm/t9TtsIe8/y9Hz0gwcvjjMKFj2UmCiJ81pLhVifF+r+L/65zrzW
	 BxFFkZaDbyDcTX7U/r3roi/PWfpgoLrlZ/8QzTT4=
Received: by mail.normalmode.org (Postfix) with ESMTPSA id 4BB6B616F2;
	Sun, 30 Mar 2025 10:54:08 +0000 (UTC)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 30 Mar 2025 06:54:07 -0400
Message-Id: <D8TJMUMOGLBC.3FR8DHTTUN4M9@lfurio.us>
Cc: "Johannes Sixt" <j6t@kdbg.org>
Subject: Re: [PATCH] revision: fix --left/right-only use with unrelated
 histories
From: "Matt Hunter" <m@lfurio.us>
To: <phillip.wood@dunelm.org.uk>, <git@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a
References: <20250330055809.1019090-1-m@lfurio.us>
 <f8a7d089-3150-4212-8ad0-c9bbb3858776@gmail.com>
In-Reply-To: <f8a7d089-3150-4212-8ad0-c9bbb3858776@gmail.com>

On Sun Mar 30, 2025 at 6:11 AM EDT, Phillip Wood wrote:
> Thank you for adding a test. We have a helper function test_line_count=20
> which provides a helpful debugging message if the comparison fails.=20
> Using that and avoiding process substitutions we'd write
>
> 	sort head >sorted_head &&
> 	sort cmp >sorted_cmp &&
> 	comm -12 sorted_head sorted_cmp >actual &&
> 	test_line_count =3D 0 actual
Thanks for that helper tip.  I was just about to send a v2 when your
message came in, so I'm getting that incorporated now.

By the way, I had originally wanted to write test assertions that
checked the actual number of commit ids returned from each of the two
calls to rev-list - something like:

    git rev-list --X-only HEAD...cmp >file &&
    test_line_count =3D N file

But since I'm not very familiar with this test harness yet, I couldn't
actually figure the correct value for N.  It's not 1 (the commit made in
my test body), and it's not 2 (that commit, plus the one from the setup
case at the top of the file).  Any appropriate higher value wasn't
obvious.

So I switched to what you saw in my v1.  Maybe this "no commit ids in
common" test is actually the stronger assertion?
