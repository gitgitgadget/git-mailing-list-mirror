From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 16/16] write_sha1_file: freshen existing objects
Date: Fri, 3 Oct 2014 20:01:15 -0400
Message-ID: <20141004000114.GA17063@peff.net>
References: <20141003202045.GA15205@peff.net>
 <20141003204110.GP16293@peff.net>
 <xmqq61g0lu3t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 04 02:01:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XaCmq-0006aV-5S
	for gcvg-git-2@plane.gmane.org; Sat, 04 Oct 2014 02:01:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756557AbaJDABU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Oct 2014 20:01:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:54956 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755822AbaJDABR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Oct 2014 20:01:17 -0400
Received: (qmail 11906 invoked by uid 102); 4 Oct 2014 00:01:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 19:01:17 -0500
Received: (qmail 16422 invoked by uid 107); 4 Oct 2014 00:01:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Oct 2014 20:01:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Oct 2014 20:01:15 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61g0lu3t.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257881>

On Fri, Oct 03, 2014 at 02:29:58PM -0700, Junio C Hamano wrote:

> > We can solve this by "freshening" objects that we avoid
> > writing by updating their mtime. The algorithm for doing so
> > is essentially the same as that of has_sha1_file. Therefore
> > we provide a new (static) interface "check_and_freshen",
> > which finds and optionally freshens the object. It's trivial
> > to implement freshening and simple checking by tweaking a
> > single parameter.
> 
> An old referent by a recent unreachable may be in pack.  Is it
> expected that the same pack will have many similar old objects (in
> other words, is it worth trying to optimize check-and-freshen by
> bypassing access() and utime(), perhaps by keeping a "freshened in
> this process already" flag in struct packed_git)?

Thanks for reminding me. I considered something like that early on and
then completely forgot to revisit it. I do not have numbers either way
on whether it is an optimization worth doing. On the one hand, it is
very easy to do.  On the other, it probably does not make a big
difference; we are literally skipping the write of an entire object, and
have just run a complete sha1 over the contents. A single utime() call
probably is not a big deal.

> Could check-and-freshen-nonlocal() ever be called with freshen set
> to true?  Should it be?  In other words, should we be mucking with
> objects in other people's repositories with utime()?

Yes, it can, and I think the answer to "should" is "yes" for safety,
though I agree it feels a little hacky. I did explicitly write it so
that we fail-safe when freshening doesn't work. That is, if we try to
freshen an object that is in an alternate and we cannot (e.g., because
we don't have write access), we'll fallback to writing out a new loose
object locally.

That's very much the safest thing to do, but obviously it performs less
well. Again, this is the code path where we _would have_ written out the
object anyway, so it might not be that bad. But I don't know to what
degree the current code relies on that optimization for reasonable
performance. E.g., if you clone from a read-only alternate and then try
to `git write-tree` immediately on the index, will we literally make a
full copy of each tree object?

Hmm, that should be easy to test...

  $ su - nobody
  $ git clone -s ~peff/compile/linux /tmp/foo
  $ cd /tmp/foo

  $ git count-objects
  0 objects, 0 kilobytes
  $ git write-tree
  $ git count-objects
  0 objects, 0 kilobytes

So far so good. Let's blow away the cache-tree to make sure...

  $ rm .git/index
  $ git read-tree HEAD
  $ git write-tree
  $ git count-objects
  0 objects, 0 kilobytes

So that's promising. But it's far from a proof that there isn't some
other code path that will be negatively impacted.

-Peff
