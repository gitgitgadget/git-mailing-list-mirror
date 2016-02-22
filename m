From: Jeff King <peff@peff.net>
Subject: Re: A different bug in git-filter-branch (v2.7.0)
Date: Mon, 22 Feb 2016 16:13:28 -0500
Message-ID: <20160222211328.GA16512@sigill.intra.peff.net>
References: <loom.20160128T153147-396@post.gmane.org>
 <20160129061820.GB23106@sigill.intra.peff.net>
 <n8gao5$3c6$1@ger.gmane.org>
 <20160129231127.GA31798@sigill.intra.peff.net>
 <n9b9tp$gbr$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Anatoly Borodin <anatoly.borodin@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 22:13:50 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aXxnh-0006uv-F4
	for gcvg-git-2@plane.gmane.org; Mon, 22 Feb 2016 22:13:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755651AbcBVVNc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2016 16:13:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:46951 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751937AbcBVVNb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2016 16:13:31 -0500
Received: (qmail 17503 invoked by uid 102); 22 Feb 2016 21:13:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 16:13:30 -0500
Received: (qmail 22192 invoked by uid 107); 22 Feb 2016 21:13:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Feb 2016 16:13:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Feb 2016 16:13:28 -0500
Content-Disposition: inline
In-Reply-To: <n9b9tp$gbr$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286952>

On Mon, Feb 08, 2016 at 11:55:37PM +0000, Anatoly Borodin wrote:

> unfortunately, `--tree-filter true` doesn't solve the problem with the
> repo at my work: not all old blobs are replaced with the new ones. I've
> made a test repository to demonstrate it; it's a huge one (115M), but I
> couldn't make it much smaller, because the bug fails to reproduce if the
> repo is not big enough:
> 
> https://github.com/anatolyborodin/git-filter-branch-bug
> 
> There are some description and instructions in `README.md`. I hope you
> will be able to reproduce it on your machine, if not - just add more
> files :)
> 
> I've debugged the test case and found the place where `git diff-index`
> behaves differently regarding `aa/bb.dat`:
> 
> read-cache.c +351	ie_match_stat():
> ...
> 	if (!changed && is_racy_timestamp(istate, ce)) {
> 		if (assume_racy_is_modified)
> 			changed |= DATA_CHANGED;
> 		else
> 			changed |= ce_modified_check_fs(ce, st);
> 	}
> ...
> 
> After `git-checkout-index` the blob hash for `aa/bb.dat` in the index is
> 88a0f09b9b2e4ccf2faec89ab37d416fba4ee79d (the huge binary), but the file
> on disk is a text file "This file was to big, and it has been removed."
> with the hash 16e0939430610600301680d5bf8a24a22ff8b6c4.

Right, that makes sense. The index doesn't know anything about the
replace mechanism. So it assumes that what it wrote matches what is in
the stat cache (i.e., some sha1 and the matching stat info). Later, when
git wants to know "should I bother reading this file back in and
computing its sha1", the stat cache says no.

And then as you noticed, it sometimes "works" because if the file and
index timestamps are the same, we err on the side of re-reading. So more
files means more likelihood of crossing the one-second boundary.

> I don't know if it should be considered to be a bug in in the logic of
> `git checkout-index`, or `git diff-index` / `git update-index`.

I'd say if any, it is the fault of checkout-index for writing out
content that does not match the sha1 in the index, but writing out the
stat information as if it is clean. For your case, you'd obviously
prefer that the file be marked dirty and re-read later.

But I'm not sure whether other users of replace refs would want the same
behavior. They may want to silently pretend as if the data is
unmodified. I'm not sure if anyone is doing that in practice, though; as
you noted, the results are not deterministic, so it probably ends up
just being a huge pain. So perhaps it would make sense to make the
checkout operation aware of replaced blobs.

As a workaround for your filter-branch, I suspect you could do
`--tree-filter 'git ls-files | xargs touch'` or something, but that is
going to be rather inefficient.

By now you've probably realized that replaced blobs are not widely used,
and there are a lot of corner cases around checking them out. So let's
take a step back for a moment. What are you trying to accomplish with
your filter-branch? If you just want to replace blob A with blob B, I
think it might be easier to skip refs/replace entirely and just do so
explicitly in an index-filter, like:

  --index-filter '
    git ls-files -s |
    sed "s/$old_sha1/$new_sha1/" |
    git update-index --index-info
  '

-Peff
