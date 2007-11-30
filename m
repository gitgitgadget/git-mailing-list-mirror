From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix a pathological case in git detecting proper renames
Date: Thu, 29 Nov 2007 16:41:09 -0800 (PST)
Message-ID: <alpine.LFD.0.9999.0711291625580.8458@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0711291050440.1711@blarg.am.freescale.net> <alpine.LFD.0.9999.0711290934260.8458@woody.linux-foundation.org> <28BD703B-24D3-41D6-8360-240A884B1305@kernel.crashing.org> <alpine.LFD.0.9999.0711291122050.8458@woody.linux-foundation.org>
 <41CB0B7D-5AC1-4703-BA99-21622A410F93@kernel.crashing.org> <alpine.LFD.0.9999.0711291303000.8458@woody.linux-foundation.org> <alpine.LFD.0.9999.0711291442300.8458@woody.linux-foundation.org> <20071129235253.GA10261@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Kumar Gala <galak@kernel.crashing.org>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 30 01:42:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IxtxM-0004IL-Gg
	for gcvg-git-2@gmane.org; Fri, 30 Nov 2007 01:42:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932722AbXK3Alw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2007 19:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762009AbXK3Alv
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Nov 2007 19:41:51 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:35337 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1763303AbXK3Alu (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 29 Nov 2007 19:41:50 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAU0f9G9023094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 29 Nov 2007 16:41:10 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id lAU0f99V015492;
	Thu, 29 Nov 2007 16:41:09 -0800
In-Reply-To: <20071129235253.GA10261@coredump.intra.peff.net>
X-Spam-Status: No, hits=-2.428 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_52
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66580>



On Thu, 29 Nov 2007, Jeff King wrote:
> 
> I think it will get worse, because you are simultaneously calculating
> all of the similarity scores bit by bit rather than doing a loop. Though
> perhaps you mean at the end you will end up with a list of src/dst pairs
> sorted by score, and you can loop over that.

Well, after thinking about this a bit, I think there's a solution that may 
work well with the current thing too: instead of looping just *once* over 
the list of rename pairs, loop twice - and simply refuse to do copies on 
the first loop.

This trivial patch does that, and turns Kumar's test-case into a perfect 
rename list.

It's not pretty, it's not smart, but it seems to work. There's something 
to be said for keeping it simple and stupid.

And it should not be nearly as expensive as it may _look_. Yes, the loop 
is "(i = 0; i < num_create * num_src; i++)", but the important part is 
that the whole array is sorted by rename score, and we have a

	if (mx[i].score < minimum_score)
		break;

in it, so uthe loop actually would tend to terminate rather quickly.

Anyway, Kumar, the thing to take away from this is:

 - git really doesn't even *care* about the whole "rename detection" 
   internally, and any commits you have done with renames are totally 
   independent of the heuristics we then use to *show* the renames.

 - the rename detection really is for just two reasons: (a) keep humans 
   happy, and keep the diffs small and (b) help automatic merging across 
   renames. So getting renames right is certainly good, but it's more of a 
   "politeness" issue than a "correctness" issue, although the merge 
   portion of it does matter a lot sometimes.

 - the important thing here is that you can commit your changes and not 
   worry about them being somehow "corrupted" by lack of rename detection, 
   even if you commit them with a version of git that doesn't do rename 
   detection the way you expected it. The rename detection is an 
   "after-the-fact" thing, not something that actually gets saved in the 
   repository, which is why we can change the heuristics _after_ seeing 
   examples, and the examples magically correct themselves!

 - try out the two patches I've posted, and see if they work for you. They 
   pass the test-suite, and the output for your example commit looks sane, 
   but hey, if you have other test-cases, try them out.

Here's Kumar's pretty diffstat with both my patches:

	 Makefile                                         |    6 +++---
	 board/{cds => freescale}/common/cadmus.c         |    0
	 board/{cds => freescale}/common/cadmus.h         |    0
	 board/{cds => freescale}/common/eeprom.c         |    0
	 board/{cds => freescale}/common/eeprom.h         |    0
	 board/{cds => freescale}/common/ft_board.c       |    0
	 board/{cds => freescale}/common/via.c            |    0
	 board/{cds => freescale}/common/via.h            |    0
	 board/{cds => freescale}/mpc8541cds/Makefile     |    0
	 board/{cds => freescale}/mpc8541cds/config.mk    |    0
	 board/{cds => freescale}/mpc8541cds/init.S       |    0
	 board/{cds => freescale}/mpc8541cds/mpc8541cds.c |    0
	 board/{cds => freescale}/mpc8541cds/u-boot.lds   |    4 ++--
	 board/{cds => freescale}/mpc8548cds/Makefile     |    0
	 board/{cds => freescale}/mpc8548cds/config.mk    |    0
	 board/{cds => freescale}/mpc8548cds/init.S       |    0
	 board/{cds => freescale}/mpc8548cds/mpc8548cds.c |    0
	 board/{cds => freescale}/mpc8548cds/u-boot.lds   |    4 ++--
	 board/{cds => freescale}/mpc8555cds/Makefile     |    0
	 board/{cds => freescale}/mpc8555cds/config.mk    |    0
	 board/{cds => freescale}/mpc8555cds/init.S       |    0
	 board/{cds => freescale}/mpc8555cds/mpc8555cds.c |    0
	 board/{cds => freescale}/mpc8555cds/u-boot.lds   |    4 ++--
	 23 files changed, 9 insertions(+), 9 deletions(-)

and here it is before:

	 Makefile                                           |    6 +-
	 board/cds/mpc8548cds/Makefile                      |   60 -----
	 board/cds/mpc8555cds/Makefile                      |   60 -----
	 board/cds/mpc8555cds/init.S                        |  255 --------------------
	 board/cds/mpc8555cds/u-boot.lds                    |  150 ------------
	 board/{cds => freescale}/common/cadmus.c           |    0
	 board/{cds => freescale}/common/cadmus.h           |    0
	 board/{cds => freescale}/common/eeprom.c           |    0
	 board/{cds => freescale}/common/eeprom.h           |    0
	 board/{cds => freescale}/common/ft_board.c         |    0
	 board/{cds => freescale}/common/via.c              |    0
	 board/{cds => freescale}/common/via.h              |    0
	 board/{cds => freescale}/mpc8541cds/Makefile       |    0
	 board/{cds => freescale}/mpc8541cds/config.mk      |    0
	 board/{cds => freescale}/mpc8541cds/init.S         |    0
	 board/{cds => freescale}/mpc8541cds/mpc8541cds.c   |    0
	 board/{cds => freescale}/mpc8541cds/u-boot.lds     |    4 +-
	 .../mpc8541cds => freescale/mpc8548cds}/Makefile   |    0
	 board/{cds => freescale}/mpc8548cds/config.mk      |    0
	 board/{cds => freescale}/mpc8548cds/init.S         |    0
	 board/{cds => freescale}/mpc8548cds/mpc8548cds.c   |    0
	 board/{cds => freescale}/mpc8548cds/u-boot.lds     |    4 +-
	 .../mpc8541cds => freescale/mpc8555cds}/Makefile   |    0
	 board/{cds => freescale}/mpc8555cds/config.mk      |    0
	 .../mpc8541cds => freescale/mpc8555cds}/init.S     |    0
	 board/{cds => freescale}/mpc8555cds/mpc8555cds.c   |    0
	 .../mpc8541cds => freescale/mpc8555cds}/u-boot.lds |    4 +-
	 27 files changed, 9 insertions(+), 534 deletions(-)

so it certainly makes the diffs prettier.

		Linus

---
 diffcore-rename.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/diffcore-rename.c b/diffcore-rename.c
index f64294e..3d37725 100644
--- a/diffcore-rename.c
+++ b/diffcore-rename.c
@@ -497,6 +497,19 @@ void diffcore_rename(struct diff_options *options)
 	qsort(mx, num_create * num_src, sizeof(*mx), score_compare);
 	for (i = 0; i < num_create * num_src; i++) {
 		struct diff_rename_dst *dst = &rename_dst[mx[i].dst];
+		struct diff_filespec *src;
+		if (dst->pair)
+			continue; /* already done, either exact or fuzzy. */
+		if (mx[i].score < minimum_score)
+			break; /* there is no more usable pair. */
+		src = rename_src[mx[i].src].one;
+		if (src->rename_used)
+			continue;
+		record_rename_pair(mx[i].dst, mx[i].src, mx[i].score);
+		rename_count++;
+	}
+	for (i = 0; i < num_create * num_src; i++) {
+		struct diff_rename_dst *dst = &rename_dst[mx[i].dst];
 		if (dst->pair)
 			continue; /* already done, either exact or fuzzy. */
 		if (mx[i].score < minimum_score)
