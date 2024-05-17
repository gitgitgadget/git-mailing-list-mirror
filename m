Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDA81EED3
	for <git@vger.kernel.org>; Fri, 17 May 2024 23:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715989753; cv=none; b=gMmzit1vL3GA+stxDCxsad3gJsBOyA2HsvLim3cPfvJthK+RBF38fMECnSWp4lqY9DcDCBGV44c77PIodWbiREwlA7TWvAqgIWKzp4BsYtaLoJQ1+wvlySUx+JBOqLX0uI7xJrIzBcKLgbw/ZO10kUAlm428ySU/anj0pu1gA+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715989753; c=relaxed/simple;
	bh=R4db0fgmmDYXFOoVKPlK8n3BhuYau4z/MptEZPB3jrw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WCpttcb1nSAnHZTq8DKfbVbFEQ8bspJ+NcwQ16dR5BfXRrebhmKmWBy1IFMFih+Rw7A4DYP5ZRwR05OnKDYTU5TNHnGNM9ZEEL4wu4EYwDmWG5nESsQByeaHd+l0rRh7ZMy9/4Ix3sfyw9fvoaVUz2fQ8Ntg5qa8G4F8sU+AOAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IoqNp26I; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IoqNp26I"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4C9BC31927;
	Fri, 17 May 2024 19:49:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=R4db0fgmmDYXFOoVKPlK8n3BhuYau4z/MptEZP
	B3jrw=; b=IoqNp26ImQmIuyZpTvoeuW1kgdJgMWOjn3P0lH67mBwrbeNMzMQL1X
	YCIbJikR5+5zRKxBbTAw1b1uRZRZdFIXmD0E8LN3clU1VrKYkgRZhZ13rqxt/dT4
	JOstYEGGVtMNrQHH+3mYs+2PmijjKURZoYe030sQKXKlYTXfY7DDk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4554531926;
	Fri, 17 May 2024 19:49:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C4D4B31925;
	Fri, 17 May 2024 19:49:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 4/5] builtin/hash-object: fix uninitialized hash
 function
In-Reply-To: <20240514011437.3779151-5-gitster@pobox.com> (Junio C. Hamano's
	message of "Mon, 13 May 2024 18:14:36 -0700")
References: <cover.1715582857.git.ps@pks.im>
	<20240514011437.3779151-1-gitster@pobox.com>
	<20240514011437.3779151-5-gitster@pobox.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 17 May 2024 16:49:05 -0700
Message-ID: <xmqqmsoodmoe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0C7ABB7E-14A8-11EF-881A-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> From: Patrick Steinhardt <ps@pks.im>
>
> The git-hash-object(1) command allows users to hash an object even
> without a repository. Starting with c8aed5e8da (repository: stop setting
> SHA1 as the default object hash, 2024-05-07), this will make us hit an
> uninitialized hash function, which subsequently leads to a segfault.
>
> Fix this by falling back to SHA-1 explicitly when running outside of
> a Git repository. Users can use GIT_DEFAULT_HASH environment to
> specify what hash algorithm they want, so arguably this code should
> not be needed.

By the way, this breaks the expectation of t1007 and t1517 when run
with GIT_DEFAULT_HASH=sha256 (I recall that they passed with the
earlier iteration of my "fall back to GIT_DEFAULT_HASH" in [1/5],
but we decided abusing GIT_DEFAULT_HASH is a bad idea).

https://github.com/git/git/actions/runs/9135149292/job/25122031380
