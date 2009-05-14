From: Jeff King <peff@peff.net>
Subject: Re: git-tag bug? confusing git fast-export with double tag objects
Date: Thu, 14 May 2009 14:22:49 -0400
Message-ID: <20090514182249.GA11919@sigill.intra.peff.net>
References: <op.utv93sdo1e62zd@merlin.emma.line.org> <op.utwdsutn1e62zd@merlin.emma.line.org> <7v8wl01iev.fsf@alter.siamese.dyndns.org> <op.utwyczlf1e62zd@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Matthias Andree <matthias.andree@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 14 20:23:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4faa-0006Ah-Jn
	for gcvg-git-2@gmane.org; Thu, 14 May 2009 20:23:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752704AbZENSWt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2009 14:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752694AbZENSWt
	(ORCPT <rfc822;git-outgoing>); Thu, 14 May 2009 14:22:49 -0400
Received: from peff.net ([208.65.91.99]:36104 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752663AbZENSWt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2009 14:22:49 -0400
Received: (qmail 24333 invoked by uid 107); 14 May 2009 18:22:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 14 May 2009 14:22:51 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2009 14:22:49 -0400
Content-Disposition: inline
In-Reply-To: <op.utwyczlf1e62zd@merlin.emma.line.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119208>

On Thu, May 14, 2009 at 11:37:37AM +0200, Matthias Andree wrote:

> HOWEVER, I see two problems here (yes, they are corner cases):
>
> #1: git tag -f ("replace tag") fails to "replace" a heaviweight tag if I  
> try to replace a tag by itself (or create a cycle by some other means).
>
> The new "foo" is unique in refs (OK), but it's *not unique* in objects  
> (FAIL), as the old "foo" is referenced by the new "foo" and bears the same 
> tag name.
>
> It screws the repo, breaking the uniqueness of tags. Basically, git tag -f 
> is implementing a half-baked, non-working "rebase tag objects"  
> functionality.

Can you explain how this "screws the repo"? The refs are unique, and in
your examples, a tag object replaced by "git tag -f" no longer has a ref
pointing to it (but in your example of making a tag of a tag, then of
course the original is still reachable indirectly). The "unique in
objects" you refer to is that the tag itself says "here is the name
under which I was tagged". That name is purely informative and has
nothing to do with ref lookup or reachability.

In your examples, I don't see any behavior that is causing actual
problems.

> #2: related: git tag -d cannot reliably delete tag objects
>
> Same here: if another tag object references the tag object I'm deleting,  
> we only delete the ref, but not the tag object. It doesn't (cannot) become 
> dangling.

Deleting the ref makes it dangling, unless something else is referencing
it. In your examples, since you tag the tag, the original tag is still
referenced.

> $ git rev-list --objects --all
> 4481a15d999b1b13066fe932e35ea05b8b1027a6
> 72f3463f5a8089ac91001d458ceffb6d4e1056ee foo
> 2e326d8a210536b7cd1f2bc77e3e29d7231f9ec4 foo
> 995773fc9b649922936e110207e6abb904cc18e8
> 15a9779d8f787428e57830410c7842e5449dfd33 a

The right-hand side of this output is a purely informative "here is a
name that may be useful for packing heuristics". It has nothing to do
with the refs (for blobs, the pathname through which we reached the blob
will be printed -- obviously this is not going to be unique, as you will
have many versions of each file).

> So what we get is (root/parents first, then children):
>
> objects:  4481a1 (commit) <- 2e326d (tag "foo") <- 72f346 (tag "foo")
> refs:     heads/master                             tags/foo
>
> Whoops. "foo" is there twice, and it's referenced from a current ref.
> We have *not* *replaced* it. *If* we did, we should have got:
>
> objects:  4481a1 (commit) <- 72f346 (tag "foo")
> refs:     heads/master       tags/foo
> with a dangling tag 2e326d

Right. Because you didn't ask to replace it. You asked to tag the tag.

> Hu, there's a nice cycle:
>
> 69bf (commit) <- 9756 ('old' tag1) <- 38ae (tag2) <- 8e7a (tag1)

You keep calling these cycles, but they're not (at least in terms of the
git graph). The fact that two distinct objects both contain the string
"tag tag1" is not any more a cycle than two commit objects with the same
commit message. They are both distinct objects with distinct hashes, and
the hashes are how the git graph is built.

> Now, more fun - watch the inconsistency:
>
> $ git tag -d tag1
> Deleted tag 'tag1'
> $ git tag -d tag1
> error: tag 'tag1' not found.

OK, so you deleted the ref tag1.

> Ha! As if... now watch this:
> $ git rev-list --objects  --all | while read a b ; do echo "$a $(git  
> cat-file -t $a) $b" ; done
> 69bf327c5d172fc8e4f63acf4d2e01c474824ce4 commit
> 38aea56fec319d8c259a80157dde2432d2d09b2b tag tag2
> 9756f6fa98a5cce2aab1f6a6e7dd4de515626e19 tag tag1
> d758baa57a7ef20d44df0535bef1a91bb3dc4f62 tree
> d3d8863b140f43f7c07050b9f2e210d41e73edb1 blob otherfile
>
> The tag object "tag1" is still there. WHOOPS!!!

Of course the _old_ tag1 is still there. It is referenced by tag2, which
still has a ref. Again you are confusing the right-hand side of "git
rev-list --objects" with actual ref names.

> I appreciate that this isn't trivial to solve, but I presume anything that 
> walks the object database and uses tags can fail - including, but not  
> limited to, git fast-export.

I am not ruling out the possibility that there is some piece of code
that will be confused by the situation you have created, but it has
nothing to do with graph walking. It would have to be a piece of code
which cares about the uniqueness of informative names inside tag
objects.

-Peff
