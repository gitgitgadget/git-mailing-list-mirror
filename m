From: Jeff King <peff@peff.net>
Subject: Re: "git notes show" is orders of magnitude slower than doing it
 manually with ls-tree and cat-file
Date: Tue, 25 Nov 2014 20:34:57 -0500
Message-ID: <20141126013456.GA13622@peff.net>
References: <20141126004242.GA13915@glandium.org>
 <20141126010051.GA29830@peff.net>
 <20141126012448.GA11183@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Nov 26 02:35:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XtRVW-0002sW-Aj
	for gcvg-git-2@plane.gmane.org; Wed, 26 Nov 2014 02:35:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751289AbaKZBe6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Nov 2014 20:34:58 -0500
Received: from cloud.peff.net ([50.56.180.127]:45066 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750929AbaKZBe5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Nov 2014 20:34:57 -0500
Received: (qmail 18514 invoked by uid 102); 26 Nov 2014 01:34:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 19:34:57 -0600
Received: (qmail 3397 invoked by uid 107); 26 Nov 2014 01:34:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Nov 2014 20:34:56 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Nov 2014 20:34:57 -0500
Content-Disposition: inline
In-Reply-To: <20141126012448.GA11183@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260263>

On Tue, Nov 25, 2014 at 08:24:48PM -0500, Jeff King wrote:

> However, this is not what trees created by git-notes look like. It
> shards the object sha1s into subtrees (1a/2b/{36}), and I think does so
> dynamically in a way that keeps each individual tree size low. The
> in-memory data structure then only "faults in" tree objects as they are
> needed. So a single lookup should only hit a small part of the total
> tree.
> 
> Doing a single "git notes edit HEAD" in my case caused the notes code to
> write the result using its sharding algorithm. Subsequent "git notes
> show" invocations were only 14ms.
> 
> Did you use something besides git-notes to create the tree? From your
> examples, it looks like you were accounting for the sharding during
> lookup, so maybe this is leading in the wrong direction (but if so, I
> could not reproduce your times at all even with a much larger case).

Hmph. Having just written all that, I looked at your example again, and
you are running "git ls-tree -r", which would read the whole tree
anyway. So "git notes" should be _faster_ for a single lookup.

Something weird is definitely going on. Can you use "strace" or "perf"
to get a sense of where the time is going? Has your repository been
packed recently?

-Peff
