From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git-log --follow?
Date: Thu, 12 Jul 2007 10:49:08 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707121026080.20061@woody.linux-foundation.org>
References: <20070704203541.GA13286@artemis.corp> <7vzm22vyin.fsf@assigned-by-dhcp.cox.net>
 <7vsl7uvx8v.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jul 12 19:49:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I92nG-0004UH-0O
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 19:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753358AbXGLRt2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 13:49:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752032AbXGLRt2
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 13:49:28 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:39499 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753653AbXGLRt0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Jul 2007 13:49:26 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6CHnE0q011057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 12 Jul 2007 10:49:15 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6CHn8ui023427;
	Thu, 12 Jul 2007 10:49:08 -0700
In-Reply-To: <7vsl7uvx8v.fsf_-_@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-5.606 required=5 tests=AWL,BAYES_00,PATCH_UNIFIED_DIFF_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52309>



On Thu, 12 Jul 2007, Junio C Hamano wrote:
> 
> I think this is just a testament that "following renames" is not
> as useful in a real project as people seem to believe, not a
> real complaint.

Yeah. That said, what you wanted would have actually worked with my 
original strange patch to "git blame", and in particular that also would 
allow you to get a "log" for certain lines in the file.

So something like

	git blame -C -Lx,y --log

may still make sense to give people.

Here's a new version of that patch (I've long since lost the original one, 
plus it probably wouldn't apply anyway, but it was easy to re-generate).

It doesn't set up the revs thing nicely, so trying to add "-p" or "--stat" 
etc doesn't really get you what you'd want, and "--decorate" doesn't work 
since it doesn't call "cmd_log_init".

So this certainly has some room for improvement, but my point is that "git 
blame" actually knows all this, and in many ways does a better job than 
"git log" (but a very *different* job!!).

So "git log" gives you the log for a (set of) pathname(s), while with this 
patch, "git blame --log" gives you the log for the commits that can be 
*blamed* for the current state of that pathname!

Two very different things, but both are valid, and interesting things to 
do, I think. And I really think it's worth doing, if only because it's so 
simple, and fits so well with the whole "git blame" structure!

			Linus

---
diff --git a/builtin-blame.c b/builtin-blame.c
index 0519339..8de06d3 100644
--- a/builtin-blame.c
+++ b/builtin-blame.c
@@ -18,6 +18,7 @@
 #include "cache-tree.h"
 #include "path-list.h"
 #include "mailmap.h"
+#include "log-tree.h"
 
 static char blame_usage[] =
 "git-blame [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-p] [-w] [-L n,m] [-S <revs-file>] [-M] [-C] [-C] [--contents <filename>] [--incremental] [commit] [--] file\n"
@@ -34,6 +35,7 @@ static char blame_usage[] =
 "  -L n,m              Process only line range n,m, counting from 1\n"
 "  -M, -C              Find line movements within and across files\n"
 "  --incremental       Show blame entries as we find them, incrementally\n"
+"  --log               Show blame entries as we find them in 'git log' style\n"
 "  --contents file     Use <file>'s contents as the final image\n"
 "  -S revs-file        Use revisions from revs-file instead of calling git-rev-list\n";
 
@@ -45,6 +47,7 @@ static int max_score_digits;
 static int show_root;
 static int blank_boundary;
 static int incremental;
+static int blame_log;
 static int cmd_is_annotate;
 static int xdl_opts = XDF_NEED_MINIMAL;
 static struct path_list mailmap;
@@ -1431,11 +1434,22 @@ static void write_filename_info(const char *path)
  * The blame_entry is found to be guilty for the range.  Mark it
  * as such, and show it in incremental output.
  */
-static void found_guilty_entry(struct blame_entry *ent)
+static void found_guilty_entry(struct blame_entry *ent, struct rev_info *rev)
 {
 	if (ent->guilty)
 		return;
 	ent->guilty = 1;
+	if (blame_log) {
+		struct origin *suspect = ent->suspect;
+		struct commit *commit = suspect->commit;
+
+		if (commit->object.flags & METAINFO_SHOWN)
+			return;
+		commit->object.flags |= METAINFO_SHOWN;
+		log_tree_commit(rev, commit);
+		maybe_flush_or_die(stdout, "stdout");
+		return;
+	}
 	if (incremental) {
 		struct origin *suspect = ent->suspect;
 
@@ -1505,7 +1519,7 @@ static void assign_blame(struct scoreboard *sb, struct rev_info *revs, int opt)
 		/* Take responsibility for the remaining entries */
 		for (ent = sb->ent; ent; ent = ent->next)
 			if (same_suspect(ent->suspect, suspect))
-				found_guilty_entry(ent);
+				found_guilty_entry(ent, revs);
 		origin_decref(suspect);
 
 		if (DEBUG) /* sanity */
@@ -2204,6 +2218,8 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		}
 		else if (!strcmp("--incremental", arg))
 			incremental = 1;
+		else if (!strcmp("--log", arg))
+			save_commit_buffer = incremental = blame_log = 1;
 		else if (!strcmp("--score-debug", arg))
 			output_option |= OUTPUT_SHOW_SCORE;
 		else if (!strcmp("-f", arg) ||
@@ -2224,7 +2240,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 			argv[unk++] = arg;
 	}
 
-	if (!incremental)
+	if (blame_log || !incremental)
 		setup_pager();
 
 	if (!blame_move_score)
@@ -2324,7 +2340,14 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	argv[unk] = NULL;
 
 	init_revisions(&revs, NULL);
+
+	/* Maybe we should call "cmd_log_init()" here instead? */
+	revs.always_show_header = 1;
+	revs.commit_format = CMIT_FMT_DEFAULT;
+	revs.verbose_header = 1;
+	revs.abbrev = DEFAULT_ABBREV;
 	setup_revisions(unk, argv, &revs, NULL);
+
 	memset(&sb, 0, sizeof(sb));
 
 	/*
