Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26A303A8E4
	for <git@vger.kernel.org>; Mon,  2 Sep 2024 03:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725248501; cv=none; b=DTatZe23wsiah94qXQZGXhfjswHXWa6eGHt77JD69tI11ZgSjDESa87ndk8gEsO0u3z20+1rhKblYT0ZglAUFBBDm/1/HEOKC2AjCOpeFtsv3ZugqOU8VrmVSnMvasmZklM32EhGa+JbgZHDLOSdrfj84rU26FktZZzmSDnypFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725248501; c=relaxed/simple;
	bh=zExPCaf1LU57xmQpiDciGoAFlZmFfCM7ju8s36z/5pk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i63XR91H2EtpBlTi7MKqGWi3khkqoqydXJ/fHmmt36/vqFjYeyKc/MDlL8WdWC5a8rrZIXgtGpfVKgtNySf6NL2b5GdQh5GmoeQXlQni+c6HyQDWgSioa+E+IXoQ+hGGvGI43pPmVW14s9V+PGcvAxRgZWEiS451u48/jYHudNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GOX0z8Ik; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GOX0z8Ik"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D79701F1FE;
	Sun,  1 Sep 2024 23:41:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=zExPCaf1LU57xmQpiDciGoAFlZmFfCM7ju8s36
	z/5pk=; b=GOX0z8IkiDvKvc61z5t98zyEnZ8oL5huWqWgSHVpRj4iy5ofpESdFq
	DPKk4iDA8We1w38IeQIx2gxHoWz+zet2p8Xm/YuNux5BBnrKoWv2uU3PNN5UWuc/
	u8wX/BDc8vpbjznuLLL3H1Ti94wB90GlXLiPsSlaCOx6KfZcWWDvA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C902D1F1FD;
	Sun,  1 Sep 2024 23:41:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 30AA31F1FC;
	Sun,  1 Sep 2024 23:41:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>,  Elijah Newren <newren@gmail.com>,
  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
In-Reply-To: <cover.1725206584.git.me@ttaylorr.com> (Taylor Blau's message of
	"Sun, 1 Sep 2024 12:03:15 -0400")
References: <cover.1725206584.git.me@ttaylorr.com>
Date: Sun, 01 Sep 2024 20:41:36 -0700
Message-ID: <xmqq8qwaoh73.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 425C9062-68DD-11EF-801E-9B0F950A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> After some profiling, I noticed that we spend a significant amount of
> time in hashwrite(), which is not all that surprising. But much of that
> time is wasted in GitHub's infrastructure, since we are using the same
> collision-detecting SHA-1 implementation to produce a trailing checksum
> for the pack which does not need to be cryptographically secure.

Cute.

I wish we can upgrade the file formats so that a writer can choose
the hash algorithm independently from whatever the payload uses.
Most of our use of the tail sum are for files that are consumed
locally in the same repository so nobody shouldn't need to know that
you are using xxHash for the tail sum instead.

Except that the story is not so simple for packfiles, which is named
after the file's tail sum, so you cannot use a hash algorithm of
your choice independently without affecting other folks.  All other
csum-file protected file types are lot smaller than the pack files
to matter, sadly.

