From: Josh Triplett <josh@joshtriplett.org>
Subject: Re: Cloning a remote tag without using git-fetch-pack directly?
Date: Wed, 20 Apr 2011 00:27:20 -0700
Message-ID: <20110420072720.GC1790@feather>
References: <20110419222050.GA3304@feather>
 <20110420062653.GE28597@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jamey Sharp <jamey@minilop.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 20 09:27:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCRoz-0000Z5-Vw
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 09:27:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934Ab1DTH13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Apr 2011 03:27:29 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:56722 "EHLO
	relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753364Ab1DTH12 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2011 03:27:28 -0400
X-Greylist: delayed 32785 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Apr 2011 03:27:27 EDT
X-Originating-IP: 217.70.178.130
Received: from mfilter10-d.gandi.net (mfilter10-d.gandi.net [217.70.178.130])
	by relay4-d.mail.gandi.net (Postfix) with ESMTP id D77A5172070;
	Wed, 20 Apr 2011 09:27:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter10-d.gandi.net
Received: from relay4-d.mail.gandi.net ([217.70.183.196])
	by mfilter10-d.gandi.net (mfilter10-d.gandi.net [10.0.15.180]) (amavisd-new, port 10024)
	with ESMTP id 2MEtVmUpyM1j; Wed, 20 Apr 2011 09:27:24 +0200 (CEST)
X-Originating-IP: 50.43.15.19
Received: from feather (static-50-43-15-19.bvtn.or.frontiernet.net [50.43.15.19])
	(Authenticated sender: josh@joshtriplett.org)
	by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id 9EAF31720A9;
	Wed, 20 Apr 2011 09:27:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110420062653.GE28597@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171846>

On Wed, Apr 20, 2011 at 02:26:54AM -0400, Jeff King wrote:
> On Tue, Apr 19, 2011 at 03:20:53PM -0700, Josh Triplett wrote:
> 
> > Using fetch-pack, I can clone a single tag from a repository:
> > 
> > /tmp/testrepo$ git init
> > Initialized empty Git repository in /tmp/testrepo/.git/
> > /tmp/testrepo$ git fetch-pack /home/josh/src/linux-2.6/.git refs/tags/v2.6.12
> 
> I don't think there is any reason to use fetch-pack here instead of
> fetch. The latter will handle other non-git protocols like dumb http and
> git-over-http.
> 
> > However, I can't seem to find any way to convince git clone to do the
> > same thing for me.  git clone will clone a branch, but not a tag.
> > 
> > /tmp/testrepo$ git clone /home/josh/src/linux-2.6/.git -b refs/tags/v2.6.12
> > Cloning into linux-2.6...
> > done.
> > warning: Remote branch refs/tags/v2.6.12 not found in upstream origin, using HEAD instead
> 
> Right. There is no way to do what you want with clone. The "-b" option
> is not "just clone this one thing", it is "clone everything, but the
> branch I am interested in is ...". The fetch refspec remains
> "+refs/heads/*:refs/remotes/origin/*".

Oh, good to know; I hadn't yet figured out that -b didn't change the
refspec.

> To clone a subset of a repository, you have to do the init+fetch trick,
> as you did above.  If you want the configuration set up by clone, you
> can do that, too, with "git config". So the equivalent commands to the
> clone you want are:
> 
>   git init linux-2.6
>   cd linux-2.6
>   git config remote.origin.url /home/josh/src/linux-2.6
>   git config remote.origin.fetch refs/tags/v2.6.12
>   git fetch origin
> 
> We could make clone more flexible with respect to such things, but I
> don't know how useful that would be. A very small minority of power
> users want to use weird fetch refspecs, and it is simple enough to
> configure them manually, as above.

I'd certainly appreciate having a "git clone --refspec=..." or similar,
but thanks for suggesting fetch rather than fetch-pack!  I actually
don't always want the remote set up for this particular purpose, so
using fetch works out well.

> > On a different note, git fetch-pack seems to silently fail if asked to
> > fetch a remote tag which points at a tree object rather than a commit
> > object:
> > 
> > /tmp/testrepo$ git init
> > Initialized empty Git repository in /tmp/testrepo/.git/
> > /tmp/testrepo$ git fetch-pack /home/josh/src/linux-2.6/.git refs/tags/v2.6.12-tree
> > (1) /tmp/testrepo$ echo $?
> > 1
> 
> Did you mean v2.6.11-tree? There is no v2.6.12-tree in standard
> linux-2.6 repositories. So fetch-pack is failing because there are no
> matching refs to fetch. This works for me:
> 
>   $ git init
>   $ git fetch-pack /home/peff/compile/linux-2.6 refs/tags/v2.6.11-tree
>   remote: Counting objects...
>   ...
> 
> If you want better error messages, use the fetch porcelain:
> 
>   $ git init
>   $ git fetch /home/peff/compile/linux-2.6 refs/tags/v2.6.12-tree
>   fatal: Couldn't find remote ref refs/tags/v2.6.12-tree
>   fatal: The remote end hung up unexpectedly

Well, *that's* embarassing.  I thought I'd tested that with a couple of
other repositories and tree-tag objects, but apparently not.

Sadly, though, I still can't check out the result:

/tmp/linux-2.6$ git checkout FETCH_HEAD
fatal: Cannot switch branch to a non-commit.
(128) /tmp/linux-2.6$ git checkout -b master FETCH_HEAD
fatal: Cannot switch branch to a non-commit.

I guess I'd hoped for something similar to "detached HEAD" mode.

Based on this, I need still to switch to using faked commits rather than
trees.

- Josh Triplett
