Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697AB171E4F
	for <git@vger.kernel.org>; Tue, 11 Jun 2024 06:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718088531; cv=none; b=bxHUVfVGsUwStBGvb5m2eEoqnlxjWLt/aXhIyOIqf3Z7cDuSIxFacoANEqHt/wH+5SqNgHo3ZUIAwStZg8MnIR+2dzxjn7rSLga1Tbi1PMqcJPzhlLQyvXKGX3aGD2v0BJpqvBq6UrJsQ+DaHl5n5s3RtRDMT+VlV/CQ7+ehom0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718088531; c=relaxed/simple;
	bh=W3e2086mK1RxVeIUDA6XsNYDqdAgeiBWRMrdC0E58rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FusRWIlqXACmJw+Z5jsgDOizAYhfKamo1ZmTtHV2BZcQxR2fnMXBO1ruc9UNdK5KBFT2lf6PQvQb/YKjQOD3D4otpqtWIwj2MJ+zO38piE25ixjna06b2p0OitEEOTrMOaTNINUbyMalROTM8A8wNYUHv07rkpUl0X50TltOrlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 17037 invoked by uid 109); 11 Jun 2024 06:48:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 11 Jun 2024 06:48:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24125 invoked by uid 111); 11 Jun 2024 06:48:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 11 Jun 2024 02:48:45 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 11 Jun 2024 02:48:47 -0400
From: Jeff King <peff@peff.net>
To: 'Yuri' <yuri@rawbw.com>
Cc: rsbecker@nexbridge.com, 'Junio C Hamano' <gitster@pobox.com>,
	'Git Mailing List' <git@vger.kernel.org>
Subject: Re: [BUG] "git clean -df ." silently doesn't delete folders with
 stale .nfs* files
Message-ID: <20240611064847.GC3248245@coredump.intra.peff.net>
References: <ae862adb-1475-48e9-bd50-0c07dc42a520@rawbw.com>
 <xmqqwmmw1sev.fsf@gitster.g>
 <4ed426e4-beb6-45ed-b493-1e19c7c0511b@rawbw.com>
 <xmqqikygzdgk.fsf@gitster.g>
 <e8feffd0-ba6d-4aae-8c80-3d6482896b08@rawbw.com>
 <0ee501dabb91$aa2340a0$fe69c1e0$@nexbridge.com>
 <8fdc76e2-3de2-4312-956c-2662336fa54d@rawbw.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8fdc76e2-3de2-4312-956c-2662336fa54d@rawbw.com>

On Mon, Jun 10, 2024 at 06:09:52PM -0700, 'Yuri' wrote:

> "touch .nfs12309" isn't enough.
> 
> Here is a reliable way to reproduce the problem:
> 1. Have a git repository on an NFS disk.
> 2. mkdir xx
> 3. touch xx/x
> 4. tail -f xx/x &
> 5. rm xx/x
> 6. git clean -df .
> 
> The last operation reproduces the problem. The xx directory and the .nfsNNNN
> file in it stay without warnings.
> The .nfsNNNN file is created by the NFS client when the xx/x file is
> removed.

That is not the behavior I get. I see:

  $ git clean -df .
  warning: failed to remove xx/.nfs0000000002c8197f00000002: Device or resource busy

Which makes sense, since the kernel fails our unlink() call. Maybe your
system behaves differently at the syscall level?

This is a pretty standard Debian system with kernel 6.8.12. I set up the
NFS mount with:

   mkdir /mnt/{server,client}
   exportfs -o rw,sync 127.0.0.1:/mnt/server
   mount -t nfs 127.0.0.1:/mnt/server /mnt/client

and then made the repository in /mnt/client. "mount" tells me it's using
nfs4.

Running "git clean" on the server side does remove the files (no
warning, but the directories are actually removed).

-peff
