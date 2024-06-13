Received: from smarthost05.digicable.hu (smarthost05.digicable.hu [94.21.128.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8442933F6
	for <git@vger.kernel.org>; Thu, 13 Jun 2024 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.21.128.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718268006; cv=none; b=YoE0ydMj7isR0wF2YjJyaFAicyF3n/rP5Szo9UyWKC37MCjcNHFQzC88y6XZYIx3FKsSkJ+lvs9WCNFIN7fuZfUDycD3dFwXK5vqn85gI36A1iPE+cP3qRDwlB+aGfjBvEhOsQ2CmfHAR5rILQB9V+Ww22hEpf5RYEfSs/97sX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718268006; c=relaxed/simple;
	bh=Cgq1gbvBNJ2l4IYOgfnZjoMr7hWvhsJeKjfFsNbQ6qs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HEc79CmphHX3V7F6bORxzMFjUoVKVWc2fjK2+YLP00JfQblbrbBv9s7RCAEyVZKksL5SaXhxlDZciJzVI8qVCntUucswbkmCFpbPwB8tWv4W6G1sCPDtSywct4HXNhQa9txI2w/sTcAVRrETU/PAi0oeO7t7lWJ+TLIkaCmjEEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikabel.hu; spf=pass smtp.mailfrom=digikabel.hu; arc=none smtp.client-ip=94.21.128.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=digikabel.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digikabel.hu
Received: from [92.249.128.189] (helo=relay01.digicable.hu)
	by smarthost05.digicable.hu with esmtp
	id 1sHfWf-0007h2-0v ;
	Thu, 13 Jun 2024 10:09:41 +0200
Received: from [100.69.136.122] (helo=raspi.lan)
	by relay01.digicable.hu with esmtpa
	id 1sHfWf-0003wv-0V ;
	Thu, 13 Jun 2024 10:09:41 +0200
Date: Thu, 13 Jun 2024 10:09:39 +0200
From: Gabor Gombas <gombasg@digikabel.hu>
To: 'Yuri' <yuri@rawbw.com>
Cc: Jeff King <peff@peff.net>, rsbecker@nexbridge.com,
	'Junio C Hamano' <gitster@pobox.com>,
	'Git Mailing List' <git@vger.kernel.org>
Subject: Re: [BUG] "git clean -df ." silently doesn't delete folders with
 stale .nfs* files
Message-ID: <ZmqpQ4FkfXRm2jAE@lan>
Mail-Followup-To: 'Yuri' <yuri@rawbw.com>, Jeff King <peff@peff.net>,
	rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
	'Git Mailing List' <git@vger.kernel.org>
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
 <xmqqwmmw1sev.fsf@gitster.g>
 <4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com>
 <xmqqikygzdgk.fsf@gitster.g>
 <e8feffd0-ba6d-4aae-8c80-3d6482896b08@rawbw.com>
 <0ee501dabb91$aa2340a0$fe69c1e0$@nexbridge.com>
 <8fdc76e2-3de2-4312-956c-2662336fa54d@rawbw.com>
 <20240611064847.GC3248245@coredump.intra.peff.net>
 <ed33cfa9-d0e2-4e98-95e9-e210b24ac337@rawbw.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed33cfa9-d0e2-4e98-95e9-e210b24ac337@rawbw.com>
X-Original: 100.69.136.122
X-Original: 92.249.128.189

On Tue, Jun 11, 2024 at 12:43:51AM -0700, 'Yuri' wrote:
> The system I observed the problem is Centos with the kernel
> 3.10.0-1160.76.1.el7.x86_64 (10 years old).
> 
> 
> "rm -rf xx" command also says Device or resource busy
> But git-2.43.0 doesn't say anything.

On RHEL7:

$ mkdir foo
$ cd foo
$ git --version
git version 2.39.2
$ git init
$ mkdir xx
$ touch xx/x
$ tail -f xx/x
$ git clean -dfx
warning: failed to remove xx/: Directory not empty
Removig xx/x
$ git clean -dfx
warning: failed to remove xx/.nfs[... long hex number...]: Device or resource busy

Well, try something:

$ echo xx > .gitignore
$ git add .gitignore
$ git commit -m foo
$ git clean -df
[there is no output - bingo]
$ git clean -dfx
warning: failed to remove xx/.nfs[... long hex number...]: Device or resource busy

Regards,
Gabor
