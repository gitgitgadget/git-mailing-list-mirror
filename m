From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] attr: don't confuse prefixes with leading directories
Date: Tue, 10 Jan 2012 14:32:06 -0500
Message-ID: <20120110193206.GA16826@sigill.intra.peff.net>
References: <20120110070300.GA17086@sigill.intra.peff.net>
 <4F0BFE6E.6080904@alum.mit.edu>
 <20120110171100.GA18962@sigill.intra.peff.net>
 <20120110180820.GA15273@sigill.intra.peff.net>
 <20120110182140.GB15273@sigill.intra.peff.net>
 <7vlipf9xbe.fsf@alter.siamese.dyndns.org>
 <20120110192810.GA16018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 20:32:19 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkhQd-0003dN-Vw
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 20:32:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932605Ab2AJTcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jan 2012 14:32:09 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33903
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932175Ab2AJTcI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jan 2012 14:32:08 -0500
Received: (qmail 13256 invoked by uid 107); 10 Jan 2012 19:39:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 Jan 2012 14:39:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2012 14:32:06 -0500
Content-Disposition: inline
In-Reply-To: <20120110192810.GA16018@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188284>

On Tue, Jan 10, 2012 at 02:28:10PM -0500, Jeff King wrote:

> On Tue, Jan 10, 2012 at 11:23:01AM -0800, Junio C Hamano wrote:
> 
> > > I'm not sure if the right solution is to change the popping loop to:
> > >
> > >   /* we will never run out of stack, because we always have the root */
> > >   while (attr_stack->origin) {
> > >           ...
> > 
> > Yeah, that makes sense, as that existing check "attr_stack &&" was a
> > misguided defensive coding, that was _not_ defensive at all as we didn't
> > do anything after we stop iterating from that loop and without checking
> > dereferenced attr_stack->origin, which was a simple bogosity.
> > 
> > >
> > > Or to be extra defensive and put:
> > >
> > >   if (!attr_stack)
> > >           die("BUG: we ran out of attr stack!?");
> > >
> > > after the loop, or to somehow handle the case of an empty attr stack
> > > below (which is hard to do, because it can't be triggered, so I have no
> > > idea what it would mean).
> > 
> > And this is even more so.
> 
> I wasn't clear: the second one is "even more so" making sense, or "even
> more so" misguided defensive coding?

If the latter, then I think we want this:

-- >8 --
Subject: [PATCH] attr: drop misguided defensive coding

In prepare_attr_stack, we pop the old elements of the stack
(which were left from a previous lookup and may or may not
be useful to us). Our loop to do so checks that we never
reach the top of the stack. However, the code immediately
afterwards will segfault if we did actually reach the top of
the stack.

Fortunately, this is not an actual bug, since we will never
pop all of the stack elements (we will always keep the root
gitattributes, as well as the builtin ones). So the extra
check in the loop condition simply clutters the code and
makes the intent less clear. Let's get rid of it.

Signed-off-by: Jeff King <peff@peff.net>
---
 attr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/attr.c b/attr.c
index fa975da..cf8f2bc 100644
--- a/attr.c
+++ b/attr.c
@@ -577,7 +577,7 @@ static void prepare_attr_stack(const char *path)
 	 * Pop the ones from directories that are not the prefix of
 	 * the path we are checking.
 	 */
-	while (attr_stack && attr_stack->origin) {
+	while (attr_stack->origin) {
 		int namelen = strlen(attr_stack->origin);
 
 		elem = attr_stack;
-- 
1.7.9.rc0.33.gd3c17
