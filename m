From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Comments on recursive merge..
Date: Wed, 9 Nov 2005 13:58:33 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511091348530.4627@g5.osdl.org>
References: <Pine.LNX.4.64.0511070837530.3193@g5.osdl.org>
 <20051107225807.GA10937@c165.ib.student.liu.se> <7vll00ov2l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511071629270.3247@g5.osdl.org>
 <Pine.LNX.4.63.0511081254520.2649@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051108210211.GA23265@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081351020.3247@g5.osdl.org>
 <20051108223609.GA4805@c165.ib.student.liu.se> <Pine.LNX.4.64.0511081450080.3247@g5.osdl.org>
 <20051109003236.GA30496@pasky.or.cz> <Pine.LNX.4.64.0511081646160.3247@g5.osdl.org>
 <7vlkzyd4aq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511081716450.3247@g5.osdl.org>
 <7v8xvyd2bh.fsf@assigned-by-dhcp.cox.net> <7v4q6mgm1l.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0511090800330.3247@g5.osdl.org> <7virv1efzv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 09 23:01:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZxy9-000146-Jl
	for gcvg-git@gmane.org; Wed, 09 Nov 2005 22:59:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030361AbVKIV66 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 Nov 2005 16:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030786AbVKIV66
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Nov 2005 16:58:58 -0500
Received: from smtp.osdl.org ([65.172.181.4]:10193 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030361AbVKIV65 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Nov 2005 16:58:57 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jA9LwYnO031144
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 9 Nov 2005 13:58:35 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jA9LwXWa016640;
	Wed, 9 Nov 2005 13:58:34 -0800
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virv1efzv.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11418>



On Wed, 9 Nov 2005, Junio C Hamano wrote:
> 
> The current show-branch code does the same as merge-base in the
> pathological example depicted in merge-base.c, but they seem to
> do different things to this picture (commit grows from bottom to
> top, time flows alphabetically; find base between G and H).
> 
>                  H
>                 / \
>            G   A   \
>            |\ /     \ 
>            | B       \
>            |  \       \
>             \  C       F
>              \  \     / 
>               \  D   /   
>                \ |  /
>                 \| /
> 		   E
> 
> "git-merge-base --all" says the merge bases are B and E, while
> "show-branch --merge-base" mentions only B.  In this case the
> latter is probably the better answer.

I don't agree.

Sure, B _may_ be the right answer for a particular merge strategt, but 
there's no way of knowing. Maybe all the big changes came in through F, 
and H is the merge that sorted that out, and E actually ends up being the 
better base.

So I think from a correctness standpoint, the only thing that matters is 
"git-merge-base --all", and anything that doesn't know to return both E 
and B looks potentially buggy.

> Actually git-merge-base without --all only mentions E.

Well, we should really consider anything that doesn't take them all into 
account to be a bug waiting to happen (or rather, a merge waiting for a 
disaster), but E is the right one, since it's the more recent one).

Now, this case obviously depends on history being almost maximally insane 
(ie pretty much _all_ the dates are wrong). So in practice we probably 
don't care.

So maybe "git-show-branch --merge-base" ends up acceptable as a faster way 
to do the quick "let's see if we can find _some_ merge-base to do the 
in-index merge with", but personally I'd much rather always do a 
"git-merge-base --all", and only do the fast index merge if we only have 
one potential parent.

That way there would never any question about what the "quick merge" does.

			Linus
