Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640F66214A
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 17:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710350248; cv=none; b=b4KiN7uo9c4F6DbIocYXm2t1rhMfsu4Sx0NWD2y8A2XiAsjx5mNf58rJEfzzAIbvwhuaKKtLZkszSJOvVnbV9Mb9DIR4jto6k9zRa1KYDWduK6WySfYBH3IlREI1hFcOKHTpZ8jxjngApPxukdmD8nzMMKKTd+9l8hOUB3ZcUYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710350248; c=relaxed/simple;
	bh=1oaOTZby7jxmRGCljoDwleexjO9WUqsSdZmeLHXWZ3w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gmMt1aS07yPDcPPkeJMSX8pXXlh3gRwhw+a5G+4C5sKESwH9C/FMphThn5R1JU/GZqC7yJP/mRBxOpL/HgaYBnQnWfyAACOewHCV8etgUX8jq00niVlbgv93WN7cWQTuK14X+1D1Gqcj20cfbFQzAsyY28xIYWmXwC351K5agEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OWZuA8xS; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OWZuA8xS"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D089C20301;
	Wed, 13 Mar 2024 13:17:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1oaOTZby7jxmRGCljoDwleexjO9WUqsSdZmeLH
	XWZ3w=; b=OWZuA8xSPqm9Y5SDa8jbK8fRK9BtgK6RRMX7Ib7w1maB8TOjmWeIPL
	D6J6kaZ7zvsqtb2gYHYK7/V1d9kRyuvd8QPwtx3N9orIPe9FrbJ9K7zCrEuohK5A
	fNenNVosUkpmy7iguIQBQXgp69BoCIThAK/3keNznIq089jTlD+8s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id C8C2820300;
	Wed, 13 Mar 2024 13:17:25 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C4F60202FE;
	Wed, 13 Mar 2024 13:17:20 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: phillip.wood123@gmail.com
Cc: Brian Lyles <brianmlyles@gmail.com>,  git@vger.kernel.org,
  newren@gmail.com,  me@ttaylorr.com
Subject: Re: [PATCH v3 7/7] cherry-pick: add `--empty` for more robust
 redundant commit handling
In-Reply-To: <d7c926ce-8a2d-4828-a3b0-3c4a9bcfe92a@gmail.com> (phillip's
	message of "Wed, 13 Mar 2024 16:10:35 +0000")
References: <20240119060721.3734775-2-brianmlyles@gmail.com>
	<20240310184602.539656-8-brianmlyles@gmail.com>
	<d7c926ce-8a2d-4828-a3b0-3c4a9bcfe92a@gmail.com>
Date: Wed, 13 Mar 2024 10:17:19 -0700
Message-ID: <xmqq1q8edpb4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8CF6323E-E15D-11EE-B4E0-A19503B9AAD1-77302942!pb-smtp21.pobox.com

phillip.wood123@gmail.com writes:

>> +Note that this option specifies how to handle a commit that was not initially
>> +empty, but rather became empty due to a previous commit. Commits that were
>> +initially empty will cause the cherry-pick to fail. To force the inclusion of
>> +those commits, use `--allow-empty`.
>
> I found this last paragraph is slightly confusing now --empty=keep
> implies --allow-empty. Maybe we could change the middle sentence to
> say something like
>
>     With the exception of `--empty=keep` commits that were initially
>     empty will cause the cherry-pick to fail.

That is certainly easier to read and much less confusing.

Thanks, both.
