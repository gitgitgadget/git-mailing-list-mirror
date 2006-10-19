From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [ANNOUNCE] Example Cogito Addon - cogito-bundle
Date: Thu, 19 Oct 2006 07:55:18 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610190747060.3962@g5.osdl.org>
References: <20061018053647.GA3507@coredump.intra.peff.net>
 <Pine.LNX.4.64.0610180739230.3962@g5.osdl.org> <20061018185225.GU20017@pasky.or.cz>
 <20061018185907.GV20017@pasky.or.cz> <7vy7rd1m4q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610181510510.1971@xanadu.home> <20061018191834.GA18829@spearce.org>
 <Pine.LNX.4.64.0610181525410.1971@xanadu.home> <20061018204626.GA19194@spearce.org>
 <Pine.LNX.4.64.0610181358200.3962@g5.osdl.org> <20061018214143.GF19194@spearce.org>
 <7vwt6xxofi.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610181542160.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610181910440.1971@xanadu.home> <Pine.LNX.4.64.0610181655430.3962@g5.osdl.org>
 <7vac3tx900.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 19 16:56:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GaZIz-0004LR-8m
	for gcvg-git@gmane.org; Thu, 19 Oct 2006 16:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946102AbWJSOz3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Oct 2006 10:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946105AbWJSOz3
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Oct 2006 10:55:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53137 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1946102AbWJSOz2 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Oct 2006 10:55:28 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k9JEtIaX007901
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 19 Oct 2006 07:55:19 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k9JEtIJh012357;
	Thu, 19 Oct 2006 07:55:18 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vac3tx900.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.971 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.95__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29353>



On Wed, 18 Oct 2006, Junio C Hamano wrote:
>
> Linus Torvalds <torvalds@osdl.org> writes:
> >
> > Actually, I've hit an impasse.
> >
> > So there's _another_ way of fixing a thin pack: it's to expand the objects 
> > without a base into non-delta objects, and keeping the number of objects 
> > in the pack the same. But _again_, we don't actually know which ones to 
> > expand until it's too late.
> 
> pack-objects.c::write_one() makes sure that we write out base
> immediately after delta if we haven't written out its base yet,
> so I suspect if you buffer one delta you should be Ok, no?

It doesn't matter. I realized that my bogus patch to unpack-objects was 
more seriously broken anyway: even the "un-deltify every single object" 
was broken. And that's despite the fact that I _tested_ it, and verified 
the end result by hand.

Why? Because I tested it within one repo, by just piping the output of 
git-pack-objects --stdout directly to the repacker. That seemed to be a 
good way to test it without setting up anything bigger. But it turns out 
that it misses one of the big problems: if you don't unpack the objects in 
a way that later phases can read, none of the streaming code works at all, 
and you have to buffer up _everything_ in memory just to be able to read 
any previous _non_delta objects too.

So my patch-series works - but it only works in a repo that already has 
all the objects in question, because then it can look up the objects in 
the original database. Which makes it useless. Duh.

So forget about unpack-objects. It's designed to be streaming (and it's a 
_good_ design for what it does), but repacking really cannot be done that 
way. Repacking needs to be done by saving the thin pack to disk, and then 
doing a multi-pass over it (like git-index-pack does, for example).

Just throw my patch away. It's not even useful as a basis for anything 
else, unless you want to use it as a way to keep all the objects in memory 
and use the "unpack-objects" logic to just _parse_ the incoming pack.

I suspect using "index-pack" is saner (since it already has the multi-pass 
logic), or just doing somethign that maps all the objects in memory, and 
then calls builtin-pack-objects once it has set up the new thin pack so 
that others can see/use the new objects without realizing that they aren't 
in the canonical pack-format.

		Linus
