From: Jeff King <peff@peff.net>
Subject: Re: git commit -a reports untracked files after a clone
Date: Mon, 16 May 2011 10:55:35 -0400
Message-ID: <20110516145535.GA25930@sigill.intra.peff.net>
References: <7B399C74-8048-42BA-8672-9D7964F24888@goli.at>
 <7v39kgr5ln.fsf@alter.siamese.dyndns.org>
 <4501A58F-46F8-410C-BCEF-DD2FC10BC3A5@goli.at>
 <20110516103829.GA23889@sigill.intra.peff.net>
 <7C2AE1EE-4CAE-4E86-A53C-C97BE1F2573B@goli.at>
 <20110516120825.GA24418@sigill.intra.peff.net>
 <1D7CF554-A4AC-49EF-A095-9B05167BC458@goli.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Philipp Metzler <phil@goli.at>
X-From: git-owner@vger.kernel.org Mon May 16 16:55:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QLzCz-000678-Nl
	for gcvg-git-2@lo.gmane.org; Mon, 16 May 2011 16:55:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755812Ab1EPOzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2011 10:55:40 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60489
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755755Ab1EPOzk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2011 10:55:40 -0400
Received: (qmail 14953 invoked by uid 107); 16 May 2011 14:57:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 16 May 2011 10:57:39 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 May 2011 10:55:35 -0400
Content-Disposition: inline
In-Reply-To: <1D7CF554-A4AC-49EF-A095-9B05167BC458@goli.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173738>

On Mon, May 16, 2011 at 02:38:33PM +0200, Philipp Metzler wrote:

> Could be a race condition / heisenbug yep. The result of "git commit
> -a" differs - the directories vcs-svn and xdiff are there all the time
> but not the others. The only constant thing is that the command "git
> status" always "cleans up" everything. Another run:

OK, I'm making some progress. I can replicate on Linux with:

  $ git config core.ignorecase true
  $ git clone git foo
  $ cd foo && git commit -a

which gives a bunch of directories which contain tracked contents. Doing
"git status" makes the problem go away, but then doing this makes it
come back:

  $ rm .git/index
  $ git read-tree --reset HEAD

And like you, it doesn't trigger with "-uall".

So it is something about:

  1. A fresh index that is perhaps missing stat information for some
     entries.

  2. Stopping the traversal at the directory boundary rather than
     looking at details of each directory ("-uall").

  3. core.ignorecase

But it is definitely repeatable. Which is good, because that will make
it easier to track down. :)

I'll see what I can do, but it may not be today.

-Peff
