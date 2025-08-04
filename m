Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFD32741D6
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 15:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754322813; cv=none; b=FSvpNl11a/OqBBEvcOLqvCwgdBT1Mx/RieRvs39euH6B77alx+mqZp+rit4LgGfAZQAX+YCVSp58ATEZ/9etQMUjzBM44QCMcJq34ocXguyzGEmHC5jANmfZrlsGmIwvrX1unhp3hEiSOezHDuuG2IumTnjEf19C3pDQcfiz8OA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754322813; c=relaxed/simple;
	bh=/b2UwOddZ5M0GOZDUcYnL8rpzM896En9X/D7hRhyT8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HpUEfrJO94cmnXxQH3Gp5GVcubbQ1APnJUb9VMwSLmUeu7nNBsuI6VkCxPGhnyI3zpXA2i+vu5VrOQgiD2Had0ZzjdhohGTzhDH7A/GemFAGvKSmolcaMIz1oVAgNM1HVdM+gltF4LfpjA60ivJBP9lSh5WWFVmlDpWx3xnIBv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=cUbLm+LT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="cUbLm+LT"
Received: (qmail 1981 invoked by uid 109); 4 Aug 2025 15:53:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=/b2UwOddZ5M0GOZDUcYnL8rpzM896En9X/D7hRhyT8M=; b=cUbLm+LTDpf9dAT/v9eiCFmVgxoWbip5p5XVoBvR49dohmIunl969AC2FS7Fb5avlh5Wc9NorxBV8Ohvd5JjnG21mQuk97oCuRTDR+AM1XBkusf7Jq+CWK1rcmIUpKwrGXSBQtfYk9JkDeKdL6QPiKjKX1QSn+k8XdsbxpaY9Rv/d5RD7x21rHz5ee5Vy7w7ZV8clIMP8/cq5/GpeJ2m8aCS2ps8DTChbJnCAD56u36Ou/6UvPcMXW0kLtaCt38NEkTBPZrjcHRYJqakkZ7p2/d9pbsfQctYWb+ghHnrwAXKZZ6Y04rE9PN4RopSqz9exvK/ftKYtxUPM9XOJ66CTQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Aug 2025 15:53:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21604 invoked by uid 111); 4 Aug 2025 15:53:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Aug 2025 11:53:30 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 4 Aug 2025 11:53:29 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, Denton Liu <liu.denton@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] fix -Wmaybe-uninitialized with -Og
Message-ID: <20250804155329.GD109984@coredump.intra.peff.net>
References: <d03308e9474f5e26fd4a5494ec243a278e971443.1754302009.git.liu.denton@gmail.com>
 <20250804131922.GB86602@coredump.intra.peff.net>
 <xmqqms8f9p2t.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqms8f9p2t.fsf@gitster.g>

On Mon, Aug 04, 2025 at 06:46:50AM -0700, Junio C Hamano wrote:

> > +	/* All modes require at least a remote name. */
> > +	if (!argc)
> > +		usage_with_options(builtin_remote_sethead_usage, options);
> > +
> > +	strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
> > +	remote = remote_get(argv[0]);
> 
> I do not know about compilers, but a sample of one, to this human it
> is more obvious ;-).

OK, cleaned up patch is below. Hopefully I am not stealing Denton's
thunder, but this seemed trivial enough that I wanted to get it off my
plate and never think of it again. ;)

> > and the line it complains about is:
> >
> >   if (filter && strncmp(test[i].name, filter, matchlen))
> > ...
> > At any rate I agree that "0" is the appropriate value here, and
> > assigning it to shut up the compiler is the best approach.
> 
> ... simply because we know the value in matchlen does not matter
> when filter is NULL?  I think that would work and I would be happy
> with a less noisy compilation.
> 
> But any other value like 99 would equally well work, which is a bit
> disturbing ;-).

It's true that any value would work with the current code. But I think
"0" makes the most sense because it is counting bytes in "filter". If
"filter" is NULL, then we have zero matched bytes. So if anybody _did_
look at it, they'd hopefully do the right thing.

BTW, this clar code comes from libgit2. They may want to fix it
upstream, too. +cc Patrick.

-- >8 --
Subject: [PATCH] remote: bail early from set_head() if missing remote name

In "git remote set-head", we can take varying numbers of arguments
depending on whether we saw the "-d" or "-a" options. But the first
argument is always the remote name.

The current code is somewhat awkward in that it conditionally handles
the remote name up-front like this:

  if (argc)
     remote = ...from argv[0]...

and then only later decides to bail if we do not have the right number
of arguments for the options we saw.

This makes it hard to figure out if "remote" is always set when it needs
to be. Both for humans, but also for compilers; with -Og, gcc complains
that "remote" can be accessed without being initialized (although this
is not true, as we'd always die with a usage message in that case).

Let's instead enforce the presence of the remote argument up front,
which fixes the compiler warning and is easier to understand. It does
mean duplicating the code to print a usage message, but it's a single
line.

Noticed-by: Denton Liu <liu.denton@gmail.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/remote.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 5dd6cbbaee..f0e49a5681 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1474,10 +1474,13 @@ static int set_head(int argc, const char **argv, const char *prefix,
 	};
 	argc = parse_options(argc, argv, prefix, options,
 			     builtin_remote_sethead_usage, 0);
-	if (argc) {
-		strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
-		remote = remote_get(argv[0]);
-	}
+
+	/* All modes require at least a remote name. */
+	if (!argc)
+		usage_with_options(builtin_remote_sethead_usage, options);
+
+	strbuf_addf(&b_head, "refs/remotes/%s/HEAD", argv[0]);
+	remote = remote_get(argv[0]);
 
 	if (!opt_a && !opt_d && argc == 2) {
 		head_name = xstrdup(argv[1]);
-- 
2.50.1.786.g492fc26cdf

