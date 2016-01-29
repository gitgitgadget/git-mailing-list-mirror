From: Jeff King <peff@peff.net>
Subject: Re: Bugs in git filter-branch (git replace related)
Date: Fri, 29 Jan 2016 18:11:27 -0500
Message-ID: <20160129231127.GA31798@sigill.intra.peff.net>
References: <loom.20160128T153147-396@post.gmane.org>
 <20160129061820.GB23106@sigill.intra.peff.net>
 <n8gao5$3c6$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Anatoly Borodin <anatoly.borodin@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 00:11:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPICW-0002gK-QG
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 00:11:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754919AbcA2XLc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2016 18:11:32 -0500
Received: from cloud.peff.net ([50.56.180.127]:34666 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754532AbcA2XLb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2016 18:11:31 -0500
Received: (qmail 29521 invoked by uid 102); 29 Jan 2016 23:11:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jan 2016 18:11:31 -0500
Received: (qmail 4849 invoked by uid 107); 29 Jan 2016 23:11:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jan 2016 18:11:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jan 2016 18:11:27 -0500
Content-Disposition: inline
In-Reply-To: <n8gao5$3c6$1@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285096>

On Fri, Jan 29, 2016 at 06:24:07PM +0000, Anatoly Borodin wrote:

> > You're expecting git to notice a tree change, even though it never even
> > examined the tree in the first place (because you didn't give it a tree
> > or index filter).
> 
> When git-filter-branch(1) says "If you have any grafts or replacement
> refs defined, running this command will make them permanent.", and it
> doesn't work like that because of some optimization, it *is* a bug.

I think the bug is in the documentation. That has always worked for
commit grafts and replacements, but never for blob and tree replacements
(and in fact, filter-branch quite predates refs/replace).

I don't think this is just an optimization; filter-branch does not touch
or rewrite bits that you did not ask it to touch, and that is a
user-visible behavior.

> Thank you, I've added this command to the script, and it works! I think
> it should be added to git-filter-branch(1), if there is no other way to
> rewrite the optimization.

Yeah, I agree.  Documentation patches are welcome.

I think with an "--index-filter", you could cement a replacement tree
into place, but you need a "--tree-filter" to do a blob replacement
(because otherwise we insert only the name of the blob sha1 into the
index).

> > You told it "--all", which is passed to rev-list, where it means "all
> > refs". I agree that running filter-branch on refs/replace is probably
> > not going to yield useful results, but I'm not sure if it is
> > filter-branch's responsibility to second-guess the rev-list options.
> 
> Look how `git log --all` works (see the second test in the script): it
> ignores (without any messages) the blobs, and writes only the commits.
> For example, the same commit log message is printed twice in the second
> testcase.

I'm not sure what you mean here. "git log --all" is not looking at blobs
at all (you did not ask it do any diffs, nor simplify history based on
TREESAME commits). The "--all" here means "start traversing from commits
found at all ref tips". It _does_ look at refs/replace, but there are no
commits to traverse there.

Likewise, "git rev-list --all" would not show any. But "git rev-list
--objects --all" would (both the refs/replace tips, as well as objects
reachable from the other commits).

> Maybe it makes sence, I don't know. I would suggest that all
> refs/replace/* heads should be ignored by `git log`. `git rev-list
> --no-replace` maybe?

It is too late for that without an extra option. "rev-list --all"
already has a well-established meaning, and changing it would break
other uses (e.g., commit reachability done during object transfer and
repacking, not to mention any third-party scripts). But...

> > Probably the documentation for filter-branch should recommend
> > "--branches --tags" instead of "--all", though.
> 
> Or redefine `--all` as "all refs excepting refs/replace/*". Who would
> really want to run `--all` the way it works now?

If you mean "rev-list --all", then: lots of things that aren't
filter-branch. :)

If we were to change anything, it would be to intercept "--all" in
filter-branch and rewrite it to "--exclude=refs/replace/* --all". I'm
slightly negative on that, just because we advertise filter-branch as
taking arbitrary rev-list args, and this is violating that. I think I'd
be more in favor if it were done robustly and clearly, like:

  - teach rev-list --all-does-not-include-refs-replace (but with a less
    horrible name)

  - advertise that filter-branch always passes that option to rev-list

Then at least it is robust (we are not mucking with rev-list options,
which we cannot do completely accurately without having the full
knowledge of all of its options), and simple to explain to the user (if
they want to work around it, they simple add "--glob=refs/replace/*" to
their invocation).

-Peff
