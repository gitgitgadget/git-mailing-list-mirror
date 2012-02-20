From: Jeff King <peff@peff.net>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Mon, 20 Feb 2012 10:11:34 -0500
Message-ID: <20120220151134.GA13135@sigill.intra.peff.net>
References: <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch>
 <20120220143644.GA13938@do>
 <20120220143952.GA8387@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 16:11:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzUty-0000el-HE
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 16:11:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753146Ab2BTPLi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 10:11:38 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:43870
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752657Ab2BTPLh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 10:11:37 -0500
Received: (qmail 1919 invoked by uid 107); 20 Feb 2012 15:11:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 10:11:36 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 10:11:34 -0500
Content-Disposition: inline
In-Reply-To: <20120220143952.GA8387@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191077>

On Mon, Feb 20, 2012 at 09:39:52AM -0500, Jeff King wrote:

> On Mon, Feb 20, 2012 at 09:36:44PM +0700, Nguyen Thai Ngoc Duy wrote:
> 
> > > test_expect_failure 'checkout gives cache-tree' '
> > > 	git checkout HEAD^ &&
> > > 	test_shallow_cache_tree
> > > '
> > > 
> > > ;-)
> > 
> > Quick and dirty that passes that test. I think we could do better if
> > we analyse two way merge rules carefully and avoid this diff, but
> > that's too much for me right now.
> 
> Unpack trees is already sprinkled with cache_tree_invalidate_path. But
> something seems to throw away the cache tree entirely (I think it may be
> that the extension simply isn't copied over to the destination index).
> I'm walking through it right now.

Hmm. OK, this doesn't pass the test, but I think it is better than the
current behavior.

Basically, what happens now with "git checkout" is this:

  1. read_cache pulls the cache_tree from disk into the_index

  2. we call unpack_trees with o->src_index == o->dst_index ==
     &the_index.

  3. during tree traversal, unpack_trees callbacks properly calls
     cache_tree_invalidate_path whenever it updates a path. We write the
     results into o->result.

  4. At the end of unpack_trees, we forget about src_index, and copy
     o->result into *o->dst_index byte for byte. I.e., we overwrite
     the_index.cache_tree, which has been properly updated the whole
     time, with NULL, dropping it entirely (in fact, I believe it even
     creates a memory leak of the old cache_tree).

This one-liner improves that a bit:

diff --git a/unpack-trees.c b/unpack-trees.c
index 8be3f6c..e8aedea 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1135,6 +1135,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 		}
 	}
 
+	o->result.cache_tree = o->src_index->cache_tree;
 	o->src_index = NULL;
 	ret = check_updates(o) ? (-2) : 0;
 	if (o->dst_index)

by copying the cache_tree (which has been updated all along) from
src_index into the result (which will then make it into the
destination index, which of course in this case is the same as the
source index, anyway).

It makes "git checkout" with no changes just work (since we preserve the
cache tree, and it doesn't need updated). It makes something like "git
checkout HEAD^" work, keeping most of the cache-tree intact, but
invalidating trees containing paths that were modified.

But it does not actually insert the _destination_ tree into the cache
tree. Which we can do in certain situations, but only if there were no
paths in the tree that were left unchanged (e.g., you modify "foo", then
"git checkout HEAD^", which updates "bar". Your tree does not match
HEAD^, and must be invalidated).  While it would be cool to be able to
handle those complex cases, making this one simple change covers most of
the cases people care about (i.e., leaving the cache-tree intact for all
of the directories that weren't touched at all).

I think this implementation matches the intent of the original calls to
cache_tree_invalidate_path sprinkled throughout unpack-trees.c. But I
have to say that it seems a little odd for us to be modifying the
o->src_index throughout the whole thing. I would think the right thing
would be to make a deep copy of o->src_index->cache_tree into
o->result.cache_tree as the very first thing, and then update
o->result.cache_tree throughout the tree traversal. There is no point in
invalidating src_index's cache_tree, since it is not receiving the
updates.

In practice, this doesn't tend to matter because everybody just sets src
and dst to &the_index anyway. The one exception seems to be diff_cache,
which sets dst_index to NULL. But it doesn't matter there, because we
are only using oneway_diff as our callback, which does not actually
write or invalidate anything in the cache.

-Peff
