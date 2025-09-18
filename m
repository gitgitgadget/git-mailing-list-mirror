Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F45288C39
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 18:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758219950; cv=none; b=DEPbO9F2HmNZylm4VNtGF4kf+FtFo9tvH8DtzBHZ8uag/CAJen7AasKNpjbigCHHDYFX2C2qQTWIuYnkGi8o0xIOmNa0cCB6US1jRktVZJQ7y6jWwUGjSz60Rii6qJQLeSPK3lWZlKckwPfLa3geM+ak4SUwY8TSsQG6D6mTqpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758219950; c=relaxed/simple;
	bh=PndyDejQi/9uUiYa4ZITPFvtOipKmMpNQswSU5N9F4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eku8/GE+FAuNTnXbv6TyKlbR/yh5BVPaLl5OhRl/rGcXMtPlgzmSB/WAFUuuznNBpZ4aGcjWGo0P6/b81ku9GMZ7WxscO7FUVNJWwCiouIVwA1WhunAxDhx4D0xwcdocCENmp6If+5PTB697JizERFP4OzjbfoCDebL/O1OOndU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Ls1ZBbv7; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Ls1ZBbv7"
Received: (qmail 121592 invoked by uid 109); 18 Sep 2025 18:25:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=PndyDejQi/9uUiYa4ZITPFvtOipKmMpNQswSU5N9F4w=; b=Ls1ZBbv75X3UIUsJ7VvHZMY5fkIMa3mCnSRR4q67rfAJAg+/cFTsQ9nn23QThr0Q5ibMQWuLXUrqmkdkjWy0RAAvunhm2yAMmkzaOYJjUk2DbW58r9IpoUZ4xh1RshPLDBbSYT85FLbMqN42XQ8UxD+Odsag6EN4oLPV3eJOW+GdQdpQuZWRyCZgq/zqr2jQG+fqOoUNeGmF/uNYeYSAhoIlijARvyk5qbUXKV6k85e5kvMlZeBPto/Y0YbuWEvQb1EQRz7dyIvmx8EbZ8wtReqpST/7mLVU4s5aFhKlS2blcRDG7ZIB8l/3QTUuCmZmF75z1uHtMYzPX3Hx8Prq7A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 18 Sep 2025 18:25:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 194601 invoked by uid 111); 18 Sep 2025 18:25:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 18 Sep 2025 14:25:46 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 18 Sep 2025 14:25:45 -0400
From: Jeff King <peff@peff.net>
To: David Goldstein <dgoldstein0@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [bug] git check-ignore returns the wrong exit code with -v when
 only a negative pattern matches
Message-ID: <20250918182545.GA1184978@coredump.intra.peff.net>
References: <CANavNqpHqVgHshUaToS51OGVuvx5FqxROP2PssHW9OELMLeBQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANavNqpHqVgHshUaToS51OGVuvx5FqxROP2PssHW9OELMLeBQQ@mail.gmail.com>

On Thu, Sep 18, 2025 at 10:28:05AM -0700, David Goldstein wrote:

> Hey folks, I think I found a git check-ignore bug.  According to the
> docs, git check-ignore should only exit 0 if a file is ignored, but if
> an untracked file matches a negative pattern in .gitignore (or the
> file can be tracked if --no-index is also used), then git check-ignore
> -v <file> exits 0 when it should exit 1; without -v the exit code is
> correct (0).
> 
> https://github.com/dgoldstein0/git_bug_repro has a self-contained
> reproduction + repeated explanation.
> 
> This exists in all git versions I've tested, but I haven't tried to
> get the latest dev version to check if it's still a problem in the
> latest version.

I can reproduce it here with the latest version. I've never looked at
the check-ignore code before, but it looks like the issue is something
like:

  1. We "count" ignored files by seeing if the matched "pattern"
     variable is left non-NULL.

  2. In non-verbose mode, we set the pattern to NULL when it is a
     negative pattern. Makes sense.

  3. In verbose mode, we don't do that because we need to show the
     pattern. So we accidentally count the entry as ignored.

So something like this makes your repo behave as you expected:

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 644c9a414f..808c0e5ff4 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -117,7 +117,7 @@ static int check_ignore(struct dir_struct *dir,
 		}
 		if (!quiet && (pattern || show_non_matching))
 			output_pattern(pathspec.items[i].original, pattern);
-		if (pattern)
+		if (pattern && !(pattern->flags & PATTERN_FLAG_NEGATIVE))
 			num_ignored++;
 	}
 	free(seen);

AFAICT it has been this way since the inception of the code. I haven't
ever used the exit code of check-ignore. I wonder if the current
behavior is actually useful, along the lines of "exit 0 if any output
was shown, and 1 otherwise". That would justify a difference in behavior
between running with "-v" and without. But again, I've never used the
exit code so I'm not sure in what circumstances it would be useful.

-Peff
