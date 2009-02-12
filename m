From: Jeff King <peff@peff.net>
Subject: Re: [topgit] tg update error
Date: Thu, 12 Feb 2009 07:56:21 -0500
Message-ID: <20090212125621.GB5397@sigill.intra.peff.net>
References: <cc723f590902120009w432f5f61xd6550409835cdbb7@mail.gmail.com> <20090212084811.GA14261@piper.oerlikon.madduck.net> <20090212092558.GB21074@skywalker>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Aneesh Kumar <aneesh.kumar@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, madduck@debian.org,
	git@vger.kernel.org
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
X-From: git-owner@vger.kernel.org Thu Feb 12 13:57:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXb8f-0006nP-Qt
	for gcvg-git-2@gmane.org; Thu, 12 Feb 2009 13:57:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758679AbZBLM40 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Feb 2009 07:56:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756860AbZBLM40
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Feb 2009 07:56:26 -0500
Received: from peff.net ([208.65.91.99]:46939 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753608AbZBLM4Z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Feb 2009 07:56:25 -0500
Received: (qmail 8315 invoked by uid 107); 12 Feb 2009 12:56:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 12 Feb 2009 07:56:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Feb 2009 07:56:21 -0500
Content-Disposition: inline
In-Reply-To: <20090212092558.GB21074@skywalker>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109612>

On Thu, Feb 12, 2009 at 02:55:58PM +0530, Aneesh Kumar K.V wrote:

> On Thu, Feb 12, 2009 at 09:48:11AM +0100, martin f krafft wrote:
> > also sprach Aneesh Kumar <aneesh.kumar@gmail.com> [2009.02.12.0909 +0100]:
> > > doing a tg update with latest git gives the below error
> > >
> > > [extent_validate@linux-2.6]$ tg update
> > > fatal: Refusing to point HEAD outside of refs/heads/
> > > [extent_validate@linux-2.6]$
> >
> > Which version? And could you please provide (a lot) more information
> > about your repository or make it available?
> >
>
> Latest git and topgit. Moving to git version v1.6.1.3 fixed the issue.
> I can reproduce the problem on any test repo. Just do a tg update after
> committing something in the dependent branch.

This error message and safety valve are not in any released version of
git yet. So by moving back to 1.6.1.3, you are just predating the
addition of that message. :)

I think I know what is going on. A safety valve was added in afe5d3d to
disallow setting HEAD to anything that would violate git's "is this a
git directory" detector:

    symbolic ref: refuse non-ref targets in HEAD

    When calling "git symbolic-ref" it is easy to forget that
    the target must be a fully qualified ref. E.g., you might
    accidentally do:

      $ git symbolic-ref HEAD master

    Unfortunately, this is very difficult to recover from,
    because the bogus contents of HEAD make git believe we are
    no longer in a git repository (as is_git_dir explicitly
    checks for "^refs/heads/" in the HEAD target). So
    immediately trying to fix the situation doesn't work:

      $ git symbolic-ref HEAD refs/heads/master
      fatal: Not a git repository

    and one is left editing the .git/HEAD file manually.

Released versions of git just check "refs/" in HEAD. _But_ as part of
this patch series, b229d18 also tightened the "refs/" check to
"refs/heads/".

So what I suspect is happening is that topgit is trying to set HEAD to
"refs/top-bases/whatever". Aneesh, can you confirm by running your test
with GIT_TRACE=1?  I suspect you will see a call like "git symbolic-ref
HEAD refs/top-bases/foo".

Junio, I think we should probably revert b229d18 (and loosen
symbolic-ref's check to just "refs/"). Even if you want to argue that
topgit should be changed to handle this differently, we are still
breaking existing topgit installations, and who knows what other scripts
which might have relied on doing something like this.

-Peff
