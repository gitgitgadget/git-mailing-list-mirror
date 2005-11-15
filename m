From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/4] diff: --full-index
Date: Tue, 15 Nov 2005 15:34:08 -0800
Message-ID: <7vacg5fpu7.fsf@assigned-by-dhcp.cox.net>
References: <7voe4lfpxm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Wed Nov 16 00:34:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EcAJa-0004gn-H1
	for gcvg-git@gmane.org; Wed, 16 Nov 2005 00:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVKOXeL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 18:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965074AbVKOXeL
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 18:34:11 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:38281 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965064AbVKOXeK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Nov 2005 18:34:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051115233315.VPIM17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 15 Nov 2005 18:33:15 -0500
To: git@vger.kernel.org
In-Reply-To: <7voe4lfpxm.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 15 Nov 2005 15:32:05 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11967>

A new option, --full-index, is introduced to diff family.  This
causes the full object name of pre- and post-images to appear on
the index line of patch formatted output, to be used in
conjunction with --allow-binary-replacement option of git-apply.

Signed-off-by: Junio C Hamano <junkio@cox.net>

---

 Documentation/diff-options.txt |    5 +++++
 diff.c                         |   14 ++++++++------
 diff.h                         |    4 +++-
 3 files changed, 16 insertions(+), 7 deletions(-)

applies-to: 87c089ccd1a4e2ea6284c1ac5e944efd5299f60e
3c38f257b87e61f02e8bf49195eb5084652ff0f9
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 8eef86e..6b496ed 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -13,6 +13,11 @@
 --name-status::
 	Show only names and status of changed files.
 
+--full-index::
+	Instead of the first handful characters, show full
+	object name of pre- and post-image blob on the "index"
+	line when generating a patch format output.	
+
 -B::
 	Break complete rewrite changes into pairs of delete and create.
 
diff --git a/diff.c b/diff.c
index ec94a96..8b7bb67 100644
--- a/diff.c
+++ b/diff.c
@@ -648,7 +648,7 @@ static void diff_fill_sha1_info(struct d
 		memset(one->sha1, 0, 20);
 }
 
-static void run_diff(struct diff_filepair *p)
+static void run_diff(struct diff_filepair *p, struct diff_options *o)
 {
 	const char *pgm = external_diff();
 	char msg[PATH_MAX*2+300], *xfrm_msg;
@@ -711,11 +711,11 @@ static void run_diff(struct diff_filepai
 
 	if (memcmp(one->sha1, two->sha1, 20)) {
 		char one_sha1[41];
+		const char *index_fmt = o->full_index ? "index %s..%s" : "index %.7s..%.7s";
 		memcpy(one_sha1, sha1_to_hex(one->sha1), 41);
 
 		len += snprintf(msg + len, sizeof(msg) - len,
-				"index %.7s..%.7s", one_sha1,
-				sha1_to_hex(two->sha1));
+				index_fmt, one_sha1, sha1_to_hex(two->sha1));
 		if (one->mode == two->mode)
 			len += snprintf(msg + len, sizeof(msg) - len,
 					" %06o", one->mode);
@@ -789,6 +789,8 @@ int diff_opt_parse(struct diff_options *
 		options->line_termination = 0;
 	else if (!strncmp(arg, "-l", 2))
 		options->rename_limit = strtoul(arg+2, NULL, 10);
+	else if (!strcmp(arg, "--full-index"))
+		options->full_index = 1;
 	else if (!strcmp(arg, "--name-only"))
 		options->output_format = DIFF_FORMAT_NAME;
 	else if (!strcmp(arg, "--name-status"))
@@ -1017,7 +1019,7 @@ int diff_unmodified_pair(struct diff_fil
 	return 0;
 }
 
-static void diff_flush_patch(struct diff_filepair *p)
+static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 {
 	if (diff_unmodified_pair(p))
 		return;
@@ -1026,7 +1028,7 @@ static void diff_flush_patch(struct diff
 	    (DIFF_FILE_VALID(p->two) && S_ISDIR(p->two->mode)))
 		return; /* no tree diffs in patch format */ 
 
-	run_diff(p);
+	run_diff(p, o);
 }
 
 int diff_queue_is_empty(void)
@@ -1158,7 +1160,7 @@ void diff_flush(struct diff_options *opt
 			die("internal error in diff-resolve-rename-copy");
 		switch (diff_output_format) {
 		case DIFF_FORMAT_PATCH:
-			diff_flush_patch(p);
+			diff_flush_patch(p, options);
 			break;
 		case DIFF_FORMAT_RAW:
 		case DIFF_FORMAT_NAME_STATUS:
diff --git a/diff.h b/diff.h
index 1259079..9b2e1e6 100644
--- a/diff.h
+++ b/diff.h
@@ -32,7 +32,8 @@ struct diff_options {
 	const char *orderfile;
 	const char *pickaxe;
 	unsigned recursive:1,
-		 tree_in_recursive:1;
+		 tree_in_recursive:1,
+		 full_index:1;
 	int break_opt;
 	int detect_rename;
 	int find_copies_harder;
@@ -96,6 +97,7 @@ extern void diffcore_std_no_resolve(stru
 "  -u            synonym for -p.\n" \
 "  --name-only   show only names of changed files.\n" \
 "  --name-status show names and status of changed files.\n" \
+"  --full-index  show full object name on index ines.\n" \
 "  -R            swap input file pairs.\n" \
 "  -B            detect complete rewrites.\n" \
 "  -M            detect renames.\n" \
---
0.99.9.GIT
