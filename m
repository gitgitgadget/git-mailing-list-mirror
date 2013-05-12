From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC/PATCH 0/2] merge-base: add --merge-child option
Date: Sun, 12 May 2013 17:28:24 +0100
Message-ID: <20130512162823.GK2299@serenity.lan>
References: <cover.1368274689.git.john@keeping.me.uk>
 <518FB8DE.7070004@bracey.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Kevin Bracey <kevin@bracey.fi>
X-From: git-owner@vger.kernel.org Sun May 12 18:28:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UbZ8d-0004ZP-JA
	for gcvg-git-2@plane.gmane.org; Sun, 12 May 2013 18:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754245Ab3ELQ2j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 May 2013 12:28:39 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:48205 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753553Ab3ELQ2i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 May 2013 12:28:38 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id C6366CDA580;
	Sun, 12 May 2013 17:28:37 +0100 (BST)
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -2.9
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_00=-1.9] autolearn=ham
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ybiwEE7LsV5y; Sun, 12 May 2013 17:28:36 +0100 (BST)
Received: from serenity.lan (mink.aluminati.org [10.0.7.180])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 72156CDA5CD;
	Sun, 12 May 2013 17:28:26 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <518FB8DE.7070004@bracey.fi>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/224050>

On Sun, May 12, 2013 at 06:44:30PM +0300, Kevin Bracey wrote:
> On 11/05/2013 15:23, John Keeping wrote:
> > This is helpful when examining branches with disjoint roots, for example
> > because one is periodically merged into a subtree of the other.
> >
> >
> >
> >          $ git log --left-right F...E --not $(git merge-base --merge-child F E)
> >          < F
> >          > E
> >
> 
> Wouldn't "--left-right --ancestry-path F...E" do the job? I can't 
> immediately see how that differs.
> 
> Unfortunately, that syntax doesn't currently work - I just stumbled 
> across this problem, and my "history traversal refinements" series in pu 
> fixes it, somewhat incidentally to the main subject in there.

You're right (and I was wrong in my reply to Junio's parallel message)
ancestry path does seem to be what I want:

    $ git rev-list --left-right --count master...git-gui/master
    31959   5

    $ git rev-list --ancestry-path --left-right --count \
            master...git-gui/master
    2056    5

    $ git rev-list --ancestry-path --left-right --count \
            master...git-gui/master \
            --not $(git merge-base --all master git-gui/master)
    2056    5

However, this doesn't seem to make a difference to the time taken when I
add in --cherry-mark (which is why I was partially correct in the
parallel thread - it doesn't have the effect on cherry-mark that I want
it to):

    $ time git rev-list --ancestry-path --left-right --count --cherry-mark \
            origin/master...git-gui/master 
    2056    5       0

    real    0m32.266s
    user    0m31.522s
    sys     0m0.749s

    $ time git rev-list  --left-right --count --cherry-mark \
            origin/master...git-gui/master
    31959   5       0

    real    0m32.140s
    user    0m31.337s
    sys     0m0.807s

This seems to be caused by the code in revision.c::limit_list() which
does the cherry detection then limits to left/right and only then
applies the ancestry path.  I haven't looked further than that, but is
there any reason not to apply the ancestry path restriction before
looking for patch-identical commits?

> However, without that patch, the alternative way of expressing it:
> 
> "--left-right --ancestry path F E --not $(git merge-base --all F E)"
> 
> should still work. Unless --left-right is magic for "..."? If it is, 
> then my patch is more significant than I thought.

Yes, --left-right only applies to symmetric differences ("...").  But I
get the results above both on master and on pu.

> My series will also be better at optimising away D too, through a 
> combination of my and Junio's efforts. Try it out.
> 
> On this subject, is there any way to exclude a path from a log query? Is 
> there a "not" operator for paths? Might be another way of doing this - 
> disjoint histories probably have disjoint paths...

That relates to another idea I had about optimizing the detection of
patch-identical commits.  If the smaller side of a symmetric difference
is quite small (as it is likely to be if it's a topic branch), would it
be a good idea to calculate the set of paths touched by commits on that
side and then skip calculating the patch ID for any commits that touch
paths outside that set.  The tree comparison is a lot cheaper than doing
a diff on all of the files.
