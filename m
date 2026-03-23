Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CB5382385
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 23:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774307459; cv=none; b=I6vA/1l631BP4RqAQymf35SBXcvhCoNxfMexWJmRQnN0J9Bp2ux/0Nunq60nfAY8qwNhXzLSSmVL9Q+T/fp5Ty3DylXcM5MrwP7P07Zi3uc2AfBlNT4O3+i0ySmju4rVSQVNh5YQdmmH8d9QE0/1SVcwpSVcKClgpR7+lx3IxOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774307459; c=relaxed/simple;
	bh=SlRaXUy9onl91GyFv8xts2yw9eaRZxbKlUUGfhnkpDs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVry2S+AH+bjrEVPUhsG58BKAV1EnXZ2g6erVTgdALwSFOMwtLmACVE9zQkNdgsugEB6bEmZjhRf2A4Euis1hBweP6LdJoTJGYIv7suvxy9AA64MzQWDSRpAx60lR5v4rqLhyxooBWfUo8xUQ86/ZYnsqHXnaNARPQGH3bQdCOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=KLSN19uZ; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="KLSN19uZ"
Received: (qmail 120574 invoked by uid 106); 23 Mar 2026 23:10:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=SlRaXUy9onl91GyFv8xts2yw9eaRZxbKlUUGfhnkpDs=; b=KLSN19uZl3P0qcyNmg/wMQJQPDyFJBnCWWRBOKBYZeio0928q0uwMK6kVwYA+3Ko9VINYMBzy0k8UOYKEz8XVYlsLnkELoNWiVfsu1sKhKC7pB7D9xiaS436W5SIS+XysE7cG5ze6zdcOCKRLP74xRQWLlb8eqZ01KBl+NsFmUXR25633JcLpQ/SSthVJTmi0gZEdrugJlibBh37Ud7wykRX72yq5RpfwlfqtjW1T2RRlNhb0a6M4tkOx7M1fZHQP0QUMOdXgaY8GRlLyi7L6ShpuBl1RUr8ihqCph5AcwOSCNFiu8apIIsaNS7MyJNxOTChgZCMuN2meaEVfyXahw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 23 Mar 2026 23:10:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 159635 invoked by uid 111); 23 Mar 2026 23:10:49 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 23 Mar 2026 19:10:49 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 23 Mar 2026 19:10:49 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>, git@vger.kernel.org,
	joliss42@gmail.com, joliss@gmail.com
Subject: Re: [PATCH v3 1/2] refspec: safely parse refspecs outside a
 repository
Message-ID: <20260323231049.GA23721@coredump.intra.peff.net>
References: <20260322023557.15907-1-jayatheerthkulkarni2005@gmail.com>
 <20260322053617.38951-1-jayatheerthkulkarni2005@gmail.com>
 <xmqq341q41wu.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq341q41wu.fsf@gitster.g>

On Mon, Mar 23, 2026 at 03:27:29PM -0700, Junio C Hamano wrote:

> Looking good.  Shall we declare victory and mark the topic for
> 'next' by now?

I'm not entirely convinced the better solution isn't just:

diff --git a/remote-curl.c b/remote-curl.c
index 92e40bb682..60774af929 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -1552,6 +1552,11 @@ int cmd_main(int argc, const char **argv)
 		goto cleanup;
 	}
 
+	/* yuck, see 9e89dcb66a (builtin/ls-remote: fall back to SHA1 outside
+	 * of a repo, 2024-08-02) */
+	if (nongit)
+		repo_set_hash_algo(the_repository, GIT_HASH_DEFAULT);
+
 	options.verbosity = 1;
 	options.progress = !!isatty(2);
 	options.thin = 1;

That would make the http transport consistent with non-http ones (or at
least any that execute in-process within ls-remote).

Or alternatively, if we think that this use of parse_refspec() is the
only remaining spot for which ls-remote needs a fallback, then we could
apply the patch here and then revert 9e89dcb66a.

-Peff
