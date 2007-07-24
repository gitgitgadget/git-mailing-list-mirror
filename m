From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] filter-branch: rewrite only refs which were not 
 excludedbythe options
Date: Tue, 24 Jul 2007 15:32:25 +0200
Organization: eudaptics software gmbh
Message-ID: <46A5FF69.F5D75C9E@eudaptics.com>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site> 
	 <46A5C615.24C24F0F@eudaptics.com> <Pine.LNX.4.64.0707241205480.14781@racer.site>
	 <46A5E136.D413D3B7@eudaptics.com> <Pine.LNX.4.64.0707241229170.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 15:32:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDKV1-0004xa-8z
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 15:32:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757540AbXGXNcW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 09:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757323AbXGXNcV
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 09:32:21 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:28352 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755539AbXGXNcU (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 09:32:20 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1IDKUq-0000Xl-Gq; Tue, 24 Jul 2007 15:32:16 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 93C5D55DD; Tue, 24 Jul 2007 15:32:16 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 2.3 (++)
X-Spam-Report: AWL=-1.346, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53587>

Johannes Schindelin wrote:
> 
> Hi,
> 
> On Tue, 24 Jul 2007, Johannes Sixt wrote:
> 
> > Johannes Schindelin wrote:
> > > So really exclude excluded refs from being rewritten.  This also allows
> > > you to safely call
> > >
> > >         git filter-branch <some-filter> --all <rev-list options>
> > >
> > > to rewrite _all_ branches and tags.
> >
> > BTW, '--all' in the argument list of filter-branch works only if it is
> > preceded by '--':
> >
> >       git filter-branch <some-filter> -- --all <rev-list options>
> 
> Hmm.  Maybe we should reconsider the logic.  I.e. instead of
> 
>         *)
>                 usage
> 
>         *)
>                 break

That is not enough: This case block comes after a test that checks that
one additional argument is present, which would not be true anymore.

> > > @@ -181,6 +181,7 @@ export GIT_DIR GIT_WORK_TREE=.
> > >
> > >  # These refs should be updated if their heads were rewritten
> > >
> > > +negatives="$(git rev-parse --revs-only "$@" | grep "^\^")"
> > >  git rev-parse --revs-only --symbolic "$@" |
> > >  while read ref
> > >  do
> > > @@ -196,7 +197,13 @@ do
> > >                         grep "refs/\(tags\|heads\)/$ref$")"
> > >         esac
> > >
> > > -       git check-ref-format "$ref" && echo "$ref"
> > > +       # make sure we have a valid ref
> > > +       git check-ref-format "$ref" || continue
> > > +
> > > +       # if the ref has been excluded by the other options, skip it
> > > +       test -z "$(git rev-list -1 "$ref" $negatives)" && continue
> >
> > Does this catch my use-case with --since? I think not, because:
> >
> > $ git rev-parse --revs-only --since=2007.01.01 master topic
> > --max-age=1167606000
> > 257061f3323dc0162f731d934f0870e919211fdf
> > 3405729b94a654df8afbb9a1e13a4cf49a1c351c
> >
> > There are no negatives. Does it help to filter the non-positives?
> >
> > negatives=$(git rev-parse --revs-only "$@" | egrep -v '^[0-9a-f]{40}$')
> >
> > (Except the the '{40}' part is not portable. Hmpf.)
> 
> To keep the "--since=..." we have to lose the "--revs-only"...
> Darn.  I thought that "--since=" was expanded by rev-parse.  FWIW this
> might work:
> 
> negatives="$(git rev-parse "$@" | while read line
>         do
>                 case "$line" in
>                 $_x40) ;;
>                 *) echo "$line";;
>                 esac
>         done)"
> 
> Can you please test?  I am off for lunch.

This worked:

negatives=`git rev-parse --revs-only "$@" | while read line
	do
		case "$line" in
		$_x40) ;;
		*) echo "$line";;
		esac
	done`

i.e. the closing parenthesis in the case arms together with the opening
$( made for a syntax error. The --revs-only did not hurt in my tests,
but you may have other reasons to remove it.

But there's another problem. Consider this history:

   ---X--o--M         <- master
             \
          ...-o-...-o <- topic

Then this (rather contrieved) command:

   $ git-filter-branch -n $n master topic --not X

If $n is small enough so that M is never rewritten, then

   git rev-list -1 "$ref" $negatives

still expands to non-empty even for 'master' (= M), which then
incorrectly ends up in "$tempdir"/heads.

I think the decision whether a positive ref should be rewritten should
be postponed until the rewrite has completed. Because then we know for
certain which revs were treated and can pick the matching refs. We only
lose the check for the error "Which ref do you want to rewrite?"

-- Hannes
