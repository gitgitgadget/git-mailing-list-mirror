Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190DF23E229
	for <git@vger.kernel.org>; Mon, 19 May 2025 06:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747635387; cv=none; b=EvVG62jr9aYG50t66UeKNWHODFgVlrs3EJED2r9YptWR+eClRD4+OSpb/bXTPs+qiJBrrryo2AcqUJIxeydO3lZ+XNsrRvg7+kbvv6tg5U8jOS3a8L3/EPVDOtVkkgs6Lu0HCFBGvWlHk1zvbycrefMDxhZp/x3mU1ps+Wj/hLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747635387; c=relaxed/simple;
	bh=ZSkC8mps38KGORKUFVlCKSG8w6quYQZhTNVekMcwKRw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CioDiAMtOz0NSpqbbcBZTknrj++9r2tRfWBDg0P83OpbzRwhbTq9JBqrxlU80xH+Sn9up+fkrr57TF5nnYlj0ijsmVQ9O35Lu+xfbTAbuDWb9Pyf2H3BJ1CYU+wNHKep7s5z6lOC6gfxeN2wRANPtLMoZIbZS16815fq6wQ+fLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PHBdnavG; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PHBdnavG"
Received: (qmail 14136 invoked by uid 109); 19 May 2025 06:16:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ZSkC8mps38KGORKUFVlCKSG8w6quYQZhTNVekMcwKRw=; b=PHBdnavGh6+gOsGpMLSMTg0cYAU2CM98DknSp0XRqh7N/v0IvFZxITdRvkfOdd3bNT75J2OeDqoeCRZCTIs3Lz06+FSfpVDpynKdvaXTf5hDrzWdXjlve6NQp14eo6IRLBxsY6pRiSGc1ExH6xT1E/YMsWDS7gMfvc0WWSt+nccID9ZlVvmSSJWw2x/CLichgG8WgEXM0QCrmkoHNw/ncdVmI+MDAKHDTzEb6yRo5d3gJCoZsascQYi0sjYTrw4QEoCux2oJaNSOkIW30iTqDU3HQHquSCkV3lPh1lsGk4irkSuiiVUuiD1NIUbi59HNGfUv8N5B25Z4uEpMzbVUUw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 19 May 2025 06:16:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24317 invoked by uid 111); 19 May 2025 06:16:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 19 May 2025 02:16:21 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 19 May 2025 02:16:17 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/13] cat-file: make --allow-unknown-type a noop
Message-ID: <20250519061617.GA102701@coredump.intra.peff.net>
References: <20250516044916.GA21985@coredump.intra.peff.net>
 <20250516044935.GB22242@coredump.intra.peff.net>
 <aCcK0p7wMURHppe7@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aCcK0p7wMURHppe7@pks.im>

On Fri, May 16, 2025 at 11:52:18AM +0200, Patrick Steinhardt wrote:

> > The code change is fairly small (but we'll able to clean up more code in
> > follow-on patches). The test updates drop any use of the option. We
> > still retain tests that feed the broken objects to cat-file without
> > --allow-unknown-type, as we should continue to confirm that those
> > objects are rejected. Note that in one spot we can drop a layer of loop,
> > re-indenting the body; viewing the diff with "-w" helps there.
> 
> Shouldn't we have a test though that the option is still accepted, even
> though it doesn't do anything?

I dunno. It is obvious-ish from looking at the code that the option does
nothing, so we know that it will behave the same whether it is provided
or not. I guess it depends on how white/black-box we want our tests to
be.

If we did this on top:

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 67a5ff2b9e..ff92b14201 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -1022,7 +1022,6 @@ int cmd_cat_file(int argc,
 	struct batch_options batch = {
 		.objects_filter = LIST_OBJECTS_FILTER_INIT,
 	};
-	int unknown_type = 0;
 	int input_nul_terminated = 0;
 	int nul_terminated = 0;
 	int ret;
@@ -1047,8 +1046,7 @@ int cmd_cat_file(int argc,
 		OPT_GROUP(N_("Emit [broken] object attributes")),
 		OPT_CMDMODE('t', NULL, &opt, N_("show object type (one of 'blob', 'tree', 'commit', 'tag', ...)"), 't'),
 		OPT_CMDMODE('s', NULL, &opt, N_("show object size"), 's'),
-		OPT_HIDDEN_BOOL(0, "allow-unknown-type", &unknown_type,
-			  N_("historical option -- no-op")),
+		OPT_NOOP_NOARG(0, "allow-unknown-type"),
 		OPT_BOOL(0, "use-mailmap", &use_mailmap, N_("use mail map file")),
 		OPT_ALIAS(0, "mailmap", "use-mailmap"),
 		/* Batch mode */

that would perhaps remove the "-ish" from "obvious-ish". I had left the
flag in place because I wondered if we might want to produce a
deprecation warning before dropping it completely.

> > @@ -202,9 +201,6 @@ flush::
> >  	only once, even if it is stored multiple times in the
> >  	repository.
> >  
> > ---allow-unknown-type::
> > -	Allow `-s` or `-t` to query broken/corrupt objects of unknown type.
> > -
> 
> Should we maybe introduce a "deprecated" section and spell out that this
> option is a no-op nowadays that will be removed for example in Git 3.0?

I don't have a strong opinion there. It mostly seems like clutter to me
in the manpage. In theory it could help somebody who had learned about
the option previously and wondered what happened. OTOH, the release
notes can help with that. With the patch above, "cat-file --help-all"
would also produce:

     --[no-]allow-unknown-type
                            no-op (backward compatibility)

though I don't really expect anybody to find that casually.

-Peff
