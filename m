Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFCD1AF4ED
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 21:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725053278; cv=none; b=o6sXFiqGQWypy5uEi8DpJR7Uu+i8QJNM3JAlaQvfHaNFuf6eDeSBpUGChjmQOz68o8wjwvQEf7yBhFmYnsrmkfMsAeahODkgD1pT5vtFvhhxW0MoxAvtNKeb4ZPDcPHSj9N6XrYiBv33Oe8Dgac7p/t6mYYxGZEF8qc1H0mXNVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725053278; c=relaxed/simple;
	bh=1foSK32qyA9eUOzzxTfL4ubNfgeAhG9mRlTp+/Vz6W0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ekFR5vug4b/0/QNGRnCy6ko4PEU2ZHUjckv/TiG6JLgFeURetsRGD0tNRCe750oJYiDj3m3ugDW3Xqn5TKPXHwhwovFfHirSa5P8u0aCYnTEZkXKbhBtjJahrmDWOXy/+4cgzfTW/2o1O2Pvvk6f9vf58lyo2rU6+SP+eygruak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=uDMyMmCx; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uDMyMmCx"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CE9BD222BD;
	Fri, 30 Aug 2024 17:27:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1foSK32qyA9eUOzzxTfL4ubNfgeAhG9mRlTp+/
	Vz6W0=; b=uDMyMmCxzquFH+iVwf4w9g1x5Dpcy46mXmUyVFOSy3CfI/p9OXTzbn
	SwZlEYbVFQA0yB/b8l9zeBaO+YMrcOPq0Utdy4TlxZYo1JbjDEd8lhclCOXeCqnn
	ZhQu5yJCxU2853jEB90javp1/U7aPmq7FcJpO2i+/Yt1ctaC1jJLM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C6FCB222BC;
	Fri, 30 Aug 2024 17:27:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 329AB222B9;
	Fri, 30 Aug 2024 17:27:55 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Yuri Karnilaev <karnilaev@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] revision: free commit buffers for skipped commits
In-Reply-To: <20240830205331.GA1038751@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 30 Aug 2024 16:53:31 -0400")
References: <60B730E6-F3C6-4B57-94D6-E5A71754DAF3@gmail.com>
	<20240830205331.GA1038751@coredump.intra.peff.net>
Date: Fri, 30 Aug 2024 14:27:53 -0700
Message-ID: <xmqq1q25r99i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B86320DC-6716-11EF-BD95-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> But since this "--skip" case is an easy one-liner, it's worth fixing in
> the meantime.

OK.

> diff --git a/revision.c b/revision.c
> index ac94f8d429..2d7ad2bddf 100644
> --- a/revision.c
> +++ b/revision.c
> @@ -4407,6 +4407,7 @@ static struct commit *get_revision_internal(struct rev_info *revs)
>  				c = get_revision_1(revs);
>  				if (!c)
>  					break;
> +				free_commit_buffer(revs->repo->parsed_objects, c);
>  			}

Even if we freed the buffer and then later need it, we'd read the
buffer again anyway, so this is a safe thing to do.  And because
commits skipped in this separate loop will _never_ be given to the
caller of get_revision(), this it a reasonable optimization, too.

Will queue.  Thanks.
