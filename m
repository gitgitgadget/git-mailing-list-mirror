From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-name-rev off-by-one bug
Date: Tue, 29 Nov 2005 22:11:54 -0800
Message-ID: <7vek4y1x79.fsf@assigned-by-dhcp.cox.net>
References: <20051130001503.28498.qmail@science.horizon.com>
	<Pine.LNX.4.64.0511291742000.3135@g5.osdl.org>
	<7v4q5u50gp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511291852530.3099@g5.osdl.org>
	<Pine.LNX.4.64.0511292031280.3099@g5.osdl.org>
	<7vslte1y5z.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 07:18:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhLCC-0007Le-8y
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 07:12:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbVK3GL5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 01:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751083AbVK3GL5
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 01:11:57 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:10658 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1751082AbVK3GL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 01:11:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130061033.VANC17690.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 01:10:33 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vslte1y5z.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 29 Nov 2005 21:51:04 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12987>

Junio C Hamano <junkio@cox.net> writes:

> Linus Torvalds <torvalds@osdl.org> writes:
>
>> Whaddaya think? I really like it.
>
> Yes.  Maybe split this into 3 pieces.  I do not want to waste
> your time with that, so will take the liberty to do so myself,
> with appropriate commit log messages, if you do not mind.
>
>  1. give diff-files -[012] flags.
>  2. merge-one-file leaves unmerged index entries.
>  3. always use -M -p in git-diff.
>
> I do not have any issue against #1.

Actually there is one.  If we are asked to do diff -1 and an
unmerged path does not have stage #2 but stage #1 entry exists,
we would end up showing that stage #1, without telling the user
that we are showing something different from what was asked.
How about doing something like this, on top of yours?

--- diff-files.c
+++ diff-files.c
@@ -117,8 +117,11 @@
 			 */
 			i--;
 			/*
-			 * Show the diff for the 'ce' we chose
+			 * Show the diff for the 'ce' if we found the one
+			 * from the desired stage.
 			 */
+			if (ce_stage(ce) != diff_unmerged_stage)
+				continue;
 		}
 
 		if (lstat(ce->name, &st) < 0) {
