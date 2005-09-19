From: Junio C Hamano <junkio@cox.net>
Subject: Re: [BUG] git-show-branch cant show --more
Date: Mon, 19 Sep 2005 01:12:18 -0700
Message-ID: <7vwtldtr19.fsf@assigned-by-dhcp.cox.net>
References: <E1EHCAx-0007xp-JW@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 10:12:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHGlX-0001DH-Du
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 10:12:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVISIMU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 04:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932372AbVISIMU
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 04:12:20 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:5579 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932369AbVISIMU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2005 04:12:20 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050919081219.TAPV29184.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 19 Sep 2005 04:12:19 -0400
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <E1EHCAx-0007xp-JW@jdl.com> (Jon Loeliger's message of "Sun, 18
	Sep 2005 22:18:39 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8845>

Jon Loeliger <jdl@freescale.com> writes:

> I realize I probably dumbly expected more history out
> of a partial git repository than is actually present,
> but a segmentation fault wasn't a nice way to tell me. :-)
>
> Start with just Paul's repo over here:
>
> rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git

Hmph.  That repository does not look partial to me, although it
seems to use alternates to borrow heavily from Linus.

  $ git clone rsync://rsync.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git ppc-merge
  $ git show-branch --more=10
  [master] ppc32: Allow user to individual select CHRP/PMAC/PREP config
  [master~1] powerpc: Merge simplified sections.h into asm-powerpc
  [master~2] powerpc: Remove section free() and linker script bits
  [master~3] powerpc: Remove sections use from ppc64 and drivers
  [master~4] powerpc: Remove sections use from ppc
  [master~5] ppc32: Removed non-inlined versions of local_irq* functions
  [master~6] powerpc: Merged ppc_asm.h
  [master~7] powerpc: Merge kmap_types.h
  [master~8] [NETFILTER]: Solve Kconfig dependency problem
  [master~9] [IPV6]: Check connect(2) status for IPv6 UDP socket (Re: xfrm_lookup)
  [master~10] [BOND]: Fix bond_init() error path handling.
  $ git --version
  git version 0.99.7

But in any case you are right.  We should barf a bit nicely when
we encounter an corrupt repository.  How about something like
this (not fully tested)?

------------
[PATCH] Be nice when running in a corrupt repository.

We may end up trying to print a commit we do not have but only
whose existence is known to us because another commit we have
refer to it.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
diff --git a/show-branch.c b/show-branch.c
--- a/show-branch.c
+++ b/show-branch.c
@@ -196,8 +196,11 @@ static void show_one_commit(struct commi
 {
 	char pretty[128], *cp;
 	struct commit_name *name = commit->object.util;
-	pretty_print_commit(CMIT_FMT_ONELINE, commit->buffer, ~0,
-			    pretty, sizeof(pretty));
+	if (commit->object.parsed)
+		pretty_print_commit(CMIT_FMT_ONELINE, commit->buffer, ~0,
+				    pretty, sizeof(pretty));
+	else
+		strcpy(pretty, "(unavailable)");
 	if (!strncmp(pretty, "[PATCH] ", 8))
 		cp = pretty + 8;
 	else
