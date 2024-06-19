Received: from dcvr.yhbt.net (dcvr.yhbt.net [173.255.242.215])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E80982495
	for <git@vger.kernel.org>; Wed, 19 Jun 2024 18:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.255.242.215
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718820489; cv=none; b=fHulwUFniyWUcSHMs4ws3gGPDBVoAPxTcONectPASgMnebMcZw+8O1koXLyIfXaNiWHZkYLCNtYYWcreQsE6KWYNjyGBJFrMW/t7TiBJUcz1wis7E2V8Z2PQrOuZT0R9lFvKJNx6mkm1X48vxbKpTGiEoUDdzfD8AnbLky86+2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718820489; c=relaxed/simple;
	bh=Ch+2m1e5o5sKKMRknlFgv23noOEXXl+UpIugtGRYIrA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dLRnobrgUM2XU06ACXrByIHAzAQIgZkIfC5Fzlm1fodVaQWihzPWgDro8wknZ1EB5BmcNx8VTXUSdyhPj1sL5Kt/5ukl2agJaRblyzo1AS9Fshnj3VH/taFqwn4MdcgDnVEjm1PGEvWrhMLeRd4wDDTXMtgbs7Z6IuNUlVVLiDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org; spf=pass smtp.mailfrom=80x24.org; dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b=15AhC5aI; arc=none smtp.client-ip=173.255.242.215
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=80x24.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=80x24.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=80x24.org header.i=@80x24.org header.b="15AhC5aI"
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 55DE7D48B4;
	Wed, 19 Jun 2024 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=80x24.org;
	s=selector1; t=1718820487;
	bh=Ch+2m1e5o5sKKMRknlFgv23noOEXXl+UpIugtGRYIrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=15AhC5aI4xA4Xmz2yxz3ItcKEMm8mWc1BRG2ZlN02u1WOoldckCf9SUfg2YihNe44
	 VMKdY0rY9d86AE4KQ5m+8UKRddI+gC4D9Cz7dg81sAEJFBnLdll6NYWEKw6HvJfNEQ
	 SsAn8dyYtVxhyGdPrirhSPFdCW+bcBS9a8W0O2fo=
Date: Wed, 19 Jun 2024 18:08:07 +0000
From: Eric Wong <e@80x24.org>
To: phillip.wood@dunelm.org.uk
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] t9700: ensure cat-file info isn't buffered by default
Message-ID: <20240619180807.M97115@dcvr>
References: <20240617104326.3522535-1-e@80x24.org>
 <20240617104326.3522535-3-e@80x24.org>
 <6e80eea5-b6ce-4218-8c43-dde2b5a698f5@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e80eea5-b6ce-4218-8c43-dde2b5a698f5@gmail.com>

Phillip Wood <phillip.wood123@gmail.com> wrote:
> Hi Eric
> 
> On 17/06/2024 11:43, Eric Wong wrote:
> > +# ensure --batch-check is unbuffered by default
> > +my ($pid, $in, $out, $ctx) = $r->command_bidi_pipe(qw(cat-file --batch-check));
> > +print $out $file1hash, "\n" or die $!;
> 
> It's been a while since I did any perl scripting and I'm not clear whether
> $out is buffered or not and if it is whether it is guaranteed to be flushed
> when we print "\n". It might be worth adding a explicit flush so it is clear
> that any deadlocks come from cat-file and not our test code.

Pipes and sockets created by Perl are always unbuffered since
5.8, at least.  If they were buffered, Git.pm users (including
git-svn) wouldn't have worked at all.

> > +my $info = <$in>;
> 
> Is there an easy way to add a timeout to this read so that the failure mode
> isn't "the test hangs without printing anything"? I'm not sure that failure
> mode is easy to diagnose from our CI output as it is hard to tell which test
> caused the CI to timeout and it takes ages for the CI to time out.

Yeah, select() has been added in v2.
