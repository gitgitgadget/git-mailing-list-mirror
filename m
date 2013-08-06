From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 05/16] blame: accept multiple -L ranges
Date: Tue,  6 Aug 2013 09:59:38 -0400
Message-ID: <1375797589-65308-6-git-send-email-sunshine@sunshineco.com>
References: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 06 16:00:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V6hob-0003Su-Lw
	for gcvg-git-2@plane.gmane.org; Tue, 06 Aug 2013 16:00:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755060Ab3HFOAj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Aug 2013 10:00:39 -0400
Received: from mail-oa0-f41.google.com ([209.85.219.41]:60671 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752013Ab3HFOAf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Aug 2013 10:00:35 -0400
Received: by mail-oa0-f41.google.com with SMTP id j6so756348oag.14
        for <git@vger.kernel.org>; Tue, 06 Aug 2013 07:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H9fKn6KVIwIwfQ261jaWN08gZ/2hiuFGKv6zpWIOBNY=;
        b=ErquncEYSGPp5IRQy/OAv4jXFO27IFFMHV52hDsh/3ERPHDEs9a/uvL4DbJMEiBb9J
         T/kS+p2zum42n4brd8kjQQeX8E7cSP7Xaqe6bWLnIb5L3MukbnhWxhtQk79NBq6QY18W
         1657HlkcehUes+fA/QT59kdsTDb31AduMIGvWI0yOYrsS+AMvmFzOAul+oKgPlx+l5dM
         z45QrD6izh3GnKLvCubsD/AMkA+8A46OM78u1HEaAMcgJMVeOJs2zFe92+OPUfkKpTir
         jPg3Xi8m/tf/GgWmEjpHgVWVnGOx6X3GjQnmdoOs8kYnq3G1YCwmiy1gcetnIwGJLvHS
         flCg==
X-Received: by 10.60.57.130 with SMTP id i2mr1148485oeq.51.1375797634834;
        Tue, 06 Aug 2013 07:00:34 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id z2sm1380175obi.3.2013.08.06.07.00.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 06 Aug 2013 07:00:33 -0700 (PDT)
X-Mailer: git-send-email 1.8.4.rc1.409.gbd48715
In-Reply-To: <1375797589-65308-1-git-send-email-sunshine@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231740>

git-blame accepts only a single -L option or none. Clients requiring
blame information for multiple disjoint ranges are therefore forced
either to invoke git-blame multiple times, once for each range, or only
once with no -L option to cover the entire file, both of which can be
costly.  Teach git-blame to accept multiple -L ranges.  Overlapping and
out-of-order ranges are accepted.

In this patch, the X in -LX,Y is absolute (for instance, /RE/ patterns
search from line 1), and Y is relative to X. Follow-up patches provide
more flexibility over how X is anchored.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This patch is a bit less scary when whitespace changes are ignored.

 builtin/blame.c | 79 ++++++++++++++++++++++++++++++++++-----------------------
 1 file changed, 47 insertions(+), 32 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 9db01b0..2f4d9e2 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -22,6 +22,7 @@
 #include "utf8.h"
 #include "userdiff.h"
 #include "line-range.h"
+#include "line-log.h"
 
 static char blame_usage[] = N_("git blame [options] [rev-opts] [rev] [--] file");
 
@@ -2233,29 +2234,18 @@ static int blame_move_callback(const struct option *option, const char *arg, int
 	return 0;
 }
 
-static int blame_bottomtop_callback(const struct option *option, const char *arg, int unset)
-{
-	const char **bottomtop = option->value;
-	if (!arg)
-		return -1;
-	if (*bottomtop)
-		die("More than one '-L n,m' option given");
-	*bottomtop = arg;
-	return 0;
-}
-
 int cmd_blame(int argc, const char **argv, const char *prefix)
 {
 	struct rev_info revs;
 	const char *path;
 	struct scoreboard sb;
 	struct origin *o;
-	struct blame_entry *ent;
-	long dashdash_pos, bottom, top, lno;
+	struct blame_entry *ent = NULL;
+	long dashdash_pos, lno;
 	const char *final_commit_name = NULL;
 	enum object_type type;
 
-	static const char *bottomtop = NULL;
+	static struct string_list range_list;
 	static int output_option = 0, opt = 0;
 	static int show_stats = 0;
 	static const char *revs_file = NULL;
@@ -2281,13 +2271,15 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("Use <file>'s contents as the final image")),
 		{ OPTION_CALLBACK, 'C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback },
 		{ OPTION_CALLBACK, 'M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback },
-		OPT_CALLBACK('L', NULL, &bottomtop, N_("n,m"), N_("Process only line range n,m, counting from 1"), blame_bottomtop_callback),
+		OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), N_("Process only line range n,m, counting from 1")),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
 
 	struct parse_opt_ctx_t ctx;
 	int cmd_is_annotate = !strcmp(argv[0], "annotate");
+	struct range_set ranges;
+	unsigned int range_i;
 
 	git_config(git_blame_config, NULL);
 	init_revisions(&revs, NULL);
@@ -2480,23 +2472,46 @@ parse_done:
 	num_read_blob++;
 	lno = prepare_lines(&sb);
 
-	bottom = top = 0;
-	if (bottomtop && parse_range_arg(bottomtop, nth_line_cb, &sb, lno,
-					 &bottom, &top, sb.path))
-		usage(blame_usage);
-	if (lno < top || ((lno || bottom) && lno < bottom))
-		die("file %s has only %lu lines", path, lno);
-	if (bottom < 1)
-		bottom = 1;
-	if (top < 1)
-		top = lno;
-	bottom--;
-
-	ent = xcalloc(1, sizeof(*ent));
-	ent->lno = bottom;
-	ent->num_lines = top - bottom;
-	ent->suspect = o;
-	ent->s_lno = bottom;
+	if (lno && !range_list.nr)
+		string_list_append(&range_list, xstrdup("1"));
+
+	range_set_init(&ranges, range_list.nr);
+	for (range_i = 0; range_i < range_list.nr; ++range_i) {
+		long bottom, top;
+		if (parse_range_arg(range_list.items[range_i].string,
+				    nth_line_cb, &sb, lno,
+				    &bottom, &top, sb.path))
+			usage(blame_usage);
+		if (lno < top || ((lno || bottom) && lno < bottom))
+			die("file %s has only %lu lines", path, lno);
+		if (bottom < 1)
+			bottom = 1;
+		if (top < 1)
+			top = lno;
+		bottom--;
+		range_set_append_unsafe(&ranges, bottom, top);
+	}
+	sort_and_merge_range_set(&ranges);
+
+	for (range_i = ranges.nr; range_i > 0; --range_i) {
+		const struct range *r = &ranges.ranges[range_i - 1];
+		long bottom = r->start;
+		long top = r->end;
+		struct blame_entry *next = ent;
+		ent = xcalloc(1, sizeof(*ent));
+		ent->lno = bottom;
+		ent->num_lines = top - bottom;
+		ent->suspect = o;
+		ent->s_lno = bottom;
+		ent->next = next;
+		if (next)
+			next->prev = ent;
+		origin_incref(o);
+	}
+	origin_decref(o);
+
+	range_set_release(&ranges);
+	string_list_clear(&range_list, 0);
 
 	sb.ent = ent;
 	sb.path = path;
-- 
1.8.4.rc1.409.gbd48715
