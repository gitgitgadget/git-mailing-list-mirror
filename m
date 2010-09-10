From: Jeff King <peff@peff.net>
Subject: Re: git revert ignore whitespace
Date: Fri, 10 Sep 2010 11:24:34 -0400
Message-ID: <20100910152434.GA8891@sigill.intra.peff.net>
References: <14756.91.183.48.98.1284105472.squirrel@stevenleeuw.kwik.to>
 <20100910142114.GB6936@sigill.intra.peff.net>
 <15732.91.183.48.98.1284130451.squirrel@stevenleeuw.kwik.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Steven <redalert.commander@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 10 17:24:29 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ou5Sn-00077m-34
	for gcvg-git-2@lo.gmane.org; Fri, 10 Sep 2010 17:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753340Ab0IJPYX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Sep 2010 11:24:23 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:41537 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750891Ab0IJPYX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Sep 2010 11:24:23 -0400
Received: (qmail 24961 invoked by uid 111); 10 Sep 2010 15:24:20 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 10 Sep 2010 15:24:20 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Sep 2010 11:24:34 -0400
Content-Disposition: inline
In-Reply-To: <15732.91.183.48.98.1284130451.squirrel@stevenleeuw.kwik.to>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155934>

On Fri, Sep 10, 2010 at 04:54:11PM +0200, Steven wrote:

> > You could just manually do the revert. Something like:
> >
> >   git diff-tree -p $commit | git apply --ignore-whitespace
> >   git commit -m "revert '`git log -1 --format=%s $commit`'"
> 
> I had to modify the commands a bit to get it to work.
> Here they are:
> git diff-tree -p <commithash> | git apply --reverse --ignore-whitespace -C0
> git add <file(s)>
> git commit -m "revert '`git log -1 --format=%s $commit`'"
>
> The --reverse is necessary to revert a patch, I needed the -C0 parameter
> as well because the line above changed as well.

Oops. Yeah, obviously I just typed that straight into the email and did
not actually run it. :) The --reverse is definitely necessary. Using -C0
can help, but it can also be dangerous, as context lines help apply make
sure it's in the right spot.

> This was a fairly simple example, but I imagine it won't work at all with
> a larger history, especially with more changes in the relevant sections
> and additions/deletions. I believe git revert does take these into
> account?

Yeah, the question is really whether the reverse diff from the reverted
commit applies to your current tree. Nearby changes obviously make that
harder.

Once upon a time revert itself was implemented like this (see 045f82c,
which introduced revert and uses "diff | apply"). These days it is only
a little more complex. It uses the 3-way merge machinery, which should
do better with finding minimal conflicts when the context has changed,
and will do rename detection (and when the patch doesn't apply, will
actually put in conflict markers, which is a nice place to start with
resolving it).

Revert is written in C these days, but you can see the shell script
version using git-merge-recursive in contrib/examples/git-revert.sh.
However, I don't think there is an easy way to ask merge-recursive to
ignore whitespace changes.

-Peff
