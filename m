From: Jeff King <peff@peff.net>
Subject: Re: git status: small difference between stating whole repository
 and small subdirectory
Date: Mon, 20 Feb 2012 15:09:03 -0500
Message-ID: <20120220200902.GA5314@sigill.intra.peff.net>
References: <20120215190318.GA5992@sigill.intra.peff.net>
 <CAA01Cso5y23UMguEe0vwOc6kR3-DjuC8-LTMDsMeeOKU4rVGvg@mail.gmail.com>
 <20120216192001.GB4348@sigill.intra.peff.net>
 <CAA01Csq6vSekW=Fa236bB0H3LVtN43Gb2aLMVE+A1wVyUqYJ7A@mail.gmail.com>
 <20120217203755.GA30114@sigill.intra.peff.net>
 <7vaa4hrtbe.fsf@alter.siamese.dyndns.org>
 <20120217222912.GC31830@sigill.intra.peff.net>
 <CAA01CsozANwtox06iihKBL8iii175FHAhChmNhG1B0ofGKWcEA@mail.gmail.com>
 <20120220140653.GC5131@sigill.intra.peff.net>
 <7vr4xpl1nm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Git Mailing List <git@vger.kernel.org>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 20 21:09:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzZXs-0006kL-Ej
	for gcvg-git-2@plane.gmane.org; Mon, 20 Feb 2012 21:09:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754Ab2BTUJH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Feb 2012 15:09:07 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44112
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752174Ab2BTUJG (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Feb 2012 15:09:06 -0500
Received: (qmail 6359 invoked by uid 107); 20 Feb 2012 20:09:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 20 Feb 2012 15:09:05 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Feb 2012 15:09:03 -0500
Content-Disposition: inline
In-Reply-To: <7vr4xpl1nm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191097>

On Mon, Feb 20, 2012 at 11:56:13AM -0800, Junio C Hamano wrote:

> These days, we have src_index and dst_index, and dst_index IIRC can start
> as empty in which case "start from kept information and selectively
> invalidate" would not work at all.  When src_index and dst_index are the
> same, however, you should be able to keep the cached tree valid, at least
> in theory.

Yeah, I was worried that the cache invalidations sprinkled throughout
unpack-trees.c would not be sufficient (and because we are invalidating,
a missing invalidation would give us bogus cache info, which is Very
Bad).

So I think the one-liner I posted before is not sufficient in the
general case, because it definitely doesn't consider where the
destination is starting from. It should at least be more like:

  if (src_index == dst_index) {
          /* We would ordinarily want to do a deep copy here, but since
           * we know that we will be overwriting src_index in the long
           * run, it's OK to just take ownership of its cache_tree. */
          o->result.cache_tree = o->src_index->cache_tree;
          o->src_index->cache_tree = NULL;
  }

  [... do the usual tree traversal here, except invalidate entries in
       o->result.call_tree instead of o->src_index. That makes it a
       no-op when src_index != dst_index (because we have no cache tree
       defined in result, then), and otherwise we are invalidating what
       will go into the result...]

  [then as before, we copy the result to dst_index; except now the
   result may have src_index's cache_tree plus any invalidations]
  o->result = *o->dst_index;

And fortunately that does exactly what we want in all cases, because we
always either read from and write to the_index, or we write to NULL (in
which case we will not bother with a cache_tree for the result, and it
is fixing a minor bug that we might be invalidating src_index's tree in the
first place).

I'm still slightly worried that we are missing some invalidation
somewhere deep in unpack_tree's callbacks (especially because they _are_
callbacks, and invalidating the cache_tree properly is now a promise
that the callbacks have to make).

-Peff
