Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14D9F23BF
	for <git@vger.kernel.org>; Sat, 23 Mar 2024 18:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711219391; cv=none; b=bgO6mvYvXuHS7i0sLJsguQyaF/Xp/Aitw38PD0Upiv9jGdRc8MVEIw+qg2dvNvZLb3Il2ZHNtmHKxsd1LOjuGl90DbxYHYW0i0XBeFEPYkHDVycwk0R9pcK1HvAUIe4dcqvULZFF1BTtFV5XVQ47ibG1WM5gZ4E88fvHghT7msI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711219391; c=relaxed/simple;
	bh=jbPHXarjkfgEWulAbtMB9DfjBAFGjI+Hr/rtp00KIRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j9aO5nw6dGV8iPCJszi86GjCHMiD+Fl7LbtaBFsDH8Y6QAJ7ITU9rP4C6X44nePRUDK9IiSkcHFJFCTX4/XF1F9nIe9u7Hw9iRqyIZpHbqx56NNNJATiy6NYcaG+VCkNM+NLa2/0MBopKY3bMR/bS+U1mbHFrCQXBOP66YZdtko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=rygr+CeK; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rygr+CeK"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 676CB220C9;
	Sat, 23 Mar 2024 14:43:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=jbPHXarjkfgEWulAbtMB9DfjBAFGjI+Hr/rtp0
	0KIRo=; b=rygr+CeKbjL3bgI0uiNK8SaZGvBSGr/mCVqNNtfFKnCXvGcBVcPla7
	pa7XZrJx1gjbaoYdavkrPdFM5oPX9FhPY3txSWCXpEnUF712XhXo8lWSa11cIszI
	TqiZyqQlgEJRcrlS87d1b6kqwVpwDnokJdCg65Eq3GzawMr7+G7Kw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 604FE220C8;
	Sat, 23 Mar 2024 14:43:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D61DB220C7;
	Sat, 23 Mar 2024 14:43:04 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Stefan Haller <lists@haller-berlin.de>
Cc: Olliver Schinagl <oliver@schinagl.nl>,  git@vger.kernel.org
Subject: Re: Allow git bisect to auto-skip
In-Reply-To: <01e09c64-4d62-406d-85fe-9fb77939cf63@haller-berlin.de> (Stefan
	Haller's message of "Sat, 23 Mar 2024 14:51:21 +0100")
References: <3d835c4b-d026-4c6a-b68e-6989a7a2065f@schinagl.nl>
	<xmqqwmptzyny.fsf@gitster.g>
	<01e09c64-4d62-406d-85fe-9fb77939cf63@haller-berlin.de>
Date: Sat, 23 Mar 2024 11:43:03 -0700
Message-ID: <xmqqle68x008.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2F32B7F4-E945-11EE-9C7D-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Stefan Haller <lists@haller-berlin.de> writes:

> On 22.03.24 23:31, Junio C Hamano wrote:
>> It often is discovered that a commit
>> breaks bisection after the fact and it is not feasible to rebase
>> all the history after the commit.
>
> This reminds me of a similar problem with git blame, for which we have
> the blame.ignoreRevsFile config to work around it. Couldn't there be a
> similar mechanism for bisect, e.g. bisect.skipRevsFile?

A Very good point.  If a breakage of a commit is "this does not even
build" kind of breakage, such a mechanism would be an excellent fit.

But if a breakage is "only this particular test fails and we know
the reason why it fails has nothing to do with the bug we are
chasing", then compiling such a fixed list of commits, or pointing
at such a list with a configuration variable, would not work very
well, I am afraid.

Thanks.
