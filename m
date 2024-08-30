Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC3F11C92
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 00:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724977911; cv=none; b=WegeRRlK9UQ288JOBR1xI7WhyZoAYdCmBhbFViUBWu+Uo3YuEKkcGJtkb9yTve6QmqRqcwt4vzc9HRcg91SqnFZ0jBrEOlJlkqUXdhwuvsdRMRFC1D3I+cVNV+QvQSbIayx/nSWWvW2ZUBw1iND2l+poxae5dhAXlO0m0oJc140=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724977911; c=relaxed/simple;
	bh=UksqA28oq8F3KosGvvH4uhO2bPcaxQAQHeBs4LgLvsM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GJteu7ww3zM59jIPPBwoF7xBmVoX6/myVmwS1E6R6sVlF9WCYIkF880mEex5qsRyoU/g+8s3eG0qh2MsrC2JprUbOLaaQI/Hx7kChic/00cCJUySBS+ywgqjosNothwmxEHmGxpcqe5dJfLukuscbw3bz4DGaV1XFryZuW7WvEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6996 invoked by uid 109); 30 Aug 2024 00:31:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 30 Aug 2024 00:31:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13673 invoked by uid 111); 30 Aug 2024 00:31:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 29 Aug 2024 20:31:50 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 29 Aug 2024 20:31:47 -0400
From: Jeff King <peff@peff.net>
To: Pavel Rappo <pavel.rappo@gmail.com>
Cc: Elijah Newren <newren@gmail.com>,
	Git mailing list <git@vger.kernel.org>
Subject: Re: How to turn off rename detection for cherry-pick?
Message-ID: <20240830003147.GA450797@coredump.intra.peff.net>
References: <CAChcVumj41NCAcjzLyDGAyb+-QuL0Ha1AANe67jKVBT8xDRYdg@mail.gmail.com>
 <CAChcVunYDO_KAmEOoWEL2q63_Gzua-Kt3BmE5Snb8==K9Cww1w@mail.gmail.com>
 <20240829214336.GA440013@coredump.intra.peff.net>
 <CAChcVukzk=-1JNAoffWQEEv4Ne1FozGEwzGuaUWuiwhoHkcUng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAChcVukzk=-1JNAoffWQEEv4Ne1FozGEwzGuaUWuiwhoHkcUng@mail.gmail.com>

On Fri, Aug 30, 2024 at 12:12:07AM +0100, Pavel Rappo wrote:

> You seem to have confirmed my understanding that I described in my
> initial email (you replied to my second email in this thread).

Heh, I did not even see the first message in the thread. But since we
independently arrived at the same conclusions, I guess we can consider
everything there accurate. :)

I do think it's a bug that ort doesn't respect -Xno-renames. The fix is
probably something like this:
 
diff --git a/merge-ort.c b/merge-ort.c
index 3752c7e595..94b3ce734c 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3338,7 +3338,7 @@ static int detect_regular_renames(struct merge_options *opt,
 	repo_diff_setup(opt->repo, &diff_opts);
 	diff_opts.flags.recursive = 1;
 	diff_opts.flags.rename_empty = 0;
-	diff_opts.detect_rename = DIFF_DETECT_RENAME;
+	diff_opts.detect_rename = opts->detect_rename;
 	diff_opts.rename_limit = opt->rename_limit;
 	if (opt->rename_limit <= 0)
 		diff_opts.rename_limit = 7000;

though I'm not sure how DIFF_DETECT_COPIES should be handled
("recursive" silently downgrades it to DIFF_DETECT_RENAME).

I've added ort's author to the thread, so hopefully he should have a
more clueful response.

-Peff
