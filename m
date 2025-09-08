Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F407404E
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 00:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757289948; cv=none; b=qvorpWynooxBDRjGzU0PBCbsX+M8iC9q6dwGZSNOx0wvK/t1wEuIpjxkW1SQ1sVCQgGBXwiQjv2E4xvQkcfz5kdjE/H5ykhk7lnkLrrGbNeuQr3mnmsPcuH5iUdktO+THzeSsPD04PIgMXDxQ5zjDLGL5KH8XRHA/uPKVim6qFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757289948; c=relaxed/simple;
	bh=BxGskf5QQ9H6ke+Nmh1FS8/WP/FaOLlCYpMysGjAr+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMJ9zDWbLfLhXz0JBermm/GoDVNVy2Mx6TqGY7ndIbNE4cKIbmlELFNj0RRtMy1uFMIgp/1CCDLZW9z4stWmSYKHeykCtW+9d8TKE6/FfmF0+DGWArdbD440CaIlR3yRKLbczjjJdhqSd/dShdWaor1itELt3NulFfOuhSFM2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=QtCKjM/P; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="QtCKjM/P"
Received: (qmail 13731 invoked by uid 109); 8 Sep 2025 00:05:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=BxGskf5QQ9H6ke+Nmh1FS8/WP/FaOLlCYpMysGjAr+0=; b=QtCKjM/PEnJgvHMt89f2rrH2yrW1175FerhUsFeb5c+y/yJyPqBzZqJpldk86da6KNkrxgiabW6O7osIicLjvJvrgkhgnQ39XrSEkapWZDCW1Z/OyynHKfcRGlHReE3RM+LVcSOVotQTnrCSma2zzs6TTSCui7yKsDQ4vqrBuiO9tM5nQp4oFQkZQWzj0SB0XxNGJ7E2vCM482+gbi/UMmqdp/mYj2Jn5FZtLKFIp+/XKEnXf5ACPF+R07hiSxwL0CjwNq86IOt4XZ0wg9SWZalSyvMPcth4laKKsc5BUK2wGQmJBj+BNw3Btzn63Aexdstnn+VWDlbODfuMawcY3w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 08 Sep 2025 00:05:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23823 invoked by uid 111); 8 Sep 2025 00:05:44 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 07 Sep 2025 20:05:44 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 7 Sep 2025 20:05:43 -0400
From: Jeff King <peff@peff.net>
To: Milan Hauth <milahu@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Git dumb HTTP protocol should work without update-server-info
Message-ID: <20250908000543.GB1281511@coredump.intra.peff.net>
References: <CAGiEHCtP29bQRsEyLabNrLuiP96P-o7EEGi88B7pJbP0tfprxw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGiEHCtP29bQRsEyLabNrLuiP96P-o7EEGi88B7pJbP0tfprxw@mail.gmail.com>

On Sun, Sep 07, 2025 at 01:24:13PM +0200, Milan Hauth wrote:

> expected:
> dumb http remotes should behave like file remotes

File remotes are running a local git-upload-pack to act as the server.
A dumb http remote can't run anything on the server side. So we are
stuck pretending that the http endpoint is a filesystem. Besides
performing terribly, as brian noted it is not even portable to do,
since there is no readdir() equivalent (and things like httpdirfs have
to resort to scraping auto-generated directory listings).

If you want to go that route, I think you're better off using a fuse
wrapper and just letting Git work against the mounted filesystem, as you
tried here:

> as another workaround
> i tried to mount the .git/ directory with httpdirfs
> but httpdirfs fails to mount git repos, see
> https://github.com/fangfufu/httpdirfs/issues/183

I think this does work. The instructions you gave there won't do it,
though, because python's http.server module doesn't support range
requests.

Something like:

  sudo apt install python3-rangehttpserver
  (cd /path/to/repo && python -m RangeHTTPServer)
  mkdir mnt
  sudo httpdirfs http://localhost:8000/.git mnt

got me a mount that worked with:

  # you could probably avoid sudo here with better mount perms above
  sudo git clone mnt foo

It's painfully slow, though.

Possibly dumb-http could learn to do the same scraping that httpdirfs
does to get the refs and pack listings (though this might be quite slow
for unpacked refs, if the ref tree is deep). But I doubt you will find
anybody that enthused about working on or reviewing dumb-http patches
these days. The code is not very well maintained, IMO.

-Peff
