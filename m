Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5C633C2F
	for <git@vger.kernel.org>; Thu,  5 Jun 2025 07:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749108194; cv=none; b=qWJ7+++7HK6ULzggs8nSquyTTzOB91AdTzc0m/x8Q61JlJIdWpin1L2Mk3DjWe1Zohx2JcQlpxhjMMaueOG18DNXzQRPCaWAfC+PbJZphz9Nf2Y69gmLg30U6YYlxyCnYBd7G9PXg2mIGWBWEjnCbANtNL0dbLEratXhaSnl7Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749108194; c=relaxed/simple;
	bh=0oiHwkc1W+zct074p8unW9Nm9yF3yE5bIstTmjaSOhE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MD6kb9oJlfJx6uKtS784vTLPc7GyPrknheE1sPonhvc82/SDX+GFaH4C0gzi4tXvHW6R7I/wXSiyViGeQ3LZ7iw8P8gJFQwDJqNwjm0jchy3O4ORtd5X5FDtfAgtgUIkSJZ0AUahgsvJpHKjIIZGeHwRoe8jbqhlJhOUk2AWY1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LTqUUpmT; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LTqUUpmT"
Received: (qmail 17264 invoked by uid 109); 5 Jun 2025 07:23:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0oiHwkc1W+zct074p8unW9Nm9yF3yE5bIstTmjaSOhE=; b=LTqUUpmTSoOy9U6fiagaSu07JiP3RHc5Do38ucEYEDbc6jNlVGsxe9zejsqjXO8iyd9cV1njHwhJpd3L3O3oBKHBEBEncNV/Ww9Cd9nEyB+qxzeqemVJctEdVlbw36Z9BdPJKSlwXJ1BPNNY0Al6bGw3qiIyC18Hh1XYTF1LbRs6NbJ2CwuJ3taaoTWdYS6JBfTNi6K7OQ10VaTjsOptmZbpCKxJ//F08RLpnggpPdpzIRpMiL2YmdmJpDLBagH9n5Gz2n5JdLdDvHHhrqM+uDLqMo7RtmgSQ14GKh1PmhszkTB/STlqodFgGpQl0mUYKVvHiFIPv5JzhL/rEcoN7w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Jun 2025 07:23:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21110 invoked by uid 111); 5 Jun 2025 07:23:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Jun 2025 03:23:12 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Jun 2025 03:23:08 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Lidong Yan <502024330056@smail.nju.edu.cn>
Subject: Re: [PATCH] repo_logmsg_reencode: fix memory leak when use
 repo_logmsg_reencode()
Message-ID: <20250605072308.GA2066712@coredump.intra.peff.net>
References: <pull.1988.git.git.1749006607791.gitgitgadget@gmail.com>
 <aD_8NxMi6Dk7CmSl@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aD_8NxMi6Dk7CmSl@pks.im>

On Wed, Jun 04, 2025 at 09:56:39AM +0200, Patrick Steinhardt wrote:

> On Wed, Jun 04, 2025 at 03:10:07AM +0000, Lidong Yan via GitGitGadget wrote:
> > diff --git a/builtin/replay.c b/builtin/replay.c
> > index 225cef08807..6172c8aacc9 100644
> > --- a/builtin/replay.c
> > +++ b/builtin/replay.c
> > @@ -84,6 +84,7 @@ static struct commit *create_commit(struct repository *repo,
> >  	obj = parse_object(repo, &ret);
> >  
> >  out:
> > +	repo_unuse_commit_buffer(the_repository, based_on, message);
> >  	free_commit_extra_headers(extra);
> >  	free_commit_list(parents);
> >  	strbuf_release(&msg);
> 
> Makes sense. This one _looks_ like a leak that I'd expect to hit in our
> test suite as it's not part of an error path.

We'll usually never flag a leak for commit buffers, because they are
stored in (and owned by) a commit-slab. So the memory is not leaked
exactly, but we may hold on to it longer than we need to. This mostly
only becomes obvious when we do it for every commit in a code path that
touches a lot of commits (e.g., "git log" or something).

The exception is if we actually had re-encode, which requires a mismatch
between the commit and output encodings (which both default to UTF-8).
And then it really is a leak.

If we add a hack like this:

diff --git a/utf8.c b/utf8.c
index 35a0251939..d7b7d372c5 100644
--- a/utf8.c
+++ b/utf8.c
@@ -3,6 +3,7 @@
 #include "git-compat-util.h"
 #include "strbuf.h"
 #include "utf8.h"
+#include "parse.h"
 
 /* This code is originally from https://www.cl.cam.ac.uk/~mgk25/ucs/ */
 
@@ -442,6 +443,12 @@ int is_encoding_utf8(const char *name)
 int same_encoding(const char *src, const char *dst)
 {
 	static const char utf8[] = "UTF-8";
+	static int always_reencode = -1;
+
+	if (always_reencode < 0)
+		always_reencode = git_env_bool("GIT_TEST_ALWAYS_REENCODE", 0);
+	if (always_reencode)
+		return 0;
 
 	if (!src)
 		src = utf8;

then running:

  GIT_TEST_ALWAYS_REENCODE=1 make SANITIZE=leak test

turns up this leak via t3650-replay-basics.sh (as well as in t6429).

It's probably a bit too specialized to carry around as a permanent test
mode, though. I thought it might find other cases, but it doesn't. The
other one in this patch only triggers when the commit message has no
header separator, which is not very likely.

> > -	if (!body)
> > +	if (!body) {
> > +		repo_unuse_commit_buffer(the_repository, commit, commit_buffer);
> >  		return;
> > +	}
> >  
> >  	trailer_iterator_init(&iter, body);
> >  	while (trailer_iterator_advance(&iter)) {
> 
> Should this one maybe be converted into a `goto out` so that we can
> release resources in a single location, only? Something like the below
> patch.

Yeah, I think that is nicer, though...

> diff --git a/builtin/shortlog.c b/builtin/shortlog.c
> index 30075b67be8..dd08bc40161 100644
> --- a/builtin/shortlog.c
> +++ b/builtin/shortlog.c
> @@ -177,7 +177,7 @@ static void insert_records_from_trailers(struct shortlog *log,
>  	struct strbuf ident = STRBUF_INIT;
>  
>  	if (!log->trailers.nr)
> -		return;
> +		goto out;

If you convert this hunk, then we'd look at the uninitialized
commit_buffer variable after we jump to the out label. I think the v2
just posted is OK, though (it touches only the one conditional that
needs the goto).

-Peff
