Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB82D05E
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 13:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837662; cv=none; b=jciyIfiSEu2YcBQ4RWP18hqvXZNd8GGKlGSoNdpyYoBusN9/IvJQdjCqZRkARlVLOlRfplQenZEDVD8G1b1EqgtFUSc3aoL3pNiblrDjCMtW36Sah4GG1oNNhnNHBKip6fhQHrPZyC+1eFfMePkAThP5Oc+eVJ2J24UjUGbbPjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837662; c=relaxed/simple;
	bh=JwvcIqxsJA4vAT+oGBI55UEPTKOTi1/Bgf4DHlKHTrE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fh26bCV/M6rsxcd7i6bQ6Hg6mCG55hNUeAJ85LMz8x76wXIS0dRuR/pgA7JVc7/EJMKUQw3wEqtqtAAg28eqO0vNHlP+adjt+AUucNRpHNyl4YJMzfBvfemxMnky1qxyscNwojYOPfkfR8R+i/K1v+IZLo30dPn/JR6AvnXlkPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 1259 invoked by uid 109); 20 Sep 2024 13:07:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 20 Sep 2024 13:07:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7372 invoked by uid 1000); 20 Sep 2024 13:07:29 -0000
Date: Fri, 20 Sep 2024 09:07:29 -0400
From: Jeff King <peff@peff.net>
To: Olaf Hering <olaf@aepfle.de>
Cc: Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: BUG: diffcore-rename.c:1674: tracking failed somehow; failed to
 find associated dst for broken pair
Message-ID: <20240920130729.GA7349@peff.net>
References: <20240920112228.3d1130f5.olaf@aepfle.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240920112228.3d1130f5.olaf@aepfle.de>

On Fri, Sep 20, 2024 at 11:22:28AM +0200, Olaf Hering wrote:

> The following issue left my terminal in a weird state.
> Is this a bug in the repository, or a bug in git 2.43/46?
> 
> set -ex
> pushd /dev/shm
> test -d x.git || git clone https://github.com/intel/linux-sgx.git x.git
> cd $_
> git checkout -b $PPID.$$ a53adeaab7a8176fabb415bfcdf6d29fe4060678
> d=external/ippcp_internal/inc
> git log -p -b -B -w --stat --follow "$d" |& tail
> cd $d
> git log -p -b -B -w --stat --follow . |& tail

Definitely a bug in Git, since we're hitting a BUG(). Looks like it
reproduces with just "-B --follow" on the path in question. Bisecting
leads to 9db2ac5616 (diffcore-rename: accelerate rename_dst setup,
2020-12-11). +cc Elijah.

-Peff
