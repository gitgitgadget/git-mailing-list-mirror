From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git config: do not create .git/ if it does not exist yet
Date: Wed, 24 Feb 2016 05:31:52 -0500
Message-ID: <20160224103152.GA21448@sigill.intra.peff.net>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de>
 <20160224082657.GD12511@sigill.intra.peff.net>
 <20160224101403.GN1766@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Wed Feb 24 11:32:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYWkG-0004H6-EQ
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 11:32:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647AbcBXKcV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Feb 2016 05:32:21 -0500
Received: from cloud.peff.net ([50.56.180.127]:48204 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755755AbcBXKbz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 05:31:55 -0500
Received: (qmail 28413 invoked by uid 102); 24 Feb 2016 10:31:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 05:31:55 -0500
Received: (qmail 6983 invoked by uid 107); 24 Feb 2016 10:32:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 05:32:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 05:31:52 -0500
Content-Disposition: inline
In-Reply-To: <20160224101403.GN1766@serenity.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287194>

On Wed, Feb 24, 2016 at 10:14:03AM +0000, John Keeping wrote:

> On Wed, Feb 24, 2016 at 03:26:57AM -0500, Jeff King wrote:
> > On Wed, Feb 24, 2016 at 08:47:00AM +0100, Johannes Schindelin wrote:
> > 
> > > 	I cannot think of a way how to test this: all of the regression
> > > 	tests run inside Git's own worktree, and we cannot even assume
> > > 	that /tmp/ is outside of a worktree (or that it exists).
> > 
> > We could make the test conditional on whether we are in a repo. Anybody
> > who builds from a tarball, or who uses --root would then run the test.
> 
> Could we use GIT_CEILING_DIRECTORIES for this?  If it's set to
> TEST_OUTPUT_DIRECTORY won't that cover the in-tree and out-of-tree test
> cases?

Oh, right. That's much less nasty than my suggestion.

> We probably do still want Peff's REPOLESS prereq just in case someone is
> collecting test results in a repository,

We can create arbitrary hierarchies within the trash directory. So even
without removing the trash-dir .git, we could probably do:

  mkdir -p non-repo/foo &&
  (
	cd non-repo &&
	GIT_CEILING_DIRECTORIES=$(pwd) &&
	export GIT_CEILING_DIRECTORIES &&
	cd foo &&
	git config foo.bar baz
  )

or something. That should work everywhere.

> but I think that will see much
> better coverage than relying on people running tests from the tarball.

With mine I think we'd see coverage from git devs, as it works with
--root, too (and if you're not using --root with a RAM disk, I highly
recommend it for the speedup). But your suggestion is way better.

-Peff
