From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Make "git gc" pack all refs by default
Date: Thu, 24 May 2007 11:41:39 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705241132400.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
To: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu May 24 20:41:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrIFx-0000ax-IA
	for gcvg-git@gmane.org; Thu, 24 May 2007 20:41:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750829AbXEXSlp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 14:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750835AbXEXSlp
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 14:41:45 -0400
Received: from smtp1.linux-foundation.org ([207.189.120.13]:34803 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750829AbXEXSlo (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 24 May 2007 14:41:44 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l4OIfenm012724
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 24 May 2007 11:41:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l4OIfdFK032400;
	Thu, 24 May 2007 11:41:40 -0700
X-Spam-Status: No, hits=-5.091 required=5 tests=AWL,BAYES_00,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.179 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48289>


I've taught myself to use "git gc" instead of doing the repack explicitly, 
but it doesn't actually do what I think it should do.

We've had packed refs for a long time now, and I think it just makes sense 
to pack normal branches too. So I end up having to do

	git pack-refs --all --prune

in order to get a nice git repo that doesn't have any unnecessary files.

So why not just do that in "git gc"? It's not as if there really is any 
downside to packing branches, even if they end up changing later. Quite 
often they don't, and even if they do, so what?

Also, make the default for refs packing just be an unambiguous "do it", 
rather than "do it by default only for non-bare repositories". If you want 
that behaviour, you can always just add a

	[gc]
		packrefs = notbare

in your ~/.gitconfig file, but I don't actually see why bare would be any 
different (except for the broken reason that http-fetching used to be 
totally broken, and not doing it just meant that it didn't even get 
fixed in a timely manner!).

So here's a trivial patch to make "git gc" do a better job. Hmm?

Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
---

Side note: I'd also like to get rid of "info/refs", and just make http 
fetching use "packed-refs" instead. That would imply that 
"update_server_info()" should do "git pack-refs --all" too! This patch 
doesn't do it, though.

 builtin-gc.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 8ea165a..45025fb 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -17,11 +17,11 @@
 
 static const char builtin_gc_usage[] = "git-gc [--prune] [--aggressive]";
 
-static int pack_refs = -1;
+static int pack_refs = 1;
 static int aggressive_window = -1;
 
 #define MAX_ADD 10
-static const char *argv_pack_refs[] = {"pack-refs", "--prune", NULL};
+static const char *argv_pack_refs[] = {"pack-refs", "--all", "--prune", NULL};
 static const char *argv_reflog[] = {"reflog", "expire", "--all", NULL};
 static const char *argv_repack[MAX_ADD] = {"repack", "-a", "-d", "-l", NULL};
 static const char *argv_prune[] = {"prune", NULL};
