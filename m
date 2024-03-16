Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEBD179AE
	for <git@vger.kernel.org>; Sat, 16 Mar 2024 23:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710631888; cv=none; b=KUVjLzOPteqbT+h2d97Fbeosf2MZO+OFU453+DBsXOjzV06zT3jgYrtyUBwMIleNb+gf+gEIC3+uKbCVI9knFrtYyg2mQ7BIdkGmxbOw5DlexB2JvgOEfU4hv7UYJAW1ymAa+CyPjXnq6M1gGyZ0AB2d/bcSYwnXStNBCkSOiEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710631888; c=relaxed/simple;
	bh=MxQ5zMKNg4O0EiM09cjuz46BhBWW/PXoSYyXVmm5fjM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gUlSrfoVdSCCFRNjuE8Yt7rZoopk/oNxgGrYhLLAUhPFNazuW6C8zQuDj4/4Q/C4PvufgI0JtOHGiZIpqZh8zVRdyEWqcfTHu/ugxy1ALjIOlCaFtf5ynuMgmru5LnRkcNQnFuLzbOwGUVUrVT0rwJgjZv0oY2iui1jGzKpWBmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ZBbxERMM; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZBbxERMM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B6DD134C58;
	Sat, 16 Mar 2024 19:31:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MxQ5zMKNg4O0EiM09cjuz46BhBWW/PXoSYyXVm
	m5fjM=; b=ZBbxERMMrEMe/WPDBBWw/Itdx/djOFUfRQV/EWRUHeXNZo381tX3YG
	zccF+ByqUDmY0MyFX8jp8dvKE1bYUr/AaoZYlbaMq1SdonPqAKSTtXn6pWda8p6S
	9yf20zjcRDYWKXwQqueTabFKID7LDj87iglv/u1N9YKVb7Z0EkH1s=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id B032F34C57;
	Sat, 16 Mar 2024 19:31:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3C0AF34C56;
	Sat, 16 Mar 2024 19:31:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Philippe Blain <levraiphilippeblain@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>
Subject: Re: Failures in GitHub Actions linux-leaks and linux-asan-ubsan
In-Reply-To: <3e217121-f49b-33bd-b76f-df24efca6d14@gmail.com> (Philippe
	Blain's message of "Sat, 16 Mar 2024 15:20:44 -0400")
References: <3e217121-f49b-33bd-b76f-df24efca6d14@gmail.com>
Date: Sat, 16 Mar 2024 16:31:15 -0700
Message-ID: <xmqqbk7dn48s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 495C75E6-E3ED-11EE-B835-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Philippe Blain <levraiphilippeblain@gmail.com> writes:

> Hi everyone,
>
> You might have noticed that the linux-leaks and linux-asan-ubsan
> jobs in GitHub Actions started failing last week. I investigated 
> this so I'm sharing my findinds in case it helps.
>
> The failures are due to the new ubuntu-22.04 GitHub Actions image
> (release 20240310.1.0, [1]) which uses a kernel where ASLR is configured
> in a way that is incompatible with ASan and LSan as used in 
> the GCC and Clang versions in that image. More info can be found
> in [2] and [3] and pages linked there.
>
> A workaround was already implemented in the image generation process 
> [4], so the next version of the image should work. I think the images
> are released weekly. We could maybe add the same sysctl command to reduce
> the entropy to our YAML file, or we could live with it for the next week
> or so while waiting for the next image to roll out.

Ah, just what I needed, as I was looking at the CI results and
noticed these failed runs.  Thanks.
