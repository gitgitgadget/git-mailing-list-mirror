From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3 v2] Make "git-remote rm" delete refs acccording to fetch specs
Date: Sun, 1 Jun 2008 02:30:51 -0400
Message-ID: <20080601063051.GH12896@spearce.org>
References: <20080601042804.GA32293@spearce.org> <7vprr1d8p2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 08:31:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2h6c-0003cM-7F
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 08:31:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751726AbYFAGaz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 02:30:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751651AbYFAGaz
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 02:30:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45059 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751497AbYFAGay (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 02:30:54 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1K2h5f-00084x-I2; Sun, 01 Jun 2008 02:30:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 232A220FBAE; Sun,  1 Jun 2008 02:30:51 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vprr1d8p2.fsf@gitster.siamese.dyndns.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83434>

Junio C Hamano <gitster@pobox.com> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> >  This is a longer, but better version of this patch.  Instead of
> >  blindly deleting the refs we remove them only if this is the last
> >  remote that would write to the local tracking ref.
> 
> If this is a better version than the previous one, then probably "git
> remote prune" patch to unconditionally remove ones that do not exist in
> one of the remotes that fetch into the tracking namespace also needs to be
> rethought, doesn't it?

Nope.  I've thought about this already.  ;-)
 
> Admittedly, next fetch from the other remote may or may not resurrect them
> and either way it is not a big deal.

Correct.

> I think this is exactly the same issue as this improvement in [3/3] deals
> with.  If "git remote rm" of one remote removed the shared tracked refs,
> next fetch from the other remote would resurrect them if the other remote
> still exists.  It may probably feel better to be extra careful like this
> improved patch, but I doubt it would matter in practice.  After all,
> people who creates such a configuration would know what they are doing.

I don't think it matters in practice.

If the user has configured two different remotes with different URLs
fetching to the same set of tracking branches, well, they get what
they get when their prune and fetch start fighting over a tracking
branch existing or disappearing.

Today I found these misfeatures in git-remote because I sort of do
what I showed in my second patch.  I have two remotes which fetch to
the same tracking branches, as they fetch from the same repository,
just over two different protocols.  There never should be a time
where I can see a difference between them, unless its just a race
condition where someone else created or deleted a branch between
my two sequential git-fetch/git-remote calls.

I think the behavior in 2/2 and 3/3v2 is the best we can do, short of
contacting all other remotes which go to the same tracking branch.
But that may not be possible.  One reason for using two different
remote configurations to the same tracking branches is to make
the URL differ.  Think fetching against repo.or.cz using git://
and also http://, where http:// is necessary when you are stuck
behind a @#U*!@(#*!@#*!@(@!! proxy server.  We cannot contact both
remotes to verify the branch really is safe to prune.

-- 
Shawn.
