Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1597B244687
	for <git@vger.kernel.org>; Fri, 25 Sep 2026 20:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368444; cv=none; b=oA4gvhVCqd7UweJ2UkI4wc/mkHFtch359W0kqeEgqPWgrLR7ckuyEP91jrPsBIKIYFf7Va7XtSqUeApwGwrREkNi4F0seLoOPFehiYJ+tr82grkwiYMmytOchFKDZGggMFjdNhFkUavIPr268YbLnRolXBg7J03ffQJz3PTVFCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368444; c=relaxed/simple;
	bh=+ZdeKrRYc+E+FeIN/fAJ7gOx4hDvX64FAfhGkstrxh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lxif4j3ajqDXQTOdR5BE6t6Tx2iFsHlvB9WhUGIZk4oqAw2XQEwL4LY7HMejKidbCOiU3rY4nxaaO25yQFRtKYNvPIrzaTUUZlGmYIbJKFj0wYh4/2w6+SKIwBh1nsfnmobJa8lsy91hpsO/u4OT8LdH3gX2Ht6HvnSSgD6+NOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dmzXQUVr; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dmzXQUVr"
Received: (qmail 53000 invoked by uid 106); 25 Sep 2026 20:34:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=+ZdeKrRYc+E+FeIN/fAJ7gOx4hDvX64FAfhGkstrxh4=; b=dmzXQUVrP+DKdy9MWjFV0aZ1dWJDMzMOITNJ/sVDKKUVC6fTXuPFiHBEjVJKcHsdtnTVA+kdsbp4HbDOVGJbGvbdxl+VKJ8xYlabwaCR9zWsjD6ZA/j3q55Ti/vhHkmMIZIBGO8x6DB1YeSXe5L3DGpcM+LOo4kZjnj1kiUH6aahaMi/3Ct9Ysk5Kkhz4sAZTMfrtvVIZFIQzYXEVIv+BPlqFazLpuie5jOJebuXM5NdFfq8BTWd2LFIVo8K/zfXar2R+SnP8EMFjWbz6oHVP/Z/Za/Q+cCHaVOH57ASt9BqEBamqwDItd2FD8T1QrFfuVJDiODMlykLQ/+leYQm4A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2026 20:34:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 210142 invoked by uid 111); 25 Sep 2026 20:33:59 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2026 16:33:59 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Sep 2026 16:33:59 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: git@vger.kernel.org
Subject: [PATCH 0/2] some parse_revision_opt() bugfixes
Message-ID: <20260925203359.GA1506705@coredump.intra.peff.net>
References: <74796901-ffb1-4cf3-bd63-7294328f70bc@app.fastmail.com>
 <20260925082636.GA1493716@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260925082636.GA1493716@coredump.intra.peff.net>

On Fri, Sep 25, 2026 at 04:26:36AM -0400, Jeff King wrote:

> > I have bisected this to cd439487 (revision: manage memory ownership of
> > argv in setup_revisions(), 2025-09-19).
> 
> Yep, definitely my fault. I don't have time to do a full write-up now,
> but the most direct solution is:
> [...]
> But I think instead doing this:

I ended up reversing my decision there, for reasons that are explained
in the second commit. But the good news is that doing so also revealed a
related bug that predates even cd439487.

So here are the fixes. I apologize in advance for the length of the
second commit message. At least I feel good about my decision to go to
bed before writing it. ;)

  [1/2]: revision: avoid reporting known options as unknown on error
  [2/2]: revision: handle argv movement in parse_revision_opt()

 revision.c          |  7 +++++--
 t/t4201-shortlog.sh | 11 +++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

-Peff
