From: Jeff King <peff@peff.net>
Subject: Re: fast-import deltas
Date: Tue, 1 Apr 2014 07:45:03 -0400
Message-ID: <20140401114502.GA15549@sigill.intra.peff.net>
References: <20140401102554.GA32231@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Apr 01 13:45:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUx8B-0003Ft-Fi
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 13:45:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736AbaDALpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 07:45:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:51670 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752741AbaDALpI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 07:45:08 -0400
Received: (qmail 26243 invoked by uid 102); 1 Apr 2014 11:45:09 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 06:45:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 07:45:03 -0400
Content-Disposition: inline
In-Reply-To: <20140401102554.GA32231@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245583>

On Tue, Apr 01, 2014 at 07:25:54PM +0900, Mike Hommey wrote:

> I am currently prototyping a "native" mercurial remote handler for git,

For my own curiosity, how does this differ from what is in
contrib/remote-helpers/git-remote-hg?

> Would adding a fast-import command to handle deltas be considered useful
> for git? If so, what kind of format would be suitable?

It breaks fast-import's "lowest common denominator" data model that is
just passing commits and their contents over the stream. But we already
do that in other cases for the sake of performance. I think the
important thing is that the alternate formats are optional and enabled
by the caller with command-line options.

That being said, I foresee a few complications:

  1. Git needs to know the sha1 of the full object. So unless the
     generating script knows that ahead of time, git has to expand the
     delta immediately anyway (this could still be a win if we end up
     using a good delta from elsewhere rather than doing our own delta
     search, but I suspect it's not so big a win as if we can just blit
     the delta straight to disk).

  2. Git does not store on-disk deltas between objects that are not in
     the same packfile. So you'd only be able to delta against an object
     that came in the same stream (or you'd have to "fix" the packfile
     on disk by adding an extra copy of the delta base, but that
     probably eliminates any savings).

As for format, I believe that git is basically xdelta under the hood, so
you'd want either that or something that can be trivially converted to
it.

-Peff
