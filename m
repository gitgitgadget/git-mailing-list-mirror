From: Jeff King <peff@peff.net>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Mon, 20 Feb 2012 15:17:49 -0500
Message-ID: <20120220201749.GA5405@sigill.intra.peff.net>
References: <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch>
 <20120220143644.GA13938@do>
 <20120220143952.GA8387@sigill.intra.peff.net>
 <20120220151134.GA13135@sigill.intra.peff.net>
 <7vfwe5l13w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 21:18:00 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzZgL-0002b9-Rj
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 21:17:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab2BTURx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 15:17:53 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44128
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752290Ab2BTURw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 15:17:52 -0500
Received: (qmail 6543 invoked by uid 107); 20 Feb 2012 20:17:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 15:17:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 15:17:49 -0500
Content-Disposition: inline
In-Reply-To: <7vfwe5l13w.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191099>

On Mon, Feb 20, 2012 at 12:08:03PM -0800, Junio C Hamano wrote:

> >   4. At the end of unpack_trees, we forget about src_index, and copy
> >      o->result into *o->dst_index byte for byte. I.e., we overwrite
> >      the_index.cache_tree, which has been properly updated the whole
> >      time,
> 
> I strongly suspect that "properly updated" part needs to be thoroughly
> audited.  I wouldn't be surprised that this behaviour is what we did when
> we split src_index vs dst_index when he rewrote unpack_trees() in order to
> emulate the original "unpack-trees is beyond salvation because it does not
> maintain cache tree correctly, just nuke it" behaviour.

Yep, I am also concerned about that.

> > But it does not actually insert the _destination_ tree into the cache
> > tree. Which we can do in certain situations, but only if there were no
> > paths in the tree that were left unchanged (e.g., you modify "foo", then
> > "git checkout HEAD^", which updates "bar". Your tree does not match
> > HEAD^, and must be invalidated).  While it would be cool to be able to
> > handle those complex cases,...
> 
> It may look cool but it may not be a good change. You are spending extra
> cycles to optimize for the next write-tree that may not happen before the
> index is further updated.

I don't think it would be too many cycles; you would have to mark each
tree you enter as having items from the left-hand tree or the right-hand
tree. If only one, you can reuse the cache-tree entry (or tree sha1, if
coming from a tree). Otherwise, you must invalidate.  And it doesn't
just help the next write-tree, but any intermediate index diffs.

Of course any such change would need timings to justify it, though.

That being said, I think just invalidating really covers 99% of the
cases. What we really care about is that when I modify kernel/foo.c, the
~2300 other directories (besides "" and "kernel") don't need rebuilt,
and that is relatively simple to do. Even if doing it the other way
produced a tiny speedup, I would be concerned with the increase in code
complexity.

> > I think this implementation matches the intent of the original calls to
> > cache_tree_invalidate_path sprinkled throughout unpack-trees.c.
> 
> Yes, and as long as we invalidate all the directories that need to be
> invalidated during the unpack-tree operation, I think it is a correct
> thing to do.

OK. I'll do some reading of the code to convince myself that the
unpack_trees callbacks are doing the right thing. I'm not sure of a good
automatic test that would detect a failure there. Just making test cases
is going to end up too contrived, unless we are missing something really
obvious.

I'm thinking maybe something like replaying the commit history of
linux-2.6 and making sure that each the tree generated by the cache-tree
in each case matches the actual committed tree.

> > But I
> > have to say that it seems a little odd for us to be modifying the
> > o->src_index throughout the whole thing.
> 
> Yes, that part is logically *wrong*.  I think it is a remnant from the
> days when there was no distinction between src_index and dst_index.

OK. I'll include a fix for that in the series I prepare.

-Peff
