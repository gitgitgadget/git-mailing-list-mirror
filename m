Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8354C2E2295
	for <git@vger.kernel.org>; Tue, 19 Aug 2025 19:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755631208; cv=none; b=RZulQhCWU1rgn+MCfGBdPTzQRURpMn7Og7IVSzxmaVqe07MC4T3DWN9sCbB1DHniioADysMTdQsToVRSVe293gQsOfrnDh+jye99aA9QRyInw9CfMa4Mm+Fk25FXW+vqY+tojHwzn1PmY6f08OttxsjKcMJuv7v6Ca4TLrftnX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755631208; c=relaxed/simple;
	bh=W2DJUXMxYKGZ20/e+7vVNoshKZ3wKHcyP6F+2lJmkfs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=SFQri2Nx0E0ofCK0lWYw64TGjSyXh6Y4DpBekskWTbatyOhxHGuOx6hyEkt79f7GAXOpqEJ2vyUFC7RXFslbxcTUY38bbScqT2qI5jlokS24uYgUnWKBY6PWn9c/PMOtgTN8hlm4Vevni8fYH7HiGhRFh9CBYxMSl0N9nBGR6iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Qdqc6T3K; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Qdqc6T3K"
Received: (qmail 31166 invoked by uid 109); 19 Aug 2025 19:20:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:mime-version:content-type; s=20240930; bh=W2DJUXMxYKGZ20/e+7vVNoshKZ3wKHcyP6F+2lJmkfs=; b=Qdqc6T3KwgZ/KRHJzc3XUSGlk5GjoS17QnK6TiiGaFijtjSoQCKKrKRV3i/VD1+1WiO85+rxfSj1f2siNUrjQBX6TPH1j4UK3oRPe+w6Dk2JtYdZ5o+CpHYAOK+E7GTG6Lzdbegdon+P2id3E7vHoDkwmDsDF71vNXi5TRD8qQ6lzyY68/Z91vqtn3OwLQjBbElHNU14h18BcfRPs/D6QdTxTkiMkw93sbYD8/A5qDoAhw1qPhIDte/faGBMLNvnDCS6g+5TIfvet9SEYmZf5nEXuadAEpeF9prqSW2BW81D6Gus1nCEoouYUkfgN0S1W1BtR+w+bOg5PFtOjCcUzg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Aug 2025 19:20:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 46338 invoked by uid 111); 19 Aug 2025 19:20:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Aug 2025 15:20:04 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Aug 2025 15:20:04 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 0/4] dangling symrefs and fetchRemoteHEAD=create
Message-ID: <20250819192004.GA1058857@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

This fixes a bug I found while investigating another semi-related bug
(that has already been fixed by Patrick), mentioned in the "PS" here:

  https://lore.kernel.org/git/20250724104536.GA1316505@coredump.intra.peff.net/

The issue is that:

  git remote add -m does-not-exist origin <url>
  git config remote.origin.followRemoteHEAD create
  git fetch

will overwrite the refs/remotes/origin/HEAD we created, even though we
asked it to do so only on creation. The issue is actually in the refs
code, and how it perceives dangling symrefs with respect to creation
events. And so this actually affects "update-ref", as well.

A fix is in the final patch, along with a detailed explanation. The
earlier patches are just cleanup of the related test script before we
add our new test there.

  [1/4]: t5510: make confusing config cleanup more explicit
  [2/4]: t5510: stop changing top-level working directory
  [3/4]: t5510: prefer "git -C" to subshell for followRemoteHEAD tests
  [4/4]: refs: do not clobber dangling symrefs

 refs/files-backend.c    |  34 ++-
 refs/reftable-backend.c |  30 ++-
 t/t1400-update-ref.sh   |  21 ++
 t/t5510-fetch.sh        | 543 ++++++++++++++++++----------------------
 4 files changed, 319 insertions(+), 309 deletions(-)

-Peff
