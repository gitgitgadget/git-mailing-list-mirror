From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Tracability in git commits
Date: Tue, 29 Apr 2008 22:51:03 -0400
Message-ID: <20080430025102.GS29771@spearce.org>
References: <1209473739.5642.31.camel@dax.rpnet.com> <7vd4o873cm.fsf@gitster.siamese.dyndns.org> <1209506199.5642.66.camel@dax.rpnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
X-From: git-owner@vger.kernel.org Wed Apr 30 04:52:11 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jr2QU-0008Cz-01
	for gcvg-git-2@gmane.org; Wed, 30 Apr 2008 04:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754262AbYD3CvL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 22:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752825AbYD3CvL
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 22:51:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60271 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752530AbYD3CvK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 22:51:10 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jr2PF-0000M5-Bg; Tue, 29 Apr 2008 22:50:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 98D8120FBAE; Tue, 29 Apr 2008 22:51:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <1209506199.5642.66.camel@dax.rpnet.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80781>

Richard Purdie <rpurdie@rpsys.net> wrote:
> On Tue, 2008-04-29 at 14:34 -0700, Junio C Hamano wrote:
> > Richard Purdie <rpurdie@rpsys.net> writes:
> > 
> > > Assuming a shared server using something like gitosis each set of
> > > commits is made under a certain ssh ID and what I'd like is to be able
> > > to validate that against the commits so we could tell that commits A-D
> > > were made by ID Z.
>
> [...] I also understood the remote repository to be
> able to accept or reject commits/merges through its hooks?

Yes.  Look at contrib/hooks/update-paranoid for an example hook that
validates the committer name and email address of each new commit
matches with the real posix uid performing the push.  I use this
hook at day-job to validate pushes made by users over SSH through
a setuid git-receive-pack process.

The receive-pack program was patched to make it safer under setuid.
My patched version drops the setuid privs if the repository it
will write to or the hook(s) it will invoke are writable or owned
by anyone other than the effective uid.

But update-paranoid could be adapted to verify committer name/email
by some means other than just posix uid, such as by SSH public key.
 
> > And then the branch you granted the right to update its tip to that person
> > is updated, using that added part of the history.  The updates to the tip
> > will be recorded in reflog to record who updated the tip and when, [...]
> 
> This sounds like my answer, it's possible to trace who did what from the
> reflog. Which area of code is responsible for updating the reflog, is it
> in git itself or is it in the form of a hook? 

Pretty much all of git automatically updates the reflog when a
change takes place.  On the receiving side of a push event its
git-receive-pack that is handling the repository updates, and one
of the functions it calls is to add the event to the branch's reflog.

> I'm asking since if the repository is read/write for several users,
> faking the log is easy. If you use something like gitosis it runs under
> one user and faking is hard due to the restricted access. There is
> probably a need to feed extra information into whatever is making the
> log, or generate an additional log though due to the single user?

Right.  The reflog events are actually logged using the value of the
environment variables GIT_COMMITTER_NAME and GIT_COMMITTER_EMAIL.

So if you set these with whatever identity you want use prior
to invoking the server side git-receive-pack, you will get that
information in the reflog.  By default if these aren't set we use
the gecos information of the real uid.

Securing a repository means protecting limiting access to it.
You can reasonably protect a repository by making only a specific
user able to run git-receive-pack in that repository, but then
you need to arrange for individual users to execute as that user
over SSH.  The forced command feature associated with public keys
is often used for this, and its how gitosis does it.

My setuid hack to receive-pack will likely be retired at day-job
in the future.  We will either stop using git entirely, or we will
transfer over to forced commands in a common user authorized_keys,
like gitosis does.

-- 
Shawn.
