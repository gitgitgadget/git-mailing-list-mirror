From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] wt-status: move #include "pathspec.h" to the header
Date: Thu, 20 Aug 2015 16:38:41 -0400
Message-ID: <20150820203841.GA12386@sigill.intra.peff.net>
References: <1440079587-26491-1-git-send-email-szeder@ira.uka.de>
 <xmqq61497pc1.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 20 22:38:49 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSWbo-0003Jj-K4
	for gcvg-git-2@plane.gmane.org; Thu, 20 Aug 2015 22:38:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752783AbbHTUio (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2015 16:38:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:47764 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752777AbbHTUin (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2015 16:38:43 -0400
Received: (qmail 25797 invoked by uid 102); 20 Aug 2015 20:38:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Aug 2015 15:38:43 -0500
Received: (qmail 27054 invoked by uid 107); 20 Aug 2015 20:38:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Aug 2015 16:38:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Aug 2015 16:38:41 -0400
Content-Disposition: inline
In-Reply-To: <xmqq61497pc1.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276265>

On Thu, Aug 20, 2015 at 12:05:34PM -0700, Junio C Hamano wrote:

> This is a tangent, but the above is different from saying that with
> a single liner test.c that has
> 
>     #include "wt-status.h"
> 
> your compilation "cc -c test.c" should succeed.  But for that goal,
> direct inclusion of <stdio.h> to wt-status.h is also iffy.  We
> include the system headers from git-compat-util.h because some
> platforms are picky about order of inclusion of system header files
> and definitions of feature test macros.
> 
> Right now, the codebase is correct only because it is NOT our goal
> to guarantee that such a single-liner test.c file compiles.
> Instead, everybody is instructed to #include "git-compat-util.h" as
> the first thing, either directly or indirectly.
> 
> So in that sense, we should also remove that inclusion from
> wt-status.h, I think.

Yeah, I think that is actively wrong. Running[1]:

  git grep '#include <' -- '*.h' ':!git-compat-util.h'

shows a few other weird ones. Things like zlib.h, pcre.h, etc, are
probably OK. They are not really "system" headers, and it is probably OK
as long as they come after git-compat-util (which they must, if they are
in a header file).

The inclusion of stdlib.h in compat/bswap.h is suspect (both are
included by git-compat-util itself). But it is inside an #ifdef _MSC_VER
block, so I cannot test that there is not some subtle interaction going
on.

A few headers include pthread.h. I would have thought that should go in
git-compat-util for the usual reasons, but nobody has complained (and
most files do not need it, though that has not generally stopped us from
making git-compat-util a catch-all for other system files).

-Peff

[1] Too bad I needed the "--" separator there. Recent git nicely learned
    to DWIM "*.h" as a pathspec, but we do not seem to give the same
    treatment to "magic" pathspecs.
