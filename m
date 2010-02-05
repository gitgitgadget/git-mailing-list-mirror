From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] make git push --dry-run --porcelain exit with
 status 0 even if updates will be rejected
Date: Fri, 5 Feb 2010 15:13:25 -0500
Message-ID: <20100205201325.GA25697@coredump.intra.peff.net>
References: <20100205150638.GB14116@coredump.intra.peff.net>
 <1265398462-17316-3-git-send-email-larry@elder-gods.org>
 <20100205195644.GE24474@coredump.intra.peff.net>
 <20100205200524.GA24027@cthulhu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Larry D'Anna <larry@elder-gods.org>
X-From: git-owner@vger.kernel.org Fri Feb 05 21:13:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NdUYb-0002Gm-9x
	for gcvg-git-2@lo.gmane.org; Fri, 05 Feb 2010 21:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754699Ab0BEUN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Feb 2010 15:13:27 -0500
Received: from peff.net ([208.65.91.99]:45550 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753561Ab0BEUN0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2010 15:13:26 -0500
Received: (qmail 27778 invoked by uid 107); 5 Feb 2010 20:13:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 05 Feb 2010 15:13:29 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Feb 2010 15:13:25 -0500
Content-Disposition: inline
In-Reply-To: <20100205200524.GA24027@cthulhu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139077>

On Fri, Feb 05, 2010 at 03:05:24PM -0500, Larry D'Anna wrote:

> > So shouldn't it just be:
> > 
> >   if (args->porcelain && args->dry_run)
> >           return 0;
> > 
> > after we check for transport errors but before the loop that you are
> > modifying.
> 
> I don't know what the deal is with REF_STATUS_EXPECTING_REPORT, so I
> didn't want to modify the behavior in the case that ref->status was
> that.  What does expecting report mean?

It means we told the other side we wanted to push that ref, and we
expect it to give us a status report. Most refs are in that state for a
short period, and then moved to their final state in
builtin-send-pack.c:receive_status. But if we never get a status for
that ref for some reason, then that could be the final state.

But more to the point, I don't think this bit of code should _have_ to
care what it means. If there is a per-ref error with "push --dry-run
--porcelain", it will be shown on that ref's output line. So I think
your proposal should simply be "if dry-run and porcelain, don't bother
looking at per-ref errors at all". You don't care what the per-ref
error is; they are all in the same class from the perspective of this
change.

-Peff
