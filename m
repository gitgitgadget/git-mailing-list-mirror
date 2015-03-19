From: Jeff King <peff@peff.net>
Subject: Re: Why is "git fetch --prune" so much slower than "git remote
 prune"?
Date: Thu, 19 Mar 2015 13:14:16 -0400
Message-ID: <20150319171416.GB6386@peff.net>
References: <CACBZZX5n5tTCSa-_A5gQzbzboF_v8a3_oVUjdjyFtKHHe8h-NA@mail.gmail.com>
 <20150306225917.GA1589@peff.net>
 <550AE1E4.7020407@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jay Soffian <jaysoffian@gmail.com>,
	=?utf-8?B?QmrDtnJu?= Gustavsson <bgustavsson@gmail.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 19 18:15:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YYe2K-0002S4-7B
	for gcvg-git-2@plane.gmane.org; Thu, 19 Mar 2015 18:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397AbbCSRPG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2015 13:15:06 -0400
Received: from cloud.peff.net ([50.56.180.127]:35262 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756628AbbCSROT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2015 13:14:19 -0400
Received: (qmail 27442 invoked by uid 102); 19 Mar 2015 17:14:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 12:14:18 -0500
Received: (qmail 14899 invoked by uid 107); 19 Mar 2015 17:14:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Mar 2015 13:14:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Mar 2015 13:14:16 -0400
Content-Disposition: inline
In-Reply-To: <550AE1E4.7020407@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265811>

On Thu, Mar 19, 2015 at 03:49:08PM +0100, Michael Haggerty wrote:

> For pruning, we can't use a ref_transaction as it is currently
> implemented because it would fail if any of the reference deletions
> failed. But in this case I think if any deletions fail, we would prefer
> to emit a warning but keep going.
>
> I'm trying to decide whether to have a separate function in the refs API
> to "delete as many of the following refs as possible", or whether to add
> a flag to ref_transaction_update() that says "try this update, but don't
> fail the transaction if it fails". The latter would probably be more
> work because we would need to invent a way to return multiple error
> messages from a single transaction.

Hmm, yeah. That is sort of antithetical to the original purpose of ref
transactions (which was atomicity). Given the way it is implemented now,
I don't think it would be too big a deal to keep a per-ref status (one
per "struct ref_upate").  But I would worry in the long run that it
makes things much harder on proposed ref backends, which otherwise can
consider a transaction an atomic unit.

OTOH, I do not think there is an abstracted way to do this _without_
the ref backend knowing about it. You cannot just do a series of
transactions; that defeats the purpose. It is a bit of a layering
violation that builtin/remote.c (which does this optimization already)
calls repack_without_refs directly.

-Peff
