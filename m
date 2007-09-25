From: Jeff King <peff@peff.net>
Subject: Re: Q: howto rebase
Date: Tue, 25 Sep 2007 11:02:49 -0400
Message-ID: <20070925150249.GA27653@coredump.intra.peff.net>
References: <BAY105-F33DC84FACB8B66BFEB9EC8FFB70@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: lode leroy <lode_leroy@hotmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 17:03:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaBwC-0001f3-0Q
	for gcvg-git-2@gmane.org; Tue, 25 Sep 2007 17:03:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbXIYPCy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 11:02:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752776AbXIYPCy
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 11:02:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3215 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751976AbXIYPCx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 11:02:53 -0400
Received: (qmail 17088 invoked by uid 111); 25 Sep 2007 15:02:50 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 25 Sep 2007 11:02:50 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Sep 2007 11:02:49 -0400
Content-Disposition: inline
In-Reply-To: <BAY105-F33DC84FACB8B66BFEB9EC8FFB70@phx.gbl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59135>

On Tue, Sep 25, 2007 at 04:46:59PM +0200, lode leroy wrote:

> In "version B" I introduce the "fix c", but in "version D" I realize it 
> should have
> been in some other place. (commit D moves the fix to its proper place).
> A-B-C-D-E
>
> Now I want to 'rewrite history'.
> I would like to move commit D after B
> A-B-D'-C'-E
>
> and then fold the commits B and D' into a single commit.
> A-B'-C'-E
>
> I somehow managed to get this done using "rebase -i"
> by exchanging the 2 appropriate lines, and then deleting the second one,
> but I'd like to understand how to do this from the command line...

The essence of git rebase is "move these commits as if they had happened
off of a different base commit." The interactive mode of rebase is
considerably more powerful, in that it allows squashing, deleting, and
arbitrary reordering. To do solve your problem without using "rebase
-i", you could do this:

# make a new branch based on 'B', which is where we want to base our commits
git-checkout -b tmp B
# pick the changes from 'D', but don't commit
git-cherry-pick -n D
# redo 'B' with the new changes
git-commit --amend

now you have a graph like this:

A-B-C-D-E
 \
  \-B' <-- branch tip

so you need to rebase C-D-E on top of it (and rebase will realize that
'D' has already been applied), with:

  git-rebase --onto tmp B master

Converting this to the manpage terminology, "B" is your upstream, and
you want to grab all of the changes from "B" to your "master", but you
want to put them on the newly created B'. Which perhaps is a little
confusing, but that's because git-rebase was designed for a simpler
situation: you and some upstream repo both made commits that the other
doesn't have, and you want to pretend your work is based off of their
most recent version.

You can see that "rebase -i" is a lot more flexible for these sorts of
history re-writing schemes. If you really must do it without user
interaction, I suspect you could use a sed script as your $GIT_EDITOR.

-Peff
