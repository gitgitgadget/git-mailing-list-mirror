Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAEEA204573
	for <git@vger.kernel.org>; Mon, 16 Dec 2024 11:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734348647; cv=none; b=qz/ZNOlqJS8xRde4ZwLXpqa5fSSP3TWnBRIk7XC5mSUH42HcMVWF8obV26Vi1r1+iSqMCk8HhSbcDQUrm3u88RgXFowWeV1OYfeKkyveKik9N7F8ujsIu/vL9LHS6IiGyH0bRnY2jemqabc0x0pcbcCPORqhA+3DVxbixwLvvqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734348647; c=relaxed/simple;
	bh=nxW0dQJ/DqcQ8WH+zAkkugwkv0ie9fATSkZ/rRzYkvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F0bUVerx/WP6r7aAfzjEGuuUSFKMFUJjZCax35KaEumtB6H7pKQNZqGDq8FogS4ldGx2Zr9/ThhlPXVE1nup6tt1PJg91gKWReaWZhbDpw4+qz38RC6L4QccQAf6oJo6qdv6//gGD4keHgbPMUva6rnJf8xwGVHmTbWURYUO+44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YCPCDiIz; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YCPCDiIz"
Received: (qmail 26398 invoked by uid 109); 16 Dec 2024 11:30:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=nxW0dQJ/DqcQ8WH+zAkkugwkv0ie9fATSkZ/rRzYkvQ=; b=YCPCDiIz/kPlNLmGWXs2xZzpf2fooHskbr73uGLdFq5KkpS5gHuWgrOQWpfRRTFmPigtqHMAEHEyLe9XPpumPQ8cB7Rg8hZNnEmzgV2lNlJGotuYX/ssbX5Gsf0oBOaOpXvz5EAKYNZ2H0LtANPIyrfPIWhmYx9TKxLAnV/dVrNbvRwXLjKUZQwvsmNQeJ0H1VyK4UR6DaqdG32EmPhbcy8UKdgqda8fTHrgAWyL02cFS1oafo8dnzEPqi/6jOygicIUcfotuSGV4uNfpRv8GYT7bVmjjEQHog1czta8DPsrnHLqxit3vHaVWPKDBjd+gFKxCcgkBFC5PcSj668Y9Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Dec 2024 11:30:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26797 invoked by uid 111); 16 Dec 2024 11:30:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Dec 2024 06:30:43 -0500
Authentication-Results: peff.net; auth=none
Date: Mon, 16 Dec 2024 06:30:42 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Justin Tobler <jltobler@gmail.com>, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH 0/3] batch blob diff generation
Message-ID: <20241216113042.GC2201417@coredump.intra.peff.net>
References: <20241213042312.2890841-1-jltobler@gmail.com>
 <20241213081211.GA1443203@coredump.intra.peff.net>
 <xmqqldwj9pq0.fsf@gitster.g>
 <xmqqa5cw8r8k.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqa5cw8r8k.fsf@gitster.g>

On Sun, Dec 15, 2024 at 03:24:11PM -0800, Junio C Hamano wrote:

> > Funny.  The raw diff format indeed was designed as an interchange
> > format from various "compare two sets of things" front-ends (like
> > diff-files, diff-cache, and diff-tree) that emits the raw format, to
> > be read by "diff-helper" (initially called "diff-tree-helper") that
> > takes the raw format and
> >
> >  - matches removed and added paths with similar contents to detect
> >    renames and copies
> >
> >  - computes the output in various formats including "patch".
> >
> > So I guess we came a full circle, finally ;-).  Looking in the archive
> > for messages exchanged between junkio@ and torvalds@ mentioning diff
> > before 2005-05-30 finds some interesting gems.
> >
> > https://lore.kernel.org/git/7v1x8zsamn.fsf_-_@assigned-by-dhcp.cox.net/

:) That same thread was linked when I posted the original diff-pairs
many years ago.

> So, if we were to do what Justin tried to do honoring the overall
> design of our diff machinery, I think what we can do is as follows:
> 
>  * Use the "diff --raw" output format as the input, but with a bit
>    of twist.
> 
>    (1) a narrow special case that takes only a single diff_filepair
>        of <old> and <new> blobs, and immediately run diff_queue() on
>        that single diff_filepair, which is Justin's use case.  For
>        this mode of operation, "flush after reach record of input"
>        may be sufficient.

My understanding was that he does not actually care about this case
(just feeding two blobs), but is actually processing --raw output in the
first place. Or did you just mean that we'd still be feeding raw output,
but just getting the flush behavior?

>    (2) as a general "interchange format" to feed "comparison between
>        two sets of <object, path>" into our diff machinery, we are
>        better off if we can treat the input stream as multiple
>        records that describes comparison between two sets.  Imagine
>        "git log --oneline --first-parent -2 --raw HEAD", where one
>        set of "diff --raw" records show the changed blobs with their
>        paths between HEAD~1 and HEAD, and another set does so for
>        HEAD~2 and HEAD~1.  We need to be able to tell where the
>        first set ends and the second set starts, so that rename
>        detection and other things, if requested, can be done within
>        each set.

Seems reasonable. For the use of diff-pairs at GitHub, I always just did
full-tree things like rename detection in the initial diff-tree
invocation. Since my goal was splitting/filtering, doing it after would
yield wrong answers (since diff-pairs never sees the complete set).

But it's possible for somebody to want to filter the intermediate
results, then do full-tree stuff on the result (or even just delay the
cost of rename detection). And certainly it's possible to want to feed a
whole bunch of unrelated diff segments without having to spawn a process
for each.

So it's not something I wanted, but I agree it's good to plan for.

>    My recommendation is to use a single blank line as a separator,
>    e.g.
> 
>         :100644 100644 ce31f93061 9829984b0a M	Documentation/git-refs.txt
>         :100644 100644 8b3882cff1 4a74f7c7bd M	refs.c
>         :100755 100755 1bfff3a7af f59bc4860f M	t/t1460-refs-migrate.sh
> 
>         :100644 100644 c11213f520 8953d1c6d3 M	refs/files-backend.c
>         :100644 100644 b2e3ba877d bec5962deb M	refs/reftable-backend.c
> 
>    so an application that wants to compare only one diff_filepair
>    at a time would issue something like
> 
>         :100644 100644 ce31f93061 9829984b0a M	Documentation/git-refs.txt
> 
>         :100644 100644 8b3882cff1 4a74f7c7bd M	refs.c
> 
>         :100755 100755 1bfff3a7af f59bc4860f M	t/t1460-refs-migrate.sh
> 
>    so the parsing machinery does not have to worry about case (1) above.

Yeah, that seems good. And it is backwards-compatible with the existing
diff-pairs format (which just barfs on a blank line). That's not a
big concern for the project, but it is nice that it makes life a bit
simpler for folks who would eventually be tasked with switching from it
to this new tool. ;)

>  * Parse and append the input into diff_queue(), until you see an
>    blank line.
> 
>    - If at EOF you are done, but if you have something accumulated
>      in diff_queue(), show them (like below) first.  In any case, at
>      EOF, you are done.

Yep, makes sense.

>  * Run diffcore_std() followed by diff_flush() to have the contents
>    of the queue nicely formatted and emptied.  Go back to parsing
>    more input lines.

That makes sense. I don't think my diff-pairs runs diffcore_std() at
all. The plumbing defaults mean it would always be a noop unless you
explicitly passed in rename, etc, options, and I never wanted to do
that.

We might have to check the interaction of diffcore code on a set of
queued diffs that already have values for renames, etc. I.e., that:

  git diff-tree --raw -M |
  git diff-pairs -M

does not barf, since the input step in diff-pairs is going to set status
to 'R', etc, in the pairs.

-Peff
