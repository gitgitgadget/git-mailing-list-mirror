From: Jeff King <peff@peff.net>
Subject: Re: error: Unable to append to
	.git/logs/refs/remotes/origin/master: Permission denied
Date: Tue, 28 Apr 2009 23:29:43 -0400
Message-ID: <20090429032943.GB8826@coredump.intra.peff.net>
References: <20090428073138.GA9094@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Apr 29 05:29:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lz0Ub-00015m-Bq
	for gcvg-git-2@gmane.org; Wed, 29 Apr 2009 05:29:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751962AbZD2D3q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 23:29:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751790AbZD2D3q
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 23:29:46 -0400
Received: from peff.net ([208.65.91.99]:59009 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751403AbZD2D3p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 23:29:45 -0400
Received: (qmail 2497 invoked by uid 107); 29 Apr 2009 03:29:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 28 Apr 2009 23:29:58 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Apr 2009 23:29:43 -0400
Content-Disposition: inline
In-Reply-To: <20090428073138.GA9094@elte.hu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117843>

On Tue, Apr 28, 2009 at 09:31:38AM +0200, Ingo Molnar wrote:

>  aldebaran:~/git> git pull
>  error: Unable to append to .git/logs/refs/remotes/origin/master: Permission denied
>  From e2:git
>   ! 66996ec..95110d7  master     -> origin/master  (unable to update local ref)
>   * [new tag]         v1.6.3-rc2 -> v1.6.3-rc2
>  error: some local refs could not be updated; try running
>   'git remote prune origin' to remove any old, conflicting branches
> 
> Obviousy Git cannot update the ref there so the failure is OK, but 
> the git-remote advice it gives is confusing IMHO: the 'git remote 
> prune origin' cannot fix anything. (and it is clear from the fetch 
> permission failure that there's no chance to fix anything here.)
> 
> I suspect there are other, more typical failure modes where that 
> advice is useful - just wanted to point out that it's confusing 
> here.

Yeah, I knew that when I wrote it:

  $ git log -1 --format=%s%n%b f3cb169
  fetch: give a hint to the user when local refs fail to update
  There are basically two categories of update failures for
  local refs:

    1. problems outside of git, like disk full, bad
       permissions, etc.

    2. D/F conflicts on tracking branch ref names

  In either case, there should already have been an error
  message. In case '1', hopefully enough information has
  already been given that the user can fix it. In the case of
  '2', we can hint that the user can clean up their tracking
  branch area by using 'git remote prune'.

  Note that we don't actually know _which_ case we have, so
  the user will receive the hint in case 1, as well. In this
  case the suggestion won't do any good, but hopefully the
  user is smart enough to figure out that it's just a hint.

Note the repeated use of "hopefully". :) Maybe the earlier message is
too hidden to rely on. We might be able to get by with checking "errno"
for ENOTDIR after trying to lock the ref and using a different message,
but I don't know how portable that will be.

-Peff
