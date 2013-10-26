From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 10/19] pack-bitmap: add support for bitmap indexes
Date: Sat, 26 Oct 2013 02:25:07 -0400
Message-ID: <20131026062507.GA23963@sigill.intra.peff.net>
References: <20131025055521.GD11810@sigill.intra.peff.net>
 <20131025060345.GH23098@sigill.intra.peff.net>
 <xmqqk3h1hrx0.fsf@gitster.dls.corp.google.com>
 <20131026002629.GA18324@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Vicent Marti <vicent@github.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 26 08:25:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZxJX-0003iS-4U
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 08:25:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751655Ab3JZGZM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 02:25:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:55941 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751475Ab3JZGZL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 02:25:11 -0400
Received: (qmail 7654 invoked by uid 102); 26 Oct 2013 06:25:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 26 Oct 2013 01:25:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 26 Oct 2013 02:25:07 -0400
Content-Disposition: inline
In-Reply-To: <20131026002629.GA18324@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236735>

On Fri, Oct 25, 2013 at 08:26:29PM -0400, Jeff King wrote:

> On Fri, Oct 25, 2013 at 04:06:19PM -0700, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > diff --git a/pack-bitmap.c b/pack-bitmap.c
> > > new file mode 100644
> > > index 0000000..73c52fd
> > > --- /dev/null
> > > +++ b/pack-bitmap.c
> > > @@ -0,0 +1,965 @@
> > > +#include <stdlib.h>
> > > +
> > > +#include "cache.h"
> > 
> > You among all people already know why this is bad, no?
> 
> Yes, I am well aware of why we do not want it. I thought I removed that,
> but it appears I missed one. Sorry.

In addition to that one, there are a few other system header includes:

  - the ewah/*.c files include the necessary standard headers, and do
    not include git-compat-util.h at all. I do not really consider these
    "git code", but rather a black box we have imported into the tree
    to ease the dependency chain. So in that sense, they operate like
    xdiff/*.c or compat/regex/*.c, which also compile on
    their own (and can get away with it because they are mostly standard
    C and do not do "system" things.

    However, the code in the ewah/ directory has been hacked up a bit
    from its original, and ewah_io.c _does_ include "git-compat-util.h".
    So it may make sense to consider our copy a fork and git-ify it
    more. The upstream Java EWAH library is active and separate, but the
    C port done by Vicent, while theoretically a separate project, does
    not actually have any users besides git (though presumably libgit2
    will build on it at some point).

  - Regardless of the decision above, ewah/ewok.h includes stdlib.h,
    which will pollute git source files which use it.

  - Ditto for khash.h.

-Peff
