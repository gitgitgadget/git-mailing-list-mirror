From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 2/2] alloc.c: remove the redundant commit_count
 variable
Date: Fri, 11 Jul 2014 04:32:20 -0400
Message-ID: <20140711083220.GA5407@sigill.intra.peff.net>
References: <53BF28F4.8050704@ramsay1.demon.co.uk>
 <20140711003053.GB11360@sigill.intra.peff.net>
 <53BF3709.6000307@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 11 10:32:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5WFo-0004mT-N3
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 10:32:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbaGKIcX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 04:32:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:59938 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750776AbaGKIcW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 04:32:22 -0400
Received: (qmail 17659 invoked by uid 102); 11 Jul 2014 08:32:22 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 03:32:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 04:32:20 -0400
Content-Disposition: inline
In-Reply-To: <53BF3709.6000307@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253254>

On Fri, Jul 11, 2014 at 01:59:53AM +0100, Ramsay Jones wrote:

> > The code you're touching here was trying to make sure that each commit
> > gets a unique index, under the assumption that commits only get
> > allocated via alloc_commit_node. But I think that assumption is wrong.
> > We can also get commit objects by allocating an OBJ_NONE (e.g., via
> > lookup_unknown_object) and then converting it into an OBJ_COMMIT when we
> > find out what it is.
> 
> Hmm, I don't know how the object is converted, but the object allocator
> is actually allocating an 'union any_object', so it's allocating more
> space than for a struct object anyway.

Right, we would generally want to avoid lookup_unknown_object where we
can for that reason.

> If you add an 'index' field to struct object, (and remove it from
> struct commit) it could be set in alloc_object_node(). ie _all_ node
> types get an index field.

That was something I considered when we did the original commit-slab
work, as it would let you do similar tricks for any set of objects, not
just commits. The reasons against it are:

  1. It would bloat the size of blob and tree structs by at least 4
     bytes (probably 8 for alignment). In most repos, commits make up
     only 10-20% of the total objects (so for linux.git, we're talking
     about 25MB extra in the working set).

  2. It makes single types sparse in the index space. In cases where you
     do just want to keep data on commits (and that is the main use),
     you end up allocating a slab entry per object, rather than per
     commit. That wastes memory (much worse than 25MB if your slab items
     are large), and reduces cache locality.

You could probably get around (2) by splitting the index space by type
and allocating them in pools, but that complicates things considerably,
as you have to guess ahead of time at reasonable maximums for each type.

-Peff
