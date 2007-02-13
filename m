From: Pavel Roskin <proski@gnu.org>
Subject: Re: StGIT discards local commits on "stg pull"
Date: Mon, 12 Feb 2007 19:20:11 -0500
Message-ID: <1171326011.2326.30.camel@dv>
References: <20070212022625.rvyyo0kc0wowgogc@webmail.spamcop.net>
	 <b0943d9e0702120131r528fb29ete143b8ce5a0a99e9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Yann Dirson <ydirson@altern.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 13 01:20:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGlPB-0000MM-2n
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 01:20:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030581AbXBMAUR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Feb 2007 19:20:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030574AbXBMAUQ
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Feb 2007 19:20:16 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:37468 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030581AbXBMAUO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Feb 2007 19:20:14 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <proski@gnu.org>)
	id 1HGlNn-0000pP-U4
	for git@vger.kernel.org; Mon, 12 Feb 2007 19:18:56 -0500
Received: from proski by gnu.org with local (Exim 4.66)
	(envelope-from <proski@gnu.org>)
	id 1HGlP1-00014E-Os; Mon, 12 Feb 2007 19:20:11 -0500
In-Reply-To: <b0943d9e0702120131r528fb29ete143b8ce5a0a99e9@mail.gmail.com>
X-Mailer: Evolution 2.9.5 (2.9.5-4.fc7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39465>

On Mon, 2007-02-12 at 09:31 +0000, Catalin Marinas wrote:
> On 12/02/07, Pavel Roskin <proski@gnu.org> wrote:

> > The example below shows that git-pull keeps my commit, but "stg pull"
> > discards it by rebasing back to the remote ID.
> 
> I think this is a "feature" but we should've probably leave the
> original behaviour as the default. Maybe we should also have this
> per-branch rather than per-repository.

I don't know the original motivation behind effectively reimplementing
"git pull" in StGIT, but it's clear that the StGIT's own implementation
needs some polish.

I think it's always wrong to lose local commits.  I think StGIT should
refuse to rebase if a merge would be needed or the rebase would go back
in history (in other words, if git-pull would not go to the remote
revision).

> In StGIT 0.12, git-fetch is used by default rather than git-pull and
> StGIT performs the rebasing. We had some discussions on whether this
> would break existing workflows and we thought it wouldn't (I don't
> usually mix git-commit with stg commands).

Maybe such assumptions could be enforced?  Perhaps we could consider
branch specialization.  As it stands now, we can have branches where
fast-forward is OK and branches where it's not OK.

If we look at it from the user standpoint, the branches could be
distinguished by the use model:

1) Tracking branch: pull is OK, commit is not OK, push is not OK.  All
development is done in StGIT patches and sent to others.

2) Development branch: commit is OK, push is OK, pull is OK but no
merges by default.

3) Merge branch: pull is OK, even with automatic merge, commit is OK,
merge is OK.

I'm not sure if this belongs to git or StGIT.

> The solution would be to define the following in your gitconfig file
> (either ~/.gitconfig or .git/config; a full example in StGIT's
> examples/gitconfig):
> 
> [stgit]
> 	pullcmd = git-pull
> 	pull-does-rebase = no
> 
> The last line would tell StGIT not to do the rebasing and let git-pull
> handle it.

It's actually my deliberate choice to subject myself to the pains of the
default configuration.  I don't want to live in backwards compatible
environment until it rots away.  I'll rather eat the dogfood we are
offering to others :)

> I agree that for the rebasing case, we should have some warning if
> fast-forwarding of the stack's base is not possible so that you could
> run 'stg uncommit'.

Sounds good to me.

-- 
Regards,
Pavel Roskin
