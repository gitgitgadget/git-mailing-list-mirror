Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C0317BA1
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 03:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719805234; cv=none; b=huwBZS1hkh+NZ3JoZn/nOZPa7H5vsEIQ5v8jlDzngLFVd9xc1hf8bPn5shVEIldd2RqnK1vMFI2elWNfrfKLz5LOGfgbk7SgTAhpUwh96WlL7g0XW5ckBAN0rS1CdmuljAy7FTO0kP2MUbyLa5H+PVK3wjAyLpjw5Mj8fSwZRpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719805234; c=relaxed/simple;
	bh=Gz/+TwH6BTiMfNGUQdL/7vPfVXEIlOUsJ4VeIj27Ve8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odnafLGB+nIYJTgWwB5JNaD2hKWgNgUN4X3+M6aFbeu/JI6/V77QaVfOxR5a2j+QhODN6Lk4GMLCP1Q1JDAVPWwQe6NUv+U6OavD585uY+HcV3DL5Zih7bFVRsyrXb6MtygoNrNkDp4ubYmeBycdzUfbAe2ncFwfXV5MrtRa/qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 16922 invoked by uid 109); 1 Jul 2024 03:40:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 01 Jul 2024 03:40:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8457 invoked by uid 111); 1 Jul 2024 03:40:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 30 Jun 2024 23:40:29 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 30 Jun 2024 23:40:31 -0400
From: Jeff King <peff@peff.net>
To: Christian Couder <christian.couder@gmail.com>
Cc: ZheNing Hu <adlternative@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>
Subject: Re: [QUESTION]: How to get uploading git objects via a git command
 in a pre-receive-hook
Message-ID: <20240701034031.GC610406@coredump.intra.peff.net>
References: <CAOLTT8Sb4+_L7TrP8zZvvSqFu0MqbDanOhi6jfxfRLQKRimYzw@mail.gmail.com>
 <CAP8UFD04cvb8k2ZkUYM20B5ym6e8q=KGL4PEDNF8_4x6G32SnQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD04cvb8k2ZkUYM20B5ym6e8q=KGL4PEDNF8_4x6G32SnQ@mail.gmail.com>

On Sat, Jun 29, 2024 at 06:29:41PM +0200, Christian Couder wrote:

> > I want to check the uploaded Git LFS objects in the pre-receive hook
> > of the Git server. Assuming that the Git repository during the upload
> > process is A.git, my current approach is to create an empty repository
> > B.git and then use
> > GIT_ALTERNATE_OBJECT_DIRECTORIES="A.git/objects/tmp_objdir-incoming-**"
> > followed by executing git -C B.git cat-file --batch-check
> > --batch-all-objects to obtain the objects being uploaded, then filter
> > out the LFS objects. This process is very time-consuming, taking
> > roughly more than 10 seconds. I wonder if there's a simpler method?
> 
> I wonder if it's possible to use `git verify-pack --verbose` on the
> received packfile.

By the time the pre-receive hook is running, we've indexed the pack. So
you can just find the pack in the tmpdir (via GIT_QUARANTINE_PATH) and
run "git show-index" against it, which is much faster. Keeping in mind
that the pack could also have been exploded to loose objects if it's
small, in which case you'd need to use "find" or similar to enumerate
the loose object files.

In theory you could use "cat-file --batch-all-objects", but I suspect
the reason it takes a long time is that it has access to all of the
original objects in the repo, too (and so is enumerating those). You
might be able to get away with unsetting various GIT_* variables to
avoid that, but I think the result would be kind of fragile.

-Peff
