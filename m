From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] lookup_object: prioritize recently found objects
Date: Fri, 3 May 2013 02:02:44 -0400
Message-ID: <20130503060244.GA13843@sigill.intra.peff.net>
References: <20130501203449.GA12535@sigill.intra.peff.net>
 <51820B37.8010503@viscovery.net>
 <20130502064630.GA15208@sigill.intra.peff.net>
 <5182101D.4050807@viscovery.net>
 <20130502154618.GA18462@sigill.intra.peff.net>
 <5183522D.5060405@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri May 03 08:02:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY952-0003zQ-0u
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 08:02:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124Ab3ECGCr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 02:02:47 -0400
Received: from cloud.peff.net ([50.56.180.127]:35651 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760523Ab3ECGCr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 02:02:47 -0400
Received: (qmail 5446 invoked by uid 102); 3 May 2013 06:03:04 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 03 May 2013 01:03:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 May 2013 02:02:44 -0400
Content-Disposition: inline
In-Reply-To: <5183522D.5060405@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223282>

On Fri, May 03, 2013 at 07:59:09AM +0200, Johannes Sixt wrote:

> Am 5/2/2013 17:46, schrieb Jeff King:
> > On Thu, May 02, 2013 at 09:05:01AM +0200, Johannes Sixt wrote:
> >> BTW, do you notice that the function is now modifying an object (the hash
> >> table) even though this is rather unexpected from a "lookup" function?
> > 
> > I think this is fine. The function is conceptually constant from the
> > outside; callers don't even know about the hash table. They just know
> > that there is some mapping. It's similar to the way that lookup_commit
> > will lazily allocate the "struct commit". The callers do not care
> > whether it exists already or not; they care that at the end of the
> > function, they have a pointer to the commit. Everything else is an
> > implementation detail.
> 
> Can we be sure that the function is never invoked in concurrently from
> different threads? I attempted to audit code paths, but quickly gave up
> because I know too little about this machinery.

I didn't check explicitly, but in general such a program would already
need a mutex to synchronize object lookup. Not for lookup_object
specifically, but because lookup_object is mostly used to back
lookup_commit, lookup_tree, etc, which are already not re-entrant
(because they lazily insert into the hash behind the scenes).

-Peff
