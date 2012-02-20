From: Jeff King <peff@peff.net>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Mon, 20 Feb 2012 15:35:40 -0500
Message-ID: <20120220203540.GA5966@sigill.intra.peff.net>
References: <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <87ty2l38ay.fsf@thomas.inf.ethz.ch>
 <20120220143644.GA13938@do>
 <20120220143952.GA8387@sigill.intra.peff.net>
 <20120220151134.GA13135@sigill.intra.peff.net>
 <87d3991gyg.fsf@thomas.inf.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Feb 20 21:35:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzZxf-0003bj-Eb
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 21:35:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753391Ab2BTUfq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 15:35:46 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44143
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753324Ab2BTUfq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 15:35:46 -0500
Received: (qmail 6721 invoked by uid 107); 20 Feb 2012 20:35:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 15:35:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 15:35:40 -0500
Content-Disposition: inline
In-Reply-To: <87d3991gyg.fsf@thomas.inf.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191100>

On Mon, Feb 20, 2012 at 07:45:59PM +0100, Thomas Rast wrote:

> > +	o->result.cache_tree = o->src_index->cache_tree;
> >  	o->src_index = NULL;
> >  	ret = check_updates(o) ? (-2) : 0;
> >  	if (o->dst_index)
> 
> Brilliant.  I know I'm stealing Junio's punchline, but please make it so
> :-)
> 
> Browsing around in history, it seems that this was silently broken by
> 34110cd (Make 'unpack_trees()' have a separate source and destination
> index, 2008-03-06), which introduced the distinction between source and
> destination index.  Before that they were the same, so the cache tree
> would have been updated correctly.

OK, good. When you write a one-liner that makes a huge change in
performance, it is usually a good idea to think to yourself "no, it
couldn't be this easy, could it?".

But after more discussion from people more clueful than I (this is the
first time I've even looked at cache-tree code), I'm feeling like this
is the right direction, at least, if not exactly the right patch.
And seeing that it is in fact a regression in 34110cd, and that the
existing cache-tree invalidations predate that makes me feel better. At
one point, at least, they were complete and we were depending on them to
be accurate. Things may have changed since then, of course, but I at
least know that they were sufficient in 34110cd^.

> +# NEEDSWORK: only one of these two can succeed.  The second is there
> +# because it would be the better result.
> +test_expect_success 'checkout HEAD^ correctly invalidates cache-tree' '
> +	git checkout HEAD^ &&
> +	test_invalid_cache_tree
> +'
> +
> +test_expect_failure 'checkout HEAD^ gives full cache-tree' '
> +	git checkout master &&
> +	git read-tree HEAD &&
>  	git checkout HEAD^ &&
> -	test_shallow_cache_tree
> +	test_cache_tree
>  '

I think you can construct two tests that will both work in the "ideal"
case. In the first one, you move to a tree that updates "foo", and
therefore the root cache-tree is invalidated.

In the second, you update "subdir1/foo" in the index, then move to a
commit that differs in "subdir1/bar" and "subdir2/bar". You should see
that subdir2 has the cache-tree of the destination commit, but that
subdir1 is invalidated (and therefore the root is also invalidated).
That will fail with my patch, of course, as it would invalidate subdir2,
also; so it would just be an expect_failure for somebody in the future.

In general, t0090 could benefit from using a larger tree. For example,
the add test does "git add foo" and checks that the root cache-tree was
invalidated. But it should _also_ check that the cache-tree for a
subdirectory is _not_ invalidated (and it isn't; git-add does the right
thing).

I'll see if I can work up some fancier tests, too.

-Peff
