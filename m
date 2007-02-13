From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: StGIT discards local commits on "stg pull"
Date: Tue, 13 Feb 2007 22:48:11 +0000
Message-ID: <b0943d9e0702131448x360018b3w6d1790a84f201710@mail.gmail.com>
References: <20070212022625.rvyyo0kc0wowgogc@webmail.spamcop.net>
	 <b0943d9e0702120131r528fb29ete143b8ce5a0a99e9@mail.gmail.com>
	 <1171326011.2326.30.camel@dv>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Yann Dirson" <ydirson@altern.org>
To: "Pavel Roskin" <proski@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 13 23:48:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH6SB-0002LB-DV
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 23:48:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbXBMWsO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 17:48:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbXBMWsO
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 17:48:14 -0500
Received: from nz-out-0506.google.com ([64.233.162.231]:27896 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751400AbXBMWsM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 17:48:12 -0500
Received: by nz-out-0506.google.com with SMTP id s1so2160713nze
        for <git@vger.kernel.org>; Tue, 13 Feb 2007 14:48:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=i0vXOfq8A167PC2mw/psJHF+ZgAN+2tJlScxVADq4b7Wt5DtASdTlkUqCzKsOFoaXKrYt5xzlF0t+JIu1cI+FDqvY/cf+wyf8J08momlI3nDohxWtqQjSotcx67FPZP5zLxX9dQWg6sEcqrVgbcCd/glsADX7ANkO/9XUT+o0Zk=
Received: by 10.114.131.2 with SMTP id e2mr2175016wad.1171406891675;
        Tue, 13 Feb 2007 14:48:11 -0800 (PST)
Received: by 10.115.110.12 with HTTP; Tue, 13 Feb 2007 14:48:11 -0800 (PST)
In-Reply-To: <1171326011.2326.30.camel@dv>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39597>

On 13/02/07, Pavel Roskin <proski@gnu.org> wrote:
> On Mon, 2007-02-12 at 09:31 +0000, Catalin Marinas wrote:
> > On 12/02/07, Pavel Roskin <proski@gnu.org> wrote:
>
> > > The example below shows that git-pull keeps my commit, but "stg pull"
> > > discards it by rebasing back to the remote ID.
> >
> > I think this is a "feature" but we should've probably leave the
> > original behaviour as the default. Maybe we should also have this
> > per-branch rather than per-repository.
>
> I don't know the original motivation behind effectively reimplementing
> "git pull" in StGIT, but it's clear that the StGIT's own implementation
> needs some polish.

Yann can describe the motivation better as he was the one pushing for
it. It was mainly to allow different local branches to be based on
different remote branches. In the normal case, i.e. using only StGIT
commands, there shouldn't be any difference. As I said, the old
behaviour is still present and maybe we should do the new one
per-branch.

> I think it's always wrong to lose local commits.  I think StGIT should
> refuse to rebase if a merge would be needed or the rebase would go back
> in history (in other words, if git-pull would not go to the remote
> revision).

Yes, indeed.

> If we look at it from the user standpoint, the branches could be
> distinguished by the use model:
>
> 1) Tracking branch: pull is OK, commit is not OK, push is not OK.  All
> development is done in StGIT patches and sent to others.
>
> 2) Development branch: commit is OK, push is OK, pull is OK but no
> merges by default.
>
> 3) Merge branch: pull is OK, even with automatic merge, commit is OK,
> merge is OK.

I probably have another situation - a branch managed partially with
StGIT but GIT commits (or 'stg commit') used and pulling would lead to
a merge of the base, followed by patch pushing. This would work if we
use git-pull rather than git-fetch.

> > The solution would be to define the following in your gitconfig file
> > (either ~/.gitconfig or .git/config; a full example in StGIT's
> > examples/gitconfig):
> >
> > [stgit]
> >       pullcmd = git-pull
> >       pull-does-rebase = no
> >
> > The last line would tell StGIT not to do the rebasing and let git-pull
> > handle it.
>
> It's actually my deliberate choice to subject myself to the pains of the
> default configuration.  I don't want to live in backwards compatible
> environment until it rots away.  I'll rather eat the dogfood we are
> offering to others :)

I don't consider this as a backward-compatibility feature. It simply
targets a different workflow and it would be even better if we have it
per-branch. The default should be the current fetch+rebase (as the
most common case would be to use StGIT commands only) but with a
warning if stack base fast-forwarding is not possible.

-- 
Catalin
