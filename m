From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 00/21] refs backend reroll
Date: Thu, 14 Jan 2016 04:26:14 -0500
Message-ID: <20160114092614.GA8533@sigill.intra.peff.net>
References: <1452561740-8668-1-git-send-email-dturner@twopensource.com>
 <xmqqbn8qqqfi.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 14 10:26:27 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aJeAi-0007ST-Sp
	for gcvg-git-2@plane.gmane.org; Thu, 14 Jan 2016 10:26:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbcANJ0U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2016 04:26:20 -0500
Received: from cloud.peff.net ([50.56.180.127]:53531 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753189AbcANJ0R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2016 04:26:17 -0500
Received: (qmail 12510 invoked by uid 102); 14 Jan 2016 09:26:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 04:26:17 -0500
Received: (qmail 5147 invoked by uid 107); 14 Jan 2016 09:26:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Jan 2016 04:26:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jan 2016 04:26:14 -0500
Content-Disposition: inline
In-Reply-To: <xmqqbn8qqqfi.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284023>

On Tue, Jan 12, 2016 at 04:22:09PM -0800, Junio C Hamano wrote:

> David Turner <dturner@twopensource.com> writes:
> 
> > This version incorporates many changes suggested by Michael Haggerty,
> > Junio, Jonathan Nieder, Eric Sunshine, and Jeff King. I think I have
> > addressed of the comments that were sent to me.  Those that I chose
> > not to incorporate, I responded to on the mailing list.
> >
> > Thanks for all of the feed back so far.
> 
> Unfortunately this did not compile for me X-< and with a trivial
> fix-up, I found that this overlaps with Peff's recent fixes to the
> locking of symbolic refs.  So for today's integration run, I punted.
> 
> I still will push out this topic to the broken-out repository I keep
> here:
> 
>     https://github.com/gitster/git
> 
> It's just 'pu' will not have this latest incarnation, but has the
> older one.

I took a look at David's changes. The conflicts come from "refs:
resolve symbolic refs first". I'm not sure I fully understand all that
is going on in that patch, but it looks like after it, we are less
likely to handle ENOTDIR and d/f conflicts for symrefs, as we skip that
whole code path for REF_ISSYMREF.

The rest of the conflicts are related to the fact that all of the
initial resolution is pulled out of lock_ref_sha1_basic(), and the
caller is supposed to do it. So I think if create_symref() is going to
call lock_ref_sha1_basic(), as in my series, when combined with David's
it should also be calling dereference_symrefs(). That uses a
ref_transaction, which we don't have in create_symref() right now, but
it makes sense that we would ultimately want to push symref updates
through the same transaction/backend system.

So sorry, I don't have a quick resolution to this. I'm hoping David can
make more sense of it than I did.

-Peff
