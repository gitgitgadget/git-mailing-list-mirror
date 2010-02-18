From: Jeff King <peff@peff.net>
Subject: Re: RFD: best way to automatically rewrite a git DAG as a linear
 history?
Date: Thu, 18 Feb 2010 00:11:29 -0500
Message-ID: <20100218051129.GD10970@coredump.intra.peff.net>
References: <2cfc40321002171835j107d2cdcr5f7667d769bf391e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 18 06:11:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhyfq-0002By-G3
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 06:11:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750996Ab0BRFLd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Feb 2010 00:11:33 -0500
Received: from peff.net ([208.65.91.99]:57961 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867Ab0BRFLc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Feb 2010 00:11:32 -0500
Received: (qmail 26031 invoked by uid 107); 18 Feb 2010 05:11:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 18 Feb 2010 00:11:43 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Feb 2010 00:11:29 -0500
Content-Disposition: inline
In-Reply-To: <2cfc40321002171835j107d2cdcr5f7667d769bf391e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140297>

On Thu, Feb 18, 2010 at 01:35:07PM +1100, Jon Seymour wrote:

> Does the git toolset currently support rewriting a restricted git DAG
> as a linear history in a completely automated way?

Not really. It's a hard problem in the general case. Consider a history
like:

    B
   / \
  A   D
   \ /
    C

That is, two branches fork, each make a commit, and then merge. You want
something like:

  A--B--C'

If there is a merge conflict when making D, then you know that B and C
conflict. In this simple case, you can apply the same conflict
resolution used in D to the creation of C' (in other words, you use the
combined tree state given in D as the tree for C'). But what if C is a
string of commits? Some of the conflict resolution in D will be
applicable to some of the conflicts you will encounter when rebasing C,
but you don't know which.

One simple strategy would be to squash all side-branch development into
a single commit. So you would turn:

    B--C--D
   /       \
  A         H
   \       /
    E--F--G

into

  A--B--C--D--X

where X has the same tree as H, but contains all of the commit messages
of E, F, and G.

You are of course losing quite a bit of information there, but you
haven't really told us what your use case is, so I don't know whether
that's unacceptable or not.

-Peff
