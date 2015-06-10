From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] clone: check if server supports shallow clones
Date: Wed, 10 Jun 2015 16:56:08 -0400
Message-ID: <20150610205607.GA25842@peff.net>
References: <1433961320-1366-1-git-send-email-adgar@google.com>
 <20150610190512.GB22800@peff.net>
 <CALkbG6+Xqw+giW3msUKYx4odFv+2GAi=C2t2d=6VjuFp0xpO0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com
To: Michael Edgar <adgar@google.com>
X-From: git-owner@vger.kernel.org Wed Jun 10 22:56:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2n2r-00073J-Rt
	for gcvg-git-2@plane.gmane.org; Wed, 10 Jun 2015 22:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965377AbbFJU4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2015 16:56:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:44456 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965170AbbFJU4N (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2015 16:56:13 -0400
Received: (qmail 23417 invoked by uid 102); 10 Jun 2015 20:56:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Jun 2015 15:56:12 -0500
Received: (qmail 32103 invoked by uid 107); 10 Jun 2015 20:56:15 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 Jun 2015 16:56:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Jun 2015 16:56:08 -0400
Content-Disposition: inline
In-Reply-To: <CALkbG6+Xqw+giW3msUKYx4odFv+2GAi=C2t2d=6VjuFp0xpO0w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271352>

On Wed, Jun 10, 2015 at 04:25:45PM -0400, Michael Edgar wrote:

> > On Wed, Jun 10, 2015 at 3:05 PM, Jeff King <peff@peff.net> wrote:
> > I see that do_fetch_pack checks server_supports("shallow"). Is that
> > enough to cover all fetch cases? And if it is, why does it not cover the
> > matching clone cases?
> > -Peff
> 
> Great question. I determined that the do_fetch_pack logic doesn't work for
> clones because it also checks is_repository_shallow(), which looks for the
> .git/shallow file (or the alternate file).
> 
> I considered changing clone to create an empty .git/shallow file or alternate,
> but it turns out that an empty shallow file is treated as no shallow file at
> all. Since at this stage in cloning we have nothing to put in the shallow file,
> it seemed like any other fix would require more substantial changes.

Hmm. Can we improve the check in do_fetch_pack? That is, do we have a
way of checking whether the _current_ fetch is going to make us shallow?
I don't see anything obvious (like a "depth" flag) passed into
do_fetch_pack, so I guess it is relying solely on global shallow state
that we've already set up? Or is it the case that "git fetch
--depth=" in a non-shallow repository does not properly check this flag?

If it turns out that "fetch --depth" is fine, and only "clone --depth"
is broken, I can certainly live with the patch you provided. But I think
we need to clarify that a bit in the commit message.

-Peff
