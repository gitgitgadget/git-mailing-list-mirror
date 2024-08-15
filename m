Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528461AD419
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 15:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723735811; cv=none; b=jxgaMCbsTKNc00yDOvgnbQWXvimSryYszzFmFBdI+WYv9YxxB1kUaXOQy+4x++eX4Yxxv53p1bYx5CBpo4HpnEgnAahOCUvvsy0PsLPf7utcKiU6dsxehXGvpuUJNoh8u84HZdqzaW/6jRRkK8zbHuj0q7DlVAqbDZ5kKJcXFo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723735811; c=relaxed/simple;
	bh=TaJdSyzcbcIZVVbF8o1aUI9z/kVi0AGylh1uK7Yjnhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IY38mxFhgy1JMjTl9iERtlJwlEw85avr79ZY8qcZCy4cYM7quKAIbO2NNeHgxqASmY2G1mld8Gy9LEojZpmZqQtNn0nbWpRKb1rGOngtl2mbbimy3Kc9pMgCH0EWxrAJLuy7cBpiooOt/vyqjJeQ/CpOi/XbHZs4ePhnZ0t/U/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 27529 invoked by uid 109); 15 Aug 2024 15:30:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 15 Aug 2024 15:30:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8327 invoked by uid 111); 15 Aug 2024 15:30:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 15 Aug 2024 11:30:08 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 15 Aug 2024 11:30:07 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: [PATCH] t4129: fix racy index when calling chmod after git-add
Message-ID: <20240815153007.GA1477220@coredump.intra.peff.net>
References: <20240801155702.70242c31d476c46c84ee11a3@linux-foundation.org>
 <xmqqed77hifn.fsf@gitster.g>
 <20240801180706.933d797b0ae5744fdcdf47d2@linux-foundation.org>
 <20240802035121.GB1246312@coredump.intra.peff.net>
 <xmqq7cczgefh.fsf@gitster.g>
 <20240805060010.GA120016@coredump.intra.peff.net>
 <xmqqcym9vnwg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqcym9vnwg.fsf@gitster.g>

On Thu, Aug 15, 2024 at 07:52:47AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +test_expect_success POSIXPERM 'patch mode for deleted file is canonicalized' '
> 
> This test seems to fail under "--stress" and I need to borrow a
> brain better clued than mine.  It appears to be fooled by mtime that
> is not updated immediately and failing match_stat check, but since
> the index file is written on the other side of the second resolution
> boundary, racy-git double-checking code does not trigger, or
> something like that.

Ah, thanks. I saw this fail once in CI, and then later succeed. But for
some reason I wrote it off as CI flakiness rather than trying --stress
locally. It's easy to reproduce the issue.

I didn't puzzle out the exact condition that causes the race, but I
think the fix is pretty clearly this:

-- >8 --
Subject: [PATCH] t4129: fix racy index when calling chmod after git-add

This patch fixes a racy test failure in t4129.

The deletion test added by e95d515141 (apply: canonicalize modes read
from patches, 2024-08-05) wants to make sure that git-apply does not
complain about a non-canonical mode in the patch, even if that mode does
not match the working tree file. So it does this:

	echo content >non-canon &&
	git add non-canon &&
	chmod 666 non-canon &&

This is wrong, because running chmod will update the ctime on the file,
making it stat-dirty and causing git-apply to refuse to apply the patch.
But this only happens sometimes, since it depends on the timestamps
crossing a second boundary (but it triggers pretty quickly when run with
--stress).

We can fix this by doing the chmod before updating the index. The order
isn't important here, as the mode will be canonicalized to 100644 in the
index anyway (in fact, the chmod is not even that important in the first
place, since git-apply will only look at the index; I only added it as
an extra confirmation that git-apply would not be confused by it).

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t4129-apply-samemode.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4129-apply-samemode.sh b/t/t4129-apply-samemode.sh
index d9a1084b5e..87ffd2b8e1 100755
--- a/t/t4129-apply-samemode.sh
+++ b/t/t4129-apply-samemode.sh
@@ -153,8 +153,8 @@ test_expect_success POSIXPERM 'patch mode for new file is canonicalized' '
 test_expect_success POSIXPERM 'patch mode for deleted file is canonicalized' '
 	test_when_finished "git reset --hard" &&
 	echo content >non-canon &&
-	git add non-canon &&
 	chmod 666 non-canon &&
+	git add non-canon &&
 
 	cat >patch <<-\EOF &&
 	diff --git a/non-canon b/non-canon
-- 
2.46.0.476.g32f0e7348d

