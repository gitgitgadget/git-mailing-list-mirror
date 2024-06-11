Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677B72AF11
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 08:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718093658; cv=none; b=QF1ZNcJuXfGoRbVhRIlY4/vy1HdOEI5qABj3V+6SSqekDwABtrrBPS0P3kiufsIZJ/q7d33u0ERbxutnARBlF0DAuLBmqPYMRtCjJXKnMiYtpcuZ0xMSZ5r22t1ROWjZxugonh2jvZhzrsXqaYEhVQ9GyEO5pmkpPLC8KyJBuek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718093658; c=relaxed/simple;
	bh=Ci+bqu5clkcnY37E89q2ouEIydK+y6l3YUoR4JPUud0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WlS2omoQW50D7UTxBBSLvK2LNMkB1fjFrHoCBhKjdvFJUPqu47KJYRib9TnXAVzJXPAlp2QWRg7Trut/fDJ2/WEDicdZ35hapec60QGSNvW8ImJNwzMaxuPcccC/dxYxSz+CrzzAUbZrGprfisZKb75UdIlfROJbJgC8bNIUUk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 18507 invoked by uid 109); 11 Jun 2024 08:14:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Jun 2024 08:14:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24647 invoked by uid 111); 11 Jun 2024 08:14:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Jun 2024 04:14:12 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Jun 2024 04:14:14 -0400
From: Jeff King <peff@peff.net>
To: Janne Kiiskila <janne.kiiskila@izumanetworks.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Git 2.45.2 - memory leaks reports by address sanitizer (asan)
Message-ID: <20240611081414.GH3248245@coredump.intra.peff.net>
References: <IA0PR14MB6188120169A3C05677F435A585C62@IA0PR14MB6188.namprd14.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <IA0PR14MB6188120169A3C05677F435A585C62@IA0PR14MB6188.namprd14.prod.outlook.com>

On Mon, Jun 10, 2024 at 02:37:05PM +0000, Janne Kiiskila wrote:

> Seems to me there's a few potential issues:
> - GitHub runners hanging (it should not hang, it should exit with error).
> - Git itself having potential memory leaks.
> - I am misusing the LD_PRELOAD and it can not or does not as I expect?
>   (i.e. it should just slow down the execution, but not report any failures if there are no leaks/other issues).
> 
> I have checked the git repo itself and you do have already some
> address sanitizing test jobs in there so I would assume you do not
> have leaks. 

There are most definitely leaks in Git. In our ASan runs we set
"detect_leaks=0" in ASAN_OPTIONS. We have a separate leak-checking
build, but are working towards having it completely clean. In the
meantime, individual scripts in our test suite are marked as leak-free
(about half of them).

As far as your use of LD_PRELOAD, I'm not sure. Typically you'd compile
with "-fsanitize=address", so the compiler is emitting extra code for
the sanitizer, in addition to linking against libasan. I don't know
enough about ASan to know whether just an LD_PRELOAD is enough to get
useful results. But in general it makes sense to me to only set the
LD_PRELOAD for the program you are interested in testing.

-Peff
