From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] builtin/blame.c::prepare_lines: fix allocation size of
 sb->lineno
Date: Sat, 8 Feb 2014 16:21:54 -0500
Message-ID: <20140208212154.GA4283@sigill.intra.peff.net>
References: <1391851166-10393-1-git-send-email-dak@gnu.org>
 <87lhxmc4sr.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Sat Feb 08 22:22:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WCFLd-0004qh-7y
	for gcvg-git-2@plane.gmane.org; Sat, 08 Feb 2014 22:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbaBHVV5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Feb 2014 16:21:57 -0500
Received: from cloud.peff.net ([50.56.180.127]:47162 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751487AbaBHVV4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Feb 2014 16:21:56 -0500
Received: (qmail 14384 invoked by uid 102); 8 Feb 2014 21:21:56 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (65.115.226.27)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 08 Feb 2014 15:21:56 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 08 Feb 2014 16:21:54 -0500
Content-Disposition: inline
In-Reply-To: <87lhxmc4sr.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241860>

On Sat, Feb 08, 2014 at 10:49:40AM +0100, David Kastrup wrote:

> But please note that since sb->lineno originally comes from a zeroed
> memory area and is passed to xrealloc, this requires that after
> 
> int *p;
> memset(&p, 0, sizeof(p));
> 
> the equivalence
> 
> ((void *)p == NULL)
> 
> will hold.  While this is true on most platforms, and while the C
> standard guarantees the slightly different
> ((void *)0 == NULL)
> is true, it makes no statement concerning the memory representation of
> the NULL pointer.
> 
> I have not bothered addressing this non-compliance with the C standard
> as it would be polishing a turd.  A wholesale replacement has already
> been proposed, and it's likely that this assumption is prevalent in the
> Git codebase elsewhere anyway.

Yes, we explicitly break this part of the standard in the name of
practicality (it simplifies frequently-used code, and machines on which
it matters are rare enough that nobody has ever complained about it).

So I do not think this is a problem.

However, is there a reason not to use:

  sizeof(*sb->lineno)

rather than

  sizeof(int)

to avoid type-mismatch errors entirely (this applies both to this patch,
and to any proposed rewrites using malloc).

-Peff
