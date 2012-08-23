From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] specifying ranges: we did not mean to make ".." an empty
 set
Date: Thu, 23 Aug 2012 04:29:16 -0400
Message-ID: <20120823082916.GA6963@sigill.intra.peff.net>
References: <7vd32i5y8w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 23 10:29:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4Sn9-0006V0-Q9
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 10:29:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933690Ab2HWI3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 04:29:21 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45940 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932176Ab2HWI3S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 04:29:18 -0400
Received: (qmail 19138 invoked by uid 107); 23 Aug 2012 08:29:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Aug 2012 04:29:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2012 04:29:16 -0400
Content-Disposition: inline
In-Reply-To: <7vd32i5y8w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204135>

On Wed, Aug 22, 2012 at 03:59:43PM -0700, Junio C Hamano wrote:

> Date: Mon, 2 May 2011 13:39:16 -0700
> 
> Either end of revision range operator can be omitted to default to HEAD,
> as in "origin.." (what did I do since I forked) or "..origin" (what did
> they do since I forked).  But the current parser interprets ".."  as an
> empty range "HEAD..HEAD", and worse yet, because ".." does exist on the
> filesystem, we get this annoying output:
> 
>   $ cd Documentation/howto
>   $ git log .. ;# give me recent commits that touch Documentation/ area.
>   fatal: ambiguous argument '..': both revision and filename
>   Use '--' to separate filenames from revisions
> 
> Surely we could say "git log ../" or even "git log -- .." to disambiguate,
> but we shouldn't have to.
> 
> Helped-by: Jeff King <peff@peff.net>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Hmm, for some reason I had no recollection of the original thread at
all. And yet reading the archives, I apparently had quite a bit to say.
Reading again with fresh eyes, I still think this is sane.

I don't think assigning any revision magic to ".." besides "the empty
range" makes sense at all for the reasons you gave in the original
thread. And the empty range is a pointless no-op. So I don't see any
real argument in favor of disambiguating towards the revision.

So the only reasonable choices are to leave it as an error, or to
disambiguate towards the pathspec.  I suppose some script could stupidly
be doing "git log $a..$b" and would prefer to error out when both are
blank. But that seems unlikely, and making ".." work is actually useful.

> --- a/Documentation/revisions.txt
> +++ b/Documentation/revisions.txt
> @@ -213,6 +213,13 @@ of 'r1' and 'r2' and is defined as
>  It is the set of commits that are reachable from either one of
>  'r1' or 'r2' but not from both.
>  
> +In these two shorthands, you can omit one end and let it default to HEAD.
> +For example, 'origin..' is a shorthand for 'origin..HEAD' and asks "What
> +did I do since I forked from the origin branch?"  Similarly, '..origin'
> +is a shorthand for 'HEAD..origin' and asks "What did the origin do since
> +I forked from them?"  Note that '..' would mean 'HEAD..HEAD' which is an
> +empty range that is both reachable and unreachable from HEAD.

This last sentence confuses me. Now we are documenting that "yes, ..
really means HEAD..HEAD, which is the empty range". But isn't the point
of this patch to say "sure, it would be the empty range, but because
that is stupid and pointless, we do not consider it valid and treat ..
as a pathspec"?

I think that may be what you are trying to say with the "would" in that
sentence, but perhaps this would be a good point to expand and mention
that we special-case "..".

> +test_expect_success 'dotdot is not an empty set' '
> +	( H=$(git rev-parse HEAD) && echo $H ; echo ^$H ) >expect &&

It almost certainly doesn't matter in practice, but the ';' here would
break the &&-chain from rev-parse.
