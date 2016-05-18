From: Jeff King <peff@peff.net>
Subject: [PATCH/RFC 0/6] pack-objects hook for upload-pack
Date: Wed, 18 May 2016 18:37:12 -0400
Message-ID: <20160518223712.GA18317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 19 00:37:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3A5i-0006D7-HL
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 00:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751757AbcERWhR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 18:37:17 -0400
Received: from cloud.peff.net ([50.56.180.127]:41559 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751641AbcERWhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 18:37:16 -0400
Received: (qmail 32285 invoked by uid 102); 18 May 2016 22:37:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 18:37:15 -0400
Received: (qmail 27598 invoked by uid 107); 18 May 2016 22:37:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 May 2016 18:37:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 May 2016 18:37:12 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295017>

I've often wanted to intercept the call from upload-pack to
pack-objects. The final patch in this series goes into more detail, but
basically it's good for:

  1. Capturing the output from pack-objects for debugging/inspection.

  2. Capturing the input to pack-objects to replay for debugging or
     performance analysis.

  3. Caching pack-objects output.

It's pretty trivial to add a hook to run instead of pack-objects (and
the hook would just run pack-objects itself). But we don't want to run
hooks in upload-pack, because we don't necessarily trust the repository
we're running in.

So instead we'd have to learn about the hook from the environment, or
from any of the non-repo config files. And that in turn requires some
support from the config code, which is what patches 1-5 are doing (along
with some cleanups along the way).

I think the config refactoring is all pretty sane, and could support
other "dangerous" features besides this particular hook in a way that's
easy to use for site admins (whether they trust the repos they're
serving or not). I've marked this "RFC" because I'd like input on some
details of the final patch; I'll point out my questions separately
there.

  [1/6]: git_config_with_options: drop "found" counting
  [2/6]: git_config_parse_parameter: refactor cleanup code
  [3/6]: config: set up config_source for command-line config
  [4/6]: config: return configset value for current_config_ functions
  [5/6]: config: add a notion of "scope"
  [6/6]: upload-pack: provide a hook for running pack-objects

-Peff
