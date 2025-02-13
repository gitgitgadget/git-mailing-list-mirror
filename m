Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1255920B209
	for <git@vger.kernel.org>; Thu, 13 Feb 2025 08:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739434951; cv=none; b=qz/276GnsihGu1/EMmi7XHsaNpUdKyYd8iAw8i/xVz+2Pf8rHHNvalKPNm6N4c8eK2pI+Uu103r2c/O5QBMgNgM328t+dcT5gepUhrLh1wVaRrGdMj9bz8HvpGKXLkzPLmD1k9P8BGyUkxP9ImWGP76lWPMe4gOO+Ngee07qOaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739434951; c=relaxed/simple;
	bh=nuajQ/87B3JYBOj8x0/q3CY9RsugJZ8WYogiPBHQ7WE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XT6JJ1EOf2Bo28N7IFSF283zgcuTuQRh+Kw0jZrg//Cs56Wy1y+NG/Q8ZIPg58+oGEME0DCc8je5eUToraC4WGSkfKN6tDOd/BtlA86VN1lLHJqb9l7qt0XgWZj7o3bqMnBnqWqLBtOXeRTCoB7rU5gkqP2wnJW0HbDCJomgN3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JRS5VDgc; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JRS5VDgc"
Received: (qmail 18961 invoked by uid 109); 13 Feb 2025 08:22:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=nuajQ/87B3JYBOj8x0/q3CY9RsugJZ8WYogiPBHQ7WE=; b=JRS5VDgcTvy53a3XuijOz+R8hL0e4bINmX3LABxm/e7xmVexW5oySiXBAW07FK5Cj2yjhCHDqBoc9wdCnIR4Vgjb1mqvGCaVBJc78AvRlE2ofcuEU2DIRXmEcX/T4GZgAKJYCYMXl9FGigIzJBIeaK8gmg4bcTrO2DWBXEPyqYrlemJolUdlO9JUf8QpUlt7eBlSp56HmE4E57kxVlz0Rsj5WbDhOtut3BsUZXGVej523wDM+r+bd3VslKMK3Mu21fg8B8vWOqoDKZe+gEyC48z12rwpJb2r2XVeBOnPcO1uAW1hlnvOrtCuYCj0Tt3SOw0RgMMNJM43VrHHzW+bIg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 13 Feb 2025 08:22:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23859 invoked by uid 111); 13 Feb 2025 08:22:21 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 13 Feb 2025 03:22:21 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 13 Feb 2025 03:22:21 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: Poor performance using reftable with many refs
Message-ID: <20250213082221.GA916028@coredump.intra.peff.net>
References: <Z602dzQggtDdcgCX@tapette.crustytoothpaste.net>
 <Z62NFXja4CkrxSil@pks.im>
 <Z62booOOXODOl_sZ@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z62booOOXODOl_sZ@pks.im>

On Thu, Feb 13, 2025 at 08:13:38AM +0100, Patrick Steinhardt wrote:

> Turns out that you're hitting quite a funny edge case: the issue comes
> from you first deleting all preexisting refs in the target repository
> before recreating them. With "packed-refs", this leads to a repository
> that has neither a "packed-refs" file nor any loose ref, except for HEAD
> of course. But with "reftables" it doesn't:
> 
>     total 368
>     -rw-r--r-- 1 pks users 332102 Feb 13 08:00 0x000000000001-0x000000000001-d8285c7c.ref
>     -rw-r--r-- 1 pks users  32941 Feb 13 08:00 0x000000000002-0x000000000003-f1a8ebf9.ref
>     -rw-r--r-- 1 pks users     86 Feb 13 08:00 tables.list
> 
> We end up with two tables: the first one has been created when cloning
> the repository and contains all references. The second one has been
> created when deleting all references, so it only contains ref deletions.
> Because deletions don't have to carry an object ID, the resulting table
> is also much smaller. This has the effect that auto-compaction does not
> kick in, because we see that the geometric sequence is still intact. And
> consequently, all the checks that we perform when recreating the refs
> are way more expensive now because we have to search for conflicts.

That makes sense. But that's only 360k of reftables. Why does it take so
long to process?

It's been a while since I looked at reftables, but I'd think for a
normal lookup we should be able to binary-search or similar in each
table, find the relevant entries, and be done.

But I guess we can't easily do that for finding write conflicts, because
writing "foo/bar" means we need to care about "foo" and "foo/bar/baz" as
well. Finding "foo" is easy; we just break apart the proposed refname
and look for each leading path. But "foo/bar/baz" is harder; we have to
merge the tables to get an authoritative sorted list of the current
state, and then look for the entries adjacent to where our proposed ref
goes. Looking at a profiling output, we're spending a lot of time in
merged_iter_next_void() and its children, which supports that.

But the run-time scales linearly with the number of refs we're adding,
which implies that we're doing this iteration independently once per ref
we're adding. Instead, if we're given a list of N refs to write, we
should be able to sort that list and walk it in parallel with the
merged_iter result, making a single pass over the lists.

So I guess we'd need a version of refs_verify_refname_available() that
takes a list of refs rather than a single name. And then you could do
that single-pass walk. And as a bonus, you'd be able to de-dup the
leading prefixes you're looking for (e.g., most of your refs will start
with "refs/heads/", so we only need to check it once).

> That being said, I found an optimization in how we parse ref updates in
> git-update-ref(1): when we see an exact object ID, we can skip the call
> to `repo_get_oid()`. This function is quite expensive because it doesn't
> only parse object IDs, but revisions in general. This didn't have much
> of an impact on "packed-refs", because there are no references in the
> first place. But it did have a significant impact on the "reftable"
> backend, where we do have deleted references.

Yes, we do similarly spend a lot of time there. But the problem isn't
quite that repo_get_oid() also parses revisions. When we see a full
object id we return it quickly. But you can fall afoul of 798c35fcd8
(get_sha1: warn about full or short object names that look like refs,
2013-05-29), which does a full dwim_ref() lookup for each one!

Try:

  git -c core.warnAmbiguousRefs=false update-ref --stdin

to disable that. Internally there's a warn_on_object_refname_ambiguity
flag that some code (like cat-file) sets when it knows it may be asked
to do a resolve a lot of entries that are likely to be oids.

I kind of wonder if we should ditch that warning. But if we wanted to
keep it, maybe adding a flag to get_oid_with_context() would be a less
hacky way of disabling that warning on a per-call basis.

-Peff
