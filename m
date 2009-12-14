From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] help.autocorrect: do not run a command if the command
 given is junk
Date: Mon, 14 Dec 2009 22:09:11 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912142146590.4985@pacific.mpi-cbg.de>
References: <4B263797.5070808@viscovery.net> <7v7hspjp3q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>,
	Alex Riesen <raa.lkml@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 22:24:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKIOj-0002Pa-5s
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 22:24:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756793AbZLNVXv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 16:23:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758215AbZLNVXt
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 16:23:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:40895 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750746AbZLNVXr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 16:23:47 -0500
Received: (qmail invoked by alias); 14 Dec 2009 21:04:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp071) with SMTP; 14 Dec 2009 22:04:57 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18nhApWbCEn8AYPPsbDspc8DVxjcIHvLqTRZIQ6R7
	6BFJv9Anvw8tHQ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v7hspjp3q.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135241>

Hi,

On Mon, 14 Dec 2009, Junio C Hamano wrote:

> I am curious about and would prefer to see the story behind '6' someday.

The '6' as a cut-off to the levenshtein distances we list when 
autocorrecting was derived in a totally scientific manner:

1) first I implemented Levenshtein-Damerau with a configurable weight of 
   neighbor flips ("switches"), substitutions, additions and deletions,

2) next I patched the code to sort the availablecommands by their distance 
   to the mispelt command,

3) as this lists way too much, I implemented a cut-off that was 
   configurable by an environment variable (without any safety checks, as 
   I did not plan to release that code anyway),

4) now comes the totally, unbelievably cunningly scientific part: I did a 
   self-experiment!  I deliberately mispelt commands in a totally random 
   manner!

5) then I changed the code to actually output the distances so I could 
   determine a cut-off that makes sense with my type of tyops,

6) after about 15 tries of deliberate mistakes (mostly doing what I 
   usually do, something like "git pull" and "git log" or something like 
   that, but watching TV, chatting on the phone _and_ cleaning the dishes 
   at the same time), I found that 5 was too low and 7 too large.

The number '6' happily coincided with the number of steps I needed to come 
up with the number.  You see?  The _perfect_ way to determine a completely 
arbitrary number.

Actually, you probably see that I just made up that number and tested a 
few times, and it seemed to work reasonably well.

FWIW almost the same procedure led to the weights 0, 2, 1 and 4 that you 
see in help.c.  The weights are basically factors with which mistakes are 
punished: if you just confuse two adjacent letters, such as "psuh" instead 
of "push" (which can be quite common if you use two hands, one on the left 
side, and one on the right side of the keyboard, with an en-US layout so 
many of us use, myself included) it costs 0.

If you write a different character than what you intended, the cost is 2.  
The idea behind it is that you're more likely to miss a key than to hit 
the wrong key.  With the laptop I am typing this email on, it is 
particularly likely that I miss a key, because there are certain 
key combinations where only the first key triggers an input event, but the 
second only triggers an input event when it is _released_ after the first 
one.  So when I type "er" real fast and happen to release the "e" key 
after the "r" key, no "r" appears on my screen.

Okay, so the weight for adding a character must be smaller than 
substituting a character, but why is the cost for deletion so high?  
Well, I really rarely type unnecessary characters (except when writing to 
the Git mailing list, arguably) so those costs must be substantially 
higher than for typing the wrong character.

My original plan was to log all my tyops into a log file and analyze those 
errors later, but then my initial 0, 2, 1, 4 and 6 constants worked well 
enough for me that I did not bother.

Satisfied?

Ciao,
Dscho
