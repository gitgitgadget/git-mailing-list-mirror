From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] rebase: use reflog to find common base with upstream
Date: Mon, 21 Oct 2013 12:24:08 +0100
Message-ID: <20131021112408.GA24317@serenity.lan>
References: <d8e9f102609ee4502f579cb4ce872e0a40756204.1381949622.git.john@keeping.me.uk>
 <CANiSa6gqGKAyLwwPVoZ_gzN85_06aTCfkdRRscNNZYs7g1rL0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 21 13:24:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VYDaz-000453-BP
	for gcvg-git-2@plane.gmane.org; Mon, 21 Oct 2013 13:24:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753263Ab3JULYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Oct 2013 07:24:21 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:36143 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753207Ab3JULYU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Oct 2013 07:24:20 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 3D3766064D7;
	Mon, 21 Oct 2013 12:24:20 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I+rrSRzKmQp4; Mon, 21 Oct 2013 12:24:19 +0100 (BST)
Received: from serenity.lan (banza.aluminati.org [10.0.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id DACC16064DD;
	Mon, 21 Oct 2013 12:24:13 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CANiSa6gqGKAyLwwPVoZ_gzN85_06aTCfkdRRscNNZYs7g1rL0A@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236428>

On Sun, Oct 20, 2013 at 10:03:29PM -0700, Martin von Zweigbergk wrote:
> On Wed, Oct 16, 2013 at 11:53 AM, John Keeping <john@keeping.me.uk> wrote:
> > Commit 15a147e (rebase: use @{upstream} if no upstream specified,
> > 2011-02-09) says:
> >
> >         Make it default to 'git rebase @{upstream}'. That is also what
> >         'git pull [--rebase]' defaults to, so it only makes sense that
> >         'git rebase' defaults to the same thing.
> >
> > but that isn't actually the case.  Since commit d44e712 (pull: support
> > rebased upstream + fetch + pull --rebase, 2009-07-19), pull has actually
> > chosen the most recent reflog entry which is an ancestor of the current
> > branch if it can find one.
> 
> It is exactly this inconsistency between "git rebase" and "git pull
> --rebase" that confused me enough to make me send my first email to
> this list almost 4 years ago [1], so thanks for working on this! I
> finished that thread with:
> 
>   Would it make sense to teach "git rebase" the same tricks as "git
> pull --rebase"?
> 
> Then it took me a year before I sent a patch not unlike this one [2].
> To summarize, the patch did not get accepted then because it makes
> rebase a little slower (or a lot slower in some cases). "git pull
> --rebase" is of course at least as slow in the same cases, but because
> it often involves connecting to a remote host, people would probably
> blame the connection rather than git itself even in those rare (?)
> cases.
> 
> I think
> 
>   git merge-base HEAD $(git rev-list -g "$upstream_name")
> 
> is roughly correct and hopefully fast enough. That can lead to too
> long a command line, so I was planning on teaching merge-base a
> --stdin option, but never got around to it.

I'm not sure we should worry about the additional overhead here.  In the
common case, we should hit a common ancestor within the first couple of
reflog entries; and in the case that will be slow, it's likely that
there are a lot of differences between the branches so the cherry
comparison phase will take a while anyway.
