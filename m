From: Jeff King <peff@peff.net>
Subject: Re: Possible segfault introduced in commit.c
Date: Wed, 25 Apr 2012 07:14:35 -0400
Message-ID: <20120425111435.GA21579@sigill.intra.peff.net>
References: <CANV9Rr_ev+34Wd030cps0UbgjRYD0=L2DQhbrCOkBVWG-2xaug@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Michael Mueller <mmueller@vigilantsw.com>
X-From: git-owner@vger.kernel.org Wed Apr 25 13:14:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SN0BN-0004n9-6p
	for gcvg-git-2@plane.gmane.org; Wed, 25 Apr 2012 13:14:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758150Ab2DYLOo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Apr 2012 07:14:44 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:44536
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754596Ab2DYLOn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Apr 2012 07:14:43 -0400
Received: (qmail 32671 invoked by uid 107); 25 Apr 2012 11:14:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 Apr 2012 07:14:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Apr 2012 07:14:35 -0400
Content-Disposition: inline
In-Reply-To: <CANV9Rr_ev+34Wd030cps0UbgjRYD0=L2DQhbrCOkBVWG-2xaug@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196307>

On Wed, Apr 25, 2012 at 12:59:28AM -0700, Michael Mueller wrote:

> As you might already know, we analyze git regularly with Sentry (our
> static analysis tool).  Today it picked up a new NULL pointer
> dereference in commit.c:366:
> 
>     void commit_list_reverse(struct commit_list **list_p)
>     {
>         struct commit_list *prev = NULL, *curr = *list_p, *next;
> 
>         if (!list_p)
>             return;
>         /* function continues... */
>     }
> 
> list_p is dereferenced on the first line, then tested for NULL on
> the very next statement.  If it's possible that list_p is NULL, this
> will be a segfault.  If it can't be NULL, then the check is
> unnecessary (and probably misleading).

Yes, you're right. There is only one caller currently, and it can never
be NULL (it passes the address-of a pointer variable). I think dropping
the NULL-check is the right thing; even an empty list will still have a
pointer to its NULL head.

-Peff
