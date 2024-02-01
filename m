Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820693BB43
	for <git@vger.kernel.org>; Thu,  1 Feb 2024 21:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706822854; cv=none; b=CXrk5eY3Zc6PRObnlZV97hOGgpZ36yX5/yaoIkRjy4g8jdzt2J4aodOFJgPJmnIT1UGsUUCCVDfxcMN9GrY2x/jc16n3It73jp4petrw35Nna27rND7HhsHTEvB1yJHOXOmRjrFV7/NsEac20TvsCHdZqSDaadThOaJr/PISeQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706822854; c=relaxed/simple;
	bh=QyptsVLnhBy8U3Ct4qd3o5CpNeoJpresblk4MyzurHs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BRzGguWbaLAGs7PWp/CNiFMkA/C/uIhC8riKYkMqGSXFT77YYBb/8YJyt1ZamFmR41vBVKkgEFjFDIN3cCzVlwj4LUo84ZQuJ1cQ1jByqUUfxj7Hh97OpbVsM1E68UPaDLTAOruEhiTYHdjSgguMquW4/RQVaNLlM1GYQUoNuQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=bwkKfMyG; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bwkKfMyG"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 268EA1BD22E;
	Thu,  1 Feb 2024 16:27:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=QyptsVLnhBy8U3Ct4qd3o5CpNeoJpresblk4My
	zurHs=; b=bwkKfMyGxPtKSTrEanGt3d6eD1il289nKo4+dYW7A7ij4TFPELRYkq
	c3FD+KpqiKplsT0epiA6/21ql1lIV2HtzxaYK8/hEOTjpDeNBJaV/0KtfxEPWndO
	jVR/6PBG54sTm0RhPEk4qx2D0PMZe8Fi3x6/vNYCgt22CEJ6iawvU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1DBEC1BD22D;
	Thu,  1 Feb 2024 16:27:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 68B721BD22C;
	Thu,  1 Feb 2024 16:27:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  John Cai
 <johncai86@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 3/3] rev-list: add --allow-missing-tips to be used with
 --missing=...
In-Reply-To: <20240201115809.1177064-4-christian.couder@gmail.com> (Christian
	Couder's message of "Thu, 1 Feb 2024 12:58:09 +0100")
References: <20240201115809.1177064-1-christian.couder@gmail.com>
	<20240201115809.1177064-4-christian.couder@gmail.com>
Date: Thu, 01 Feb 2024 13:27:22 -0800
Message-ID: <xmqqil37yix1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B049BECA-C148-11EE-86A5-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> When such a command is used to find the dependencies of some objects,
> for example the dependencies of quarantined objects, it would be
> better if the command would instead consider such missing objects,
> especially commits, in the same way as other missing objects.
>
> If, for example `--missing=print` is used, it would be nice for some
> use cases if the missing tips passed as arguments were reported in
> the same way as other missing objects instead of the command just
> failing.
>
> Let's introduce a new `--allow-missing-tips` option to make it work
> like this.

An obvious question is if this even needs to be a new option.  What
are expected use cases where --missing=print without this option is
beneficial?  If there is no plausible use case, perhaps we can treat
it as a mere bugfix to the existing --missing mechanism, especially
given that support of commits in "--missing" itself is relatively
a new thing.

If we can do this as a bugfix that is always on when --missing is
used, then we do not have to worry about adding another tasteless
loop outside the main command line parser, which is a huge upside
;-).
