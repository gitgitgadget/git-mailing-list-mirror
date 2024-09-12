Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1F9A5F
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 20:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726173003; cv=none; b=HyW+JIhzfrZxhZnZuNUmpJ4QPljX3t1V9KzIj/6jN65KrOCKFd9bKw7rEiz07Hg/E+tJorqhUwgqagM869+lZ3lRMCjHcln1s/6cweN3nvCvbIr0ycQlYSDILqqFLmoPe9IRKCsl8yNmNGoOOhEeoxeqBHj1WMC7wXmd47kvmdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726173003; c=relaxed/simple;
	bh=VpdKGCBvpCcIKGpKIV+Mi5Pg1SgYbMrPMvqGkH+rUcc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ENzSVvkJMzJqxYEPpJ33w2JYHCnyaoIj+kOZCFkR4UvJCsn4/lTCXdUUtBWYbhrGDNkk93nVOXoZUbqIBxNQxP5a1rMyp4ds+4dbB1GnwMgPrmseO7vRne+Bx0GXDCUwbAZXi5ETPTH1734d6ME+7/Ilg4plF+gDHBO4i/rQfLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Np6PEbJz; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Np6PEbJz"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C606037237;
	Thu, 12 Sep 2024 16:29:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=VpdKGCBvpCcIKGpKIV+Mi5Pg1SgYbMrPMvqGkH
	+rUcc=; b=Np6PEbJz7xpWii/9p2EfjuU5RRNu/qNLo4LOXUfW3etASsei63mx2x
	7BOsAqENrc6/E2tT6NoWc02LJLubOWp4ce4Z7RGWfcUP2HZb4r9N/LBttjtdaAAd
	OkVZ6uo+Pkfa1IvrXA4V4RQsmd8pDvqw2JH3zYwxA7mQbCbqG3Vuc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BCA2037236;
	Thu, 12 Sep 2024 16:29:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 11CF137235;
	Thu, 12 Sep 2024 16:29:58 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Calvin Wan <calvinwan@google.com>,  Josh Steadmon
 <steadmon@google.com>,  Elijah Newren <newren@gmail.com>,  Toon claes
 <toon@iotcl.com>
Subject: Re: [PATCH v2 00/22] Memory leak fixes (pt.6)
In-Reply-To: <cover.1725530720.git.ps@pks.im> (Patrick Steinhardt's message of
	"Thu, 5 Sep 2024 12:08:35 +0200")
References: <cover.1724656120.git.ps@pks.im> <cover.1725530720.git.ps@pks.im>
Date: Thu, 12 Sep 2024 13:29:57 -0700
Message-ID: <xmqq1q1o4nui.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C7D292F8-7145-11EF-B5E0-9B0F950A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> Hi,
>
> this is the second version of this round of memory leak fixes.
>
> There are only some smallish changes compared to v1:
>
>   - Explain leak checking a bit more carefully and document the new
>     `GIT_TEST_PASSING_SANITIZE_LEAK=check-failing` value in t/README.
>
>   - Some more trivial commit message improvements.
>
> Thanks!

Looking good.  Let me mark the topic for 'next' soonish.

Thanks.
