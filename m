From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Fix revision log diff setup, avoid unnecessary diff generation
Date: Sat, 29 Sep 2007 09:50:39 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0709290932040.3579@woody.linux-foundation.org>
References: <e5bfff550709290429n291968f2md8068a945ff7a79e@mail.gmail.com>
 <20070929123724.01BB045EC@madism.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Pierre Habouzit <madcoder@debian.org>
X-From: git-owner@vger.kernel.org Sat Sep 29 18:51:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbfXP-0004Pu-S5
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 18:51:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755102AbXI2QvS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 12:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754968AbXI2QvS
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 12:51:18 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38573 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754744AbXI2QvR (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 29 Sep 2007 12:51:17 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8TGoeam001921
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 29 Sep 2007 09:50:41 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l8TGodUi024127;
	Sat, 29 Sep 2007 09:50:39 -0700
In-Reply-To: <20070929123724.01BB045EC@madism.org>
X-Spam-Status: No, hits=-2.447 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_41
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.41__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59478>


We used to incorrectly start calculating diffs whenever any argument but 
'-z' was recognized by the diff options parsing. That was bogus, since not 
all arguments result in diffs being needed, so we just waste a lot of time 
and effort on calculating diffs that don't matter.

This actually also fixes another bug in "git log". Try this:

	git log -C

and notice how it prints an extra empty line in between log entries, even 
though it never prints the actual diff (because we didn't ask for any diff 
format, so the diff machinery never prints anything).

With this patch, that bogus empty line is gone, because "revs->diff" is 
never set.  So this isn't just a "wasted time and effort" issue, it's also 
a slight semantic fix.

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---
On Sat, 29 Sep 2007, Pierre Habouzit wrote:
>
> -				if (strcmp(argv[i], "-z"))
> -					revs->diff = 1;
> +				revs->diff = strcmp(argv[i], "-z")
> +					&& strcmp(argv[i], "--color")
> +					&& strcmp(argv[i], "--no-color");

The old code was already pretty damn ugly, the new code is worse (never 
mind the bug).

I don't think we should care *at*all* about the actual argument string, we 
should just look at what the diffopts end up being at the end.

So I would suggest a patch like the appended instead!

(Maybe there are other cases where we'd want to run the diff, but I can't 
think of any)

		Linus

---
 revision.c |   10 ++++++++--
 1 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 33d092c..6584713 100644
--- a/revision.c
+++ b/revision.c
@@ -1209,8 +1209,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 
 			opts = diff_opt_parse(&revs->diffopt, argv+i, argc-i);
 			if (opts > 0) {
-				if (strcmp(argv[i], "-z"))
-					revs->diff = 1;
 				i += opts - 1;
 				continue;
 			}
@@ -1254,6 +1252,14 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 		add_pending_object_with_mode(revs, object, def, mode);
 	}
 
+	/* Did the user ask for any diff output? Run the diff! */
+	if (revs->diffopt.output_format & ~DIFF_FORMAT_NO_OUTPUT)
+		revs->diff = 1;
+
+	/* Pickaxe needs diffs */
+	if (revs->diffopt.pickaxe)
+		revs->diff = 1;
+
 	if (revs->topo_order)
 		revs->limited = 1;
 
