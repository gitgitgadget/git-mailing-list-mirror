From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 15/17] commit-slab: provide a static initializer
Date: Thu, 12 Jun 2014 15:51:28 -0400
Message-ID: <20140612195127.GA4468@sigill.intra.peff.net>
References: <20140610213509.GA26979@sigill.intra.peff.net>
 <20140610214251.GO19147@sigill.intra.peff.net>
 <xmqq7g4m6lka.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 21:51:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvB26-0002qZ-Dv
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 21:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbaFLTva (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 15:51:30 -0400
Received: from cloud.peff.net ([50.56.180.127]:42869 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751112AbaFLTva (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 15:51:30 -0400
Received: (qmail 1648 invoked by uid 102); 12 Jun 2014 19:51:29 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Jun 2014 14:51:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Jun 2014 15:51:28 -0400
Content-Disposition: inline
In-Reply-To: <xmqq7g4m6lka.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251491>

On Thu, Jun 12, 2014 at 11:15:49AM -0700, Junio C Hamano wrote:

> Why do we need an initialiser at this point (in other words, how
> have other existing slab users coped without having one)?
> 
> I think they call init_*_slab() when the slab is needed/used the
> first time (e.g. it is not even worth initialising indegree slab
> unless we are sorting in topo order).
> 
> Unlike the author-date and indegree slabs, there are too many entry
> points that may want access to the buffer slab (save_commit_buffer's
> default being on does not help us either), so it would be much less
> error prone to always initialise a static slab like this patch does,
> I guess.

Yes, and also because the lifetime of this slab is different. For the
indegree and author-date slabs, the slab lives for one operation.  So we
init the slab at the beginning of the operation, do the sort, then clear
it at the end.

This slab does not exist for one operation. It is a global cache that
can be used by any code, just like the "struct commit" cache itself.. It
should always be initialized from the start, and continue until the
program exits.

-Peff
