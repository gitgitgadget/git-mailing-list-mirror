From: Jeff King <peff@peff.net>
Subject: Re: Cloning a remote tag without using git-fetch-pack directly?
Date: Wed, 20 Apr 2011 02:26:54 -0400
Message-ID: <20110420062653.GE28597@sigill.intra.peff.net>
References: <20110419222050.GA3304@feather>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Jamey Sharp <jamey@minilop.net>
To: Josh Triplett <josh@joshtriplett.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 08:27:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCQse-0004an-RR
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 08:27:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413Ab1DTG05 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 02:26:57 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37232
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752202Ab1DTG04 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 02:26:56 -0400
Received: (qmail 16447 invoked by uid 107); 20 Apr 2011 06:27:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 20 Apr 2011 02:27:50 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Apr 2011 02:26:54 -0400
Content-Disposition: inline
In-Reply-To: <20110419222050.GA3304@feather>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171843>

On Tue, Apr 19, 2011 at 03:20:53PM -0700, Josh Triplett wrote:

> Using fetch-pack, I can clone a single tag from a repository:
> 
> /tmp/testrepo$ git init
> Initialized empty Git repository in /tmp/testrepo/.git/
> /tmp/testrepo$ git fetch-pack /home/josh/src/linux-2.6/.git refs/tags/v2.6.12

I don't think there is any reason to use fetch-pack here instead of
fetch. The latter will handle other non-git protocols like dumb http and
git-over-http.

> However, I can't seem to find any way to convince git clone to do the
> same thing for me.  git clone will clone a branch, but not a tag.
> 
> /tmp/testrepo$ git clone /home/josh/src/linux-2.6/.git -b refs/tags/v2.6.12
> Cloning into linux-2.6...
> done.
> warning: Remote branch refs/tags/v2.6.12 not found in upstream origin, using HEAD instead

Right. There is no way to do what you want with clone. The "-b" option
is not "just clone this one thing", it is "clone everything, but the
branch I am interested in is ...". The fetch refspec remains
"+refs/heads/*:refs/remotes/origin/*".

To clone a subset of a repository, you have to do the init+fetch trick,
as you did above.  If you want the configuration set up by clone, you
can do that, too, with "git config". So the equivalent commands to the
clone you want are:

  git init linux-2.6
  cd linux-2.6
  git config remote.origin.url /home/josh/src/linux-2.6
  git config remote.origin.fetch refs/tags/v2.6.12
  git fetch origin

We could make clone more flexible with respect to such things, but I
don't know how useful that would be. A very small minority of power
users want to use weird fetch refspecs, and it is simple enough to
configure them manually, as above.

> On a different note, git fetch-pack seems to silently fail if asked to
> fetch a remote tag which points at a tree object rather than a commit
> object:
> 
> /tmp/testrepo$ git init
> Initialized empty Git repository in /tmp/testrepo/.git/
> /tmp/testrepo$ git fetch-pack /home/josh/src/linux-2.6/.git refs/tags/v2.6.12-tree
> (1) /tmp/testrepo$ echo $?
> 1

Did you mean v2.6.11-tree? There is no v2.6.12-tree in standard
linux-2.6 repositories. So fetch-pack is failing because there are no
matching refs to fetch. This works for me:

  $ git init
  $ git fetch-pack /home/peff/compile/linux-2.6 refs/tags/v2.6.11-tree
  remote: Counting objects...
  ...

If you want better error messages, use the fetch porcelain:

  $ git init
  $ git fetch /home/peff/compile/linux-2.6 refs/tags/v2.6.12-tree
  fatal: Couldn't find remote ref refs/tags/v2.6.12-tree
  fatal: The remote end hung up unexpectedly

-Peff
