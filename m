From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/17] Clean up how fetch_pack() handles the heads list
Date: Thu, 23 Aug 2012 05:26:24 -0400
Message-ID: <20120823092624.GG6963@sigill.intra.peff.net>
References: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Thu Aug 23 11:26:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4TgO-0008LF-Uz
	for gcvg-git-2@plane.gmane.org; Thu, 23 Aug 2012 11:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756919Ab2HWJ02 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Aug 2012 05:26:28 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46016 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753899Ab2HWJ00 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Aug 2012 05:26:26 -0400
Received: (qmail 19575 invoked by uid 107); 23 Aug 2012 09:26:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 23 Aug 2012 05:26:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Aug 2012 05:26:24 -0400
Content-Disposition: inline
In-Reply-To: <1345709442-16046-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204142>

On Thu, Aug 23, 2012 at 10:10:25AM +0200, mhagger@alum.mit.edu wrote:

> There were various confusing things (and a couple of bugs) in the way
> that fetch_pack() handled the list (nr_heads, heads) of references to
> be sought from the remote:

Aside from the minor comments I made to individual patches, this all
looks good. As usual, thanks for breaking it down; I wish all series
were as easy to review as this.

> I'm still suspicious about the logic related to args.fetch_all and
> args.depth, but I don't think I've made anything worse.

I think the point of that is that when doing "git fetch-pack --all
--depth=1", the meaning of "--all" is changed from "all refs" to
"everything but tags".

Which I kind of see the point of, because you don't want to grab ancient
tags that will be expensive. But wouldn't it make more sense to limit it
only to the contents of refs/heads in that case? Surely you wouldn't
want refs/notes, refs/remotes, or other hierarchies.

I suspect this code is never even run at all these days. All of the
callers inside git should actually provide a real list of refs, not
"--all". So it is really historical cruft for anybody who calls the
fetch-pack plumbing (I wonder if any third-party callers even exist;
this is such a deep part of the network infrastructure that any sane
scripts would probably just be calling fetch).

-Peff
