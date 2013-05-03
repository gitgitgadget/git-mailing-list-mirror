From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] lookup_object: prioritize recently found objects
Date: Fri, 3 May 2013 02:16:05 -0400
Message-ID: <20130503061605.GB13674@sigill.intra.peff.net>
References: <20130501203449.GA12535@sigill.intra.peff.net>
 <51820B37.8010503@viscovery.net>
 <20130502064630.GA15208@sigill.intra.peff.net>
 <5182101D.4050807@viscovery.net>
 <20130502154618.GA18462@sigill.intra.peff.net>
 <5183522D.5060405@viscovery.net>
 <20130503060244.GA13843@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 03 08:16:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY9Hx-00080N-Rl
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 08:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762060Ab3ECGQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 02:16:09 -0400
Received: from cloud.peff.net ([50.56.180.127]:35742 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756734Ab3ECGQI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 02:16:08 -0400
Received: (qmail 6020 invoked by uid 102); 3 May 2013 06:16:24 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 May 2013 01:16:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 May 2013 02:16:05 -0400
Content-Disposition: inline
In-Reply-To: <20130503060244.GA13843@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223283>

On Fri, May 03, 2013 at 02:02:44AM -0400, Jeff King wrote:

> > Can we be sure that the function is never invoked in concurrently from
> > different threads? I attempted to audit code paths, but quickly gave up
> > because I know too little about this machinery.
> 
> I didn't check explicitly, but in general such a program would already
> need a mutex to synchronize object lookup. Not for lookup_object
> specifically, but because lookup_object is mostly used to back
> lookup_commit, lookup_tree, etc, which are already not re-entrant
> (because they lazily insert into the hash behind the scenes).

I just looked through the 25 existing calls to lookup_object. All of
them should be OK. Most of them are coupled with immediate calls to
update the hash table and/or to call read_sha1_file (which is also very
not-thread-safe). So I don't think the patch introduces any bug into the
current code.

It does introduce a potential for future bugs in concurrent code, but I
don't know that it makes a significant dent in the current codebase. We
already have a lot of non-reentrant functions, including all of the
other lookup_* functions.  Our concurrent code is typically very careful
to use a small known-safe subset of functions.

I did look originally at updating the ordering when the hash is already
being updated (i.e., to insert a new entry at the front of a collision
chain, rather than the back). However, that didn't yield nearly as much
improvement. I think partially because the locality of an insert/lookup
pair is not as good as a lookup/lookup pair. And partially because we
destroy that ordering for existing entries whenever we grow the hash
table.

-Peff
