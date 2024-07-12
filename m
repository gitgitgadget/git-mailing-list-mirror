Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0771BDD5
	for <git@vger.kernel.org>; Fri, 12 Jul 2024 21:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720820337; cv=none; b=mYSqDfWH5EMMPihk+7ripJi98rua/fHdRQFYlT4phqbwkukFyNhGF6zOGi20xs56Ci4vr8NbV+4L8Hlq2mGSAHChDKdAaTCU1U/UyZ5Ufne6VaiyxLed7VWp4rTH2AGw5jviur8KHd8jKoW/nRb+fl0QgE8kfD5FnGjRlh+cyzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720820337; c=relaxed/simple;
	bh=XxBeLG0MBMluDFv34pU3XsuPIy7KQ3AXkZRFTnd6BPE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r/9AYagArozBu4sCXQ0gEPZutY18TjZl/0lJIHE2ykIGg4eVseZ6bI46uq7yBhnU6aKUfgzBMKkoc2XqVMYE7P8pBfularrrRcB4lcDnMolJnA05+cJGKNTjC8EMgcXMmpe8FTSR0/wsBfIf06JjK0yto79CydcK9EjuKwWA2+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=LXhtn7Qy; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="LXhtn7Qy"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5085A35176;
	Fri, 12 Jul 2024 17:38:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=XxBeLG0MBMluDFv34pU3XsuPIy7KQ3AXkZRFTn
	d6BPE=; b=LXhtn7QyvnHplAneOXEos7OBIY3skWx1tDEQCCV/dcJavixcdJCGsE
	9RRez8KFzS8kHl15CaHc2hZxwJDR2EDHe5j7JcZb1/xyxavZBggQlpLJ0Y2MmGDO
	nfNduuKBgdpo4cGk0kogXjK3/nc2hSm3DoIfDNl/8SFcfA6iwq5l8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 469A435175;
	Fri, 12 Jul 2024 17:38:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A44D235174;
	Fri, 12 Jul 2024 17:38:53 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] cmake: fix build of `t-oidtree`
In-Reply-To: <pull.1761.git.1720816450344.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 12 Jul 2024 20:34:10
	+0000")
References: <pull.1761.git.1720816450344.gitgitgadget@gmail.com>
Date: Fri, 12 Jul 2024 14:38:52 -0700
Message-ID: <xmqqa5iml28j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 229FEAE4-4097-11EF-BC16-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When the `oidtree` test helper was turned into a unit test, a new
> `lib-oid` source file was added as dependency. This was only done in the
> Makefile so far, but also needs to be done in the CMake definition.
>
> This is a companion of ed548408723d (t/: migrate helper/test-oidtree.c
> to unit-tests/t-oidtree.c, 2024-06-08).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>     cmake: fix build of t-oidtree
>     
>     This is based on the gt/unit-test-oidtree branch.
>     
>     /cc "Ghanshyam Thakkar" shyamthakkar001@gmail.com

The base topic has been merged last month during this cycle, so the
fix must be merged down to the 'master' before the release.  Will
queue.

Thanks.
