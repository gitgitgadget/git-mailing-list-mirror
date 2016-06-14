From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] fetch: document that pruning happens before fetching
Date: Tue, 14 Jun 2016 06:22:10 -0400
Message-ID: <20160614102210.GA14357@sigill.intra.peff.net>
References: <20160613235850.GA8009@sigill.intra.peff.net>
 <CACsJy8Ds_DnBLJ0jx7Pp9EH1coG-xAtri4w4hh__=nigCmBbdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Tom Miller <jackerran@gmail.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 12:22:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bClUA-00016m-45
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 12:22:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752443AbcFNKWO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 06:22:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:54486 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752440AbcFNKWN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 06:22:13 -0400
Received: (qmail 18333 invoked by uid 102); 14 Jun 2016 10:22:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 06:22:13 -0400
Received: (qmail 26977 invoked by uid 107); 14 Jun 2016 10:22:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 06:22:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 06:22:10 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8Ds_DnBLJ0jx7Pp9EH1coG-xAtri4w4hh__=nigCmBbdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297280>

On Tue, Jun 14, 2016 at 04:36:59PM +0700, Duy Nguyen wrote:

> On Tue, Jun 14, 2016 at 6:58 AM, Jeff King <peff@peff.net> wrote:
> > This was changed in 10a6cc8 (fetch --prune: Run prune before
> > fetching, 2014-01-02), but it seems that nobody in that
> > discussion realized we were advertising the "after"
> > explicitly.
> 
> Ah... ok. Good to know it's moved up top on purpose because I almost
> tried to move it down :) It's irritating that current output looks
> like this
> 
> <delete ref>
> <delete ref>
> <delete ref>
> remote: <random progress lines>
> <update ref>
> <update ref>
> <update ref>
> 
> It probably looks better if we can move the <delete ref> part after
> "remote: ..." lines (iow still _after_ fetch, but _before_ ref
> updates), e.g.
> 
> remote: <random progress lines>
> <delete ref>
> <delete ref>
> <delete ref>
> <update ref>
> <update ref>
> <update ref>

I don't think it would be hard to do the deletion separate from the
status-printing (in the worst case, you could simply queue the list of
deleted refs and then print them later).

That might put the status lines for the deletions farther from any
errors or warnings we print when doing the actual deletions, but in
theory the error lines are self-contained and can stand on their own.

> If we do so, there's no need to update document. But I don't know,
> maybe it's not worth doing.

I think the documentation should be updated either way. This is not
about the ordering in the status table, but rather about the order of
the real operations. The user may care about that ordering if they want
to know what races are possible, or what would happen if the packfile
fetch failed (we'd already have deleted the old refs, but wouldn't fetch
the new ones).

-Peff
