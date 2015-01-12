From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] blame.c: fix garbled error message
Date: Mon, 12 Jan 2015 15:40:26 -0500
Message-ID: <20150112204025.GB9686@peff.net>
References: <1420925601-21615-1-git-send-email-git@cryptocrack.de>
 <xmqq4mrv95qt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lukas Fleischer <git@cryptocrack.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 21:40:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YAlmq-0005wT-EL
	for gcvg-git-2@plane.gmane.org; Mon, 12 Jan 2015 21:40:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbbALUk2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2015 15:40:28 -0500
Received: from cloud.peff.net ([50.56.180.127]:33414 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754011AbbALUk1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2015 15:40:27 -0500
Received: (qmail 5822 invoked by uid 102); 12 Jan 2015 20:40:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 14:40:26 -0600
Received: (qmail 20342 invoked by uid 107); 12 Jan 2015 20:40:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 12 Jan 2015 15:40:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Jan 2015 15:40:26 -0500
Content-Disposition: inline
In-Reply-To: <xmqq4mrv95qt.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262291>

On Mon, Jan 12, 2015 at 11:08:26AM -0800, Junio C Hamano wrote:

> Lukas Fleischer <git@cryptocrack.de> writes:
> 
> > The helper functions prepare_final() and prepare_initial() return a
> > pointer to a string that is a member of an object in the revs->pending
> > array. This array is later rebuilt when running prepare_revision_walk()
> > which potentially transforms the pointer target into a bogus string. Fix
> > this by maintaining a copy of the original string.
> >
> > Signed-off-by: Lukas Fleischer <git@cryptocrack.de>
> > ---
> > The bug manifests when running `git blame HEAD^ -- nonexistent.file`.
> 
> Before 1da1e07c (clean up name allocation in prepare_revision_walk,
> 2014-10-15), these strings used to be non-volatile; they were instead
> leaked more or less deliberately.  But these days, these strings are
> cleared, so your patch is absolutely the right thing to do.
> 
> Thanks for catching and fixing.  This fix needs to go to the 2.2.x
> maintenance track.

Yeah, agreed. Sorry for not catching this as part of 1da1e07c.

I did a grep for 'pending.*name' to look at any other potential problem
sites. It looks like blame is the only one that tries to retain a
long-lived pointer to the name.

The other potentially interesting spot is that they are fed to the
object callbacks from traverse_commit_list for tags. However, none of
the callbacks saves it (and it would not make much sense to do so; they
also receive broken-down filenames in the same way, so if they want to
use it at all, they feed it through path_name() first, which makes a
copy).

So I think Lukas's patch fixes everything (and his positioning of the
strdup() calls is right where I would have put them).

-Peff
