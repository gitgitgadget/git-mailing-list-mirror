From: Jeff King <peff@peff.net>
Subject: Re: Confusing error message in rebase when commit becomes empty
Date: Fri, 13 Jun 2014 03:27:50 -0400
Message-ID: <20140613072749.GD7908@sigill.intra.peff.net>
References: <alpine.DEB.2.00.1406111321090.6307@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Peter Krefting <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Fri Jun 13 09:28:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WvLtz-00067I-UW
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jun 2014 09:27:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752857AbaFMH1w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2014 03:27:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:43233 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752491AbaFMH1v (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2014 03:27:51 -0400
Received: (qmail 9316 invoked by uid 102); 13 Jun 2014 07:27:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Jun 2014 02:27:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2014 03:27:50 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1406111321090.6307@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251524>

On Wed, Jun 11, 2014 at 01:49:04PM +0100, Peter Krefting wrote:

> Hi!
> 
> I am rebasing a branch to combine a couple of commits. One is a revert of a
> previous commit. Since there are commits in-between, I do "squash" to make
> sure I get everything, and then add the actual change on top of that. The
> problem is that rebase stops with a confusing error message (from commit,
> presumably):
> 
>   $ git rebase --interactive
>   [...]
>   You asked to amend the most recent commit, but doing so would make
>   it empty. You can repeat your command with --allow-empty, or you can
>   remove the commit entirely with "git reset HEAD^".
>   rebase in progress; onto 342b22f
>   You are currently rebasing branch 'mybranch' on '342b22f'.
> 
>   No changes
> 
>   Could not apply 4682a1f20f6ac29546536921bc6ea0386441e23e... Revert "something"
> 
> OK, so I should retry the command with --allow-empty, then:
> 
>   $ git rebase --interactive --allow-empty
>   error: unknown option `allow-empty'
> 
> Nope, that's not quite right.

Yeah, that message comes from "commit --amend", which is called by
rebase to handle the squash. The "repeat your command" part is
confusing. The right thing to do here is:

  git commit --amend --allow-empty

if you want to have an empty commit, or:

  git reset HEAD^

if you want to have nothing.

Of course the first one would never occur to you, because it is not
"your command" in the first place. :)

We could change it to say "use git commit --amend --allow-empty", though
that is slightly incomplete for other cases (e.g., you might have
actually said "git commit --amend -a", and the right advice is to
include that "-a".

Commit understands a "whence" flag that could let it customize the
message for the case of rebase. But I think you would have to teach
determine_whence to figure out that we are in a rebase.

> Running "git rebase --continue" does work as expected, but perhaps it just
> shouldn't stop in this case?

As you noticed later in the thread, doing "--continue" omits the revert.
That's because it is telling rebase "OK, I've fixed this up, we can keep
going". But of course it wasn't fixed.
