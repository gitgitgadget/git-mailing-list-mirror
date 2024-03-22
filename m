Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868CE225A2
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 09:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101595; cv=none; b=rX/oeeEUVKS0J5N/m5uN1GcDRsGfStVazOKZAiyr0EBw0zDC9+LMtnyuSFEbih+ESluS9//envM3XeDouPYXTGDFKNqI+cIngecChnS13BBWp+prwUtC3TIXjdh5SdOGW99QZUOYvofplXlopfpeJN1OYhjkBZQrWpXvygv5Jno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101595; c=relaxed/simple;
	bh=v0FHTHmAtQSeWTC2Upv8N44w9hGGf42BFCvuvSGxQB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ALHnkwPBKV+RO2lOz4Nk26bhNpcii0GEXzHcSvMOWJOzn8IJ9oOwlyl4ZeYkhDkIDq0pgKfwXAYhluSvBxYo3hpeygJoD7LKvZ4Mz/iXdFwCDTUChdwyIN1qcirOhlbFpdDRiQ9Dv000kqs0DyjK02IeTtogXez/WKyveakCFjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 5555 invoked by uid 109); 22 Mar 2024 09:59:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 22 Mar 2024 09:59:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5844 invoked by uid 111); 22 Mar 2024 09:59:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 22 Mar 2024 05:59:56 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 22 Mar 2024 05:59:51 -0400
From: Jeff King <peff@peff.net>
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH 7/6] format-patch: fix leak of empty header string
Message-ID: <20240322095951.GA529578@coredump.intra.peff.net>
References: <cover.1709841147.git.code@khaugsbakk.name>
 <cover.1710873210.git.code@khaugsbakk.name>
 <9a7102b708e4afe78447e48e4baf5b6d66ca50d1.1710873210.git.code@khaugsbakk.name>
 <20240319212940.GE1159535@coredump.intra.peff.net>
 <20240320002555.GB903718@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240320002555.GB903718@coredump.intra.peff.net>

On Tue, Mar 19, 2024 at 08:25:55PM -0400, Jeff King wrote:

>   [1/6]: shortlog: stop setting pp.print_email_subject
>   [2/6]: pretty: split oneline and email subject printing
>   [3/6]: pretty: drop print_email_subject flag
>   [4/6]: log: do not set up extra_headers for non-email formats
>   [5/6]: format-patch: return an allocated string from log_write_email_headers()
>   [6/6]: format-patch: simplify after-subject MIME header handling

These patches introduce a small leak into format-patch. I didn't notice
before because the "leaks" CI jobs were broken due to sanitizer problems
in the base image (which now seem fixed?).

Here's a fix that can go on top of jk/pretty-subject-cleanup. That topic
is not in 'next' yet, so I could also re-roll. The issue was subtle
enough that a separate commit is not such a bad thing, but I'm happy to
squash it in if we'd prefer.

-- >8 --
Subject: [PATCH] format-patch: fix leak of empty header string

The log_write_email_headers() function recently learned to return the
"extra_headers_p" variable to the caller as an allocated string. We
start by copying rev_info.extra_headers into a strbuf, and then detach
the strbuf at the end of the function. If there are no extra headers, we
leave the strbuf empty. Likewise, if there are no headers to return, we
pass back NULL.

This misses a corner case which can cause a leak. The "do we have any
headers to copy" check is done by looking for a NULL opt->extra_headers.
But the "do we have a non-empty string to return" check is done by
checking the length of the strbuf. That means if opt->extra_headers is
the empty string, we'll "copy" it into the strbuf, triggering an
allocation, but then leak the buffer when we return NULL from the
function.

We can solve this in one of two ways:

  1. Rather than checking headers->len at the end, we could check
     headers->alloc to see if we allocated anything. That retains the
     original behavior before the recent change, where an empty
     extra_headers string is "passed through" to the caller. In practice
     this doesn't matter, though (the code which eventually looks at the
     result treats NULL or the empty string the same).

  2. Only bother copying a non-empty string into the strbuf. This has
     the added bonus of avoiding a pointless allocation.

     Arguably strbuf_addstr() could do this optimization itself, though
     it may be slightly dangerous to do so (some existing callers may
     not get a fresh allocation when they expect to). In theory callers
     are all supposed to use strbuf_detach() in such a case, but there's
     no guarantee that this is the case.

This patch uses option 2. Without it, building with SANITIZE=leak shows
many errors in t4021 and elsewhere.

Signed-off-by: Jeff King <peff@peff.net>
---
 log-tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/log-tree.c b/log-tree.c
index eb2e841046..59eeaef1f7 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -480,7 +480,7 @@ void log_write_email_headers(struct rev_info *opt, struct commit *commit,
 
 	*need_8bit_cte_p = 0; /* unknown */
 
-	if (opt->extra_headers)
+	if (opt->extra_headers && *opt->extra_headers)
 		strbuf_addstr(&headers, opt->extra_headers);
 
 	fprintf(opt->diffopt.file, "From %s Mon Sep 17 00:00:00 2001\n", name);
-- 
2.44.0.682.g01e1dab148

