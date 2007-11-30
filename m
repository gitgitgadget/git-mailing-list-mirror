From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Fix a pathological case in git detecting proper renames
Date: Thu, 29 Nov 2007 19:18:04 -0600
Message-ID: <AC8DD8B5-C41E-4195-9CD6-E1A327F1878A@kernel.crashing.org>
References: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net> <alpine.LFD.0.9999.0711290934260.8458@woody.linux-foundation.org> <28BD703B-24D3-41D6-8360-240A884B1305@kernel.crashing.org> <alpine.LFD.0.9999.0711291122050.8458@woody.linux-foundation.org> <41CB0B7D-5AC1-4703-BA99-21622A410F93@kernel.crashing.org> <alpine.LFD.0.9999.0711291303000.8458@woody.linux-foundation.org> <alpine.LFD.0.9999.0711291442300.8458@woody.linux-foundation.org> <20071129235253.GA10261@coredump.intra.peff.net> <alpine.LFD.0.9999.0711291625580.8458@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Nov 30 02:19:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxuX5-0005Ph-9w
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 02:19:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763578AbXK3BSs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 20:18:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763566AbXK3BSs
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 20:18:48 -0500
Received: from gate.crashing.org ([63.228.1.57]:56135 "EHLO gate.crashing.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757173AbXK3BSr (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2007 20:18:47 -0500
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gate.crashing.org (8.13.8/8.13.8) with ESMTP id lAU1I5u5017203;
	Thu, 29 Nov 2007 19:18:05 -0600
In-Reply-To: <alpine.LFD.0.9999.0711291625580.8458@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66594>


On Nov 29, 2007, at 6:41 PM, Linus Torvalds wrote:

>
>
> On Thu, 29 Nov 2007, Jeff King wrote:
>>
>> I think it will get worse, because you are simultaneously calculating
>> all of the similarity scores bit by bit rather than doing a loop.  
>> Though
>> perhaps you mean at the end you will end up with a list of src/dst  
>> pairs
>> sorted by score, and you can loop over that.
>
> Well, after thinking about this a bit, I think there's a solution  
> that may
> work well with the current thing too: instead of looping just *once*  
> over
> the list of rename pairs, loop twice - and simply refuse to do  
> copies on
> the first loop.
>
> This trivial patch does that, and turns Kumar's test-case into a  
> perfect
> rename list.

Glad I can be of use for something :)

> It's not pretty, it's not smart, but it seems to work. There's  
> something
> to be said for keeping it simple and stupid.
>
> And it should not be nearly as expensive as it may _look_. Yes, the  
> loop
> is "(i = 0; i < num_create * num_src; i++)", but the important part is
> that the whole array is sorted by rename score, and we have a
>
> 	if (mx[i].score < minimum_score)
> 		break;
>
> in it, so uthe loop actually would tend to terminate rather quickly.
>
> Anyway, Kumar, the thing to take away from this is:
>
> - git really doesn't even *care* about the whole "rename detection"
>   internally, and any commits you have done with renames are totally
>   independent of the heuristics we then use to *show* the renames.
>
> - the rename detection really is for just two reasons: (a) keep humans
>   happy, and keep the diffs small and (b) help automatic merging  
> across
>   renames. So getting renames right is certainly good, but it's more  
> of a
>   "politeness" issue than a "correctness" issue, although the merge
>   portion of it does matter a lot sometimes.

Yeah both of these dawned on me after my brain started working and  
thinking about what you were talking about when you say git manages  
'content' and thinking about how the content management correlates to  
the diffs we generate.

> - the important thing here is that you can commit your changes and not
>   worry about them being somehow "corrupted" by lack of rename  
> detection,
>   even if you commit them with a version of git that doesn't do rename
>   detection the way you expected it. The rename detection is an
>   "after-the-fact" thing, not something that actually gets saved in  
> the
>   repository, which is why we can change the heuristics _after_ seeing
>   examples, and the examples magically correct themselves!
>
> - try out the two patches I've posted, and see if they work for you.  
> They
>   pass the test-suite, and the output for your example commit looks  
> sane,
>   but hey, if you have other test-cases, try them out.

Only started using -M when a co-worker informed me about it.  But if I  
see other cases in the future I'll let you guys know.

> Here's Kumar's pretty diffstat with both my patches:
>
> 	 Makefile                                         |    6 +++---
> 	 board/{cds => freescale}/common/cadmus.c         |    0
> 	 board/{cds => freescale}/common/cadmus.h         |    0
> 	 board/{cds => freescale}/common/eeprom.c         |    0
> 	 board/{cds => freescale}/common/eeprom.h         |    0
> 	 board/{cds => freescale}/common/ft_board.c       |    0
> 	 board/{cds => freescale}/common/via.c            |    0
> 	 board/{cds => freescale}/common/via.h            |    0
> 	 board/{cds => freescale}/mpc8541cds/Makefile     |    0
> 	 board/{cds => freescale}/mpc8541cds/config.mk    |    0
> 	 board/{cds => freescale}/mpc8541cds/init.S       |    0
> 	 board/{cds => freescale}/mpc8541cds/mpc8541cds.c |    0
> 	 board/{cds => freescale}/mpc8541cds/u-boot.lds   |    4 ++--
> 	 board/{cds => freescale}/mpc8548cds/Makefile     |    0
> 	 board/{cds => freescale}/mpc8548cds/config.mk    |    0
> 	 board/{cds => freescale}/mpc8548cds/init.S       |    0
> 	 board/{cds => freescale}/mpc8548cds/mpc8548cds.c |    0
> 	 board/{cds => freescale}/mpc8548cds/u-boot.lds   |    4 ++--
> 	 board/{cds => freescale}/mpc8555cds/Makefile     |    0
> 	 board/{cds => freescale}/mpc8555cds/config.mk    |    0
> 	 board/{cds => freescale}/mpc8555cds/init.S       |    0
> 	 board/{cds => freescale}/mpc8555cds/mpc8555cds.c |    0
> 	 board/{cds => freescale}/mpc8555cds/u-boot.lds   |    4 ++--
> 	 23 files changed, 9 insertions(+), 9 deletions(-)
>
> and here it is before:
>
> 	 Makefile                                           |    6 +-
> 	 board/cds/mpc8548cds/Makefile                      |   60 -----
> 	 board/cds/mpc8555cds/Makefile                      |   60 -----
> 	 board/cds/mpc8555cds/init.S                        |  255  
> --------------------
> 	 board/cds/mpc8555cds/u-boot.lds                    |  150  
> ------------
> 	 board/{cds => freescale}/common/cadmus.c           |    0
> 	 board/{cds => freescale}/common/cadmus.h           |    0
> 	 board/{cds => freescale}/common/eeprom.c           |    0
> 	 board/{cds => freescale}/common/eeprom.h           |    0
> 	 board/{cds => freescale}/common/ft_board.c         |    0
> 	 board/{cds => freescale}/common/via.c              |    0
> 	 board/{cds => freescale}/common/via.h              |    0
> 	 board/{cds => freescale}/mpc8541cds/Makefile       |    0
> 	 board/{cds => freescale}/mpc8541cds/config.mk      |    0
> 	 board/{cds => freescale}/mpc8541cds/init.S         |    0
> 	 board/{cds => freescale}/mpc8541cds/mpc8541cds.c   |    0
> 	 board/{cds => freescale}/mpc8541cds/u-boot.lds     |    4 +-
> 	 .../mpc8541cds => freescale/mpc8548cds}/Makefile   |    0
> 	 board/{cds => freescale}/mpc8548cds/config.mk      |    0
> 	 board/{cds => freescale}/mpc8548cds/init.S         |    0
> 	 board/{cds => freescale}/mpc8548cds/mpc8548cds.c   |    0
> 	 board/{cds => freescale}/mpc8548cds/u-boot.lds     |    4 +-
> 	 .../mpc8541cds => freescale/mpc8555cds}/Makefile   |    0
> 	 board/{cds => freescale}/mpc8555cds/config.mk      |    0
> 	 .../mpc8541cds => freescale/mpc8555cds}/init.S     |    0
> 	 board/{cds => freescale}/mpc8555cds/mpc8555cds.c   |    0
> 	 .../mpc8541cds => freescale/mpc8555cds}/u-boot.lds |    4 +-
> 	 27 files changed, 9 insertions(+), 534 deletions(-)
>
> so it certainly makes the diffs prettier.

Much better.  I love with open source development works.

- k
