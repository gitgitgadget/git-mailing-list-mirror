From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] archive: loosen restrictions on remote object lookup
Date: Wed, 5 Jun 2013 12:38:23 -0400
Message-ID: <20130605163823.GE8664@sigill.intra.peff.net>
References: <20120111193916.GA12333@sigill.intra.peff.net>
 <20120111194232.GB12441@sigill.intra.peff.net>
 <loom.20130529T133942-310@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ian Harvey <iharvey@good.com>
X-From: git-owner@vger.kernel.org Wed Jun 05 18:38:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UkGjG-0006og-9D
	for gcvg-git-2@plane.gmane.org; Wed, 05 Jun 2013 18:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756109Ab3FEQi0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Jun 2013 12:38:26 -0400
Received: from cloud.peff.net ([50.56.180.127]:51953 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755288Ab3FEQiZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Jun 2013 12:38:25 -0400
Received: (qmail 31982 invoked by uid 102); 5 Jun 2013 16:39:12 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 05 Jun 2013 11:39:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Jun 2013 12:38:23 -0400
Content-Disposition: inline
In-Reply-To: <loom.20130529T133942-310@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226459>

On Wed, May 29, 2013 at 12:05:41PM +0000, Ian Harvey wrote:

> So, did this patch make it anywhere? We could really use it.
> 
> Here's the use case. The original ee27ca4 patch broke our build system when
> the git server was upgraded to Debian Wheezy last night. The builder fetches
> source from the repo in two pieces using git archive, and we need to make
> sure both pieces are from the same commit. So we get a sha1 hash with git
> ls-remote, and use it with git archive --remote. This, of course, breaks
> with the 'no such ref' error.

The patch you are responding to[1] would not help there, either. It does
not allow raw sha1s. The only way to do that would be:

  1. Add an option to the server to allow arbitrary sha1s, even if they
     are not reachable from the ref tips. This is an easy fix, but
     requires server admins to cooperate (and they may or may not want
     to lose the "you can only access reachable things policy".

  2. Actually do a reachability check. Doing a full object check to
     allow fetching an arbitrary tree by sha1 is probably prohibitively
     expensive[2], but we could allow the form "<commit>[:<path>]", check
     that "<commit>" is reachable, and then allow arbitrary paths within
     it.

> At the very least, the documentation is wrong when it talks about passing a
> commit ID to git archive: maintainers must surely agree that the
> documentation and the actual behavior ought to match.

I am not sure which documentation you mean. The part about "commit ID"
in the current manpage is drawing the distinction between something that
resolves to a commit versus something that resolves to a tree. Either is
available both locally and remotely. I think the use of the phrase
"commit ID" is questionable there, as it really means "something that
resolves to a commit", not "a sha1 commit ID". We used to use the phrase
"commit-ish" to refer to that, but I think it has fallen out of favor as
being too jargon-y.

The documentation does not mention at all the restrictions placed on
refs using "--remote", and it probably should.

-Peff

[1] http://article.gmane.org/gmane.comp.version-control.git/188387

[2] If we had a reachability bitmap cache, calculating arbitrary object
    reachability would actually be pretty cheap. But the bitmap feature
    for core git is not yet ready for prime-time, so I think we should
    not depend on it yet.
