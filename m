Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171B1AF6B5
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 16:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718902668; cv=none; b=Mhtl3RBnORg8XK1rpeeqMZk+VryoNTEV3Zwkfv1oCU9iV2gaKOVVaYB64tI/+KtodpaDlnI0uEFih0PdOXu6QU5LvboEUl/gyIaQLzbJVM/6Jzj5Q/dMGEa8VHz66iXSwu+kfhVtajhUMbSSpo78InD7F6tVrAxrv1wFREXLSQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718902668; c=relaxed/simple;
	bh=EIOGAhAg1dEqOlpWDWhsKWNb/3BQSXEr28N8zI8GUIQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g4ObG2NUToj3urw+xWxL2WijHT9UJaXn/J4jKKOusdSlEyzxqbVmZDrrgweVk6lKCI6QNAiQ+8rYpGWLUeesjaE0GOQaJRq2IMBv+I90vOwXsbxxznYvfNNakNxiqdgkx4p7TFTK2baW0GOvkSGn9jizdeSHuejhnA6+IoGXiow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xkVJm7FP; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xkVJm7FP"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id E9B701CDFD;
	Thu, 20 Jun 2024 12:57:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EIOGAhAg1dEq
	OlpWDWhsKWNb/3BQSXEr28N8zI8GUIQ=; b=xkVJm7FPtxoPImMuUioZvk6ljRo2
	sOIYOBX/Xxl4SKPuszidUEKSfHdIKZopvsKFs4v5ApfN1DJAjYMGwT5G7gaXPrwT
	K0Y6VYjcBqR5VPpWBABiqUNVNzl4Z6woRBcay+mnsFPwzaX+S7bqNm78gzuVddDY
	tP//xoh4F7aCKoQ=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D16FA1CDFC;
	Thu, 20 Jun 2024 12:57:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 400971CDF8;
	Thu, 20 Jun 2024 12:57:45 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Paul Millar <paul.millar@desy.de>
Cc: git@vger.kernel.org
Subject: Re: bug with git describe --dirty --broken
In-Reply-To: <0fd230f6-a5c5-463d-8584-651ceff3cf99@desy.de> (Paul Millar's
	message of "Thu, 20 Jun 2024 13:14:24 +0200")
References: <0fd230f6-a5c5-463d-8584-651ceff3cf99@desy.de>
Date: Thu, 20 Jun 2024 09:57:43 -0700
Message-ID: <xmqqwmmjwnzs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 372DF0E6-2F26-11EF-A1B6-5B6DE52EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Paul Millar <paul.millar@desy.de> writes:

> When run within the container, git identifies the repo as dirty. =C2=A0=
The
> 'podman run' command returns
>
> v1.0.0-dirty
>
> Anything else you want to add:
>
> I believe the problem comes from two parts.
>
> First, when running within the container, the files seemed to be owned
> by user root.
> ...
> This results in an inconsistency between the ownership information
> contained within the .git/index file and the ownership information on
> the filesystem when git is run within the container.

Indeed.  You are running git in two separate environments with
inconsistent worldview.  As many attributes of each file (like the
last modified timestamp and who owns the file) are recorded in the
index for files that were verified to be unmodified (this is done so
that by doing lstat() on a path and comparing the result with the
information saved in the index, we can notice that the path was
modified without actually opening the file and looking at the
contents), after doing something (like "git diff") that causes this
information updated while the files appear to be owned by you,
switching to the alternate world where the files appear to be owned
by root and asking "are these files modified?", Git will trust what
is in the index and report "the index says they are owned by you but
lstat() says otherwise; you must have modified them".

The way we deal with such false positives is to "refresh the index".

And it is done in "git describe --dirty" codepath, but not
"--broken" codepath, which is the cause of the issue you discovered.

There is code snippet in builtin/describe.c that does:

	if (broken) {
		run 'git diff-index' in a subprocess
		use the result from 'diff-index' unless the command
		aborted
	} else if (dirty) {
		refresh the index
		run the equivalent of 'diff-index' in-core
		use the result; if the in-core diff-index aborts,
		you are dead already.
	}

I _think_ the "broken" codepath should be taught to also run "git
update-index --refresh" before it runs "git diff-index" (both in
their own subprocesses, or run in the same subprocess sequencially,
as if "git update-index --refresh && git diff-index" were run), and
your problem may disappear.

Thanks.
