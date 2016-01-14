From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/21] refs backend reroll
Date: Thu, 14 Jan 2016 15:12:01 -0500
Message-ID: <20160114201201.GA1985@sigill.intra.peff.net>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
 <xmqqbn8qqqfi.fsf@gitster.mtv.corp.google.com>
 <20160114092614.GA8533@sigill.intra.peff.net>
 <1452788752.16226.17.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 21:12:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJoFg-0007HY-6O
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 21:12:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753414AbcANUMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 15:12:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:53886 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753314AbcANUME (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 15:12:04 -0500
Received: (qmail 7568 invoked by uid 102); 14 Jan 2016 20:12:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 15:12:03 -0500
Received: (qmail 11110 invoked by uid 107); 14 Jan 2016 20:12:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 15:12:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2016 15:12:01 -0500
Content-Disposition: inline
In-Reply-To: <1452788752.16226.17.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284084>

On Thu, Jan 14, 2016 at 11:25:52AM -0500, David Turner wrote:

> > I took a look at David's changes. The conflicts come from "refs:
> > resolve symbolic refs first". I'm not sure I fully understand all
> > that
> > is going on in that patch, but it looks like after it, we are less
> > likely to handle ENOTDIR and d/f conflicts for symrefs, as we skip
> > that
> > whole code path for REF_ISSYMREF.
> 
> We only get into the symref part of that codepath if there's already a
> symref present, meaning that d/f conflicts can't happen.

Ah, right, that makes sense.

> > The rest of the conflicts are related to the fact that all of the
> > initial resolution is pulled out of lock_ref_sha1_basic(), and the
> > caller is supposed to do it. So I think if create_symref() is going
> > to
> > call lock_ref_sha1_basic(), as in my series, when combined with
> > David's
> > it should also be calling dereference_symrefs(). That uses a
> > ref_transaction, which we don't have in create_symref() right now,
> > but
> > it makes sense that we would ultimately want to push symref updates
> > through the same transaction/backend system.
> 
> I don't think that's quite true.  create_symref *always* creates
> symrefs, and never creates underlying refs.  So it calls
> lock_ref_sha1_basic(), but since type_p is NULL, it doesn't go into the
> resolved-symlinks path; instead, we get into the original codepath.

I'm not sure in which version of the code you mean here. I guess in the
merged one, because in your original create_symref is still
pre-lock_ref_sha1_basic. But I think...

> I was totally convinced that we were doomed, but I think the stupid
> resolution basically works, with some minor tweaks.  I'm going to re
> -review that patch and resend the series (then go out of town until
> Tuesday).

...the best thing for me to do is wait and see your revised patch. :)

Thanks for looking into it.

> We will need to apply your new d/f conflict check to the LMDB backend's
> symref code (presently, it fails your new test), but I'm going to punt
> on that for now since d/f conflicts don't cause problems for the LMDB
> backend and this is a relatively minor case.  I've added a TODO to the
> code.

Makes sense.

-Peff
