Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B0014B092
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 17:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717523115; cv=none; b=QVKQb69GojO4z51jmhl7Rl0ko/m82TbSJ0flpAq/Tpom3R/QZOZISADEc+l+ogRve9Qs6uD+zi0dVgpeVByfNkd5QUviYrKDysJcvXxnGD8MpikIodS8YW1E6htn7iIbD3xgV5+ilSjF06UL7YEl0f7Ygtj55r3JoTl/Bkt/WbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717523115; c=relaxed/simple;
	bh=69QcNJTh4ZxEkwzPtiH/BLSAcqhZi9swTy7MiWGyG3o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IIK+y7CQCqtpKugM2eATbElhlPQ/2Xxt1z5Sn9NCPLzts9WLEIK5lqnHJa9R0GG8xMO/+XzDoqNwbsAHAH+SMDUHsMZXQ2RHpznGDRNCokkwmbaaRXen59WIXICVyS9RWNdKbiW1cCHpSoadmIdsYi5Nd+kiu+lzh+6adFF5g8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Am3kCPYL; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Am3kCPYL"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B4D801D09C;
	Tue,  4 Jun 2024 13:45:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=69QcNJTh4ZxEkwzPtiH/BLSAcqhZi9swTy7MiW
	GyG3o=; b=Am3kCPYL2unNoc9uTBls1OrpGhQ4BZFnoziHS8DWqSdGnl1Nm1YJIP
	kmM+05KN3eJKB7r5exWM9p4IHt9vpg9ea2ErCgGdLs2jn/+vKkQ2K0sH6vs1hLgK
	/Bhk6HkJx1OKBP2rp+vesnIQMxKtWgnYVasSJhEJGDYNViOyvngwo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A6A841D09A;
	Tue,  4 Jun 2024 13:45:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E98741D098;
	Tue,  4 Jun 2024 13:45:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] dir.c: skip .gitignore, etc larger than INT_MAX
In-Reply-To: <20240604103947.GC1781455@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 4 Jun 2024 06:39:47 -0400")
References: <20240531120034.GA442032@coredump.intra.peff.net>
	<xmqqh6eehvj4.fsf@gitster.g>
	<20240604103947.GC1781455@coredump.intra.peff.net>
Date: Tue, 04 Jun 2024 10:45:04 -0700
Message-ID: <xmqqikyowqjj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2E5A9EC6-229A-11EF-9EC6-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> I was hoping to avoid making up an arbitrary number. But your question
> about gitattributes reminded me that we already did something similar in
> 3c50032ff5 (attr: ignore overly large gitattributes files, 2022-12-01).
> There it's a hard-coded 100MB limit (without even a config option).
>
> Maybe we should just do the same here?

Hmph, I thought the 100MB was only for blobs, as we stream the input
we read from a regular file, but we do have the same limit there
presumably to match what we do to blobs?  I do not mind that, but I
do not mind leaving it a future "consolidate various size limits on
control files used by Git" patch, that unifies the limit for attrs,
excludes, gitmodules, .git/config, etc.

