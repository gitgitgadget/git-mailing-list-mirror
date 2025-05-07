Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842CC28980B
	for <git@vger.kernel.org>; Wed,  7 May 2025 13:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746623611; cv=none; b=DH7Ft8MIlI+Rw2cbeQc6ntQ9PRbNjyPKIV7VrmCZFl2Y34C5TW9RYL0w7IJnBg4QOEJzQDZk1reSaCeLS7vHANfIw4F0GbEOTeqY21ZOjjNzP2qHT1N4GWYBUuITG6lSxeF0wG5fUCfzbcYCnFQSocNJ03en9x0mG9qZGabt5tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746623611; c=relaxed/simple;
	bh=aG/6o76QyKyEN00S3n/kVfBORLl1u2nzx6s2cWw9QF4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sLmM1btntUCGb4DN2c5FomOZyrxWtXS4Ys4MI1Z9+bttYlvGP5fowls9AaVX8pmS1D+4HTeCOnIzbteRc64dqtWTp9uy32UusepMp2O3KaUw8m1VgoOiC63yyqFOvBD6Q5eTvhiKM2Swo6I93ccTTcLaPpTYaw33cawRp9zWp20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=QV9AVeRB; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="QV9AVeRB"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1746623605;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l88C2lc1hxOpSW0HtpzfCha9uk15Y/uRzme2QDBH0tk=;
	b=QV9AVeRBJjtKE+X8WjnWNnE9nKR5ean330EHKwY9v7S8/cYv047yeFSNw9hAt1an7qTQ1h
	NnmVg0dSRF8FPPoPQ7k4fAovVpRe8qtYFygJU/7PodHMCpCb4xFfUR2Y6lxsZwwrmWnKbt
	RMQsA0ibsoBs2RA4iChzCyWWqi2pVEU=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Taylor Blau
 <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, =?utf-8?B?w4Z2YXIg?=
 =?utf-8?B?QXJuZmrDtnLDsA==?=
 Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH RFC 1/5] blame-tree: introduce new subcommand to blame
 files
In-Reply-To: <xmqqfrhxv8fn.fsf@gitster.g>
References: <20250422-toon-new-blame-tree-v1-0-fdb51b8a394a@iotcl.com>
 <20250422-toon-new-blame-tree-v1-1-fdb51b8a394a@iotcl.com>
 <xmqqfrhxv8fn.fsf@gitster.g>
Date: Wed, 07 May 2025 15:13:12 +0200
Message-ID: <87h61wimxj.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> What is missing in the series is an end-user facing documentation,
> it seems?  Don't take this as a complaint; an RFC is expected to be
> incomplete and one of the reasons asking for comment responses is
> to fill the gaps.

Yes, I'm aware that was missing, but I didn't want to spend too much
time on this if the general idea would be discarded anyway.

> How is the "most recent modification" defined in a history with
> forks and merges?  For example, in this topology:
>
>  A---B---B---B---B---B
>           \     /
>            C---D
>
> where each letter denotes the contents in the path we are interested
> in (and as usual, time flows from left to right), is it the child of
> commit A that made the last modification from A to B?  Or was it the
> merge commit that compared B and D and decided that the path should
> have B?  Something else?  Does it change the story if the sides of
> the merge were swapped, i.e. if the branch that kept B all the way
> were not the mainline but the side branch that got merged?
>
>  A---B---B---C---D---B---B
>           \         /
>            B-------B
>
> The same question applies if the path we are interested in is a
> tree, not a leaf file.
>
> I do not seem to see such a case that involves "ours" merge in the
> tests, either.

Those are good scenarios to think about. I'll try to include them in
test cases for the next version. I think it's easier to argue about it
then.

--
Toon
