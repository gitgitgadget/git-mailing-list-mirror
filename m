Received: from mail.normalmode.org (h01.normalmode.org [157.230.60.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EB237AA63
	for <git@vger.kernel.org>; Fri, 12 Jun 2026 06:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=157.230.60.252
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781244004; cv=none; b=BRhcK5pnBl+BxBaZgC+7bcBITrl3aSaTfP/8Pku9z8JVZ7lfCxRmyfkKLMY3ef9q5duC6qfAAcwBWSgCu76WGGf+uTq3Xvbeiu4Uv5wF70g4UGTYy4rkLyJ7tdbbgAdEsNLwmXxoxgoxJkn9JWj8zxviA0DuFBZqu5kvAHdNIdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781244004; c=relaxed/simple;
	bh=yUkE4bcGp7qWoQtC5JpTFglF3RLZRXWSCljmUwaCnbw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q484TyRiQXcOYsUZAJx2iz9nKBRRTbymvf9u3eTKETsUT8wgYotApsdr34P+/yB2Dl8c2XDbSd2ngD92UJouDLqlZ9IKtaLnD06XQywCbTPAmiL1p4IjJpu6D2W4DgEYudplvNFh2PusKcgPHrffYbsJ9/Mevw2ClBaYBorB/1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us; spf=pass smtp.mailfrom=lfurio.us; dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b=QrFPqpAR; arc=none smtp.client-ip=157.230.60.252
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lfurio.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lfurio.us
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lfurio.us header.i=@lfurio.us header.b="QrFPqpAR"
Received: by mail.normalmode.org (Postfix) with ESMTPSA id AE7B360002;
	Fri, 12 Jun 2026 05:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lfurio.us; s=default;
	t=1781243995; bh=yUkE4bcGp7qWoQtC5JpTFglF3RLZRXWSCljmUwaCnbw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QrFPqpARZ2n5wQTGEMjx28T7Qi3/HN31Kf8N2eHZ99EeUAGp3JBLyoZJxciVbmEva
	 dXbnD5bRf6LFFgFCrCSiIR2nvPuD53Uy951CzPhdrQpCDH+lVmaxRJi1XtMANTuQy0
	 Yu4PmzMQI15h5IbKfnCr/7zUuKzhxtTUwgE+0+Gw=
From: Matt Hunter <m@lfurio.us>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH 0/7] Introduce fetch.followRemoteHEAD config option
Date: Fri, 12 Jun 2026 01:55:36 -0400
Message-ID: <20260612055947.1499497-1-m@lfurio.us>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
References: <DJ19CI50W6UH.17QLIBNTXBWXU@lfurio.us>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git-fetch presently offers some useful ways to control how remote HEAD
symbolic-refs are (or aren't) updated when fetching from remote
repositories.  Namely this is done via the
'remote.<name>.followRemoteHEAD' configuration option.

However, this option can be somewhat painful to use if you prefer a
default other than the "create" option, and often work with multiple
different remote repositories.

This series introduces the option 'fetch.followRemoteHEAD', which
provides a configurable default in place of per-remote settings.

'fetch.followRemoteHEAD' functions exactly the same as the original
option, except that it doesn't allow warning suppression via
'warn-if-not-$branch'.  Given that different remotes will vary their
HEAD and set of branches independently, setting a false-positive
globally in this way doesn't make logical sense.

While it is not mentioned by any of the patches in this series, note
also that the behavior introduced by 012bc566bad7 (remote set-head: set
followRemoteHEAD to "warn" if "always") is unaffected by this series,
and this feature continues to work for only the
'remote.<name>.followRemoteHEAD' option.

Matt Hunter (7):
  fetch: fixup set_head advice for warn-if-not-branch
  doc: explain fetchRemoteHEADWarn advice
  t5510: cleanup remote in followRemoteHEAD dangling ref test
  fetch: rename function report_set_head
  fetch: refactor do_fetch handling of followRemoteHEAD
  fetch: add configuration option fetch.followRemoteHEAD
  fetch: fixup a misaligned comment

 Documentation/config/advice.adoc |   4 ++
 Documentation/config/fetch.adoc  |  19 ++++++
 Documentation/config/remote.adoc |  21 +++---
 builtin/fetch.c                  |  52 +++++++++++----
 remote.h                         |  14 ++--
 t/t5510-fetch.sh                 | 106 +++++++++++++++++++++++++++++++
 6 files changed, 186 insertions(+), 30 deletions(-)


base-commit: 1ff279f3404a482a83fb04c7457e41ab26884aea
-- 
2.54.0

