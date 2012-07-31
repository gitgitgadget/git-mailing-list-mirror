From: Jeff King <peff@peff.net>
Subject: Re: [WIP PATCH] Manual rename correction
Date: Tue, 31 Jul 2012 15:23:42 -0400
Message-ID: <20120731192342.GB30808@sigill.intra.peff.net>
References: <20120731141536.GA26283@do>
 <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 31 21:23:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SwI2q-0000mp-Ql
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jul 2012 21:23:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab2GaTXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jul 2012 15:23:47 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:43669 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751206Ab2GaTXq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jul 2012 15:23:46 -0400
Received: (qmail 31054 invoked by uid 107); 31 Jul 2012 19:23:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 31 Jul 2012 15:23:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 31 Jul 2012 15:23:42 -0400
Content-Disposition: inline
In-Reply-To: <7vtxwnki1a.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202672>

On Tue, Jul 31, 2012 at 09:32:49AM -0700, Junio C Hamano wrote:

> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
> 
> > The above output is done with "git diff --manual-rename=foo A B"
> > and "foo" contains (probably not in the best format though)
> >
> > -- 8< --
> > attr.c dir.c
> > dir.c attr.c
> > -- 8< --
> > ...
> > Comments?
> 
> It is a good direction to go in, I would think, to give users a way
> to explicitly tell that "in comparison between these two trees, I
> know path B in the postimage corresponds to path A in the preimage".

I do not think that is the right direction. Let's imagine that I have a
commit "A" and I annotate it (via notes or whatever) to say "between
A^^{tree} and A^{tree}, foo.c became bar.c". That will help me when
doing "git show" or "git log". But it will not help me when I later try
to merge "A" (or its descendent). In that case, I will compute the diff
between "A" and the merge-base (or worse, some descendent of "A" and the
merge-base), and I will miss this hint entirely.

A much better hint is to annotate pairs of sha1s, to say "do not bother
doing inexact rename correlation on this pair; I promise that they have
value N". Then it will find that pair no matter which trees or commits
are being diffed, and it will do so relatively inexpensively[1].

That is not fool-proof, of course. You might have a manual rename from
sha1 X to sha1 Y, and then a slight modification to Y to make Z. So you
would want some kind of transitivity to notice that X and Z correlate.
I think you could model it as a graph problem; sha1s are nodes, and each
"this is a rename" pair of annotated sha1s has an edge between them.
They are the "same file" if there is a path.

Of course that gives you bizarre and counter-intuitive results, because
X and Z might not actually be that similar. And that is why we have
rename detection in the first place. The idea of file identity (which
this fundamentally is) leads to these sorts of weird results.

I'm sure you could get better results by weakening the transitivity
according to the rename score, or something like that. But now you are
getting pretty complex.

-Peff

[1] We could actually cache rename results by storing pairs of sha1s
    along with their rename score, and should be able to get a good
    speedup (we are still src*dst in comparing, but now the comparison
    is a simple table lookup rather than loading the blobs and computing
    the differences). If we had such a cache, then manually marking a
    rename would just be a matter of priming the cache with your manual
    entries.
