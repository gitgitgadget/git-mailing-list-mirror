From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs
Date: Tue, 22 Apr 2008 06:56:58 -0400
Message-ID: <20080422105658.GA11238@sigill.intra.peff.net>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond> <20080409203453.GA10370@sigill.intra.peff.net> <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net> <20080413093102.GC12107@mithlond.arda.local> <20080416034823.GA11727@sigill.intra.peff.net> <alpine.LNX.1.00.0804161126280.19665@iabervon.org> <7vod89pnxx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Teemu Likonen <tlikonen@iki.fi>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 12:57:56 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoGC6-0005Z1-Jq
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 12:57:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759635AbYDVK5D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 06:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752866AbYDVK5C
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 06:57:02 -0400
Received: from peff.net ([208.65.91.99]:2411 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751843AbYDVK5A (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 06:57:00 -0400
Received: (qmail 11731 invoked by uid 111); 22 Apr 2008 10:56:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Apr 2008 06:56:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Apr 2008 06:56:58 -0400
Content-Disposition: inline
In-Reply-To: <7vod89pnxx.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80099>

On Wed, Apr 16, 2008 at 01:03:22PM -0700, Junio C Hamano wrote:

> > I was only working on making "HEAD" expand to HEAD:<current branch>. I 
> > think that the matching type is only most likely what you want, not 
> > certainly enough to just do it. I'd say that push should suggest it, but 
> > not actually do it automatically, or possibly require -f to do it without 
> > the full name.
> 
> Hmm.  `-f` means "I know there are the ones that do not fast forward but I
> want them updated", which is quite a different thing.  I'd say either we
> should just do it, or we don't, and keep `-f` orthogonal to the ref
> dwimming.

Hmm. I was kind of hoping other people would chime in with opinions on
the dwimmery, but clearly they didn't.

I agree that "-f" is a terrible idea here. Not only is it overloading
what "-f" does, but it's totally unnecessary. If we want to send a
message to the user to retry with different parameters, we can already
say: "try again with refs/heads/$foo".

The "refs/heads/" dwimmery makes sense to me, because:

  1. it changes a behavior which is currently an error condition, so
     we're not hurting anyone's existing workflow

  2. In my usage, pushing a branch to a tag (or vice versa) is the
     exception, so I don't mind favoring pushing like types to like
     types.

But I recognize that (2) is based on my own workflow, so if people
disagree, I guess it isn't so for everyone.

We should probably at least improve the message. Something like this is
perhaps a bit better, or it could even customize the suggestion based
on the source ref's type (i.e., implement the dwimmery, but don't
surprise anyone by doing it automatically).

-Peff

---
diff --git a/remote.c b/remote.c
index 06ad156..2151829 100644
--- a/remote.c
+++ b/remote.c
@@ -867,9 +867,12 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		if (!memcmp(dst_value, "refs/", 5))
 			matched_dst = make_linked_ref(dst_value, dst_tail);
 		else
-			error("dst refspec %s does not match any "
-			      "existing ref on the remote and does "
-			      "not start with refs/.", dst_value);
+			error("The destination refspec does not match any "
+			      "existing ref on the remote,\n"
+			      "and it does not specify a full refname; "
+			      "did you mean one of:\n"
+			      "    refs/heads/%s\n"
+			      "    refs/tags/%s\n", dst_value, dst_value);
 		break;
 	default:
 		matched_dst = NULL;
