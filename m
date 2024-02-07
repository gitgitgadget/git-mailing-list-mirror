Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62628127B68
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 21:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707339951; cv=none; b=k/okhUyOZYx/SkW4w1XinaTSw/Bze0neEwR19NBZeSlJObAc0u/bTemjfuMzTAkQn+Xq56rwyTxISLho7RVXjFBGNylgcQBQjHoIce6D77JXATCFYwN8IyUeY7xO/2bftYqJjY+7fDHzvKvCjSd64HW6LKD9vlJkP1yQVBv7ua8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707339951; c=relaxed/simple;
	bh=9MZhHtolcwYkIygLhDFP6BQ0T39wK7x9VdYQ4razrMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T0z/qQJJSwwGTNcIrS8VNZWOjqZ84CGOmIP6gN/a5aIZqWhdca1xc7zuJMuQBYOzQMEhC3hOViPjsQCUorluJ17sK+FCuA/nbcu8r9EzssDfJu+5/oFhvXU0EPK6eZCox4pfRYKo9Tx/Q47g2A2zhTTdRWMza1O+u8gXmbIEdSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pU1kqvrB; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pU1kqvrB"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E0F722B92D;
	Wed,  7 Feb 2024 16:05:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=9MZhHtolcwYkIygLhDFP6BQ0T39wK7x9VdYQ4r
	azrMw=; b=pU1kqvrB5PELfOQawk6gilbiI2kqiSQ4oaCL3PBDgIcFQhWizaAWPT
	NubiDJZgJO+gaRwtkZE/DLpRa9TsMqUXci6E5hwm+rfVmgUSQ5M95eRCn9kZG9J1
	dG+Bo6WfsC6W7xSerYHLuFdrEjm3TIqHoPFgF19aZH839glVeQ9+Q=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D92882B92C;
	Wed,  7 Feb 2024 16:05:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 775FB2B929;
	Wed,  7 Feb 2024 16:05:46 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Orgad Shaneh <orgads@gmail.com>
Cc: git <git@vger.kernel.org>
Subject: Re: git gc destroys autostash
In-Reply-To: <CAGHpTBKpYp370QTw93wK_RP+X2S+44jd-8kjodiUj4k0BoAEqA@mail.gmail.com>
	(Orgad Shaneh's message of "Wed, 7 Feb 2024 22:52:00 +0200")
References: <CAGHpTBKpYp370QTw93wK_RP+X2S+44jd-8kjodiUj4k0BoAEqA@mail.gmail.com>
Date: Wed, 07 Feb 2024 13:05:44 -0800
Message-ID: <xmqq7cjg6l3r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A9BA47E2-C5FC-11EE-B36D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Orgad Shaneh <orgads@gmail.com> writes:

> Running git gc --prune=now during rebase with autostash deletes the
> autostash object, and it cannot be recovered when the rebase ends.
>
> Example:
>
> #!/bin/sh
>
> git init
> echo 1 > foo; git add foo; git commit -m 'Initial commit'
> echo 2 > foo; git add foo; git commit -m 'Second commit'
> echo 3 > foo; git rebase -i --autostash HEAD^
> # Choose edit
> git gc --prune=now

This is totally expected, unfortunately, as the autostash does not
use the ref API to use the refs/stash (presumably in order to avoid
shifting the shash@{$N} numbers). Because of that, the stash entry
is not protected from the garbage collection.  This currently falls
into "it hurts when I twist my arm this way. --do not do it then"
category.

It may be a simple fix to teach sequencer.c:apply_save_autostash()
not to use a random on-disk file to store the returned value from
"git stash create", but use a dedicated ref that is not refs/stash
for its own use via proper use of the ref API.

> git rebase --continue
> # fatal: '3b88163a1bff3859a005554c168d94e5357ee45b' is not a stash-like commit
> # error: cannot store 3b88163a1bff3859a005554c168d94e5357ee45b
> # Successfully rebased and updated refs/heads/master.
>
> Thanks,
> - Orgad
