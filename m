Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C3A22DC20
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 09:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846822; cv=none; b=TmhoI7eDbbiM3nbSWM2WH/3PVHU5tK5Y2gKdCuWIR7IGhdIyUmkClJ4wvmcb/TNuFwkJwJi0BiuNHXVeu6CrlN2G9JZZEzncYXqj7KIxSQ6LWac+e2DfKXi9z4YFZq3xr06P3t9MfK2Hsw6lujk2cGDYWy2W84h4b1k2Dgvw1YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846822; c=relaxed/simple;
	bh=HVeLp7Z9gPyvy0ZeOQ4s24N+bPVPJQx0wY28VVQhQXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d89cVg0H402Hp40wtLwpDETmp1ODzwuVvJGTuHIujzQ+QILH2ioOSsOaa5sicgrJDxzPswv0eU4W2uFxQz0z3WhrvZIINIB10A9vCl94nFC1meumVAz3F7htSPbINdOIsCaRjwMk6SSWZVR6LtwLXV3i96T1fYrH8fWZEA+2oQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Md7EDxzE; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Md7EDxzE"
Received: (qmail 27122 invoked by uid 109); 14 Jan 2025 09:26:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=HVeLp7Z9gPyvy0ZeOQ4s24N+bPVPJQx0wY28VVQhQXc=; b=Md7EDxzEr13heypSSlQPGoStjVaqVfxvGVSBWkDqe8C/EGdWJ2W+80tcV2++PMvH5iSS3VwdLZ4Sx2JaD6D7pv+Z7LmepyMNQFN8pewbIYnZ1BIwEcT1d3XVWfC0Xn/wmfwZg/slc+fZYj/HG3g+r/TDi3rJ0yOcPJcHpcOFkmeVLvwPVYdwRU0D/8zlQsmEjDIc44kGiseowiTp8CYj5dQ+WvmLJi7LXnGEoGzCveHGjfKHWdV3qVCZ/jAqiw8+xvSOPZOny76yzxgEuft7soqdRVFpTTx1hdoJp3b3sgmVaPk+e/T2sgOlmhF0/dSaFxnBVTF9mmegYh3+qGD5Zw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jan 2025 09:26:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4716 invoked by uid 111); 14 Jan 2025 09:26:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jan 2025 04:26:56 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jan 2025 04:26:50 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Wink Saville <wink@saville.com>
Subject: Re: [PATCH 08/14] tree-diff: pass whole path string to
 path_appendnew()
Message-ID: <20250114092650.GA882468@coredump.intra.peff.net>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
 <20250109084907.GH2748836@coredump.intra.peff.net>
 <Z4UzyFqao8Ty_RQb@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4UzyFqao8Ty_RQb@pks.im>

On Mon, Jan 13, 2025 at 04:40:00PM +0100, Patrick Steinhardt wrote:

> On Thu, Jan 09, 2025 at 03:49:07AM -0500, Jeff King wrote:
> > diff --git a/tree-diff.c b/tree-diff.c
> > index 22fc2d8f8c..d2f8dd14a6 100644
> > --- a/tree-diff.c
> > +++ b/tree-diff.c
> > @@ -129,20 +129,18 @@ static int emit_diff_first_parent_only(struct diff_options *opt, struct combine_
> >   * and append it to paths list tail.
> >   */
> >  static struct combine_diff_path *path_appendnew(struct combine_diff_path *last,
> > -	int nparent, const struct strbuf *base, const char *path, int pathlen,
> > +	int nparent, const char *path, size_t len,
> 
> Sneaky, you also changed the type of `len` :) You might want to point
> that out in the commit message.

Sort of. The original took a (ptr,size_t) pair in the form of "base",
and then also a (ptr,int) path. That matches what the caller has:
"pathlen" comes from tree_entry(), which returns an int (it should
probably become a size_t in the long run, but it has a lot of ripple
effects if you change it).

Now the caller handles path/pathlen itself here:

> > +		strbuf_add(base, path, pathlen);

So there is nothing left to pass in except a (ptr,size_t) pair. We could
have continued passing those in as a strbuf, but calling it "base"
doesn't make sense any more.

The "int" is still there, but it just stays in the caller. In the
original it becomes a size_t via passing to combine_diff_path_size(). In
the new code, it happens when we feed it to strbuf_add().

-Peff
