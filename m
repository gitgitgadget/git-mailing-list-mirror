From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] rebase: use reflog to find common base with upstream
Date: Thu, 24 Oct 2013 21:26:35 +0100
Message-ID: <20131024202635.GB10779@serenity.lan>
References: <d8e9f102609ee4502f579cb4ce872e0a40756204.1381949622.git.john@keeping.me.uk>
 <CANiSa6gNJiUGb47Sw38V3oeJ-=0c1oZ0wO-GhNQminN3+SvgaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Martin von Zweigbergk <martinvonz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 24 22:26:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZRUZ-0003yh-6R
	for gcvg-git-2@plane.gmane.org; Thu, 24 Oct 2013 22:26:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755734Ab3JXU0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 16:26:47 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:34948 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755677Ab3JXU0r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 16:26:47 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id E9466CDA5B9;
	Thu, 24 Oct 2013 21:26:45 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.899
X-Spam-Level: 
X-Spam-Status: No, score=-2.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9, URIBL_BLOCKED=0.001]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AVg-QQ2P1zYM; Thu, 24 Oct 2013 21:26:43 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 8526DCDA566;
	Thu, 24 Oct 2013 21:26:37 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <CANiSa6gNJiUGb47Sw38V3oeJ-=0c1oZ0wO-GhNQminN3+SvgaA@mail.gmail.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236618>

On Mon, Oct 21, 2013 at 10:40:22PM -0700, Martin von Zweigbergk wrote:
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
> >
> > Change rebase so that it uses the same logic.
> >
> > Signed-off-by: John Keeping <john@keeping.me.uk>
> > ---
> >  git-rebase.sh     | 8 ++++++++
> >  t/t3400-rebase.sh | 6 ++++--
> >  2 files changed, 12 insertions(+), 2 deletions(-)
> >
> > diff --git a/git-rebase.sh b/git-rebase.sh
> > index 226752f..fd36cf7 100755
> > --- a/git-rebase.sh
> > +++ b/git-rebase.sh
> > @@ -437,6 +437,14 @@ then
> >                         error_on_missing_default_upstream "rebase" "rebase" \
> >                                 "against" "git rebase <branch>"
> >                 fi
> > +               for reflog in $(git rev-list -g "$upstream_name" 2>/dev/null)
> > +               do
> > +                       if test "$reflog" = "$(git merge-base "$reflog" HEAD)"
> > +                       then
> > +                               upstream_name=$reflog
> > +                               break
> > +                       fi
> > +               done
> >                 ;;
> >         *)      upstream_name="$1"
> >                 shift
> 
> A little later, "onto_name" gets assigned like so:
> 
>   onto_name=${onto-"$upstream_name"}
> 
> So if upstream_name was set above, then onto would get the same value,
> which is not what we want, right? It seems like this block of code
> should come a bit later.
> 
> I also think it not be run only when rebase was run without a given
> upstream. If the configured upstream is "origin/master", it seems like
> it would be surprising to get different behavior from "git rebase" and
> "git rebase origin/master".

Hmm... I think you're right.  I originally didn't want to change the
behaviour when the user specifies a branch, but in this case we want to
look for a common ancestor in the reflog of the upstream regardless of
where the ref came from.
