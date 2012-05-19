From: Jeff King <peff@peff.net>
Subject: Re: cherry-pick is slow
Date: Fri, 18 May 2012 20:54:24 -0400
Message-ID: <20120519005424.GF765@sigill.intra.peff.net>
References: <CAPZ_ugYojqTaWi0atr2ApOu9xmcwy4y8FduNC+TDhgWgSxXNPQ@mail.gmail.com>
 <CAPc5daW6eBLUf55_Qk+4bA6Y16TehfOUGc1xFzhib9vm=8O2Yw@mail.gmail.com>
 <CAPZ_ugbV6hB+8z8UsQKdHhxGuHbLzC5WK19mK7M8k2tMz+mtXw@mail.gmail.com>
 <20120514145412.GA1159@sigill.intra.peff.net>
 <CAPZ_ugbD=mOPBs6GyapWtv6NWuJ-=r2+bqBN9n+gdTPwGj3F0Q@mail.gmail.com>
 <20120515132451.GA25378@sigill.intra.peff.net>
 <7v1umldw3i.fsf@alter.siamese.dyndns.org>
 <7vwr4dcg2b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Dmitry Risenberg <dmitry.risenberg@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 19 02:54:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVXwH-0003GK-Vf
	for gcvg-git-2@plane.gmane.org; Sat, 19 May 2012 02:54:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968265Ab2ESAy3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 20:54:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48914
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S968248Ab2ESAy2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 20:54:28 -0400
Received: (qmail 10283 invoked by uid 107); 19 May 2012 00:54:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 18 May 2012 20:54:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2012 20:54:24 -0400
Content-Disposition: inline
In-Reply-To: <7vwr4dcg2b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198003>

On Tue, May 15, 2012 at 02:03:40PM -0700, Junio C Hamano wrote:

> > 	git format-patch -1 --stdout $commit | git apply --index --3way
> [...]
> An unscientific datapoint shows that with a project as small as the kernel,
> the difference is noticeable.
>
> For example, v3.4-rc7-22-g3911ff3 (random tip of the day) touches two
> paths, and cherry-picking it on top of v3.3 goes like this:

Yeah that's what I would expect. And that's not even that far away.
Cherry-picking the same commit onto v3.0 should be even more noticeable.

> I _think_ most of the overhead comes from having to match the large trees
> in unpack_trees() even though none of the changes between the base
> versions matters for this" cherry-pick".
> 
> Both reads the flat index into the core in its entirety and futzing with
> the index file format would not affect this comparison, even though it
> could improve the performance of "am", if done right, as it could limit
> its updates to only two paths.  In the merge case, we pretty much rebuild
> the resulting index from scratch by walking the entire tree in
> unpack_trees(), so there won't be much benefit.
> 
> Perhaps we might want to rethink the way we run merges?

For merge-recursive, we would always want to compute the pair-wise
renames between each side and the ancestor. So that diff to the
cherry-pick destination is always going to be an expensive O(# of
changes between source and dest) operation.

Without renames, you could do better on the actual merge with a
three-way tree walk. E.g., you see that some sub-tree is at tree A in
the "ours" and "ancestor" trees, but at tree B in "theirs". So you don't
have to descend further, and can just say "take theirs" (well, you have
to descend "theirs" to get the values). But I expect it gets more
complicated with the interactions with the index (and is probably not
worth spending much effort on because of the rename issue, anyway).

-Peff
