From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree
	performance problems)
Date: Thu, 21 Apr 2005 08:29:54 +1000
Message-ID: <1114036196.5877.70.camel@localhost.localdomain>
References: <200504191250.10286.mason@suse.com>
	 <200504191708.23536.mason@suse.com>
	 <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org>
	 <200504192049.21947.mason@suse.com>
	 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org>
	 <42660708.60109@zytor.com>
	 <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org>
	 <1114006429.5877.42.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0504200731590.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>,
	Chris Mason <mason@suse.com>
X-From: git-owner@vger.kernel.org Thu Apr 21 00:27:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DONeU-0000Ex-Md
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 00:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261836AbVDTWau (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 18:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261838AbVDTWau
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 18:30:50 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:61342 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261836AbVDTWaf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 18:30:35 -0400
Received: from [203.53.50.91] (helo=[172.18.240.72])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DONiG-00027Y-52; Wed, 20 Apr 2005 23:30:29 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504200731590.6467@ppc970.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 2005-04-20 at 07:59 -0700, Linus Torvalds wrote:
>         external-parent <commit-hash> <external-parent-ID>
>                 comment for this parent
> 
> and the nice thing about that is that now that information allows you to 
> add external parents at any point. 
> 
> Why do it like this? First off, I think that the "initial import" ends up
> being just one special case of the much more _generic_ issue of having
> patches come in from other source control systems 

This isn't about patches coming in from other systems -- it's about
_history_, and the fact that it's imported from another system is just
an implementation detail. It's git history now, and what we have here is
just a special case of wanting to prune ancient git history to keep the
size of our working trees down. You refer to this yourself...

> Secondly, we do need something like this for pruning off history anyway, 
> so that the tools have a better way of saying "history has been pruned 
> off" than just hitting a missing commit. 

Having a more explicit way of saying "history is pruned" than just a
reference to a missing commit is a reasonable request -- but I really
don't see how we can do that by changing the now-oldest commit object to
contain an 'external-parent' field. Doing that would change the sha1 of
the commit object in question, and then ripple through all the
subsequent commits.

Come this time next year, if I decide I want to prune anything older
than 2.6.40 from all the trees on my laptop, it has to happen _without_
changing the commit objects which occur after my arbitrarily-chosen
cutoff point.

If we want to have an explicit record of pruning rather than just
copying with a missing object, then I think we'd need to do it with an
external note to say "It's OK that commit XXXXXXXXXXX is missing".

> Thirdly, I don't actually want my new tree to depend on a conversion of
> the old BK tree.
> 
> Two reasons: if it's a really full conversion, there are definitely going
> to be issues with BitMover. They do not want people to try to reverse
> engineer how they do namespace merges

Don't think of it as "a conversion of the old BK tree". It's just an
import of Linux's development history. This isn't going to help
reverse-engineer how BK does merges; it's just our own revision history.
I'm not sure exactly how Thomas is extracting it, but AIUI it's all
obtainable from the SCCS files anyway without actually resorting to
using BK itself. 

There's nothing here for Larry to worry about. It's not as if we're
actually using BK to develop git by observing BK's behaviour w.r.t
merges and trying to emulate it. Besides -- if we wanted to do that,
we'd need to use the _BK_ version of the tree; the git version wouldn't
help us much anyway.

And given that BK's merges are based on individual files and we're not
going that route with git, it's not clear how much we could lift
directly from BK even if we _were_ going to try that.

> The other reason is just the really obvious one: in the last week, I've
> already changed the format _twice_ in ways that change the hash. As long
> as it's 119MB of data, it's not going to be too nasty to do again.

That's fine. But by the time we settle on a format and actually start
using it in anger, it'd be good to be sure that it _is_ possible to
track development from current trees all the way back -- be that with
explicit reference to pruned history as you suggest, or with absent
parents as I still prefer.

> it's not that it's necessarily the wrong thing to do, but I think it
> is the wrogn thing to do _now_.

OK, time for us to keep arguing over the implementation details of how
we prune history then :)

-- 
dwmw2

