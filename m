From: Jeff King <peff@peff.net>
Subject: [PATCH] pager: turn on "cat" optimization for DEFAULT_PAGER
Date: Tue, 3 Sep 2013 03:41:50 -0400
Message-ID: <20130903074150.GE3608@sigill.intra.peff.net>
References: <201308261957.r7QJvfjF028935@freeze.ariadne.com>
 <xmqqd2ozhhob.fsf@gitster.dls.corp.google.com>
 <201308281819.r7SIJmnh025977@freeze.ariadne.com>
 <xmqqr4dd8suz.fsf@gitster.dls.corp.google.com>
 <201308291541.r7TFfuJr023110@freeze.ariadne.com>
 <vpqsixsv6dq.fsf@anie.imag.fr>
 <201309030227.r832RmBd013888@freeze.ariadne.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: "Dale R. Worley" <worley@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Sep 03 09:41:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGlFN-0004yt-LM
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 09:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932516Ab3ICHlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 03:41:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:53049 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932502Ab3ICHlw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Sep 2013 03:41:52 -0400
Received: (qmail 21859 invoked by uid 102); 3 Sep 2013 07:41:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 03 Sep 2013 02:41:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Sep 2013 03:41:50 -0400
Content-Disposition: inline
In-Reply-To: <201309030227.r832RmBd013888@freeze.ariadne.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233703>

On Mon, Sep 02, 2013 at 10:27:48PM -0400, Dale R. Worley wrote:

> > I guess the "else" could and should be dropped. If you do so (and
> > possibly insert a blank line between the DEFAULT_PAGER case and the
> > "pager = NULL" case), you get a nice pattern
> > 
> > if (!pager)
> > 	try_something();
> > if (!pager)
> > 	try_next_option();
> 
> That's true, but it would change the effect of using "cat" as a value:
> "cat" as a value of DEFAULT_PAGER would cause git_pager() to return
> NULL, whereas now it causes git_pager() to return "cat".  (All other
> places where "cat" can be a value are translated to NULL already.)
> 
> This is why I want to know what the *intended* behavior is, because we
> might be changing Git's behavior, and I want to know that if we do
> that, we're changing it to what it should be.  And I haven't seen
> anyone venture an opinion on what the intended behavior is.

I'll venture my opinion. We should do this:

-- >8 --
Subject: pager: turn on "cat" optimization for DEFAULT_PAGER

If the user specifies a pager of "cat" (or the empty
string), whether it is in the environment or from config, we
automagically optimize it out to mean "no pager" and avoid
forking at all. We treat an empty pager variable similary.

However, we did not apply this optimization when
DEFAULT_PAGER was set to "cat" (or the empty string). There
is no reason to treat DEFAULT_PAGER any differently. The
optimization should not be user-visible (unless the user has
a bizarre "cat" in their PATH). And even if it is, we are
better off behaving consistently between the compile-time
default and the environment and config settings.

The stray "else" we are removing from this code was
introduced by 402461a (pager: do not fork a pager if PAGER
is set to empty., 2006-04-16). At that time, the line
directly above used:

   if (!pager)
	   pager = "less";

as a fallback, meaning that it could not possibly trigger
the optimization. Later, a3d023d (Provide a build time
default-pager setting, 2009-10-30) turned that constant into
a build-time setting which could be anything, but didn't
loosen the "else" to let DEFAULT_PAGER use the optimization.

Noticed-by: Dale R. Worley <worley@alum.mit.edu>
Suggested-by: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Signed-off-by: Jeff King <peff@peff.net>
---
 pager.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pager.c b/pager.c
index c1ecf65..fa19765 100644
--- a/pager.c
+++ b/pager.c
@@ -54,7 +54,7 @@ const char *git_pager(int stdout_is_tty)
 		pager = getenv("PAGER");
 	if (!pager)
 		pager = DEFAULT_PAGER;
-	else if (!*pager || !strcmp(pager, "cat"))
+	if (!*pager || !strcmp(pager, "cat"))
 		pager = NULL;
 
 	return pager;
-- 
1.8.4.2.g87d4a77
