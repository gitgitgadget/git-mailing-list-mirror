From: Jeff King <peff@peff.net>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Wed, 24 Jun 2015 04:51:41 -0400
Message-ID: <20150624085141.GA5436@peff.net>
References: <1435020656.28466.8.camel@twopensource.com>
 <20150623114716.GC12518@peff.net>
 <CACsJy8B=jthxn_E-zWnDfua29FGGgz221N-cLw=NxeVOKadUxA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>,
	git mailing list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 10:52:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7gPY-0003GY-DW
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 10:52:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751542AbbFXIv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 04:51:57 -0400
Received: from cloud.peff.net ([50.56.180.127]:50884 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750868AbbFXIvq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 04:51:46 -0400
Received: (qmail 7517 invoked by uid 102); 24 Jun 2015 08:51:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Jun 2015 03:51:44 -0500
Received: (qmail 26028 invoked by uid 107); 24 Jun 2015 08:51:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Jun 2015 04:51:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jun 2015 04:51:41 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8B=jthxn_E-zWnDfua29FGGgz221N-cLw=NxeVOKadUxA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272541>

On Tue, Jun 23, 2015 at 08:10:03PM +0700, Duy Nguyen wrote:

> >   - we keep a key/value index mapping the name of any branch that exists
> >     to the byte offset of its entry in the logfile. This would probably
> 
> One key/value mapping per branch, pointing to the latest reflog entry,
> or one key/valye mapping for each reflog entry?

Yeah, sorry, I meant to point only to the latest entry (and then from
there if you want to actually walk the reflog, you can do so by
following the backreference to the previous entry).

> >     be in some binary key/value store (like LMDB). Without this,
> >     resolving a ref is O(U), which is horrible. With it, it should be
> >     O(1) or O(lg N), depending on the index data structure.
> 
> I'm thinking of the user with small or medium repos, in terms of refs,
> who does not want an extra dependency. If we store one mapping per
> branch, then the size of this mapping is small enough that the index
> in a text file is ok. If we also store the offset to the previous
> reflog entry of the same branch in the current reflog entry, like a
> back pointer, then we could jump back faster.
> 
> Or do you have something else in mind? Current reflog structure won't
> work because I think you bring back the reflog graveyard with this,
> and I don't want to lose that

I hadn't really thought about having multiple formats for the index. But
in theory, yes, you could, and the lowest common denominator could just
use the filesystem. Or even something similar to the packed-refs file,
where we have to write the whole thing to make a single update. That
doesn't perform well, but it's dirt simple and might be OK if you have
only a handful of refs.

-Peff
