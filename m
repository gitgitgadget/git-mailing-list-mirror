Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3904B672
	for <git@vger.kernel.org>; Fri,  2 Jan 2026 07:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767340531; cv=none; b=nvA4r1aJ08DMgO/N/pan3tQ/ursB4XvaazhIcYPQ0QCzHrbiabqVwEC0jwaKJTZFsqWXgJ/oWk/C95mlUmvsTsGBsdpEkdT8WgZvyH8MQ/BvBOHMzjVJxUJXSfBXeLk5IKW6IS6Bas1y5how4dVE0ZSpRL+29LNI585LPin0N4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767340531; c=relaxed/simple;
	bh=Kxy9qJGSvRqCHNnc657er/jbkFZwET9x4ipbpvJ9zVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tlhlL4FmnFl+n9HQ3VJxNwMR4LrSHoGqU1hR0wkujGvYMplq8iZZ5tfq3S5080HFoqhMLGjQbNJlKMfQNionWMsNvkqewA97MrujQV+ZnRJN/817Z7CIrLNOwaRx+a4FSKidAd52Qz5wwkDnJK8OrOIfAusu7aESM5FVFRuRclU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Zll/QF6z; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Zll/QF6z"
Received: (qmail 553249 invoked by uid 109); 2 Jan 2026 07:55:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:content-transfer-encoding:in-reply-to; s=20240930; bh=Kxy9qJGSvRqCHNnc657er/jbkFZwET9x4ipbpvJ9zVY=; b=Zll/QF6zPinYCMb+t9bXDePdeAgT3tF4kTno8HNqS3tI6cqWdPJ68l9ulmB9CEKGITlKumsezIbfV4forzMOwD6wrAnJRyQAKVbZFlLH/umt24A3E0BliEWI1ygwt1HV2V/ePhxC7hAGxyVMiaUAAHfu3xWlwEfuVG1SRsAtiL9PkmubOlrgKA6P7ZCyVph4Y6uzsxGkDJJHqKgc7tlug5VwBOIib9zvb4nVRIv67FidOy6BPZRXRWDmgBGsXBRX/M+Mp9hdB0GGjPNo3yWkvrIdR9jqRoKiEINE8ywVqTqSh7PWhvBPDUV5hY4En7QlDCu2sAdzNyI6F6yRmmtzEg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Jan 2026 07:55:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 719917 invoked by uid 111); 2 Jan 2026 07:55:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Jan 2026 02:55:32 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Jan 2026 02:55:28 -0500
From: Jeff King <peff@peff.net>
To: Hadmut Danisch <hadmut@danisch.de>
Cc: git@vger.kernel.org
Subject: Re: Git destroys u+s and g+s directory modes
Message-ID: <20260102075528.GE2581074@coredump.intra.peff.net>
References: <eb36360d-f539-4f77-b175-57330ef05eac@danisch.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <eb36360d-f539-4f77-b175-57330ef05eac@danisch.de>

On Sat, Dec 27, 2025 at 03:37:51AM +0100, Hadmut Danisch wrote:

> I do have a problem with git 2.43.0 (ubuntu server 24.04.3) and directory
> modes:
> 
> 
> I do need my git repo (owned by me) to be readable by a system user (running
> a rootless podman container).
> 
> I therefore set a special group for the directory, and set the sgid bit of
> the directory ( chgrp ... and chmod 2770 ), but when doing a git clone onto
> that directory, git rewrites all file modes, including the one of the root
> directory, and the  S_ISGID is lost.

Can you show more exactly what commands you're running? From your
description, it sounds like this:

  mkdir clone

  # just a convenient group that I happen to be in but which is not the
  # default
  chgrp audio clone
  chmod 2770 clone

  ls -ld clone
  git clone $SOME_URL clone
  ls -ld clone clone/* clone/*/* clone/.git

Before the clone, I have:

  drwxrws--- 2 peff audio 4096 Jan  2 02:53 clone

and after:

  drwxrws--- 4 peff audio 4096 Jan  2 02:53 clone
  drwxrwsr-x 8 peff audio 4096 Jan  2 02:53 clone/.git
  drwxrwsr-x 2 peff audio 4096 Jan  2 02:53 clone/sub
  -rw-rw-r-- 1 peff audio    8 Jan  2 02:53 clone/sub/file

So the sgid bits were preserved and propagated to subdirectories, and
everything was added to the correct group. Do you get different results?
Or does my recipe not match what you're trying to do?

-Peff
