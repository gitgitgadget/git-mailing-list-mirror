Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5951F76D2
	for <git@vger.kernel.org>; Tue, 21 Jan 2025 21:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737496365; cv=none; b=YxLMwtcQ861U9Viq58ub3SaqIu9cMqW4IzbEWlsfgkvHBR34t9ZDKTwsDqyNHCHJhhHdXMwRJArgQUB7jzAHQGajUv3mIfEJuUczNAPuEGOihnLg9TXvzoC5f3D60yFl/jsDJM8CkeDIrbL160wZIrvWEMX+rUP5dBO3/2c/FlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737496365; c=relaxed/simple;
	bh=EdGy14TpFcmdoXxLYEVHaHzAOBteFCy7QpAPtnGjdiM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j8O2PEQv6Jj3xcx8FsIQkL3Qc5D60bAHa1c3ehfjq9Q77T0OWUexMMKOAMp6D8Fsw8eW6Z5gQoAV4ZNjHU/pZGhxg7LqT0t326gUMAEFjIrQzE+ttUIRnE7VZGBcau+DjIppgs9oG9dF6lXG9NYheQVFO7JtfQau7pE7pViZh5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=NbNRg7BO; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="NbNRg7BO"
Received: (qmail 2676 invoked by uid 109); 21 Jan 2025 21:52:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=EdGy14TpFcmdoXxLYEVHaHzAOBteFCy7QpAPtnGjdiM=; b=NbNRg7BOJXt8V6rPWYkV6fTKLr5EKXCugbGsO/3cKGGXZ7N03G4p3lu/l5dk4hiaebvsuvdZV4nWeI2y9R5y4r/oYCSYcCCl0sUT8pii7/mfI3bQuUcxsVRU/A/noAqDIJgELJc3wDGIvGPwC7V/WhYl2HjKrGsVWGavg16STKDmkeSgGmAbSQOVQIO5QgxaQa4c8Il4eiL6gP4iKBbWZS6FDrHC7KoBzQNDFwPJgOmBolt17rJW0cuMY2ljehiDqdGnuuLHnnw9gike6zAPB3NG6TvLCqRiMl/YtMX39haJxmlGVj98IAfn7+qnl09NLRTmaNH+W43+Pt9KCzHbuA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Jan 2025 21:52:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31725 invoked by uid 111); 21 Jan 2025 21:52:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Jan 2025 16:52:38 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 21 Jan 2025 16:52:35 -0500
From: Jeff King <peff@peff.net>
To: Nika Layzell <nika@thelayzells.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: `git update-ref` fails to set reflog old_oid in 2.48
Message-ID: <20250121215235.GA2753621@coredump.intra.peff.net>
References: <CACwGqKixQEGau8CZuLwJx02F4h8hxrf9e_7N1tHMU=Wvy8ViyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACwGqKixQEGau8CZuLwJx02F4h8hxrf9e_7N1tHMU=Wvy8ViyQ@mail.gmail.com>

On Tue, Jan 21, 2025 at 03:40:06PM -0500, Nika Layzell wrote:

> In git 2.48.1, the `git update-ref` subcommand no longer correctly
> updates the reflog in some cases. Specifically, it appears that the
> `old_oid` field will not be updated when modifying a branch referenced
> by another symbolic ref (e.g. HEAD). This doesn't break the `git
> reflog` subcommand, but does break references like `HEAD@{1}`, which
> appear to read the `old_oid` field.
> 
> STR (in a fresh directory):
> ```
> git init -b main
> git commit --allow-empty -m "A"
> git commit --allow-empty -m "B"
> git update-ref -m "reason" refs/heads/main HEAD~ HEAD
> ```
> [...]
> The `old_oid` field is empty (all zeroes). This is only the case in
> derived reflogs (in this case .git/logs/HEAD). The reflog for
> refs/heads/main appears to be updated correctly.

Thanks for an easy reproduction recipe. Looks like it bisects to
297c09eabb (refs: allow multiple reflog entries for the same refname,
2024-12-16). Author cc'd.

Just looking at the diff, the early return from lock_ref_for_update()
seems suspicious to me. Doing this:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 8953d1c6d3..1c0e24a855 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2611,9 +2611,6 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 
 	update->backend_data = lock;
 
-	if (update->flags & REF_LOG_ONLY)
-		goto out;
-
 	if (update->type & REF_ISSYMREF) {
 		if (update->flags & REF_NO_DEREF) {
 			/*

makes the problem go away, and doesn't fail any tests. But that is just
me poking at it without understanding why those lines were there in the
first place.

-Peff
