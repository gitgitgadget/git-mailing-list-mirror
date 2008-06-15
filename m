From: Jeff King <peff@peff.net>
Subject: Re: [Crash] git-push $remote $non_ref:$anything
Date: Sun, 15 Jun 2008 15:55:41 -0400
Message-ID: <20080615195541.GA7683@sigill.intra.peff.net>
References: <20080615193823.GA11218@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Sun Jun 15 21:56:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7yLA-0005Me-Ty
	for gcvg-git-2@gmane.org; Sun, 15 Jun 2008 21:56:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365AbYFOTzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jun 2008 15:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbYFOTzo
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Jun 2008 15:55:44 -0400
Received: from peff.net ([208.65.91.99]:1544 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751089AbYFOTzo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jun 2008 15:55:44 -0400
Received: (qmail 11342 invoked by uid 111); 15 Jun 2008 19:55:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 15 Jun 2008 15:55:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 15 Jun 2008 15:55:41 -0400
Content-Disposition: inline
In-Reply-To: <20080615193823.GA11218@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85111>

[cc'ing Daniel for remote.c advice]

On Sun, Jun 15, 2008 at 09:38:23PM +0200, Mike Hommey wrote:

> I somehow managed to get a segfault by running this:
> 
> git push origin non-existant-branch-name:non-existant-branch-name

Hmm. The problem is the ref-guessing code. Given "git push foo:bar",
when we try to figure out what "bar" means we first try to find
refs/heads/bar or refs/heads/bar on the remote. But if that fails, we
are pushing a new item, so we try to use the same prefix as what "foo"
resolved to (e.g., if "foo" is a branch, we make it "refs/heads/bar").

So if "foo" doesn't resolve, we end up dereferencing NULL as part of our
guess. And the fix is obvious and the patch is below.

But it kind of makes me wonder why we bother looking at the dst side of
the refspec at all, since the src has already failed. Is there a good
reason not to just bail from match_explicit when we can't resolve the
src?

---
diff --git a/remote.c b/remote.c
index 91e3b11..fd8c71a 100644
--- a/remote.c
+++ b/remote.c
@@ -920,7 +920,8 @@ static int match_explicit(struct ref *src, struct ref *dst,
 	case 0:
 		if (!memcmp(dst_value, "refs/", 5))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
-		else if((dst_guess = guess_ref(dst_value, matched_src)))
+		else if(matched_src &&
+			(dst_guess = guess_ref(dst_value, matched_src)))
 			matched_dst = make_linked_ref(dst_guess, dst_tail);
 		else
 			error("unable to push to unqualified destination: %s\n"
