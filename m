From: Jeff King <peff@peff.net>
Subject: Re: Bugs in git filter-branch (git replace related)
Date: Fri, 29 Jan 2016 01:18:20 -0500
Message-ID: <20160129061820.GB23106@sigill.intra.peff.net>
References: <loom.20160128T153147-396@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Anatoly Borodin <anatoly.borodin@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 07:18:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aP2O3-0000XT-2b
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 07:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751545AbcA2GSX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 01:18:23 -0500
Received: from cloud.peff.net ([50.56.180.127]:34158 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751381AbcA2GSX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 01:18:23 -0500
Received: (qmail 28835 invoked by uid 102); 29 Jan 2016 06:18:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jan 2016 01:18:23 -0500
Received: (qmail 28081 invoked by uid 107); 29 Jan 2016 06:18:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jan 2016 01:18:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jan 2016 01:18:20 -0500
Content-Disposition: inline
In-Reply-To: <loom.20160128T153147-396@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285063>

On Thu, Jan 28, 2016 at 02:46:40PM +0000, Anatoly Borodin wrote:

> The `git replace` makes the second commit empty (use the file content from
> the first commit). It should disappear after `git filter-branch`, but it
> doesn't happen.
> 
> Bug 1: the empty commit stays.

I'm not sure if this is a bug or not. The "empty commit" check works by
checking the tree sha1s, without doing a full diff respecting replace
refs.

You're expecting git to notice a tree change, even though it never even
examined the tree in the first place (because you didn't give it a tree
or index filter).

Try:

  git filter-branch --prune-empty --tree-filter true master

which will force git to go through the motions of checking out the
replaced content and re-examining it.

This will run much more slowly, as it actually touches the filesystem.
In the general case, it would be interesting if filter-branch (or a
similar tool) could "cement" replacement objects into place as
efficiently as possible. But I'm not sure whether that should be the
default mode for filter-branch.

> Bug 2: the replace refs are not ignored (they can epresent blobs, trees etc,
> but even if they represent commits - should they be rewritten?).

You told it "--all", which is passed to rev-list, where it means "all
refs". I agree that running filter-branch on refs/replace is probably
not going to yield useful results, but I'm not sure if it is
filter-branch's responsibility to second-guess the rev-list options.

Probably the documentation for filter-branch should recommend
"--branches --tags" instead of "--all", though.

-Peff
