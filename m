From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] pathspec: rename free_pathspec() to clear_pathspec()
Date: Thu, 2 Jun 2016 17:29:38 -0400
Message-ID: <20160602212938.GA13071@sigill.intra.peff.net>
References: <xmqq60trthl4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 23:30:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8aBW-00013H-Na
	for gcvg-git-2@plane.gmane.org; Thu, 02 Jun 2016 23:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932565AbcFBV3m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jun 2016 17:29:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:48021 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932215AbcFBV3m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jun 2016 17:29:42 -0400
Received: (qmail 4983 invoked by uid 102); 2 Jun 2016 21:29:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 17:29:41 -0400
Received: (qmail 14391 invoked by uid 107); 2 Jun 2016 21:29:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 02 Jun 2016 17:29:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Jun 2016 17:29:38 -0400
Content-Disposition: inline
In-Reply-To: <xmqq60trthl4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296238>

On Thu, Jun 02, 2016 at 02:18:47PM -0700, Junio C Hamano wrote:

> The function takes a pointer to a pathspec structure, and releases
> the resources held by it, but does not free() the structure itself.
> Such a function should be called "clear", not "free".

Hmm, makes sense, though...

>  * This is just something I noticed.  Among the hits in
> 
>     $ git grep free_ \*.h
> 
>    I think free_notes() is also a candidate for such renaming, but
>    because we are not actively working on that subsystem, we may
>    want to leave that dog sleeping to avoid unnecessary code churn.
>    The same for diff_free_filespec_data(), for which a better name
>    would have been diff_filespec_clear().

I think diff_filespec_clear() would not be quite right. It is freeing
only the allocated _data_, but leaving the other portions intact.
Generally our _clear() functions reset the object back to an initial
state, from which it can be reused. I don't see that as a big problem
because there is an other object for the verb "free" here: "data". We
are just freeing its data, but the rest of the object remains intact and
we may fill in the data again later.

But I think pathspec is in similar boat; it has not been cleared back to
its initial state. But it is in a much _worse_ state than the filespec,
which you can continue to use. It is in a totally broken state where
"nr" does not correspond to the actual number of items, the has_wildcard
flag is bogus, etc.

So I think it would be OK to move it to "clear", but we should probably
also zero the whole thing, too.

-Peff
