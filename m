From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 0/2] merge-base: add --merge-child option
Date: Sun, 12 May 2013 17:33:18 +0100
Message-ID: <20130512163317.GL2299@serenity.lan>
References: <cover.1368274689.git.john@keeping.me.uk>
 <518FB8DE.7070004@bracey.fi>
 <20130512162823.GK2299@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sun May 12 18:33:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbZDM-0007Y9-AI
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 18:33:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754651Ab3ELQdc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 12:33:32 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:49678 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754248Ab3ELQdb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 12:33:31 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id 5B7FBCDA607;
	Sun, 12 May 2013 17:33:31 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2nHvK4sDxP2R; Sun, 12 May 2013 17:33:30 +0100 (BST)
Received: from pichi.aluminati.org (pichi.aluminati.org [10.0.16.50])
	by jackal.aluminati.org (Postfix) with ESMTP id DA86ECDA580;
	Sun, 12 May 2013 17:33:30 +0100 (BST)
Received: from localhost (localhost [127.0.0.1])
	by pichi.aluminati.org (Postfix) with ESMTP id CD044161E3F1;
	Sun, 12 May 2013 17:33:30 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at aluminati.org
Received: from pichi.aluminati.org ([127.0.0.1])
	by localhost (pichi.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hGsnA1wpQuns; Sun, 12 May 2013 17:33:30 +0100 (BST)
Received: from serenity.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by pichi.aluminati.org (Postfix) with ESMTPSA id C85D4161E469;
	Sun, 12 May 2013 17:33:20 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130512162823.GK2299@serenity.lan>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224051>

On Sun, May 12, 2013 at 05:28:24PM +0100, John Keeping wrote:
> On Sun, May 12, 2013 at 06:44:30PM +0300, Kevin Bracey wrote:
> > On 11/05/2013 15:23, John Keeping wrote:
> > > This is helpful when examining branches with disjoint roots, for example
> > > because one is periodically merged into a subtree of the other.
> > >
> > >
> > >
> > >          $ git log --left-right F...E --not $(git merge-base --merge-child F E)
> > >          < F
> > >          > E
> > >
> > 
> > Wouldn't "--left-right --ancestry-path F...E" do the job? I can't 
> > immediately see how that differs.
> > 
> > Unfortunately, that syntax doesn't currently work - I just stumbled 
> > across this problem, and my "history traversal refinements" series in pu 
> > fixes it, somewhat incidentally to the main subject in there.
> 
> You're right (and I was wrong in my reply to Junio's parallel message)
> ancestry path does seem to be what I want:
> 
>     $ git rev-list --left-right --count master...git-gui/master
>     31959   5
> 
>     $ git rev-list --ancestry-path --left-right --count \
>             master...git-gui/master
>     2056    5
> 
>     $ git rev-list --ancestry-path --left-right --count \
>             master...git-gui/master \
>             --not $(git merge-base --all master git-gui/master)
>     2056    5
> 
> However, this doesn't seem to make a difference to the time taken when I
> add in --cherry-mark (which is why I was partially correct in the
> parallel thread - it doesn't have the effect on cherry-mark that I want
> it to):
> 
>     $ time git rev-list --ancestry-path --left-right --count --cherry-mark \
>             origin/master...git-gui/master 
>     2056    5       0
> 
>     real    0m32.266s
>     user    0m31.522s
>     sys     0m0.749s
> 
>     $ time git rev-list  --left-right --count --cherry-mark \
>             origin/master...git-gui/master
>     31959   5       0
> 
>     real    0m32.140s
>     user    0m31.337s
>     sys     0m0.807s
> 
> This seems to be caused by the code in revision.c::limit_list() which
> does the cherry detection then limits to left/right and only then
> applies the ancestry path.  I haven't looked further than that, but is
> there any reason not to apply the ancestry path restriction before
> looking for patch-identical commits?
> 
> > However, without that patch, the alternative way of expressing it:
> > 
> > "--left-right --ancestry path F E --not $(git merge-base --all F E)"
> > 
> > should still work. Unless --left-right is magic for "..."? If it is, 
> > then my patch is more significant than I thought.
> 
> Yes, --left-right only applies to symmetric differences ("...").  But I
> get the results above both on master and on pu.

No I didn't.  I forgot to update my $PATH when I built on master - those
results are from pu.  master says:

    fatal: --ancestry-path given but there are no bottom commits

> > My series will also be better at optimising away D too, through a 
> > combination of my and Junio's efforts. Try it out.
> > 
> > On this subject, is there any way to exclude a path from a log query? Is 
> > there a "not" operator for paths? Might be another way of doing this - 
> > disjoint histories probably have disjoint paths...
> 
> That relates to another idea I had about optimizing the detection of
> patch-identical commits.  If the smaller side of a symmetric difference
> is quite small (as it is likely to be if it's a topic branch), would it
> be a good idea to calculate the set of paths touched by commits on that
> side and then skip calculating the patch ID for any commits that touch
> paths outside that set.  The tree comparison is a lot cheaper than doing
> a diff on all of the files.
