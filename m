Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7131A3A8A
	for <git@vger.kernel.org>; Mon, 17 Mar 2025 17:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233899; cv=none; b=DhFMQ4lvq3pJtDiwskLAdubIlIgAj5cUratRWNkHYPkyhpd71U3Neb1fuvP892Qsg0vHm5ZDA/D9OdtcUYC9OTtyskB/RZmrCU5Lz9Yn5Blzb9BypKaOPdNEeV44hg8Q6YAyec4Ht7Kfjf3puy+Kjh++UCQAxQsZbpq0Hh8IQco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233899; c=relaxed/simple;
	bh=rdfzW2qa4bvPuWW3nCbTASQHnfY6Wuu8ut0oZ3/zphI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVDe9P5QkY0Mjk+SI6S1DAOnrC88lYB3hVslfOPhJQcmDgNsJQ30WNJpjW0wcTTANVCSJ0jSaeJerdnoCa444m2Uvx8cMSnjWtJqV/hUXOjsrSBNTa4m1/jcwRZvzS8J1BeepZJvUSXK/zFllo2lAqgm9J3+WRE3n7mPuQf57bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=ZArAxtqy; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="ZArAxtqy"
Received: (qmail 21159 invoked by uid 109); 17 Mar 2025 17:51:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=rdfzW2qa4bvPuWW3nCbTASQHnfY6Wuu8ut0oZ3/zphI=; b=ZArAxtqyW5yrydDZ97Mdf+O1kMS3QZeRfv0Jj6aOUKFHzir59SRCZ7BGpCrkTFL2bEAyFVMUPJTC1zmkiPdcYQ4WXuF6KCcWEQgSSkNurXsHqASgnTQKPX9REVtuuiAb30GSabxnWz0iikTQG5ISxA4yU/vNSMIhT+JoofGAlsQ5KTb6yQH55HDHmnGYQD9kIyocHgC369t//0p3T/ss8Bye6BrGrrvZVAGONMd5lKY1+ZGJ3gC116fpQRqGfX0HwuYvEHRl9hc/H3+ptgVGWbr/5e0iNNkRPkV6L1O+ySLmuvXQ00TMzHHyAFokf1PBop631ZIlGASgVRUilwKFbQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Mar 2025 17:51:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27953 invoked by uid 111); 17 Mar 2025 17:51:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Mar 2025 13:51:36 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 17 Mar 2025 13:51:35 -0400
From: Jeff King <peff@peff.net>
To: Elijah Newren <newren@gmail.com>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] diffcore-rename: fix BUG when break detection and
 --follow used together
Message-ID: <20250317175135.GB704253@coredump.intra.peff.net>
References: <pull.1876.git.1741395615315.gitgitgadget@gmail.com>
 <20250314172437.GA16311@coredump.intra.peff.net>
 <CABPp-BF5R_ob5uAS=m9Vt775-Er2fFqpH7jBjm_=MRmnRVbeew@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BF5R_ob5uAS=m9Vt775-Er2fFqpH7jBjm_=MRmnRVbeew@mail.gmail.com>

On Fri, Mar 14, 2025 at 03:28:09PM -0700, Elijah Newren wrote:

> > So maybe this is the best we can do, but it feels like we should be able
> > to at least trigger the existing BUG() reliably. I couldn't seem to
> > figure it out, though. :(
> 
> So, after _another_ 7 hours or so on it today...  The BUG() the
> reporter triggered only happens when there is no uninitialized memory
> use, and is only triggerable when you use invalid flags.  For the
> reporter, they passed a directory name for their pathspec along with
> --follow, despite the fact that --follow only works when given a
> single pathspec that names an individual file.  You can also trigger
> their particular manifestation of the issue here when using a glob
> pathspec together with --follow.  In either event, the --follow
> becomes useless: when the follow logic checks whether filenames are
> equal to the given pathspec to see if it might be a relevant rename,
> no filename is exactly equal to the pathspec, so it never finds any
> relevant files to follow or to include in the rename detection.  The
> upshot is the command basically behaves the same as if you hadn't
> given --follow, other than the fact that the presence of --follow
> makes diffcore_rename throw away rename_dst pairs in a way that
> happens to trigger this particular BUG().

OK, that all makes sense (and what I was trying to reduce the case, too,
but somehow it eluded me).

Sorry, I didn't mean for you to spend all day on it. I was just
wondering if there was low-hanging fruit we could convince to trigger
with ASan (which would much better protect against regression). It does
look like we at least got some benefit, though. ;)

> The testcase I found is:
>     seq 1 127 >numbers &&
>     git add numbers &&
>     git commit -m "numbers" &&
> 
>     printf "%s\n" A B C D E F G H I J K L M N O Q R S T U V W X Y Z >pool &&
>     seq 1 10 >numbers &&
>     git add pool numbers &&
>     git commit -m "pool" &&
> 
>     git log -1 -B --raw --follow -- "p*"

Yeah, that's similar to what I was trying, but I didn't try the globbing
pathspec. I stuck everything in a subdirectory and use subdir/. But I
think I got caught up on...

> The BUG will _not_ be triggered if:
>   * you change the log's pathspec to match numbers

I put both files into the subdir/, so they both matched.

> In all of these cases (and this is also true for the reporter's
> original case), in locate_rename_dst(), idx will be computed as 0, but
> rename_dst is NULL, so &rename_dst[idx] is NULL as well.

Makes sense.

> However, I think the fact that rename_dst == NULL implies
> &rename_dst[0] == NULL should raise alarm bells about the risks of
> using memory improperly, even if it doesn't directly use uninitialized
> memory in this case.  Which brings us to the bigger more encompassing
> issue, which is what I reported in the commit message:
> 
> > > In short, when these two rare options are used together, fix the
> > > accidental find of the wrong dst entry (which would often be
> > > uninitialized memory just past the end of the array), by adding a little
> > > more care around the recorded indices for break_idx.
> 
> It's just the special case when rename_dst is empty and, in fact,
> NULL, that you trigger the BUG() call.

Oh, absolutely. The uninitialized memory is the bigger problem, and the
fact that it BUG()-ed at all was mostly lucky.

> Maybe what I wrote above helps.  Is this enough information to satisfy
> your curiosity?

Definitely.

> I suspect adding this second test to the commit makes sense.  Which
> parts of my explanation in this email would you like to see added to
> the commit message as well, or is it fine as-is?

I read over your v2, and I think the explanation there is good. In the
long run we might eventually disallow --follow on the glob like this
(since as you note, it's invalid and doesn't actually work). In which
case I guess we'd end up deleting that test case. But in the meantime, I
think there's some benefit to having it.

-Peff
