Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D7C17EB85
	for <git@vger.kernel.org>; Tue, 14 May 2024 15:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715699153; cv=none; b=rsiU1s2a1fomcKRP/NXDVHrukSKxqeJC7CAUabsr650aNyNvj+rbDXRbx1MpwVu0mZwqRKJ9kqJs/ZaaDFG6Mi5KZ07EOHD2+UXamfpwCHoGEmUEA8weaC2OFAm3scnG+XGXN6jXlD6r2RWpdQjDW7v7YQ/VRAoj37dehZbqq68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715699153; c=relaxed/simple;
	bh=4ZKA5Yv4f8EO6FDGAwSa5Ebvcl+lSxKjjTnZ3F2XMns=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UO/NBiHlrH7F6RU6le/WrjPjZHDcW7mpwGyc5vw/kwioaBrx6Nqe/qPrcLioFPgKr3bMRaJk8PSD8+nJPMHXz5fO2nK8aR4H9lmmvew8OIhNB95/J5n5Ymq+8Zj2FMUtv/n+frc6QE963eGWYVyq0s/PTshI1xWq/I40Vju/Hx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Wnx5Uiyv; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Wnx5Uiyv"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E50233C7AE;
	Tue, 14 May 2024 11:05:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4ZKA5Yv4f8EO6FDGAwSa5Ebvcl+lSxKjjTnZ3F
	2XMns=; b=Wnx5UiyvEvSZ89Ze53a+/JuE4ry5Nn3vBaHXycrTCkGiWx1dZloUCP
	PeNd2jui9gCdXplx7fdf1fYk/JKX0hACGiAMYOzweSMx6Uw/TbZ1pSuamupzU51U
	F3eCRVpNGieu0zAacdXDhz2XwFmYTLrxjczOrKK/Qw8XjDvAuJLvQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id DD25C3C7AD;
	Tue, 14 May 2024 11:05:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0B4F53C7AC;
	Tue, 14 May 2024 11:05:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 1/5] setup: add an escape hatch for "no more default
 hash algorithm" change
In-Reply-To: <ZkLpSW6TNcpKpg-V@tanuki> (Patrick Steinhardt's message of "Tue,
	14 May 2024 06:32:09 +0200")
References: <cover.1715582857.git.ps@pks.im>
	<20240514011437.3779151-1-gitster@pobox.com>
	<20240514011437.3779151-2-gitster@pobox.com> <ZkLpSW6TNcpKpg-V@tanuki>
Date: Tue, 14 May 2024 08:05:46 -0700
Message-ID: <xmqqseyk77sl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 721F9712-1203-11EF-956F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> The problem with reusing "GIT_DEFAULT_HASH" is that we unconditionally
> set it in our test suite in "test-lib.sh". This will have the effect
> that we will never hit segfaults in our tests because we always end up
> setting up the default hash, whereas our users now will.

I tried the version you posted with only SHA-1 fallback and it
failed with SHA256 CI jobs, and eventually came up with using the
existing environment variable.

The variable is the perfect fit in the longer term for our purpose.
It is what the end-users will set, not for papering over remaining
bugs from the "no longer there is a fallback default" change, but
for telling Git that they want to use sha256 repositories.

With GIT_DEFAULT_HASH set to sha256, we will be testing a
configuration that is very close to those end-users.

There probably are four cases we need to check:

 - In a repository, invocations of commands that should honor the
   hash function that is in use by the repository (i.e. this is true
   for most commands and their invocations).

 - In a repository, invocations of commands that should ignore the
   repository settings and always use SHA-1 (i.e. proposed fix to
   patch-id).

 - Outside a repository, invocations with GIT_DEFAULT_HASH set
   should probably parallel the above two, as if GIT_DEFAULT_HASH
   came from the repository.

 - Outside a repository, invocations without GIT_DEFAULT_HASH set
   should all default to SHA-1???

The last combination cannot be tested UNLESS we unset GIT_DEFAULT_HASH
that is given by test-lib.sh, but that can easily be arranged, now
we have one primary/central place that tests out-of-repository
invocations of various commands in t1517.

And using the existing environment variable has an added benefit
that we do not have to add an extra option to random commands.
