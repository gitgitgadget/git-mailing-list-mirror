From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] archive: let remote clients get reachable commits
Date: Fri, 22 Feb 2013 13:26:54 -0500
Message-ID: <20130222182654.GA18934@sigill.intra.peff.net>
References: <1361456643-51851-1-git-send-email-gurugray@yandex.ru>
 <20130221155208.GA19943@sigill.intra.peff.net>
 <995301361532360@web22h.yandex.ru>
 <7vehg8s295.fsf@alter.siamese.dyndns.org>
 <20130222172710.GB17475@sigill.intra.peff.net>
 <7vfw0odxz3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sergey Sergeev <gurugray@yandex.ru>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 19:27:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U8xL9-0004qI-AX
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 19:27:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758223Ab3BVS05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 13:26:57 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57277 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758184Ab3BVS04 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 13:26:56 -0500
Received: (qmail 7021 invoked by uid 107); 22 Feb 2013 18:28:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 22 Feb 2013 13:28:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Feb 2013 13:26:54 -0500
Content-Disposition: inline
In-Reply-To: <7vfw0odxz3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216849>

On Fri, Feb 22, 2013 at 10:06:56AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > How are you proposing to verify master~12 in that example? Because
> > during parsing, it starts with "master", and we remember that?
> 
> By not cheating (i.e. using get_sha1()), but making sure you can
> parse "master" and the adornment on it "~12" is something sane.

So, like these patches:

  http://article.gmane.org/gmane.comp.version-control.git/188386

  http://article.gmane.org/gmane.comp.version-control.git/188387

? They do not allow arbitrary sha1s that happen to point to branch tips,
but I am not sure whether that is something people care about or not.

> That is why I said "this is harder than one would naively think, but
> limiting will make it significantly easier".  I didn't say that it
> would become "trivial", did I?

I'm not implying it would be trivial. It was an honest question, since
you did not seem to want to do the pass-more-information-out-of-get-sha1
approach last time this came up.

Even though those patches above are from me, I've come to the conclusion
that the best thing to do is to harmonize with upload-pack. Then you
never have the "well, but I could fetch it, so why won't upload-archive
let me get it" argument. Something like:

  1. split name at first colon (like we already do)

  2. make sure the left-hand side is reachable according to the same
     rules that upload-pack uses. Right we just say "is it a ref". It
     should be:

      2a. if it is a commit-ish, is it reachable from a ref?

      2b. otherwise, is it pointed to directly by a ref?

  3. Abort if it's not reachable. Abort if it's not a tree-ish. No
     checks necessary on the right-hand side, because a path lookup in a
     tree-ish is always reachable from the tree-ish. I.e., the same rule
     we have now.

I did not check if upload-pack will respect a "want" line for an object
accessible only by peeling a tag. But an obvious 2c could be "is it
accessible by peeling the refs?"

That leaves the only inaccessible thing as direct-sha1s of trees and
blobs that are reachable from commits. But you also cannot ask for those
directly via upload-pack, and I do not think it's worth it to do the
much more expensive reachability check to verify those (OTOH, it is no
more expensive than the current "counting objects" for a clone, and we
could do it only as a fallback when cheaper checks do not work).

-Peff
