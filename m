From: Jeff King <peff@peff.net>
Subject: Re: message on no-args push to an empty repo
Date: Sun, 14 Mar 2010 16:54:09 -0400
Message-ID: <20100314205409.GB31564@coredump.intra.peff.net>
References: <2e24e5b91003121759k34ec294cl8a57ef22eda2bbf5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Sitaram Chamarty <sitaramc@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 21:54:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqupS-0001JZ-3Y
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 21:54:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932970Ab0CNUyV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Mar 2010 16:54:21 -0400
Received: from peff.net ([208.65.91.99]:44311 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754051Ab0CNUyU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Mar 2010 16:54:20 -0400
Received: (qmail 15804 invoked by uid 107); 14 Mar 2010 20:54:46 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 14 Mar 2010 16:54:46 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Mar 2010 16:54:09 -0400
Content-Disposition: inline
In-Reply-To: <2e24e5b91003121759k34ec294cl8a57ef22eda2bbf5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142155>

On Sat, Mar 13, 2010 at 07:29:21AM +0530, Sitaram Chamarty wrote:

> When someone is doing the *first* push to an empty remote repo, and
> they try to use the no-args "git push", they get this:
> 
> > No refs in common and none specified; doing nothing.
> > Perhaps you should specify a branch such as 'master'.
> > fatal: The remote end hung up unexpectedly
> > error: failed to push some refs to 'git@gitsrv:testsite.git'
> 
> This is a fairly clear message, except that by only mentioning the

Actually, I think that message could be improved in several ways. It
looks like it is triggered any time we have nothing to push. But "no
refs in common" is specifically about the matching behavior, which these
days may not even have been invoked (e.g., if I set push.default).

Also, since this is the error path, I don't see a problem in spending a
few extra cycles to come up with a more specific error message. In
particular, it may help users to distinguish between "you have no
commits" and "you have nothing matching". In the former case, there is
no useful push command to issue, and we should tell them so. In the
latter, they should probably issue "git push $remote HEAD".

And as you noted later, it doesn't really tell them what push command to
do at all. Any advice should probably be in the form of "try this
cut-and-pastable command."

> > $ git push master
> >
> > fatal: 'master' does not appear to be a git repository
> > fatal: The remote end hung up unexpectedly
> 
> The correct answer of course is "git push origin master", and yes I
> realise they should read the git-push manpage...

It would be nice if this message was better, too, but that is harder.
receive-pack generates the first line, and then just hangs up (and push
generates the second message). But the user can't even tell which end
produced what message.

It may be that we can give better advice from the pushing side if the
remote end hangs up unexpectedly before saying anything. But I suspect
there are a lot of corner cases for such advice (off the top of my head,
receive-pack wasn't found, ssh didn't connect, tcp didn't connect, bad
hostname, bad remote name, typo in git repository name, etc).

-Peff
