Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EB4634EE
	for <git@vger.kernel.org>; Wed, 13 Mar 2024 17:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710351089; cv=none; b=AtOFbaBXaEmlDeCIM3zr2izZx1Szk+0eM/cg3BlJqIqnO+ifWKKc/dDi3pC0IpSouONEnoV91jKSv0C2mfyTfqug3m/kt8GPVuZAl2FAM/D/6HqJJk8/nzuHmKBSxEM028lNRb1iPxOp7tkbTVffueByYflAQ0Xr6M809+8F8qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710351089; c=relaxed/simple;
	bh=5yj7zgqoWw2WyF/rrZeGf0+bTe3YDyrTaaw90AaQXj4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nEF4qT/31ogxPidDgca0mnN69E7DF84ucrKeQ7ahUV0jsgBJ/eKFeIQcAEi9LJqzz572TSOF1nkBrKJ+eimtZ8Y66EoSMWEOpf2cW0roR5ZAQltxN18LF5ktKQppn7zIRb7iPfWrdg/RgAkPQ6p78zFF1TSq4G012Xoa78I/CqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=A6D1axxS; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="A6D1axxS"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 415931D429B;
	Wed, 13 Mar 2024 13:31:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=5yj7zgqoWw2WyF/rrZeGf0+bTe3YDyrTaaw90A
	aQXj4=; b=A6D1axxSL54Fvo5xp0+Jjv6XpSxmuRCqIeiSmsad3C6eNfYyS7DQZ/
	K7Tt21EelMcGu2OqUW16hglNBR86arHPRoxgwG3SABrUh8hqKnnYbuivcbkuqNMn
	cmw1xSWOwFNsdHSfgEk/NOrA5ZaruiCAN0MG0IbPnfhQtdvm4HlTs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 39D531D429A;
	Wed, 13 Mar 2024 13:31:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 94A1F1D4299;
	Wed, 13 Mar 2024 13:31:26 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: James Liu <james@jamesliu.io>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/1] log: make the --oneline option work with -L
In-Reply-To: <20240313090841.36717-1-james@jamesliu.io> (James Liu's message
	of "Wed, 13 Mar 2024 20:08:40 +1100")
References: <20240313090841.36717-1-james@jamesliu.io>
Date: Wed, 13 Mar 2024 10:31:25 -0700
Message-ID: <xmqqr0geca36.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 85196930-E15F-11EE-8A8E-25B3960A682E-77302942!pb-smtp2.pobox.com

James Liu <james@jamesliu.io> writes:

> git-log accepts the --oneline option to display the short commit SHA and
> title only. This is a convenient option when searching through Git
> history, as it gives a rough idea of the changes introduced in each
> commit. git-log also accepts the -L flag, which lets us provide a line
> range for a given file. This is handy for limiting the search to a given
> area of interest.
>
> However, when --oneline is used in combination with -L, Git actually
> outputs the single line commit information _as well_ as the full diff.
> For example:
>
>         git log --oneline -L 660:Documentation/MyFirstObjectWalk.txt
>
> will incorrectly display the diffs too.

Why is it incorrect?

 * "git log" takes options to tweak formatting of the commit log,
   options to tweak what commits are chosen, and options to tweak
   how the diff are shown.

 * "--oneline" tweaks how the log message gets shown.  Others in the
   family are --pretty=fuller, --format='%h %s', etc.

 * "-L" tweaks how the diff gets shown (e.g. limits which part of
   the diff is shown) and what commits are shown (e.g. limits to
   commits that touch the specified area).

So, just like "git log -L <range>:<file>" shows the commit log for
each commit that touches the specified area of the file, followed by
the diff that shows how the commit modified the range, it is natural
to expect "git log --oneline -L <range>:<file>" to show the same diff
after showing the commit log for these commits in the specified format,
namely, with just a one-line description.

It is not limited to "-L"; "git log --oneline -p" is expected to
show the patch after a one-line description for the commit.

