From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [PATCH] push: don't guess at qualifying remote refs on deletion
Date: Thu, 05 Jul 2012 19:24:11 +0200
Message-ID: <1341509051.10752.34.camel@flaca.cmartin.tk>
References: <CAKON4OwnUKQ6MT8HBNDyfhZLZS5xGKA2Ss1krY9OQGG1gaFhDw@mail.gmail.com>
	 <7vsjd9wkek.fsf@alter.siamese.dyndns.org>
	 <CAKON4OxBo7XiF5c60oyEUMR1xCh16n5BZCz-mmcUc0V9X7D32A@mail.gmail.com>
	 <20120703180439.GC3294@sigill.intra.peff.net>
	 <CAKON4Oy0YBVTAhZPU=1B=yYY4t2O_uRWDW1zOMaC5iCb=kRQ2w@mail.gmail.com>
	 <20120703184018.GB5765@sigill.intra.peff.net>
	 <1341386512.3871.4.camel@flaca.cmartin.tk>
	 <CABURp0rVPAvxP1sp_nmoNYd+F+OsvWeHgUAeo7-VTnQhdebFeg@mail.gmail.com>
	 <1341472926.10752.5.camel@flaca.cmartin.tk>
	 <CABURp0r8EfShHVE-Vycz3g8-WPXFzs1-WOT7LRwh-XOuWVYG+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>,
	"jonsmirl@gmail.com" <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Phil Hord <phil.hord@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 05 19:24:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Smpmt-0000p4-0c
	for gcvg-git-2@plane.gmane.org; Thu, 05 Jul 2012 19:24:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645Ab2GERYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jul 2012 13:24:14 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:60663 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751184Ab2GERYN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jul 2012 13:24:13 -0400
Received: from [141.23.102.101] (unknown [141.23.102.101])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 1EFA146057;
	Thu,  5 Jul 2012 19:24:11 +0200 (CEST)
In-Reply-To: <CABURp0r8EfShHVE-Vycz3g8-WPXFzs1-WOT7LRwh-XOuWVYG+Q@mail.gmail.com>
X-Mailer: Evolution 3.4.3-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201053>

On Thu, 2012-07-05 at 11:32 -0400, Phil Hord wrote:
> 
> The possible enhancements to cover this I can think of are mostly in
> the form of enhanced help or advice.  For example, I could imagine
> these:
> 
> 1. Add a link to 'git push' on the 'git-branch' man page.   I suspect
> this is where newbies would go to look for this feature, but I am only
> guessing.  The git-branch help discusses deleting branches and even
> deleting remote-tracking branches.  But it does not discuss deleting
> branches on a remote repository, even to say "this is not the command
> you want" for that action, but "see this other one instead".

Yeah, that seems like a good addition.

> 
> 2. Add 'apropos' behavior for git help.
>    $ git apropos delete
> 
> Except I notice that the system 'apropos' does not turn up 'git-push'
> for either of these:
>    $ apropos delete
>    $ apropos branch

Huh, I don't think I've used apropos in years. I guess changing the
subject to include removing/deleting would be conceivable, but we still
have the issue that branches are a particular form of ref, which is what
push acts on.

> 
> 3. Add a search feature for help.  Currently this feature is provided
> instead by Google and StackOverflow.
>    $ git help --find delete --and branch --and remote
> Except I don't expect this "advanced" form of help, if it existed, to
> be noticed by newbies early enough on the learning curve.
> 
> 4. Add advice in appropriate locations.
> Instead of this:
>    $ git remote rm origin/foo
>    error: Could not remove config section 'remote.origin/foo'

Ugh, this is horrible. We should definitely do better than this error
message.

>    $ git branch -d origin/foo
>    error: branch 'origin/foo' not found.
> 
> Do this:
>    $ git remote rm origin/foo
>    error: There is no remote named 'origin/foo'
>    hint: Did you mean to remove the remote tracking branch 'origin/foo'?
>    hint: Try "git branch --delete --remotes origin/foo" instead.
>    hint: Did you mean to remove the branch 'foo' on the remote
> 'origin' repository?
>    hint: Try "git push --delete origin foo" instead.
> 
>    $ git branch -d origin/foo
>    error: branch 'origin/foo' not found.
>    hint: To delete the remote-tracking branch origin/foo,
>    hint:  use git branch --delete --remotes origin/foo
> 
>    $ git branch -dr origin/foo
>    Deleted remote branch origin/foo (was fadda12).

If we're changing error messages, this could probably do with an update
to say "remote-tracking" branch so it's clearer that it didn't affect
the branch on the remote.

>    hint: This deleted your remote-tracking branch but
>    hint:  did not affect the branch on the remote server.
>    hint:  To remove the branch from the remote server,
>    hint:  use "git push".  See '--delete' in "git help push" .
> 

IMO these seem too verbose (but maybe I've just seen people post the old
'git pull' error message without even reading it too many times).

   cmn
