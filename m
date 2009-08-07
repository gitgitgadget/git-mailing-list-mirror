From: Jeff King <peff@peff.net>
Subject: Re: Performance issue of 'git branch'
Date: Fri, 7 Aug 2009 00:21:33 -0400
Message-ID: <20090807042132.GA14751@sigill.intra.peff.net>
References: <20090723160740.GA5736@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907230913230.21520@localhost.localdomain>
 <20090723165335.GA15598@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907231158280.21520@localhost.localdomain>
 <alpine.LFD.2.01.0907231212180.21520@localhost.localdomain>
 <20090723195548.GA28494@Pilar.aei.mpg.de>
 <alpine.LFD.2.01.0907241327410.3960@localhost.localdomain>
 <alpine.LFD.2.01.0907241346450.3960@localhost.localdomain>
 <alpine.LFD.2.01.0907241349390.3960@localhost.localdomain>
 <alpine.LFD.2.01.0907241505400.3960@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	"Carlos R. Mafra" <crmafra2@gmail.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Aug 07 06:21:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZGxY-0001Mg-Uk
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 06:21:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502AbZHGEVe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Aug 2009 00:21:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752448AbZHGEVe
	(ORCPT <rfc822;git-outgoing>); Fri, 7 Aug 2009 00:21:34 -0400
Received: from peff.net ([208.65.91.99]:57622 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752273AbZHGEVd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Aug 2009 00:21:33 -0400
Received: (qmail 6488 invoked by uid 107); 7 Aug 2009 04:23:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 07 Aug 2009 00:23:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 07 Aug 2009 00:21:33 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.01.0907241505400.3960@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125173>

On Fri, Jul 24, 2009 at 03:13:07PM -0700, Linus Torvalds wrote:

> Subject: [PATCH] git-http-fetch: not a builtin
> 
> We should really try to avoid having a dependency on the curl libraries
> for the core 'git' executable. It adds huge overheads, for no advantage.
> 
> This splits up git-http-fetch so that it isn't built-in.  We still do
> end up linking with curl for the git binary due to the transport.c http
> walker, but that's at least partially an independent issue.
>
> [...]
>
> +git-http-fetch$X: revision.o http.o http-push.o $(GITLIBS)
> +	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
> +		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)

Err, this seems to horribly break git-http-fetch (see if you can spot
the logic error in dependencies). Patch is below.

Nobody noticed, I expect, because nothing in git _uses_ http-fetch
anymore, now that git-clone is no longer a shell script. I only noticed
because it tried to build http-push on one of my NO_EXPAT machines.

It might be an interesting exercise to dust off the old shell scripts
once in a while and see if they still pass their original tests while
running on top of a more modern git. It would test that we haven't
broken the plumbing interfaces.

-- >8 --
Subject: [PATCH] Makefile: build http-fetch against http-fetch.o

As opposed to http-push.o. We can also drop EXPAT_LIBEXPAT,
since fetch does not need it.

This appears to be a bad cut-and-paste in commit 1088261f.

Signed-off-by: Jeff King <peff@peff.net>
---
 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 97d904b..d6362d3 100644
--- a/Makefile
+++ b/Makefile
@@ -1502,9 +1502,9 @@ http.o http-walker.o http-push.o: http.h
 
 http.o http-walker.o: $(LIB_H)
 
-git-http-fetch$X: revision.o http.o http-push.o $(GITLIBS)
+git-http-fetch$X: revision.o http.o http-fetch.o http-walker.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
-		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
+		$(LIBS) $(CURL_LIBCURL)
 git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
-- 
1.6.4.117.g6056d.dirty
