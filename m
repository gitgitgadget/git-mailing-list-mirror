From: Jeff King <peff@peff.net>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 16:41:22 -0400
Message-ID: <20110714204122.GB28548@sigill.intra.peff.net>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com>
 <20110714183710.GA26820@sigill.intra.peff.net>
 <7vmxgg38xz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 14 22:41:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhSiv-0004zh-Aj
	for gcvg-git-2@lo.gmane.org; Thu, 14 Jul 2011 22:41:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932160Ab1GNUlY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 16:41:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38907
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932075Ab1GNUlY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 16:41:24 -0400
Received: (qmail 11759 invoked by uid 107); 14 Jul 2011 20:41:49 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Jul 2011 16:41:49 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jul 2011 16:41:22 -0400
Content-Disposition: inline
In-Reply-To: <7vmxgg38xz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177175>

On Thu, Jul 14, 2011 at 01:26:32PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > There's also one other issue with generation numbers. How do you handle
> > grafts and object-replacement refs?  If you graft history, your embedded
> > generation numbers will all be junk, and you can't trust them.
> 
> By the way, I doubt your "invalidate and recompute generation cache when
> replacement changes" would really work when we consider object transfer
> (which is the whole point of deprecating graft with object replacement
> mechanism). For the purpose of connectivity check during object transfer,
> we deliberately _ignore_ the object replacements, so you would at least
> want to have an ability to show the generation number according to the
> "true" history recorded in commits (which can come from Linus's in-commit
> generation number once everybody migrates) and the generation number that
> takes grafts and replacements into account (for which we cannot depend on
> in-commit record).

It should actually work in that scenario, at least with replace refs,
but the performance is suboptimal. The copy of git doing the object
transfer will turn off read_replace_refs, our validity token will
not match, we will see that our cache is no longer valid, and
regenerate it. Another run with replace-refs turned on will do the same
thing in reverse. Even two programs running simultaneously will still be
correct, because the cache is replaced atomically.

However, there are two issues:

  1. I don't think grafts have a "respect grafts" flag in the same way;
     I haven't looked at how the packing code decides not to respect
     them, but the "stir graft info into the checksum" data should use
     the same check.

  2. If you do a lot of object transfer, you will ping-pong back and
     forth between cache versions, which is inefficient. It would
     probably be better to store the cache that is valid under condition
     $SHA1 as:

       .git/cache/generations/$SHA1

     In most cases, you would have a single file (i.e., you are not
     using replace refs at all). But if you did, then you keep two
     separate caches, one for the view from replace-refs, and one for
     the standard view.

If we ignore replace refs and grafts, as Linus suggested, and always
store the true generation number, then we could generate it at pack time
(and even put it in the pack index if we want to deal with a version
bump there).

-Peff
