From: Jeff King <peff@peff.net>
Subject: Re: odd behavior with git-rebase
Date: Mon, 26 Mar 2012 15:56:19 -0400
Message-ID: <20120326195619.GB13098@sigill.intra.peff.net>
References: <20120323185205.GA11916@hmsreliant.think-freely.org>
 <20120323195455.GB15063@sigill.intra.peff.net>
 <CABURp0qeJEwELpg_YKxn9Ghb6EMphrwwfueM2XCqua3X_dacdA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Neil Horman <nhorman@tuxdriver.com>, git@vger.kernel.org
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 26 21:56:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SCG1i-0001yr-HR
	for gcvg-git-2@plane.gmane.org; Mon, 26 Mar 2012 21:56:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755188Ab2CZT4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Mar 2012 15:56:22 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60153
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753251Ab2CZT4V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2012 15:56:21 -0400
Received: (qmail 16521 invoked by uid 107); 26 Mar 2012 19:56:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 26 Mar 2012 15:56:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Mar 2012 15:56:19 -0400
Content-Disposition: inline
In-Reply-To: <CABURp0qeJEwELpg_YKxn9Ghb6EMphrwwfueM2XCqua3X_dacdA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193967>

On Mon, Mar 26, 2012 at 02:31:05PM -0400, Phil Hord wrote:

> Coincidentally I ran into this same behavior this week.  But what
> bothered me about it was the messages git gave me.  The empty commit
> gave me cherry-pick hints instead of rebase ones, including advising
> me to "use 'git reset'" to resolve the problem if I don't want this
> commit after all.
> 
> $ git rebase -i HEAD~10
> ...
> The previous cherry-pick is now empty, possibly due to conflict resolution.
> If you wish to commit it anyway, use:
> 
>     git commit --allow-empty
> 
> Otherwise, please use 'git reset'
> # Not currently on any branch.
> nothing to commit (working directory clean)
> Could not apply d513504... Some commit message
> 
> 
> I'm not sure if this is the norm or if it's a result of some other
> things I did in this sequence.  But I've seen it several times now.
> I've only tested it on 1.7.10 versions, including RC2.

This is easily reproducible on a simple test case:

  commit() {
    echo $1 >$1 && git add $1 && git commit -m $1 && git tag $1
  }

  git init repo &&
  cd repo &&
  commit one &&
  commit two &&
  git commit --allow-empty -m empty &&
  commit three &&
  git checkout -b fork one &&
  commit four &&
  git rebase -i fork master
  git --no-pager log --oneline

(this is the same test case I used without "-i" to check the rebase
skipping behavior).

I agree the mention of cherry-pick is a little confusing. I think the
advice to use "git commit --allow-empty" is still the right thing
(although better still would be to recognize that the commit was empty
in the first place and not stop at all). I think the message is showing
the fact that "rebase -i" is cobbled together from other pieces. I
wonder if the sequencer work would make this a little smoother (I
confess I have not paid much attention to what is happening in that
area).

-Peff
