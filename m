Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C97222157F
	for <git@vger.kernel.org>; Sat,  6 Sep 2025 15:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757172518; cv=none; b=fkxwDLdivAC5E/h5hm1RsBaC1qx9wN3j8mfElfXNGZr/QlheGfZit6+9BS0pnl/bwA7Y14TZPCW6AiM21I2F/xRKHRsZ1EOeyGkCPWRfiRwbMoV9dGF2hbvO5/AXr8Nv7eh7ygVGVqDEdMlkr0iL5zmtGQVM9kU6kiL6tpfRr+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757172518; c=relaxed/simple;
	bh=kmJ/k2wommsPxFWDKM4K0hcOJUlGwSK3KKhQVy6P7ZM=;
	h=From:To:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=O1WhB2UhYLx4wDHP0RhmWU0/tOligGFFgA2cTsoHkUd84AgFLXBZjCaNNdnQiw3qkIgwlG9ihMR0KNVK1LR7gM+CBUVsWZLlHD7qKZzJWzkRTunGYipZlzcr0HBe8crtGoyDCGxYZzvXhWhL0nsqv4YU2WgUNCu1LOUuuj9BJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (pool-99-228-67-183.cpe.net.cable.rogers.com [99.228.67.183])
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 586FSRQT2560360
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 6 Sep 2025 15:28:28 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Kousik Sanagavarapu'" <five231003@gmail.com>, <git@vger.kernel.org>
References: <20250906141711.64419-1-five231003@gmail.com>
In-Reply-To: <20250906141711.64419-1-five231003@gmail.com>
Subject: RE: Running out of inodes on an NFS which stores repos
Date: Sat, 6 Sep 2025 11:28:22 -0400
Organization: Nexbridge Inc.
Message-ID: <03d101dc1f42$e5380a70$afa81f50$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQHU5NgVExgkbaNppoySknD5rX3PIbSUuzIQ
X-Antivirus: Norton (VPS 250906-2, 9/6/2025), Outbound message
X-Antivirus-Status: Clean

On September 6, 2025 10:16 AM, Kousik Sanagavarapu wrote:
>Hello everyone,
>At my $(DAYJOB), we have an NFS which stores different git repos.
>Due to how git stores objects, we have started to run out of inodes on the
NFS as
>the number of repos coming into the NFS increased.
>
>These git repos come from another service and there are typically thousands
of
>them each day. It is important to note that we only store the .git dir and
expose a url
>which is configured as the remote by default to read and write into this
repo.
>
>All of these are small repos; usually not many files and not many commits
too - I'd
>say ~5 commits on average.
>
>Historically, when we ran out of inodes, we had implemented a few
strategies
>where we used to repack the objects or archive the older repos and move
them into
>another store and bring them back into this NFS and unarchive the repo.
>
>However, none of these totally mitigated the issue and we still run into
issue as the
>traffic increases. As a last resort,  we increased the disk size even
though there was
>ton of free space left - just for increasing the number of inodes.
>
>We can't delete any of these repos, no matter how old, because they are
valuable
>data.
>
>I was wondering if there was some other strategy that we could implement
here as
>this seems like a problem that people might often run into. It would really
help to
>here your thoughts or if you could point me to anywhere else.

I would suggest running

git gc --aggressive

on your repos. This might help compress your pack files. I have seen
customers
with thousands of pack files who have never run a garbage collection.

Another thing you might want to try is to use sparse-checkout to only keep
the
directories you absolutely need if that is an option. Also, check your /tmp
and
lost+found directories. 

