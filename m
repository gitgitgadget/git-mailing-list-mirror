From: Jeff King <peff@peff.net>
Subject: Re: git push [rejected] question
Date: Mon, 18 Feb 2008 23:33:53 -0500
Message-ID: <20080219043353.GA23239@sigill.intra.peff.net>
References: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jason Garber <jgarber@ionzoft.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 05:34:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRKBb-0001a6-Cq
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 05:34:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbYBSEd5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 23:33:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752154AbYBSEd4
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 23:33:56 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1311 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752136AbYBSEd4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 23:33:56 -0500
Received: (qmail 18386 invoked by uid 111); 19 Feb 2008 04:33:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 18 Feb 2008 23:33:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 18 Feb 2008 23:33:53 -0500
Content-Disposition: inline
In-Reply-To: <E7DE807861E8474E8AC3DC7AC2C75EE50542F2F1@34093-EVS2C1.exchange.rackspace.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74374>

On Mon, Feb 18, 2008 at 04:15:01PM -0600, Jason Garber wrote:

> One of our users had this come up today.  He (on a different branch)
> did a push (successfully) earlier today.  Upon pushing some more
> changes this afternoon in the "Task/4919..." branch, the following
> message was received:

I think the user is missing one fundamental aspect of pushing: the
behavior of "git push" without any refspecs specified is to push all
matching refs (i.e., if you have branch refs/heads/Issue/Default and so
does the remote, then it will attempt to push). So no matter what branch
he is on when doing the push, it tries to push many such branches.

If you want to push just the current branch, try:

  git push origin HEAD

> [caleb@neon VOS4]$ git push
> Enter passphrase for key '/home/caleb/.ssh/id_rsa':
> To ssh://git@code.izrm.com/~/WhiteBoot4/VOS4-NEW
>  ! [rejected]        Issue/Default -> Issue/Default (non-fast forward)
>  ! [rejected]        Issue/Task_4831_MUP_Survey_Layout -> Issue/Task_4831_MUP_Survey_Layout (non-fast forward)
>  ! [rejected]        Task/4872-MUP-APlan-promotion -> Task/4872-MUP-APlan-promotion (non-fast forward)
>  <snip>
> error: failed to push to 'ssh://git@code.izrm.com/~/WhiteBoot4/VOS4-NEW'

These branches are rejected because he has local branches of the same
name that are _behind_ where the remote is. In other words, pushing
would roll back history, and therefore these pushes are rejected without
the '-f' option to force.

These branches get in this state through something like:

  # check out a local branch to match an upstream branch
  git checkout -b Issue/Default origin/Issue/Default
  # now hack on it or whatever
  hack hack hack
  build build build
  # and we're finished, so let's go back to another branch
  git checkout Task/4919...
  # time passes, and somebody else pushes changes to Issue/Default

And now at this point the user's Issue/Default is behind the remote's.
Pushing would roll back history, and so is rejected.

> However the branch in question was pushed successfully (despite the error message).
> 
> * Task/4919-MUP-Agent-ID-promotion         7e80ca6
>   origin/Task/4919-MUP-Agent-ID-promotion  7e80ca6

Yes, presumably that was in your <snip> section above. The "error:"
message is reported if pushing _any_ branch fails or is rejected. If you
are interested in pushing only the one branch, then you need to say so
explicitly.

-Peff
