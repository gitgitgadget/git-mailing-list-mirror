From: Johannes Sixt <J.Sixt@eudaptics.com>
Subject: Re: [PATCH] filter-branch: rewrite only refs which were not 
 excludedbythe options
Date: Tue, 24 Jul 2007 16:08:43 +0200
Organization: eudaptics software gmbh
Message-ID: <46A607EB.BA31D7C5@eudaptics.com>
References: <Pine.LNX.4.64.0707231829210.14781@racer.site>  
	 <46A5C615.24C24F0F@eudaptics.com> <Pine.LNX.4.64.0707241205480.14781@racer.site>
	  <46A5E136.D413D3B7@eudaptics.com> <Pine.LNX.4.64.0707241229170.14781@racer.site>
	 <46A5FF69.F5D75C9E@eudaptics.com> <Pine.LNX.4.64.0707241435290.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 24 16:08:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IDL44-0001r6-TI
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 16:08:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757070AbXGXOIi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Jul 2007 10:08:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756639AbXGXOIi
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jul 2007 10:08:38 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:30269 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756606AbXGXOIh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jul 2007 10:08:37 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtp (Exim 4.66)
	(envelope-from <J.Sixt@eudaptics.com>)
	id 1IDL3x-0001Wv-NR; Tue, 24 Jul 2007 16:08:34 +0200
Received: from eudaptics.com (tethys.linz.eudaptics [192.168.1.88])
	by linz.eudaptics.com (Postfix) with ESMTP
	id ACCFD55DD; Tue, 24 Jul 2007 16:08:33 +0200 (CEST)
X-Mailer: Mozilla 4.73 [en] (Windows NT 5.0; U)
X-Accept-Language: en
X-Spam-Score: 2.3 (++)
X-Spam-Report: AWL=-1.330, BAYES_99=3.5, FORGED_RCVD_HELO=0.135
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53598>

Johannes Schindelin wrote:
> On Tue, 24 Jul 2007, Johannes Sixt wrote:
> > This worked:
> >
> > negatives=`git rev-parse --revs-only "$@" | while read line
> >       do
> >               case "$line" in
> >               $_x40) ;;
> >               *) echo "$line";;
> >               esac
> >       done`
> >
> > i.e. the closing parenthesis in the case arms together with the opening
> > $( made for a syntax error. The --revs-only did not hurt in my tests,
> > but you may have other reasons to remove it.
> 
> Funny.  AFAIR something similar worked here, all the time.  But I believe
> you... you're on MinGW, right?

No. filter-branch is a shell script. I don't have time to waste ;)
It happens in bash 2.05b on Linux.

> > But there's another problem. Consider this history:
> >
> >    ---X--o--M         <- master
> >              \
> >           ...-o-...-o <- topic
> >
> > Then this (rather contrieved) command:
> >
> >    $ git-filter-branch -n $n master topic --not X
> >
> > If $n is small enough so that M is never rewritten, then
> >
> >    git rev-list -1 "$ref" $negatives
> >
> > still expands to non-empty even for 'master' (= M), which then
> > incorrectly ends up in "$tempdir"/heads.
> 
> Aaargh!  Of course!  Since I have to add --topo-order at the end.
> Otherwise it makes no sense.

No, that was no my point: In my example above, if n=1, `git rev-list -1
"$ref" $negatives` evaluates to

    $ git rev-list -1 "master" -n 1 ^X

which returns M, even though M is not going to be rewritten.
--topo-order changes nothing. The problem is that the -n is a relative
restriction. --since is turned into --max-age, which is absolute,
therefore, the test works as expected with --since.

> > I think the decision whether a positive ref should be rewritten should
> > be postponed until the rewrite has completed. Because then we know for
> > certain which revs were treated and can pick the matching refs. We only
> > lose the check for the error "Which ref do you want to rewrite?"
> 
> No, that is not enough:
> 
>         A - B - C
> 
> B touches the subdirectory sub/.
> 
>         git filter-branch C -- sub/
> 
> will not rewrite C.

Fair enough.

-- Hannes
