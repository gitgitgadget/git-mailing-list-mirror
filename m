From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 08/12] initial_ref_transaction_commit(): function for
 initial ref creation
Date: Mon, 15 Jun 2015 14:57:46 -0400
Message-ID: <20150615185746.GB10080@peff.net>
References: <cover.1434206062.git.mhagger@alum.mit.edu>
 <19f421f504ae22538fd2a902840209c0799e67cb.1434206062.git.mhagger@alum.mit.edu>
 <xmqqy4jk95pw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Stefan Beller <sbeller@google.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 20:58:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4Za7-0006IQ-0H
	for gcvg-git-2@plane.gmane.org; Mon, 15 Jun 2015 20:58:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755867AbbFOS5x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Jun 2015 14:57:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:46375 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754453AbbFOS5t (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jun 2015 14:57:49 -0400
Received: (qmail 3476 invoked by uid 102); 15 Jun 2015 18:57:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Jun 2015 13:57:48 -0500
Received: (qmail 6289 invoked by uid 107); 15 Jun 2015 18:57:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Jun 2015 14:57:54 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Jun 2015 14:57:46 -0400
Content-Disposition: inline
In-Reply-To: <xmqqy4jk95pw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271708>

On Mon, Jun 15, 2015 at 11:39:07AM -0700, Junio C Hamano wrote:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
> > It would seem to make sense to add a test here that there are no
> > existing references, because that is how the function *should* be
> > used. But in fact, the "testgit" remote helper appears to call it
> > *after* having set up refs/remotes/<name>/HEAD and
> > refs/remotes/<name>/master, so we can't be so strict.
> 
> Is "testgit" so hard to fix (or so sacred to break) that we want to
> sacrifice the quality of this part that is nearer to the core?

I do not think "testgit" is sacred; it is there to serve the needs of
git and not the other way around. But we do have to stop and think
whether what "testgit" is doing is representative of what a real
remote-helper might do.

It has been a while since I touched the remote-helper code (and it has
always been under-documented and confusing, from my recollection), but I
think it is not "testgit" that is making the refs, but rather that
"import"-style helpers will feed a data stream to git-fast-import
(actually the transport code does it on behalf of the remote).

So "fast-import" creates the refs, and then "clone" later wants to
recreate them. IMHO this is not ideal[1]; we should have fast-import create
the objects and report the ref tips, which can then be relayed to clone.
But with the way the code works now, this is not about fixing "testgit",
but rather would break any "import"-style helper.

Take all of that with a grain of salt, though. I might be totally wrong
about how this part of the code works.

-Peff

[1] This may also be buggy for regular fetches. E.g., do we correctly
    respect "--force" (or lack thereof) and "+"-refspecs when importing?
    I am not sure, as I think we may pass enough information to the
    helper to handle this itself. But certainly if the responsibility
    for updating refs was always in the caller (clone or fetch), then it
    would follow the regular code path and Just Work.
