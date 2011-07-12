From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/5] add object-cache infrastructure
Date: Tue, 12 Jul 2011 13:57:39 -0400
Message-ID: <20110712175739.GA17031@sigill.intra.peff.net>
References: <20110711161332.GA10057@sigill.intra.peff.net>
 <20110711161754.GB10418@sigill.intra.peff.net>
 <201107121241.40242.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Ts'o <tytso@mit.edu>, Jonathan Nieder <jrnieder@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Eric Wong <normalperson@yhbt.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 12 19:58:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QghDl-0004dg-Te
	for gcvg-git-2@lo.gmane.org; Tue, 12 Jul 2011 19:58:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754540Ab1GLR5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jul 2011 13:57:42 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46684
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754467Ab1GLR5m (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jul 2011 13:57:42 -0400
Received: (qmail 14189 invoked by uid 107); 12 Jul 2011 17:58:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 12 Jul 2011 13:58:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 12 Jul 2011 13:57:39 -0400
Content-Disposition: inline
In-Reply-To: <201107121241.40242.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176959>

On Tue, Jul 12, 2011 at 12:41:35PM +0200, Jakub Narebski wrote:

> On Mon, 11 July 2011, Jeff King wrote:
> 
> > There is sometimes a need to cache some information about an
> > object or set of objects persistently across git
> > invocations. The notes-cache interface can be used for this,
> > but it is very heavyweight and slow for storing small
> > values.
> > 
> > This patch introduces a new API, object-cache, which stores
> > a mapping of objects to values in a concise and efficient
> > form. See the added API documentation for details.
> > 
> > Signed-off-by: Jeff King <peff@peff.net>
> > ---
> > As I mentioned earlier, I wanted this to be generic and size-agnostic,
> > because I'd also like to try caching patch-ids for git-cherry.
> 
> Could this API be generalized to support "reverse cache", for example
> to map Subversion revision numbers to Git revision identifiers (for 
> git-svn)?

I hadn't really considered that. It definitely _could_ be done, but I'm
not sure if it's a good idea, for two reasons:

  1. The in-memory store is based on decorate.[ch], which actually
     stores pointers to objects instead of sha1s as keys. Which keeps
     the hash entries a little smaller, and makes comparisons faster.

     We can only take that shortcut because we know what the keys are
     (i.e., objects, and the in-memory store gets pointers and the disk
     store gets sha1s). So I have some fear that a more generalized form
     may be a little slower.

  2. The disk store uses a binary search over a sorted list of sha1s.
     Generalizing this to "a sequence of bytes" would not be hard. But
     we currently have the option of using the uniform distribution of
     sha1 to make better guesses about our "middle" (see the comments in
     sha1-lookup.c). That assumption does not hold over arbitrary bytes.

-Peff
