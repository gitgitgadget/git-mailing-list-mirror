Received: from mail2.viabit.com (mail2.viabit.com [65.246.80.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82999197A98
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 12:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.246.80.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730376930; cv=none; b=rfpCRh/or2Uq4K3iIaVIia1wfrIW8eN7Y0F8gsti/4uYP573r9s5pLUZ+V1f0iIfXJKOA2iVWmXV7bBK3Y1MYlyIGox9HH5judEQY/sqFNXk+RMBshHIlRxaaM99SgxQEABmjGM8QvoB6p1VXyn6FQcEjJmXCWvlP2baVqsKfH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730376930; c=relaxed/simple;
	bh=LsxCTp2AfVEm8godqlqumGPdG/3BLVNQr8LtgwCuRjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iOT/bZAkQHJc3wuIPN8yR4KfVcedpiZtt2QBQPWhmkfX9sBt8wY0UqSxk9q3cWcg7GRk8LKHEaomvj0S6UKFDHAnyQDkY64tKBYZ3lUMgOfdfrGHgrz2akR8SPNhQs+WY17a8y7CLO0IDHl+8SXj/MZoCRPlqn33kK3LzCvnEFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orlitzky.com; spf=pass smtp.mailfrom=orlitzky.com; dkim=pass (1024-bit key) header.d=orlitzky.com header.i=@orlitzky.com header.b=qNtfdDWh; arc=none smtp.client-ip=65.246.80.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=orlitzky.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=orlitzky.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=orlitzky.com header.i=@orlitzky.com header.b="qNtfdDWh"
Received: from mertle.michael.orlitzky.com (vpn1.metro-data.com [65.213.236.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail2.viabit.com (Postfix) with ESMTPSA id 4XfNHJ6wh7z3wnl;
	Thu, 31 Oct 2024 08:15:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=orlitzky.com; s=mail2;
	t=1730376925; bh=LsxCTp2AfVEm8godqlqumGPdG/3BLVNQr8LtgwCuRjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=qNtfdDWh2rLoe1FtUGAImNWN8Q2PNuVs4CWLz/eBXZHhh3dBEBKC7TCaBP0tZsqQt
	 EQyWs8ym0sKj2lEySLvAVO6OVEOAZFZ0Z3lBtefPhrElb6HiuSIpxDD0X2/XIpUkBF
	 FHsDzl7Psep7Op7EboEkdgBFCaijgMuMxeZw4KG8=
Received: by mertle.michael.orlitzky.com (Postfix, from userid 1000)
	id 7D34512C258E; Thu, 31 Oct 2024 08:15:24 -0400 (EDT)
Date: Thu, 31 Oct 2024 08:15:24 -0400
From: Michael Orlitzky <michael@orlitzky.com>
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: safe.directory warnings for root-owned repositories
Message-ID: <ZyN03D8os53XJGDo@mertle>
References: <ZyMGKHTnZDQ5JVuo@mertle>
 <D59QZ1P3KSNB.ZXDHUA5HGC97@pm.me>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <D59QZ1P3KSNB.ZXDHUA5HGC97@pm.me>

On 2024-10-31 05:38:00, Caleb White wrote:
> 
> The dubious ownership check simply reports that the directory is owned by
> someone other than the user running the command, with no special handling
> for the root user. While the error might not make the most sense in this
> context, I'm not sure that it's worth special-casing the root user
> (really the user with id = 0 as it might not be named `root`) in the
> implementation.
> 
> Why would you initialize a repository as `root` in the first place?

To avoid the dubious ownership warning, obviously :)

These are shared repositories that I and my coworkers push to over
SSH. Write access is granted via ACLs, with ownership being mostly
irrelevant. (This is still "unsafe," but not for the stated reason.)

I don't necessarily have a problem with adding O(m*n) safe.directory
entries, but every once in a while someone will ask me about it, and I
don't have a good answer for why it's not safe to push to a repository
that's owned by root. I guess it's just more annoying to have to
override the warning when the warning is wrong. Though if it was
changed to "dubious repository writability," I wouldn't be able to
complain any more.
