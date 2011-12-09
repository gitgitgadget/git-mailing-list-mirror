From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv2 0/13] credential helpers
Date: Fri, 9 Dec 2011 18:18:00 -0500
Message-ID: <20111209231800.GA14376@sigill.intra.peff.net>
References: <20111206062127.GA29046@sigill.intra.peff.net>
 <7v7h29fkfy.fsf@alter.siamese.dyndns.org>
 <20111207064231.GA499@sigill.intra.peff.net>
 <7vmxb2hhne.fsf@alter.siamese.dyndns.org>
 <20111209022913.GA2600@sigill.intra.peff.net>
 <7vzkf1fwvn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 10 00:18:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZ9ht-0005Hk-J6
	for gcvg-git-2@lo.gmane.org; Sat, 10 Dec 2011 00:18:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754905Ab1LIXST (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Dec 2011 18:18:19 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45431
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751698Ab1LIXSE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2011 18:18:04 -0500
Received: (qmail 9729 invoked by uid 107); 9 Dec 2011 23:24:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 09 Dec 2011 18:24:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Dec 2011 18:18:00 -0500
Content-Disposition: inline
In-Reply-To: <7vzkf1fwvn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186701>

On Fri, Dec 09, 2011 at 10:00:44AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It works, and it detects truncated output both ways properly (I know
> > because I had to update every test, since the old output was missing the
> > end-of-credential marker).
> >
> > It makes me a little sad, because the original format (relying on EOF)
> > was so Unix-y.
> 
> It saddens me, too.  A reasonable middle ground would be to stop treating
> an empty input as "no restriction" but "never matches".
> 
> I suspect that it is far more likely for a helper to fail (due to
> configuration errors, for example) before it produces any output than
> after it gives some but not all output lines.

Yeah, I think that's a reasonable compromise. Instead of the patch I
posted earlier, how about this:

diff --git a/credential-store.c b/credential-store.c
index a2c2cd0..26f7589 100644
--- a/credential-store.c
+++ b/credential-store.c
@@ -96,7 +96,16 @@ static void store_credential(const char *fn, struct credential *c)
 
 static void remove_credential(const char *fn, struct credential *c)
 {
-	rewrite_credential_file(fn, c, NULL);
+	/*
+	 * Sanity check that we actually have something to match
+	 * against. The input we get is a restrictive pattern,
+	 * so technically a blank credential means "erase everything".
+	 * But it is too easy to accidentally send this, since it is equivalent
+	 * to empty input. So explicitly disallow it, and require that the
+	 * pattern have some actual content to match.
+	 */
+	if (c->protocol || c->host || c->path || c->username)
+		rewrite_credential_file(fn, c, NULL);
 }
 
 static int lookup_credential(const char *fn, struct credential *c)


We _could_ modify credential_match() to automatically reject such a
pattern at that level, but it does actually have a use on the lookup
side. In config, a context like "https://example.com/foo.git" would
match each of:

  [credential "https://example.com/foo.git"]
          helper = ...
  [credential "https://example.com"]
          helper = ...
  [credential "https://"]
          helper = ...
  [credential]
          helper = ...

The final one is an just an extension of the others to the empty pattern
(you could also spell it [credential ""], and it would have the same
effect).

So the "empty pattern" does actually have a use, from the end-users's
point of view. It's just that with removal, it's a little more dangerous
and a little less likely to be useful (as compared to lookup).

-Peff
