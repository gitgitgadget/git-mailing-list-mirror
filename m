Received: from coleridge.oriole.systems (coleridge.oriole.systems [89.238.76.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BB91BF2B
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 09:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.238.76.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728984831; cv=none; b=XKX7IddyzmtLJ1XtnA3nVc6R7MjliSJMG4ljafNfKQYpb+flADtLhkFudjOZF/0Qi/D5NBrzzs5Q2SLenFCiCTQfxIqkMPKSpUzEdX5RJ+k/rIkGEa6YnEMCACq9x7/Bujt3zx/4n+Ocou122qWaX0ZbqfRSCUBHnPewkHynpWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728984831; c=relaxed/simple;
	bh=VkYXs8fekPFgvJ/DXD7ZCVU6FMLmg9R4zPjn4cbLfjQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i6iK25KgUYlCCY5Eran12a74kmGUzaeAfmUov4mq1TksX5n4vppBnQtNXs19xDeglA5/us71e6G79vd6FNqT6nxANkahdxXW2tKjuHm0SQDAVIXD+3Jvy4c9k6O7x3IOlNydbBQoo/L+qRFGu7ikwYqGaaoDokkZgpNpf5Xf3nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems; spf=pass smtp.mailfrom=oriole.systems; dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b=e8/xD4Fy; arc=none smtp.client-ip=89.238.76.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oriole.systems
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oriole.systems
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oriole.systems header.i=@oriole.systems header.b="e8/xD4Fy"
Date: Tue, 15 Oct 2024 11:33:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=oriole.systems;
	s=canary-202303; t=1728984816;
	bh=VkYXs8fekPFgvJ/DXD7ZCVU6FMLmg9R4zPjn4cbLfjQ=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:In-Reply-To:From:Sender:
	 Reply-To:Subject:Date:Message-Id:To:Cc:Mime-Version:Content-Type:
	 Content-Transfer-Encoding:In-Reply-To:References;
	b=e8/xD4FyE1jiyDF797bRY2/WAZ7ftiC9sC03VMBIZUPaJEAKdbvYw6ANNI5UJXocV
	 O7theuu/9I1hYIm3WdtRSr272t256D/UUCmgDues9mmmpH92UWLbTUTNlYJytxUDwb
	 9gFbj3TucdkGiiJvKur4cfFJVRkzaDaBNr+q8CvLzVuCCsZZTN9EplSS631gVrO3HF
	 ephvhdQaEYYK+xbyJEE0FTMtj9TuIe7cnZHYYJHGwDI4hti+P60sW+9T9Z64Qluyee
	 oVYc0ZUupdIyHvp66RU/D0sE0NZZXdXAIxdBPdJ6qajK/0ym19HVAGjjgPb+tyRPO8
	 ohb58CuCRFmpQ==
From: Wolfgang =?utf-8?Q?M=C3=BCller?= <wolf@oriole.systems>
To: git@vger.kernel.org
Subject: Re: [RFC PATCH] builtin/shortlog: explicitly set hash algo when
 there is no repo
Message-ID: <r4btv3hmwv6haflwhmjbjshova4wnth5mkbknsuuqcvose5lix@bvy5e6gxnit6>
Mail-Followup-To: git@vger.kernel.org
References: <20241011183445.229228-1-wolf@oriole.systems>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241011183445.229228-1-wolf@oriole.systems>

On 2024-10-11 20:34, Wolfgang Müller wrote:
> Whilst git-shortlog(1) does not explicitly need any repository
> information when run without reference to one, it still parses some of
> its arguments with parse_revision_opt() which assumes that the hash
> algorithm is set. However, in c8aed5e8da (repository: stop setting SHA1
> as the default object hash, 2024-05-07) we stopped setting up a default
> hash algorithm and instead require commands to set it up explicitly.
> 
> This was done for most other commands like in ab274909d4 (builtin/diff:
> explicitly set hash algo when there is no repo, 2024-05-07) but was
> missed for builtin/shortlog, making git-shortlog(1) segfault outside of
> a repository when given arguments like --author that trigger a call to
> parse_revision_opt().
> 
> Fix this for now by explicitly setting the hash algorithm to SHA1.
> 
> Signed-off-by: Wolfgang Müller <wolf@oriole.systems>
> ---
> I think there is a much cleaner patch here if one would look at
> disentangling the parsing machinery split between cmd_shortlog() and
> parse_revision_opt() such that the latter is only called if there is an
> actual repository, but I'm not at all familiar enough with the codebase
> to do that. Like the commit says some other commands were fixed like
> this as well, so I thought to send this patch your way.

Was this topic maybe missed? It's not a critical fix but would solve a
segfault that is pretty easy for a user to trigger.

Thanks!

-- 
Wolf
