From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid sorting if references are added to ref_cache in
 order
Date: Thu, 24 May 2012 13:49:06 -0400
Message-ID: <20120524174906.GC3161@sigill.intra.peff.net>
References: <1337861810-9366-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu May 24 19:49:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXc9y-0002kI-9i
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 19:49:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757624Ab2EXRtJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 13:49:09 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53750
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753677Ab2EXRtI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 13:49:08 -0400
Received: (qmail 29801 invoked by uid 107); 24 May 2012 17:49:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 13:49:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 13:49:06 -0400
Content-Disposition: inline
In-Reply-To: <1337861810-9366-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198399>

On Thu, May 24, 2012 at 02:16:50PM +0200, mhagger@alum.mit.edu wrote:

> The old code allowed many references to be efficiently added to a
> single directory, because it just appended the references to the
> containing directory unsorted without doing any searching (and
> therefore without requiring any intermediate sorting).  But the old
> code was inefficient when a large number of subdirectories were added
> to a directory, because the directory always had to be searched to see
> if the new subdirectory already existed, and this search required the
> directory to be sorted first.  The same was repeated for every new
> subdirectory, so the time scaled like O(N^2), where N is the number of
> subdirectories within a single directory.
> 
> In practice, references are often added to the ref_cache in
> lexicographic order, for example when reading the packed-refs file.
> So build some intelligence into add_entry_to_dir() to optimize for the
> case of references and/or subdirectories being added in lexicographic
> order: if the existing entries were already sorted, and the new entry
> comes after the last existing entry, then adjust ref_dir::sorted to
> reflect the fact that the ref_dir is still sorted.

Thanks for a nice analysis and the patch; this definitely fixes the
regression I was seeing.

The fix feels a little bit like a hack to me. The real problem is that
there is a mismatch in how the ref code wants to receive chunks of refs,
and how the packed-refs code wants to feed them. The optimal way to feed
refs would be breadth-first, giving an entire single level (say,
"refs/remotes/*", but not "refs/remotes/*/*") at once, and then sorting
the result. And as far as I can tell, that is what read_loose_refs does.

But the packed-refs file is read sequentially, and we end up inserting
the refs in a depth-first way, which triggers this problem. Your fix
relies on the fact that our depth-first feed happens in sorted order,
and we can avoid the extra sorts. But I think the problem would still
exist if we did a depth-first feed of unsorted refs.

The packed-refs file is always in sorted order. The only other source of
feed-one-at-a-time refs seems to be clone.c:write_remote_refs. It gets
its refs from the mapped_refs, which eventually come from the remote
side of the connection (and git tends to list refs in sorted order).

So I think in practice we are OK, but would go quadratic again if we
ever fed an unsorted list of refs. So the right thing is probably to
apply this patch (which makes sense _anyway_, as it is even cheaper than
sorting afterwards when we can avoid it), and be aware of the issue for
any future unsorted provider, and deal with it if and when it ever
happens.

> +	/* optimize for the case that entries are added in order */
> +	if (dir->nr == 1 ||
> +	    (dir->nr == dir->sorted + 1 &&
> +	     strcmp(dir->entries[dir->nr - 2]->name,
> +		    dir->entries[dir->nr - 1]->name) < 0))
> +		dir->sorted = dir->nr;

Technically we would still be sorted if strcmp(...) == 0. But I guess it
probably doesn't matter, as we shouldn't ever be adding duplicates here.

-Peff
