Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0553B4502F
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 22:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758322309; cv=none; b=i7PLMAbcPokeDsNrbOTz4XT1wHan6ztA2DuRFVNAPtRHVqNCPiba8A+VE7QPq7jZL96Fh0bsZ1KoO5iKzQNjCx1kgL3hWbpnWcPNSEiJS0mbs/5NQmsuFNsURisVi9MStBRFU7EJk3th1zPZHCyecSh+mDDaDtJdEz0ex4O65Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758322309; c=relaxed/simple;
	bh=lBOp+H3gMLOEirxLfvmu6yh6eKc/EMcUALXKiTzJxe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qreIBBlQ9Xi/7u3GMYvuBi4MinGZDozn2VeO0YRtINgT5VI+0S3xHjHPviVYWoVk8jzu+CTFOtXjT0/wVBwiDb0xS54lIFAziYctWx39P9VxwG6bIYCJtnne3G37n7yAodYBNTxHTG3YerlCIe5XhSegj/XOnBikrHqfl/k0j/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=MHZVVvQY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="MHZVVvQY"
Received: (qmail 134830 invoked by uid 109); 19 Sep 2025 22:51:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=lBOp+H3gMLOEirxLfvmu6yh6eKc/EMcUALXKiTzJxe0=; b=MHZVVvQYyCW5DDeVzucbwaDWgi5Uz0+8tXRUTUM3MiL3Zg2rHTDsBg64EXeM3IBPHrNNqHGh3UA5P19TTul9yNNB53/kLfoIibXa5Nky68iURqqXF+LND2OH99ffJf7IfiJMvzH3vij5MPCur2zPK8uQIZzkDXLy02LwMlC8VkhBEy/xEHHz6QSNVQslYvUyU8x8W07/PwAuX9D3xhT3F2bM1V0LmzHtANcSjfZMKsDeWJXIMbvlCmkyfcsnz0fR8nO3AXfqzskBg7Fbyz6t4my2T6v5fsIDZ0dhz2Um4sr0p6tMZK34XkbNUhSXOuhdjc173JDMUcpruxCWSfpftg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Sep 2025 22:51:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 211470 invoked by uid 111); 19 Sep 2025 22:51:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Sep 2025 18:51:46 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Sep 2025 18:51:46 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH 6/6] revision: retain argv NULL invariant in setup_revisions()
Message-ID: <20250919225146.GF594545@coredump.intra.peff.net>
References: <20250919223351.GA3906184@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250919223351.GA3906184@coredump.intra.peff.net>

In an argc/argv pair, the entry for argv[argc] is generally NULL. You
can iterate by counting up to argc, or by looking for the NULL entry in
argv.

When we pass such a pair to setup_revisions(), it shrinks argc to
account for the options we consumed and returns the result to the
caller. But it doesn't touch the entries after the reduced argc. So
argv[argc] will be left pointing at some arbitrary entry rather than
NULL.

This isn't the source of any known bugs, since all callers are aware of
the limitation and act accordingly. But it's a possible gotcha that may
be easy to miss.

Let's set the new argv[argc] to NULL, taking care to free it if the
caller asked us to do so.

It is tempting to do likewise for all of the entries afterwards, too, as
some of them may also need to be freed (e.g., if coming from a strvec).
But doing so isn't entirely trivial, as we munge argc in the function
(e.g., when we find "--" and move all of the entries after it into the
prune_data list). It would be possible with some light refactoring, but
it's probably not worth it. Nobody should ever look at them (they are
beyond the revised argc and past the NULL argv entry) outside of strvec
cleanup, and setup_revisions_from_strvec() already handles this case.

There's one other interesting gotcha: many callers which do not want to
provide arguments just pass 0/NULL for argc/argv. We need to check for
this case before assigning the final NULL.

Signed-off-by: Jeff King <peff@peff.net>
---
 revision.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/revision.c b/revision.c
index f50f5d8ea2..806a1c4c24 100644
--- a/revision.c
+++ b/revision.c
@@ -3192,6 +3192,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 		revs->show_notes_given = 1;
 	}
 
+	if (argv) {
+		if (opt && opt->free_removed_argv_elements)
+			free((char *)argv[left]);
+		argv[left] = NULL;
+	}
+
 	return left;
 }
 
-- 
2.51.0.568.g6b54b97edf
