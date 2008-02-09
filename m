From: Jeff King <peff@peff.net>
Subject: Re: Minor annoyance with git push
Date: Fri, 8 Feb 2008 21:46:36 -0500
Message-ID: <20080209024636.GE2572@coredump.intra.peff.net>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <alpine.LSU.1.00.0802081142060.11591@racer.site> <46a038f90802081427k6ee94cfagbc02533538e75b49@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 03:47:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNfkM-0000xH-PB
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 03:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752218AbYBICql (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 21:46:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752173AbYBICqk
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 21:46:40 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3123 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751386AbYBICqj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 21:46:39 -0500
Received: (qmail 7089 invoked by uid 111); 9 Feb 2008 02:46:38 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 08 Feb 2008 21:46:38 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2008 21:46:36 -0500
Content-Disposition: inline
In-Reply-To: <46a038f90802081427k6ee94cfagbc02533538e75b49@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73185>

On Sat, Feb 09, 2008 at 11:27:51AM +1300, Martin Langhoff wrote:

> Exactly. And we could show a nicer message - rejected is too strong a
> word ;-)

Like

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 454ad8f..3979918 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -315,7 +315,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count)
 				ref->peer_ref, NULL);
 		break;
 	case REF_STATUS_REJECT_NONFASTFORWARD:
-		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
+		print_ref_status('!', "[kindly refused]", ref, ref->peer_ref,
 				"non-fast forward");
 		break;
 	case REF_STATUS_REMOTE_REJECT:

?

> The local side has the remote refs if the client has fetched recently,
> so it might be able to tell in some cases. Not with authority (things
> may have changed on the server side...) but the client might be able
> to say something less alarming.

This is actually not that hard to do in the case that we can. Patch will
follow in a second, though I am not sure it is a good idea (because it
silently ignores pushing rewinds).

> > Another way to "solve" this issue, of course, is to use the remote layout.
> > I did the switchover myself some time ago; it was hard at first, since I
> > was so used to just check out the branches I just fetched.  But in the
> > long run the distinction between local and tracking branches made life
> > much easier for me.
> 
> What do you mean with "the remote layout"? I am using
> "remotes"+tracking branches as far as I can tell...

I think he means something like "if I have 'next' and 'origin/next',
then I should check whether 'next' is a subset of 'origin/next'" and
just say "nothing to send." But that suffers from the same "silently
ignoring rewinds" as above. You could ignore the push if you have
next exactly equal to origin/next, but that implies that you haven't done
any fetching (which is unlikely in the scenario you described).

-Peff
