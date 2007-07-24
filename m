From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] filter-branch: rewrite only refs which were not excluded
  bythe options
Date: Tue, 24 Jul 2007 12:33:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707241229170.14781@racer.site>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site> 
 <46A5C615.24C24F0F@eudaptics.com> <Pine.LNX.4.64.0707241205480.14781@racer.site>
 <46A5E136.D413D3B7@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jul 24 13:34:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDIee-0006KH-J9
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 13:34:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765899AbXGXLeO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 07:34:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932078AbXGXLeN
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 07:34:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:34214 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1760102AbXGXLeL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 07:34:11 -0400
Received: (qmail invoked by alias); 24 Jul 2007 11:34:09 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp055) with SMTP; 24 Jul 2007 13:34:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xgoM+BCDxGslI8ki1s1/Z6Jij+cvgiXCTLCMKAk
	WC/mbU3ST5ufh7
X-X-Sender: gene099@racer.site
In-Reply-To: <46A5E136.D413D3B7@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53575>

Hi,

On Tue, 24 Jul 2007, Johannes Sixt wrote:

> Johannes Schindelin wrote:
> > So really exclude excluded refs from being rewritten.  This also allows
> > you to safely call
> > 
> >         git filter-branch <some-filter> --all <rev-list options>
> > 
> > to rewrite _all_ branches and tags.
> 
> BTW, '--all' in the argument list of filter-branch works only if it is
> preceded by '--':
> 
> 	git filter-branch <some-filter> -- --all <rev-list options>

Hmm.  Maybe we should reconsider the logic.  I.e. instead of

        *)
                usage

        *)
                break

> > @@ -181,6 +181,7 @@ export GIT_DIR GIT_WORK_TREE=.
> > 
> >  # These refs should be updated if their heads were rewritten
> > 
> > +negatives="$(git rev-parse --revs-only "$@" | grep "^\^")"
> >  git rev-parse --revs-only --symbolic "$@" |
> >  while read ref
> >  do
> > @@ -196,7 +197,13 @@ do
> >                         grep "refs/\(tags\|heads\)/$ref$")"
> >         esac
> > 
> > -       git check-ref-format "$ref" && echo "$ref"
> > +       # make sure we have a valid ref
> > +       git check-ref-format "$ref" || continue
> > +
> > +       # if the ref has been excluded by the other options, skip it
> > +       test -z "$(git rev-list -1 "$ref" $negatives)" && continue
> 
> Does this catch my use-case with --since? I think not, because:
> 
> $ git rev-parse --revs-only --since=2007.01.01 master topic
> --max-age=1167606000
> 257061f3323dc0162f731d934f0870e919211fdf
> 3405729b94a654df8afbb9a1e13a4cf49a1c351c
> 
> There are no negatives. Does it help to filter the non-positives?
> 
> negatives=$(git rev-parse --revs-only "$@" | egrep -v '^[0-9a-f]{40}$')
> 
> (Except the the '{40}' part is not portable. Hmpf.)

To keep the "--since=..." we have to lose the "--revs-only"...
Darn.  I thought that "--since=" was expanded by rev-parse.  FWIW this 
might work:

negatives="$(git rev-parse "$@" | while read line
	do
		case "$line" in
		$_x40) ;;
		*) echo "$line";;
		esac
	done)"

Can you please test?  I am off for lunch.

Ciao,
Dscho
