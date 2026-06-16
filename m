Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6981F29346F
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 08:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781599126; cv=none; b=j6Lsab/zxAjMxC+wIXspeGhkAWZC9HELMJZNFH6UTlyWenXaIJ1rsthfkGWLp9R44X/8doMeLczHlgDFpv7/3TXeRbT/M+ixSaXFDBZ8K/cpqg1Lt1cCcgwfuhX3zQmlpkM1okG9uUsTDtceV6E0Cr5zgG6zwa+R6WCOHI4hAdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781599126; c=relaxed/simple;
	bh=ME2TXQ3jPM0ty4lpC49GnwwSdoItqZkNcELTHPJQORs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nA7zI+64qSVPOxrBMvuIkhc5skiNd+IU8r8lN9RJ90CaJQg9Bzl9KBxkFkjCLw8W5Edems4q3qz1VWVthf5aAilm4vr/84FPWDwTifS21Hr7J5QOz26xpbQzULYynt3xFA0UfNYl0wKa+88B6q50og4A3LS7jl8Afy+38bf+a+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=YoMzCP7Z; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="YoMzCP7Z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1781599120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=swYFco2zfSbWnwb/dTINH5CfJv2HLQ71Ixk2eVSIBL0=;
	b=YoMzCP7ZBs50zzNWve6BmI4cIymRrlOGnaYH6OVIC8TN95hSJsKeWjDUFUjtXBHAf1aFNi
	XGfg+/620eS48e7ZpEy26jiR4/e5ow9kJjwXvkz785FjAqNotOvsowWvl41zrZqL7ocaH5
	NtpJ76lDw2m5O7k5d6ToTcZ9gCGyFFk=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 3/3] replay: offer an option to linearize the commit
 topology
In-Reply-To: <xmqqjys6wcpo.fsf@gitster.g>
References: <20260610-toon-git-replay-drop-merges-v2-0-5714a71c6d83@iotcl.com>
 <20260610-toon-git-replay-drop-merges-v2-3-5714a71c6d83@iotcl.com>
 <xmqqjys6wcpo.fsf@gitster.g>
Date: Tue, 16 Jun 2026 10:38:34 +0200
Message-ID: <871pe6zxpx.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> In the review response during the previous iteration, I commented
> that (1) the original excluded only merges, but (2) your version
> excluded both merges and the root commits the same way.  Your
> response was:
>
>     The way it was written in v1 was maybe a bit too smart and hard to
>     follow. I agree with your suggestion and will adopt this (with some
>     tweaks) in the next version.
>
> which I took as saying "it may be confusing, but it correctly
> expresses what we want to do", meaning "yes, roots and merges should
> be handled the same way".  But the above no longer treats roots the
> same way as merges.  I think that is intended, but just wanted to
> double check.

Great callout. I was running the "replay down to root" test with v1 vs
v2, but as you pointed out, the test I wrote doesn't actually replay
down to root. Now I've fixed the test and reran the test against both
versions and verified what you're saying.

So to answer your question, yes this change is intentional and shout out
to you for requesting to add this test (properly) so we actually catch
this. 

>> +test_expect_success 'replay to rebase merge commit with --linearize down to root commit' '
>> +	git replay --ref-action=print --linearize --onto main A..topic-with-merge >result &&
>
> As with other test pieces, this "git replay" command line is overly
> long and hides the important bit which is that the range being
> replayed is *not* actually down to the root, which is A (it excludes
> A).  Intended?

No, not intended. And while at it, I'll split up the command on two
lines. 

-- 
Cheers,
Toon
