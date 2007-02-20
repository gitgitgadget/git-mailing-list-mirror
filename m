From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/4] prefixcmp(): fix-up leftover strncmp().
Date: Tue, 20 Feb 2007 01:55:07 -0800
Message-ID: <7vtzxhw3us.fsf_-_@assigned-by-dhcp.cox.net>
References: <200702191839.05784.andyparkins@gmail.com>
	<7vlkit7vy5.fsf@assigned-by-dhcp.cox.net>
	<200702200942.18654.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 10:55:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJRiM-0001II-OS
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 10:55:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932682AbXBTJzL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Feb 2007 04:55:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932693AbXBTJzK
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Feb 2007 04:55:10 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44353 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932682AbXBTJzJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Feb 2007 04:55:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070220095508.FRXA21177.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Tue, 20 Feb 2007 04:55:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Rlv71W0081kojtg0000000; Tue, 20 Feb 2007 04:55:08 -0500
In-Reply-To: <200702200942.18654.andyparkins@gmail.com> (Andy Parkins's
	message of "Tue, 20 Feb 2007 09:42:17 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40223>

There were instances of strncmp() that were formatted improperly
(e.g. whitespace around parameter before closing parenthesis)
that caused the earlier mechanical conversion step to miss
them.  This step cleans them up.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This concludes the series.  I'll go over these line by line
   tomorrow for the last time, and then will apply them.

 builtin-ls-tree.c     |    2 +-
 builtin-rev-parse.c   |    2 +-
 builtin-show-branch.c |    4 ++--
 diff.c                |    2 +-
 http-fetch.c          |    2 +-
 http-push.c           |    2 +-
 imap-send.c           |    8 ++++----
 revision.c            |    2 +-
 wt-status.c           |    2 +-
 9 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/builtin-ls-tree.c b/builtin-ls-tree.c
index 201defd..6472610 100644
--- a/builtin-ls-tree.c
+++ b/builtin-ls-tree.c
@@ -118,7 +118,7 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 				chomp_prefix = 0;
 				break;
 			}
-			if (!strncmp(argv[1]+2, "abbrev=",7)) {
+			if (!prefixcmp(argv[1]+2, "abbrev=")) {
 				abbrev = strtoul(argv[1]+9, NULL, 10);
 				if (abbrev && abbrev < MINIMUM_ABBREV)
 					abbrev = MINIMUM_ABBREV;
diff --git a/builtin-rev-parse.c b/builtin-rev-parse.c
index a1c3411..37addb2 100644
--- a/builtin-rev-parse.c
+++ b/builtin-rev-parse.c
@@ -233,7 +233,7 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			}
 			continue;
 		}
-		if (!strncmp(arg,"-n",2)) {
+		if (!prefixcmp(arg, "-n")) {
 			if ((filter & DO_FLAGS) && (filter & DO_REVS))
 				show(arg);
 			continue;
diff --git a/builtin-show-branch.c b/builtin-show-branch.c
index 402a8f7..67ae6ba 100644
--- a/builtin-show-branch.c
+++ b/builtin-show-branch.c
@@ -378,7 +378,7 @@ static int append_head_ref(const char *refname, const unsigned char *sha1, int f
 {
 	unsigned char tmp[20];
 	int ofs = 11;
-	if (strncmp(refname, "refs/heads/", ofs))
+	if (prefixcmp(refname, "refs/heads/"))
 		return 0;
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
@@ -392,7 +392,7 @@ static int append_remote_ref(const char *refname, const unsigned char *sha1, int
 {
 	unsigned char tmp[20];
 	int ofs = 13;
-	if (strncmp(refname, "refs/remotes/", ofs))
+	if (prefixcmp(refname, "refs/remotes/"))
 		return 0;
 	/* If both heads/foo and tags/foo exists, get_sha1 would
 	 * get confused.
diff --git a/diff.c b/diff.c
index fad13ab..c3afee2 100644
--- a/diff.c
+++ b/diff.c
@@ -77,7 +77,7 @@ int git_diff_ui_config(const char *var, const char *value)
 			diff_detect_rename_default = DIFF_DETECT_RENAME;
 		return 0;
 	}
-	if (!prefixcmp(var, "diff.color.") || !strncmp(var, "color.diff.", 11)) {
+	if (!prefixcmp(var, "diff.color.") || !prefixcmp(var, "color.diff.")) {
 		int slot = parse_diff_color_slot(var, 11);
 		color_parse(value, var, diff_colors[slot]);
 		return 0;
diff --git a/http-fetch.c b/http-fetch.c
index d9a4561..e6cd11d 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -718,7 +718,7 @@ static int fetch_indices(struct alt_base *repo)
 			i++;
 			if (i + 52 <= buffer.posn &&
 			    !prefixcmp(data + i, " pack-") &&
-			    !strncmp(data + i + 46, ".pack\n", 6)) {
+			    !prefixcmp(data + i + 46, ".pack\n")) {
 				get_sha1_hex(data + i + 6, sha1);
 				setup_index(repo, sha1);
 				i += 51;
diff --git a/http-push.c b/http-push.c
index eb77c9a..9ad6fd0 100644
--- a/http-push.c
+++ b/http-push.c
@@ -1061,7 +1061,7 @@ static int fetch_indices(void)
 			i++;
 			if (i + 52 < buffer.posn &&
 			    !prefixcmp(data + i, " pack-") &&
-			    !strncmp(data + i + 46, ".pack\n", 6)) {
+			    !prefixcmp(data + i + 46, ".pack\n")) {
 				get_sha1_hex(data + i + 6, sha1);
 				setup_index(sha1);
 				i += 51;
diff --git a/imap-send.c b/imap-send.c
index 3eaf025..84df2fa 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -1192,7 +1192,7 @@ count_messages( msg_data_t *msg )
 	char *p = msg->data;
 
 	while (1) {
-		if (!strncmp( "From ", p, 5 )) {
+		if (!prefixcmp(p, "From ")) {
 			count++;
 			p += 5;
 		}
@@ -1216,7 +1216,7 @@ split_msg( msg_data_t *all_msgs, msg_data_t *msg, int *ofs )
 	data = &all_msgs->data[ *ofs ];
 	msg->len = all_msgs->len - *ofs;
 
-	if (msg->len < 5 || strncmp( data, "From ", 5 ))
+	if (msg->len < 5 || prefixcmp(data, "From "))
 		return 0;
 
 	p = strchr( data, '\n' );
@@ -1267,12 +1267,12 @@ git_imap_config(const char *key, const char *val)
 		imap_folder = xstrdup( val );
 	} else if (!strcmp( "host", key )) {
 		{
-			if (!strncmp( "imap:", val, 5 ))
+			if (!prefixcmp(val, "imap:"))
 				val += 5;
 			if (!server.port)
 				server.port = 143;
 		}
-		if (!strncmp( "//", val, 2 ))
+		if (!prefixcmp(val, "//"))
 			val += 2;
 		server.host = xstrdup( val );
 	}
diff --git a/revision.c b/revision.c
index abab3b9..622afe3 100644
--- a/revision.c
+++ b/revision.c
@@ -832,7 +832,7 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				revs->max_count = atoi(argv[++i]);
 				continue;
 			}
-			if (!strncmp(arg,"-n",2)) {
+			if (!prefixcmp(arg, "-n")) {
 				revs->max_count = atoi(arg + 2);
 				continue;
 			}
diff --git a/wt-status.c b/wt-status.c
index d17a6ba..035e546 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -344,7 +344,7 @@ int git_status_config(const char *k, const char *v)
 		wt_status_use_color = git_config_colorbool(k, v);
 		return 0;
 	}
-	if (!prefixcmp(k, "status.color.") || !strncmp(k, "color.status.", 13)) {
+	if (!prefixcmp(k, "status.color.") || !prefixcmp(k, "color.status.")) {
 		int slot = parse_status_slot(k, 13);
 		color_parse(v, k, wt_status_colors[slot]);
 	}
-- 
1.5.0.1.571.ge5a1a
