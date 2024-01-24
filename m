Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA65132C31
	for <git@vger.kernel.org>; Wed, 24 Jan 2024 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706125571; cv=none; b=LEuBkwkLSchXSAPUpAWRsp7VhpcmMxeR9n1jXpmw253z6dEK5wLZ/uK7UIPbPccrZ9rcw4H7a+s1YcEHFvAW3YGvZkcNEROIXC2U9FYVI0gKzDiKav7ksYuAkyh6jdD2of/SW2pKAq+bD6FlsNYzIbT9n4YYpwTxI3tdaD7sQlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706125571; c=relaxed/simple;
	bh=aP53x5uUDouuuRbex43k+V3NW9ck1yQ9JjNwjdwqi08=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ti1EabZ34wJKDgjVbeDbTJmuxNgYmPNJRrrO6uWpNFB3JiCqImFYjLZiS2oNgS5D0wimpnppnBUAeXiJJzh1ERhjKRjoj5RXbUtzW0BQ2YGSBHbQs2jqQQUXDpyLqduHW1VBO1BffHV0mCO/PL66OJaOrlUM70/oNEjLtgO7xDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=CaxZ5HfV; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CaxZ5HfV"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5681E1BBD9;
	Wed, 24 Jan 2024 14:46:09 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aP53x5uUDouuuRbex43k+V3NW9ck1yQ9JjNwjd
	wqi08=; b=CaxZ5HfVVhIOl17se+zAf01xGzJZJ+msGqlIuB4BcioJYANNm+7SMu
	XQY/2TWpYG6kd1Y7qhsBe+CLgKgTgIjpLq254kxU9difJxXJzC3AfWTkZ74UlLIs
	NqfighhGoe/P4S2Ia0gCcAeDWEpivaydVFRgmJIPWBYKOjFeZx3v8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4E27F1BBD8;
	Wed, 24 Jan 2024 14:46:09 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C8A4F1BBD6;
	Wed, 24 Jan 2024 14:46:05 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Elijah Newren <newren@gmail.com>,  Michael Lohmann
 <mi.al.lohmann@gmail.com>,  git@vger.kernel.org,
  phillip.wood123@gmail.com
Subject: Re: [PATCH v3 2/2] revision: Implement `git log --merge` also for
 rebase/cherry_pick/revert
In-Reply-To: <dfb582cf-b1e4-414d-bfe1-0f93d910ec54@kdbg.org> (Johannes Sixt's
	message of "Wed, 24 Jan 2024 18:19:39 +0100")
References: <xmqqzfxa9usx.fsf@gitster.g>
	<20240117081405.14012-1-mi.al.lohmann@gmail.com>
	<20240117081405.14012-2-mi.al.lohmann@gmail.com>
	<CABPp-BE4zqRX=wd5EBj96hzCS8V73QpdN-2pCpv7qMdkpkX93w@mail.gmail.com>
	<dfb582cf-b1e4-414d-bfe1-0f93d910ec54@kdbg.org>
Date: Wed, 24 Jan 2024 11:46:04 -0800
Message-ID: <xmqq1qa6ecqr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 3671C276-BAF1-11EE-9D85-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Johannes Sixt <j6t@kdbg.org> writes:

> Good point! IMO, REBASE_HEAD should have lower precedence than all the
> other *_HEADs. It would mean to reorder the entries:
>
> 	static const char *const other_head[] = {
> 		"MERGE_HEAD", "CHERRY_PICK_HEAD", "REVERT_HEAD", "REBASE_HEAD"
> 	};
>
> (and perhaps adjust the error message, too).

And probably give a warning saying that we noticed you are rebasing
and cherry-picking and we chose to show the --merge based on the
relationship between cherry-pick-head and head, ignoring your rebase
status, or something.


