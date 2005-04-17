From: Junio C Hamano <junkio@cox.net>
Subject: (Resend) [PATCH] checkout-cache -a should not extract unmerged
 stages
Date: Sun, 17 Apr 2005 15:00:14 -0700
Message-ID: <7vis2lvzbl.fsf@assigned-by-dhcp.cox.net>
References: <7vy8bi0y2k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 17 23:57:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNHlH-0007gZ-E3
	for gcvg-git@gmane.org; Sun, 17 Apr 2005 23:57:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261499AbVDQWAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 18:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261500AbVDQWAj
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 18:00:39 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:26549 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S261499AbVDQWAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Apr 2005 18:00:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050417220014.PTEO22013.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 17 Apr 2005 18:00:14 -0400
To: Linus Torvalds <torvalds@osdl.org>, Petr Baudis <pasky@ucw.cz>
In-Reply-To: <7vy8bi0y2k.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 16 Apr 2005 22:30:43 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus,

    do you have any particular reason you did not want the patch
to skip unmerged ones when "checkout-cache -a" is done, and if
so could you let me know?

Here is what happens before the patch:

    $ ls -al
    total 16
    drwxrwsr-x  3 junio src 4096 Apr 17 14:30 ./
    drwxrwsr-x  8 junio src 4096 Apr 17 14:17 ../
    drwxr-sr-x  3 junio src 4096 Apr 17 14:30 .git/
    -rw-rw-r--  1 junio src   29 Apr 17 14:30 SS
    $ show-files --stage
    100644 9e26851b98ab7dd3a3b9653a2efb9b4de0465310 0 SS
    100644 e14bafaadce6c34768ba2ff8b3c6419e8839e7d2 1 TT
    100644 99ef1b30fc6d6ea186d6eac62619e1afd65ad64e 2 TT
    100644 033b9385f7a29882a6b4b34f67b20e2304d3489d 3 TT
    $ ../++linus/checkout-cache -a
    checkout-cache: SS already exists
    checkout-cache: TT already exists
    checkout-cache: TT already exists
    $ ls -al
    total 20
    drwxrwsr-x  3 junio src 4096 Apr 17 14:31 ./
    drwxrwsr-x  8 junio src 4096 Apr 17 14:17 ../
    drwxr-sr-x  3 junio src 4096 Apr 17 14:30 .git/
    -rw-rw-r--  1 junio src   29 Apr 17 14:30 SS
    -rw-rw-r--  1 junio src  363 Apr 17 14:31 TT

See those two warning for TT?  It has extracted stage 1 and
complaining about what it has done when it goes on to extract
stage 2 and 3.

At this point what is in TT is from the stage 1.

This behaviour is somewhat defensible, in that you are giving
the user a ready access to the "original" (from stage 1), and he
can continue cat-file blob other stages to decide what to do.
But I think that the way the user wants to resolve the unmerged
state is not our business and it is not particulary useful for
the plumbing layer to assume that he would always need stage 1
contents to arrive the merged result (e.g. sdiff between stage 2
and stage 3 would not require stage 1).

With the patch, you get this:

    $ checkout-cache -a
    checkout-cache: SS already exists
    checkout-cache: needs merge TT
    $ ls -al
    total 16
    drwxrwsr-x  3 junio src 4096 Apr 17 14:32 ./
    drwxrwsr-x  8 junio src 4096 Apr 17 14:17 ../
    drwxr-sr-x  3 junio src 4096 Apr 17 14:30 .git/
    -rw-rw-r--  1 junio src   29 Apr 17 14:30 SS

I think it is consistent with this behaviour you already have
merged:

    $ ../++linus/checkout-cache SS TT
    checkout-cache: SS already exists
    checkout-cache: TT is unmerged.
    $ ls -al
    total 16
    drwxrwsr-x  3 junio src 4096 Apr 17 14:32 ./
    drwxrwsr-x  8 junio src 4096 Apr 17 14:17 ../
    drwxr-sr-x  3 junio src 4096 Apr 17 14:30 .git/
    -rw-rw-r--  1 junio src   29 Apr 17 14:30 SS

Attached is a re-diff with an updated message.  

I could also send you a patch that implements an alternative
strategy.  With or without "-a", checkout of unmerged files can
result in something like this:

    $ checkout-cache -a
    checkout-cache: SS already exists
    checkout-cache: storing stage 1 for TT in TT~1~
    checkout-cache: storing stage 2 for TT in TT~2~
    checkout-cache: storing stage 3 for TT in TT~3~
    $ ls -al
    total 28
    drwxrwsr-x  3 junio src 4096 Apr 17 14:55 ./
    drwxrwsr-x  8 junio src 4096 Apr 17 14:17 ../
    drwxr-sr-x  3 junio src 4096 Apr 17 14:30 .git/
    -rw-rw-r--  1 junio src   29 Apr 17 14:30 SS
    -rw-rw-r--  1 junio src  363 Apr 17 14:55 TT~1
    -rw-rw-r--  1 junio src  363 Apr 17 14:55 TT~2
    -rw-rw-r--  1 junio src  363 Apr 17 14:55 TT~3

Maybe these two behaviours can be controlled with another
option (say, -m).

Petr, do you think this alternative behaviour would be useful
for Cogito when it starts using "read-tree -m"?

----------------------------------------------------------------
When checkout-cache -a is run, currently it attempts to extract
all existing unmerged stages to the same destination and
complains to what it itself has done for the first stage when it
tries to extract the later stages.  This is nonsensical.  Just
report the unmerged state and let the user sort the mess out
using "show-files --unmerged" and "cat-file blob".

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 checkout-cache.c |   11 +++++++++++
 1 files changed, 11 insertions(+)

--- ++linus/checkout-cache.c	2005-04-17 13:57:04.000000000 -0700
+++ ++junio/checkout-cache.c	2005-04-17 14:35:11.000000000 -0700
@@ -137,10 +137,21 @@
 
 static int checkout_all(void)
 {
+	struct cache_entry *unmerge_skipping = NULL;
 	int i;
 
 	for (i = 0; i < active_nr ; i++) {
 		struct cache_entry *ce = active_cache[i];
+		if (ce_stage(ce)) {
+			if (!unmerge_skipping ||
+			    strcmp(unmerge_skipping->name, ce->name))
+				fprintf(stderr,
+					"checkout-cache: needs merge %s\n",
+					ce->name);
+			unmerge_skipping = ce;
+			continue;
+		}
+		unmerge_skipping = NULL;
 		if (checkout_entry(ce) < 0)
 			return -1;
 	}


