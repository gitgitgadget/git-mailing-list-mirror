From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git and larger trees, not so fast?
Date: Fri, 10 Aug 2007 08:49:56 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708100836340.30176@woody.linux-foundation.org>
References: <20070809163026.GD568@mbox.bz>
 <alpine.LFD.0.999.0708090948250.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091015500.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091056180.25146@woody.linux-foundation.org>
 <7vmyx0y3vp.fsf@assigned-by-dhcp.cox.net> <7v7io4xwvp.fsf@assigned-by-dhcp.cox.net>
 <20070809165218.9b76ebf7.seanlkml@sympatico.ca>
 <alpine.LFD.0.999.0708091426050.25146@woody.linux-foundation.org>
 <alpine.LFD.0.999.0708091444550.25146@woody.linux-foundation.org>
 <7vtzr8wemb.fsf@assigned-by-dhcp.cox.net> <7vps1wwa5w.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708091734210.25146@woody.linux-foundation.org>
 <7vhcn8w6sw.fsf@assigned-by-dhcp.cox.net>
 <alpine.LFD.0.999.0708091754150.25146@woody.linux-foundation.org>
 <7v643ovyli.fsf@assigned-by-dhcp.cox.net>
 <7vy7gkue5s.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Sean <seanlkml@sympatico.ca>, moe <moe-git@mbox.bz>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 17:50:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IJWlE-0006mX-I4
	for gcvg-git@gmane.org; Fri, 10 Aug 2007 17:50:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757745AbXHJPun (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Aug 2007 11:50:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936500AbXHJPun
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Aug 2007 11:50:43 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:52964 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S937382AbXHJPuj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 10 Aug 2007 11:50:39 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AFo2m2020065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 10 Aug 2007 08:50:07 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l7AFnuRr028674;
	Fri, 10 Aug 2007 08:49:56 -0700
In-Reply-To: <7vy7gkue5s.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-2.724 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: lf$Revision: 1.184 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55547>



On Thu, 9 Aug 2007, Junio C Hamano wrote:
> 
> FWIW, moe's script with and without two patches gives these
> numbers for me.

Btw, I really think it's worth doing even just the hacky patches at this 
stage, even though it's late in the game for 1.5.3.

That performance problem is serious enough that I'd call it a major bug. 
Performance has always been one of the goals of git, and when you have a 
difference between 17s and 0.7s for "git status", that's a *huge* 
usability thing. It would be sad to release 1.5.3 with a known bug.

[ Some people don't think performance issues are "real bugs", and I think 
  such people shouldn't be allowed to program. ]

Side note: your first patch is actually quite noticeable on even just the 
kernel. Not nearly as much, but without it, I get about 0.5s, and with it, 
I get consistently under 0.3s. So it's about a 40% improvement even for 
smaller projects (and it's probably much more if you have a CPU with a 
smaller cache: my Core 2 Duo has 4MB of L2 cache, and a lot of the index 
will even fit in the L1 - a slower CPU with less cache will see a bigger 
impact, and with smaller repositories, from the unnecessary memory 
moving).

While 0.5s -> 0.3s may not sound like much, on a slower machine where it 
might otherwise be 2.5s -> 1.5s, that's likely to be quite noticeable.

In fact, I can tell even on my machine: 0.3s is visible as a "I'm clearly 
thinking about it" delay (quite frankly, it would be better at 0.1s, which 
is "immediate"), but 0.5s is already approaching the point where you 
actually wait for the answer (rather than just notice that it wasn't quite 
immediate).

				Linus
