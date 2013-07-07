From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH/RFC] blame: accept multiple -L ranges
Date: Sun,  7 Jul 2013 04:45:06 -0400
Message-ID: <1373186706-19284-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 07 10:51:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uvkgv-00038G-M3
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jul 2013 10:51:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851Ab3GGIv3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jul 2013 04:51:29 -0400
Received: from mail-ye0-f178.google.com ([209.85.213.178]:46904 "EHLO
	mail-ye0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751750Ab3GGIv2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jul 2013 04:51:28 -0400
Received: by mail-ye0-f178.google.com with SMTP id m15so1288788yen.9
        for <git@vger.kernel.org>; Sun, 07 Jul 2013 01:51:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:x-mailer;
        bh=He4sXOilUVPUgI9RVZgLAOPbiA+pgm14NYvuazg2EJI=;
        b=uXDnqHDbEFVsWmEpokrc2Ax7x6haJKRPkcd6IXjG2bJP2qwnBsPgnfjjBVO8Q8wVTK
         39rPrKyju1jlibc1Th140nA8JC5tMfvX5emfTBdahNCx7JjKQrn9PemhEhbwWrQwXwBg
         DM0mLMNO64KQ4oKc0FEZGMMsi+Kt7b1WydXSNib+FqcXLmDsYP9+0bjPWyKnH/5CvSOY
         rvHdt+2n6H8HrUaVP10rXGktfPRL8RlCGgQlVnCV5XaX3nPUBA1J03maWtxoz390o3Ms
         utMCagpY/bck9ASd5Q+MZD234RdlARs0RJhSK7xJ2mtVlfMxNSazMnUdlpyzh4wwHn9N
         TEiw==
X-Received: by 10.236.190.169 with SMTP id e29mr9548121yhn.17.1373186723249;
        Sun, 07 Jul 2013 01:45:23 -0700 (PDT)
Received: from localhost.localdomain (user-12l3dfg.cable.mindspring.com. [69.81.181.240])
        by mx.google.com with ESMTPSA id d91sm27509326yhq.16.2013.07.07.01.45.21
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 07 Jul 2013 01:45:22 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229755>

git-blame accepts only zero or one -L option. Clients requiring blame
information for multiple disjoint ranges are therefore forced either to
invoke git-blame multiple times, once for each range, or only once with
no -L option to cover the entire file, which can be costly. Teach
git-blame to accept multiple -L ranges.

Overlapping and out-of-order ranges are accepted and handled gracefully.
For example:

  git blame -L 3,+4 -L 91,+7 -L 2,3 -L 89,100 source.c

emits blame information for lines 2-6 and 89-100.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is RFC because it lacks documentation and test updates, and because
I want to make sure the approach is sound and not abusive of the blame
machinery.

Rather than sorting and coalescing input -L ranges manually, existing
add_blame_range() and coalesce() are (ab)used to normalize the input.
This requires a small change to coalesce() to deal with potentially
overlapping ranges since it never otherwise encounters overlap during
normal blame operation.

This patch is somewhat less scary when whitespace changes are ignored.


 builtin/blame.c | 70 +++++++++++++++++++++++++++++----------------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 079dcd3..f26ff44 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -278,8 +278,11 @@ static void coalesce(struct scoreboard *sb)
 	for (ent = sb->ent; ent && (next = ent->next); ent = next) {
 		if (same_suspect(ent->suspect, next->suspect) &&
 		    ent->guilty == next->guilty &&
-		    ent->s_lno + ent->num_lines == next->s_lno) {
-			ent->num_lines += next->num_lines;
+		    ent->s_lno + ent->num_lines >= next->s_lno) {
+			int ent_top = ent->lno + ent->num_lines;
+			int next_top = next->lno + next->num_lines;
+			if (ent_top < next_top)
+				ent->num_lines = next_top - ent->s_lno;
 			ent->next = next->next;
 			if (ent->next)
 				ent->next->prev = ent;
@@ -2245,17 +2248,6 @@ static int blame_move_callback(const struct option *option, const char *arg, int
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
@@ -2263,11 +2255,11 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 	struct scoreboard sb;
 	struct origin *o;
 	struct blame_entry *ent;
-	long dashdash_pos, bottom, top, lno;
+	long dashdash_pos, lno;
 	const char *final_commit_name = NULL;
 	enum object_type type;
 
-	static const char *bottomtop = NULL;
+	static struct string_list ranges;
 	static int output_option = 0, opt = 0;
 	static int show_stats = 0;
 	static const char *revs_file = NULL;
@@ -2293,13 +2285,14 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "contents", &contents_from, N_("file"), N_("Use <file>'s contents as the final image")),
 		{ OPTION_CALLBACK, 'C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback },
 		{ OPTION_CALLBACK, 'M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback },
-		OPT_CALLBACK('L', NULL, &bottomtop, N_("n,m"), N_("Process only line range n,m, counting from 1"), blame_bottomtop_callback),
+		OPT_STRING_LIST('L', NULL, &ranges, N_("n,m"), N_("Process only line range n,m, counting from 1")),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
 
 	struct parse_opt_ctx_t ctx;
 	int cmd_is_annotate = !strcmp(argv[0], "annotate");
+	unsigned int range_i;
 
 	git_config(git_blame_config, NULL);
 	init_revisions(&revs, NULL);
@@ -2492,24 +2485,33 @@ parse_done:
 	num_read_blob++;
 	lno = prepare_lines(&sb);
 
-	bottom = top = 0;
-	if (bottomtop)
-		prepare_blame_range(&sb, bottomtop, lno, &bottom, &top);
-	if (bottom < 1)
-		bottom = 1;
-	if (top < 1)
-		top = lno;
-	bottom--;
-	if (lno < top || lno < bottom)
-		die("file %s has only %lu lines", path, lno);
-
-	ent = xcalloc(1, sizeof(*ent));
-	ent->lno = bottom;
-	ent->num_lines = top - bottom;
-	ent->suspect = o;
-	ent->s_lno = bottom;
-
-	sb.ent = ent;
+	if (!ranges.nr)
+		string_list_append(&ranges, xstrdup("0,0"));
+
+	for (range_i = 0; range_i < ranges.nr; ++range_i) {
+		long bottom, top;
+		prepare_blame_range(&sb, ranges.items[range_i].string,
+				    lno, &bottom, &top);
+		if (bottom < 1)
+			bottom = 1;
+		if (top < 1)
+			top = lno;
+		bottom--;
+		if (lno < top || lno < bottom)
+			die("file %s has only %lu lines", path, lno);
+
+		ent = xcalloc(1, sizeof(*ent));
+		ent->lno = bottom;
+		ent->num_lines = top - bottom;
+		ent->suspect = o;
+		ent->s_lno = bottom;
+		add_blame_entry(&sb, ent);
+	}
+	coalesce(&sb);
+
+	origin_decref(o);
+	string_list_clear(&ranges, 0);
+
 	sb.path = path;
 
 	read_mailmap(&mailmap, NULL);
-- 
1.8.3.2
