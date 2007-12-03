From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Sun, 2 Dec 2007 21:13:33 -0500
Message-ID: <20071203021333.GC8322@coredump.intra.peff.net>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org> <20071202212224.GA22117@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 03:14:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Iz0oq-0006ia-8A
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 03:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbXLCCNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Dec 2007 21:13:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbXLCCNg
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Dec 2007 21:13:36 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4325 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034AbXLCCNg (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2007 21:13:36 -0500
Received: (qmail 25284 invoked by uid 111); 3 Dec 2007 02:13:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Dec 2007 21:13:34 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Dec 2007 21:13:33 -0500
Content-Disposition: inline
In-Reply-To: <20071202212224.GA22117@midwinter.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66843>

On Sun, Dec 02, 2007 at 01:22:24PM -0800, Steven Grimm wrote:

> 	Since Junio's main objection to this seemed to be the protocol
> 	change to bypass the automatic update of the tracking ref in
> 	git-send-pack, that code is gone (thus reverting this to the
> 	same code change as the initial version!) and I added a section
> 	to the git-send-pack manual page describing the automatic
> 	tracking ref update behavior, which wasn't documented at all
> 	before. Someone please review my terminology there.

I am dubious of the usefulness of passing back the new commit id, but an
"ok, but btw I changed your commit" status from receive-pack seems like
it would be useful, for two reasons:

  - it can be displayed differently, so the user is reminded to do a
    fetch afterwards
  - we can avoid updating the tracking ref, which makes it less likely
    to result in a non-fast forward fetch next time.  For example,
    consider:

      1. The remote master and my origin/master are at A.
      2. I make a commit B on top of A.
      3. I push B to remote, who rewrites it to B' on top of A. At the
         same time, I move my origin/master to B.
      4. I fetch, and get non-ff going from B to B'.

    If I had never written anything to my origin/master, it would be a
    fast forward. And obviously git handles it just fine, but it is more
    useful to the user during the next fetch to see A..B rather than
    B'...B.

-Peff
