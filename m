From: Jeff King <peff@peff.net>
Subject: Re: git clone (ssh://) skips detached HEAD
Date: Wed, 1 Jun 2011 18:05:18 -0400
Message-ID: <20110601220518.GA32681@sigill.intra.peff.net>
References: <BANLkTi=xK+hmvGTLnKREScABU=7v_SKqPQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Dmitry Ivankov <divanorama@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:05:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRtXd-0002Nj-EY
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 00:05:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755146Ab1FAWFW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 18:05:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:37121
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755098Ab1FAWFV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 18:05:21 -0400
Received: (qmail 18038 invoked by uid 107); 1 Jun 2011 22:05:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jun 2011 18:05:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2011 18:05:18 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTi=xK+hmvGTLnKREScABU=7v_SKqPQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174906>

On Thu, Jun 02, 2011 at 03:30:37AM +0600, Dmitry Ivankov wrote:

> For some reason git doesn't try to fetch detached HEAD object if it's
> not needed by needed heads.

The reason is that the default refspec on clone is:

  $ git config remote.origin.fetch
  +refs/heads/*:refs/remotes/origin/*

And HEAD is not under refs/heads/.

So you can do:

  git init test2 && cd test2
  git fetch ../test HEAD

if you want. So I don't think it's a bug that we don't fetch it, but...

> Steps to reproduce:
> git init test && cd test
> touch 1 && git add 1 && git commit -m 123
> touch 2 && git add 2 && git commit -m 345
> git reset --hard HEAD^
> git checkout HEAD@{1}
> 
> cd ../
> git clone ssh://127.0.0.1/`pwd`/test test2
> remote: Counting objects: 3, done.
> remote: Total 3 (delta 0), reused 0 (delta 0)
> Receiving objects: 100% (3/3), done.
> error: Trying to write ref HEAD with nonexistant object
> 91dbc2403853783f637744c31036f94a66084286
> fatal: Cannot update the ref 'HEAD'.

This is quite bad behavior. In addition to the ugly error messages, it
actually aborts the clone. So it is impossible to clone a repo with a
detached HEAD that is not otherwise referenced.

We basically have two choices:

  1. Fetch objects for HEAD on clone.

  2. Don't checkout a detached HEAD if we don't have the object (or
     possibly, don't checkout a detached HEAD at all; we already do
     something similar for the case of a HEAD that points to a bogus
     branch).

I think (2) is more consistent with the refspec we set up, but (1) is
probably more convenient to users (and better matches the case where the
remote is on a detached HEAD that _does_ point to something we have).

> HEAD seems to be treated in a special way in various places, so
> haven't found any easy patch to fix this.

I think it should just be a matter of adding HEAD to the list of things
we fetch, although we don't actually want to write it to a ref. I'll
take a look.

> And by the way, clone --no-hardlinks test test2 still goes to is_local
> codepath and avoids the bug.

Yeah. --no-hardlinks still avoids the git-transport; it just copies
instead of hardlinking. I saw you used ssh://localhost above to do your
test. You can also use file://$PWD/test to accomplish the same thing
without having to run an ssh daemon.

-Peff
