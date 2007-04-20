From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: cg-log "fatal: bad revision ''"
Date: Fri, 20 Apr 2007 16:25:50 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0704201554550.9964@woody.linux-foundation.org>
References: <1Hergt-0EBwVE0@fwd29.aul.t-online.de> <20070420135816.GO4489@pasky.or.cz>
 <Pine.LNX.4.64.0704201900430.4275@castor.milkiway.cos>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, Git Mailing List <git@vger.kernel.org>
To: Michael Dressel <MichaelTiloDressel@t-online.de>
X-From: git-owner@vger.kernel.org Sat Apr 21 01:26:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hf2Uh-0002lF-NT
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 01:26:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751220AbXDTX0B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Apr 2007 19:26:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbXDTX0B
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Apr 2007 19:26:01 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:43522 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751220AbXDTX0A (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Apr 2007 19:26:00 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l3KNPps2016450
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 20 Apr 2007 16:25:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3KNPo9r026288;
	Fri, 20 Apr 2007 16:25:50 -0700
In-Reply-To: <Pine.LNX.4.64.0704201900430.4275@castor.milkiway.cos>
X-Spam-Status: No, hits=-6.039 required=5 tests=AWL,BAYES_00,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45137>



On Fri, 20 Apr 2007, Michael Dressel wrote:
> 
> Thanx for the reply. Is there a way to follow renaming at all, either 
> with cogito or git?

"git blame" will follow renames, but doesn't really show things as a log, 
more just as a "these commits mattered" thing.

You can use something like this patch to then make it *look* like a "log" 
function.

Junio - I really think that something along these lines is worth doing, 
but I wonder what the right semantics are. This patch is stupid, and just 
keeps the "blame" semantics, just showing it in a "log format". It does 
mean that when I do

	git blame -C --log block/ll_rw_block.c

it will show entries for the old drivers/block/ll_rw_blk.c location.

HOWEVER, it's still broken, because when you do logging, you don't 
actually care about the diffs at all, so *any* difference from the 
previous version should show up, even if the lines don't show up in the 
end result. So this doesn't really do what people actually *want* to do, 
it does somethign much more complicated ;)

		Linus

---
 builtin-blame.c |   21 +++++++++++++++++----
 1 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/builtin-blame.c b/builtin-blame.c
index 8919b02..ee98753 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -16,6 +16,7 @@
 #include "quote.h"
 #include "xdiff-interface.h"
 #include "cache-tree.h"
+#include "log-tree.h"
 
 static char blame_usage[] =
 "git-blame [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file\n"
@@ -30,6 +31,7 @@ static char blame_usage[] =
 "  -L n,m              Process only line range n,m, counting from 1\n"
 "  -M, -C              Find line movements within and across files\n"
 "  --incremental       Show blame entries as we find them, incrementally\n"
+"  --log               Show blame entries as a log\n"
 "  --contents file     Use <file>'s contents as the final image\n"
 "  -S revs-file        Use revisions from revs-file instead of calling git-rev-list\n";
 
@@ -42,6 +44,7 @@ static int show_root;
 static int blank_boundary;
 static int incremental;
 static int cmd_is_annotate;
+static int log;
 
 #ifndef DEBUG
 #define DEBUG 0
@@ -1370,11 +1373,15 @@ static void write_filename_info(const char *path)
  * The blame_entry is found to be guilty for the range.  Mark it
  * as such, and show it in incremental output.
  */
-static void found_guilty_entry(struct blame_entry *ent)
+static void found_guilty_entry(struct rev_info *revs, struct blame_entry *ent)
 {
 	if (ent->guilty)
 		return;
 	ent->guilty = 1;
+	if (log) {
+		log_tree_commit(revs, ent->suspect->commit);
+		return;
+	}
 	if (incremental) {
 		struct origin *suspect = ent->suspect;
 
@@ -1443,7 +1450,7 @@ static void assign_blame(struct scoreboard *sb, struct rev_info *revs, int opt)
 		/* Take responsibility for the remaining entries */
 		for (ent = sb->ent; ent; ent = ent->next)
 			if (same_suspect(ent->suspect, suspect))
-				found_guilty_entry(ent);
+				found_guilty_entry(revs, ent);
 		origin_decref(suspect);
 
 		if (DEBUG) /* sanity */
@@ -2072,7 +2079,6 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	cmd_is_annotate = !strcmp(argv[0], "annotate");
 
 	git_config(git_blame_config);
-	save_commit_buffer = 0;
 
 	opt = 0;
 	seen_dashdash = 0;
@@ -2123,6 +2129,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		}
 		else if (!strcmp("--incremental", arg))
 			incremental = 1;
+		else if (!strcmp("--log", arg))
+			log = 1;
 		else if (!strcmp("--score-debug", arg))
 			output_option |= OUTPUT_SHOW_SCORE;
 		else if (!strcmp("-f", arg) ||
@@ -2244,6 +2252,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	init_revisions(&revs, NULL);
 	setup_revisions(unk, argv, &revs, NULL);
+	revs.abbrev = DEFAULT_ABBREV;
+	revs.commit_format = CMIT_FMT_DEFAULT;
+	revs.verbose_header = 1;
+	revs.always_show_header = 1;
+
 	memset(&sb, 0, sizeof(sb));
 
 	/*
@@ -2335,7 +2348,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 
 	assign_blame(&sb, &revs, opt);
 
-	if (incremental)
+	if (incremental || log)
 		return 0;
 
 	coalesce(&sb);
