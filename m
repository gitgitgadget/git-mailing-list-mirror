From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFC 1/3] send-pack: track errors for each ref
Date: Tue, 13 Nov 2007 17:30:06 -0500
Message-ID: <20071113223006.GA19032@sigill.intra.peff.net>
References: <20071113102500.GA2767@sigill.intra.peff.net> <20071113102709.GA2905@sigill.intra.peff.net> <20071113190447.GB3268@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 23:31:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Is4Hg-00054p-D9
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 23:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761027AbXKMWaM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Nov 2007 17:30:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761056AbXKMWaM
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Nov 2007 17:30:12 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4807 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761743AbXKMWaK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Nov 2007 17:30:10 -0500
Received: (qmail 24839 invoked by uid 111); 13 Nov 2007 22:30:08 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 13 Nov 2007 17:30:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Nov 2007 17:30:07 -0500
Content-Disposition: inline
In-Reply-To: <20071113190447.GB3268@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64896>

On Tue, Nov 13, 2007 at 08:04:47PM +0100, Alex Riesen wrote:

> > -	unsigned char force;
> > -	unsigned char merge;
> > +	unsigned char force : 1;
> > +	unsigned char merge : 1;
> > +	unsigned char nonff : 1;
> 
>         unsigned char fastforward : 1; ? ffwd?

I agree it is a little funny to have a negative flag, but it is the
exceptional case to be nonff, so I think it makes the code flow a little
better (you would just be asking for !ref->fastforward all the time). I
am fine with a more readable name.

> > +	unsigned char deletion : 1;
> > +	enum {
> > +		REF_STATUS_NONE = 0,
> > +		REF_STATUS_OK,
> > +		REF_STATUS_NONFF,
> 
> isn't it a duplication of nonff?

No. The nonff flag is "is this push a non-fast forward". The
REF_STATUS_NONFF state is "we didn't push because this is a nonff case".
So you can have nonff = 1 and status = REF_STATUS_OK, which means that
the push was forced (either by ->force, or args.force).

So perhaps a better name is REF_STATUS_REJECT_NONFF (or something longer
if NONFF is too non-obvious).

An alternative is that the deletion and nonff flags can be folded into
the status. But then checking for "is everything OK" becomes
non-obvious (it's something like REF_STATUS_NONFF_FORCED ||
REF_STATUS_DELETION_OK || REF_STATUS_PUSH_OK). I tried it that way and
found the code is a bit more readable by pulling those features away
from status (so status is "did we succeed, or did we fail, and if the
latter, for what reason?").

-Peff
