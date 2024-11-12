Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1DA120ADE4
	for <git@vger.kernel.org>; Tue, 12 Nov 2024 08:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731400444; cv=none; b=PDw8N9bVuV0MbVulT03fpN4ejcJDWvBwUSYxbgS19Sqc/vNHAemExrJGD3QMoBsooP2dmt1HjBHpmNVlpNgQJdOOqkzd17AtpZALCN+XbfRUIXrD+v8KYL6bBzk4i1RtXEjnDwUwcdJ7ltGarvCEIg4mqpufRaYdJreFrdQ3CpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731400444; c=relaxed/simple;
	bh=RmcrRyn0Z7a2+TaDGgD1IIVR1Xa1ies3M+JvQuFwyb4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dgqXXX6trbw9rP3M1sfhIqvW22tz7lJ98MfX9711BvD0aZSNesyCUdx2W0P1YFLyqLnQM+sPyIRii4VAOyABeuRW5Mavbhf77x5Ss0gTKHVqhbhtVPTCS5QtwHYT6XzFT8yNf+GLXti1Nb5tH5FcrBsww1nkxZjJ3LzgfVtuL2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=F0ytx36E; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="F0ytx36E"
Received: (qmail 30297 invoked by uid 109); 12 Nov 2024 08:34:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=RmcrRyn0Z7a2+TaDGgD1IIVR1Xa1ies3M+JvQuFwyb4=; b=F0ytx36E7s6vmbDQIjEpKyNY6ka7iq7f1ds2JbVLWAPVXH0DMm6Nq+myqPtZ2eLO3fVuaRqorwPtSyJgYWHFxAL1fgJqFxt7udw2fEN/qjtcpwxw5eBiDYLf08F2xGV6erXm+wmbV7OE8v7b4kjeh8ye4llaUQ9y4SWnTApUJKMh4kFosmSYW3kmcQH1WQ6y6k5WpYe8ou45aU6qmBH4zHrU981R85H4lMQ86+xpSxxZq50RxwqkaWiAuaton8tDTjjQ3FcPb4x0ARyU7R1WTm2Cp/xMHrCtUOPF7BZZxNdIZBAgmCUu5lOWSBj8f6omAHVHX1Owx6HZWQfQAXjOdg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 12 Nov 2024 08:34:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27525 invoked by uid 111); 12 Nov 2024 08:34:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2024 03:34:05 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 12 Nov 2024 03:34:00 -0500
From: Jeff King <peff@peff.net>
To: Eric Mills <ermills@epic.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH 1/3] fetch: adjust refspec->raw_nr when filtering prefetch
 refspecs
Message-ID: <20241112083400.GA3529122@coredump.intra.peff.net>
References: <20241112083204.GA2636868@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241112083204.GA2636868@coredump.intra.peff.net>

In filter_prefetch_refspecs(), we may remove one or more refspecs if
they point into refs/tags/. When we do, we remove the item from the
refspec->items array, shifting subsequent items down, and then decrement
the refspec->nr count.

We also remove the item from the refspec->raw array, but fail to
decrement refspec->raw_nr. This leaves us with a count that is too high,
and anybody looking at the "raw" array will erroneously see either:

  1. The removed entry, if there were no subsequent items to shift down.

  2. A duplicate of the final entry, as everything is shifted down but
     there was nothing to overwrite the final item.

The obvious culprit to run into this is calling refspec_clear(), which
will try to free the removed entry (case 1) or double-free the final
entry (case 2). But even though the bug has existed since the function
was added in 2e03115d0c (fetch: add --prefetch option, 2021-04-16), we
did not trigger it in the test suite. The --prefetch option is normally
only used with configured refspecs, and we never bother to call
refspec_clear() on those (they are stored as part of a struct remote,
which is held in a global variable).

But you could trigger case 2 manually like:

  git fetch --prefetch . refs/tags/foo refs/tags/bar

Ironically you couldn't trigger case 1, because the code accidentally
leaked the string in the raw array, and the two bugs (the leak and the
double-free) cancelled out. But when we fixed the leak in ea4780307c
(fetch: free "raw" string when shrinking refspec, 2024-09-24), it became
possible to trigger that, too, with a single item:

  git fetch --prefetch . refs/tags/foo

We can fix both cases by just correctly decrementing "raw_nr" when we
shrink the array. Even though we don't expect people to use --prefetch
with command-line refspecs, we'll add a test to make sure it behaves
well (like the test just before it, we're just confirming that the
filtered prefetch succeeds at all).

Reported-by: Eric Mills <ermills@epic.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c                   | 1 +
 t/t5582-fetch-negative-refspec.sh | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index d9027e4dc9..9e0cabebe7 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -463,6 +463,7 @@ static void filter_prefetch_refspec(struct refspec *rs)
 				rs->raw[j - 1] = rs->raw[j];
 			}
 			rs->nr--;
+			rs->raw_nr--;
 			i--;
 			continue;
 		}
diff --git a/t/t5582-fetch-negative-refspec.sh b/t/t5582-fetch-negative-refspec.sh
index 7fa54a4029..b21bf2057d 100755
--- a/t/t5582-fetch-negative-refspec.sh
+++ b/t/t5582-fetch-negative-refspec.sh
@@ -283,4 +283,8 @@ test_expect_success '--prefetch succeeds when refspec becomes empty' '
 	git -C one fetch --prefetch
 '
 
+test_expect_success '--prefetch succeeds with empty command line refspec' '
+	git -C one fetch --prefetch origin +refs/tags/extra
+'
+
 test_done
-- 
2.47.0.508.g57228aee23

