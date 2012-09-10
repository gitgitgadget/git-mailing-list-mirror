From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] cherry-pick: Append -x line on separate paragraph
Date: Mon, 10 Sep 2012 12:27:54 -0400
Message-ID: <20120910162754.GD9435@sigill.intra.peff.net>
References: <7vmx136cdc.fsf@alter.siamese.dyndns.org>
 <1498324622.1357.1347113459304.JavaMail.root@bazinga.schuettel.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robin Stocker <robin@nibor.org>
X-From: git-owner@vger.kernel.org Mon Sep 10 18:28:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB6qO-0007D4-CC
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 18:28:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765Ab2IJQ2H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 12:28:07 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39740 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750706Ab2IJQ15 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 12:27:57 -0400
Received: (qmail 29402 invoked by uid 107); 10 Sep 2012 16:28:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 12:28:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 12:27:54 -0400
Content-Disposition: inline
In-Reply-To: <1498324622.1357.1347113459304.JavaMail.root@bazinga.schuettel.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205141>

On Sat, Sep 08, 2012 at 04:10:59PM +0200, Robin Stocker wrote:

> > > Maybe the solution is to detect if the original commit message
> > > ends with a trailer and in that case keep the existing behavior
> > > of not inserting a blank line?
> > 
> > Yeah, that sounds like a good change from "this makes the result
> > look better" point of view.
> 
> How do you think we could best detect a tailer? Check if all
> lines of the last paragraph start with /[\w-]+: /?

There is ends_rfc2822_footer() in builtin/commit.c, which is currently
used for adding Signed-off-by lines. It might make sense to factor that
out, and have a new:

  add_pseudoheader(struct strbuf *commit_message,
                   const char *header)

that would implement the same set of spacing rules for signed-off-by,
cherry-picked-from, and anything else we end up adding later.

I think pseudo-headers like these might also want duplicate suppression
of the final line, which could be part of that function. Note that you
would not want to suppress a duplicate line from the middle of the
trailer, since you might want to sign-off twice (e.g., you sign-off the
original, and then also the cherry-pick). But you would not want two
duplicate lines at the end saying "Signed-off-by: ...", and I believe
"git commit" already suppresses those duplicates.

> I'm going to work on this and submit a new version of the patch. The
> "Cherry-picked-from" change could then be made later on top of that.

Yay. This has come up more than once over the years, so I am glad to see
somebody working on it.

-Peff
