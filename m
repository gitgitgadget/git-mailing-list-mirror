Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD59D14C5B3
	for <git@vger.kernel.org>; Wed,  3 Apr 2024 20:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177320; cv=none; b=TBt48qe+DrKKFvcwEgyNHRkbvwcDT+c/pB/LLF09dSXflyBx4UFfErdTKRdpd6aftP848PGXF1ohfhORPLikezbiKVtXQ8b2AAhvL/hbDhOvJVQUNhMMUs1sU0LvAR/l4YlvMsopJbUNWepdP4DRFPvvX11k/7kWQ7nb4SOcJ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177320; c=relaxed/simple;
	bh=67ts7dnTA/TaayGMWpOd1IchrOeUpzcEWWG32UTQP/8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gTYYSp5Xiu8eDC/4FE+BwXMLJUDdRZvasOMMHSpSs2oa4HJoSeln/dfC3mX+fiCrX9szkNMOoUeamKNK7/wJHF4YzgUuxUUh/IC4aaFmO+hhpTmfdjSL9gxAvd57s6+S+51kVU8pszsVh764bvm11NGT4ro9j8IjlXZRrOPvlSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 26720 invoked by uid 109); 3 Apr 2024 20:48:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 03 Apr 2024 20:48:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11663 invoked by uid 111); 3 Apr 2024 20:48:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 03 Apr 2024 16:48:38 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 3 Apr 2024 16:48:36 -0400
From: Jeff King <peff@peff.net>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] mem-pool: use st_add() in mem_pool_strvfmt()
Message-ID: <20240403204836.GC1949464@coredump.intra.peff.net>
References: <bbe00b9e-64d8-4ec8-a2b9-2c6917c72dbd@web.de>
 <20240401033642.GB2639525@coredump.intra.peff.net>
 <9f26b9f0-f8d7-4988-b6d4-e0446dab30b1@web.de>
 <20240403011818.GB892394@coredump.intra.peff.net>
 <b48fd3ee-2975-481f-aa0e-8ec4d07ea705@web.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b48fd3ee-2975-481f-aa0e-8ec4d07ea705@web.de>

On Wed, Apr 03, 2024 at 12:01:13PM +0200, René Scharfe wrote:

> > For mksnpath(), though, I
> > suspect that trying to format a very long name could result in the
> > output being full of uninitialized bytes.
> >
> > It only has one caller, which creates "foo~1" when we got EEXIST from
> > "foo". So I doubt you can get up to too much mischief with it. But it
> > could easily be replaced by mkpathdup() (or even a reusable strbuf
> > outside the loop if you really wanted to hyper-optimize)
> >
> > And then we could get rid of mksnpath() entirely, and its horrible
> > bad_path failure mode.
> 
> mkpath() would be perfect but unusable in multiple threads.  Cleaning
> up after mkpathdup() is a bit iffy in that caller.  strbuf would be a
> bit much in that error path, I think, and you might have to export or
> reimplement strbuf_cleanup_path().

Yeah, I'd prefer not to go to mkpath(), even though that's the simplest
thing, just because we should be reducing the subtle non-reentrant parts
of the code over time. I don't think the cleanup handling for
mkpathdup() is too bad:

diff --git a/apply.c b/apply.c
index 432837a674..15dfe607ff 100644
--- a/apply.c
+++ b/apply.c
@@ -4502,20 +4502,25 @@ static int create_one_file(struct apply_state *state,
 		unsigned int nr = getpid();
 
 		for (;;) {
-			char newpath[PATH_MAX];
-			mksnpath(newpath, sizeof(newpath), "%s~%u", path, nr);
+			char *newpath = mkpathdup("%s~%u", path, nr);
 			res = try_create_file(state, newpath, mode, buf, size);
-			if (res < 0)
+			if (res < 0) {
+				free(newpath);
 				return -1;
+			}
 			if (!res) {
-				if (!rename(newpath, path))
+				if (!rename(newpath, path)) {
+					free(newpath);
 					return 0;
+				}
 				unlink_or_warn(newpath);
+				free(newpath);
 				break;
 			}
 			if (errno != EEXIST)
 				break;
 			++nr;
+			free(newpath);
 		}
 	}
 	return error_errno(_("unable to write file '%s' mode %o"),

It even gets a little easier if you hoist it to a strbuf outside the
loop, as you don't need to free on each loop iteration. That seems worth
it to me to get rid of a function that IMHO is mis-designed (it is
really only useful if you assume paths are bounded by PATH_MAX, which we
know isn't always true).

> > diff --git a/usage.c b/usage.c
> > index 09f0ed509b..5baab98fa3 100644
> > --- a/usage.c
> > +++ b/usage.c
> > @@ -19,8 +19,10 @@ static void vreportf(const char *prefix, const char *err, va_list params)
> >  	}
> >  	memcpy(msg, prefix, prefix_len);
> >  	p = msg + prefix_len;
> > -	if (vsnprintf(p, pend - p, err, params) < 0)
> > +	if (vsnprintf(p, pend - p, err, params) < 0) {
> > +		if (snprintf(p, pend - p, "could not format error: %s", err) < 0)
> >  		*p = '\0'; /* vsnprintf() failed, clip at prefix */
> > +	}
> >
> >  	for (; p != pend - 1 && *p; p++) {
> >  		if (iscntrl(*p) && *p != '\t' && *p != '\n')
> >
> > Though most of the rest of the function is not that useful (it is mostly
> > removing unreadable chars, and hopefully we do not have any of those in
> > our format strings!).
> 
> For warnings and usage messages this would keep the prefix and not
> die.  This would look a bit strange, no?
> 
> 	usage: could not format error: TERRIBLE MESSAGE!

Sure, but I think any solution here is going to look strange. Keep in
mind that we're trying to improve the case where we print _nothing_
useful at all. If you do see this on a non-fatal message, the subsequent
messages may be informative. E.g.:

  error: could not format error: unable to open loose object %s
  fatal: bad object HEAD~12

is probably better than just exiting after the first.

> Yes, showing errno doesn't add that much value.  Except in this case it
> shows that there's something going on that I don't understand.  Dare I
> dig deeper?  Probably not..

Well, let us know if you do. ;)

-Peff
