From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Git clone of a bundle fails, but works (somewhat) when run
 with strace
Date: Fri, 15 Feb 2013 23:01:09 -0500
Message-ID: <20130216040109.GA31630@sigill.intra.peff.net>
References: <511E8D84.6060601@gmail.com>
 <kfmclb$4ro$2@ger.gmane.org>
 <kfmide$4ro$3@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Alain Kalker <a.c.kalker@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 16 05:01:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U6Yy0-00085A-38
	for gcvg-git-2@plane.gmane.org; Sat, 16 Feb 2013 05:01:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027Ab3BPEBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Feb 2013 23:01:12 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49696 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab3BPEBM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2013 23:01:12 -0500
Received: (qmail 1513 invoked by uid 107); 16 Feb 2013 04:02:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 15 Feb 2013 23:02:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Feb 2013 23:01:09 -0500
Content-Disposition: inline
In-Reply-To: <kfmide$4ro$3@ger.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216371>

On Sat, Feb 16, 2013 at 12:03:58AM +0000, Alain Kalker wrote:

> ---test.sh---
> #!/bin/sh
> 
> make clean
> make || return 125
> GIT=$(pwd)/git
> 
> cd /tmp
> rm -rf testrepo
> mkdir testrepo
> cd testrepo
> $GIT init
> echo test > test.txt
> $GIT add test.txt
> $GIT commit -m "Add test.txt"
> $GIT bundle create ../testrepo.bundle master || return 125
> cd ..
> 
> rm -rf testrepofrombundle
> $GIT clone testrepo.bundle testrepofrombundle || return 1
> ---
> I was unable to find a bad revision.
> After a lot more searching I found that I had `git` aliased to `hub`, a 
> tool used to make Github actions easier.
> Eliminating `hub` from the equation resolved most problems.

Great.

> The only ones remaining are the confusing error message from `git bundle 
> create` and the "missing HEAD" (you can interpret that in different 
> ways) ;-)

I do not see any odd message from "bundle create" in the recipe above.
Mine says:

$ git bundle create ../repo.bundle master
Counting objects: 3, done.
Writing objects: 100% (3/3), 209 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)

What you _might_ be seeing is the fact that the invocation above is
likely to be running two different versions of git under the hood. "git
bundle" will invoke "git rev-list", and it will use the first git in
your PATH, even if it is not $GIT. The proper way to test an un-installed
version of git is to use $YOUR_GIT_BUILD/bin-wrappers/git, which will
set up environment variables sufficient to make sure all sub-gits are
from the same version. Sometimes mixing versions can have weird results
(e.g., the new "git bundle" expects "rev-list" to have a particular
option, but the older version does not have it).

Secondly, I do get the same warning about HEAD:

  $ git clone repo.bundle repofrombundle
  Cloning into 'repofrombundle'...
  Receiving objects: 100% (3/3), done.
  warning: remote HEAD refers to nonexistent ref, unable to checkout.

but that warning makes sense. You did not create a bundle that contains
HEAD, therefore when we clone it, we do not know what to point HEAD to.
You probably wanted "git bundle create ../repo.bundle --all" which
includes both "master" and "HEAD".

It would be slightly more accurate to say "the remote HEAD does not
exist", rather than "refers to nonexistent ref".  It would perhaps be
nicer still for "git clone" to make a guess about the correct HEAD when
one is not present (especially in the single-branch case, it is easy to
make the right guess).

Patches welcome. In the meantime, you can clone with "-b master" to tell
it explicitly, or you can "git checkout master" inside the newly-cloned
repository.

-Peff
