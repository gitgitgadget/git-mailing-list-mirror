From: Jeff King <peff@peff.net>
Subject: [PATCH 52/67] use sha1_to_hex_to() instead of strcpy
Date: Tue, 15 Sep 2015 12:05:35 -0400
Message-ID: <20150915160535.GZ29753@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 15 18:05:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zbsjm-0006Jm-Q7
	for gcvg-git-2@plane.gmane.org; Tue, 15 Sep 2015 18:05:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbbIOQFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Sep 2015 12:05:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:59440 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752239AbbIOQFi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Sep 2015 12:05:38 -0400
Received: (qmail 14068 invoked by uid 102); 15 Sep 2015 16:05:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 11:05:37 -0500
Received: (qmail 7808 invoked by uid 107); 15 Sep 2015 16:05:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 15 Sep 2015 12:05:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Sep 2015 12:05:35 -0400
Content-Disposition: inline
In-Reply-To: <20150915152125.GA27504@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277957>

Before sha1_to_hex_to() existed, a simple way to get a hex
sha1 into a buffer was with:

  strcpy(buf, sha1_to_hex(sha1));

This isn't wrong (assuming the buf is 41 characters), but it
makes auditing the code base for bad strcpy() calls harder,
as these become false positives.

Let's convert them to sha1_to_hex_to(), and likewise for
some calls to find_unique_abbrev(). While we're here, we'll
double-check that all of the buffers are correctly sized,
and use the more obvious GIT_SHA1_HEXSZ constant.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/blame.c        |  8 ++++----
 builtin/merge-index.c  |  4 ++--
 builtin/merge.c        | 20 ++++++++++----------
 builtin/receive-pack.c | 15 +++++++++------
 builtin/rev-list.c     |  4 ++--
 diff.c                 |  9 ++++-----
 6 files changed, 31 insertions(+), 29 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 4db01c1..f8ec7ff 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1867,9 +1867,9 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
 	int cnt;
 	const char *cp;
 	struct origin *suspect = ent->suspect;
-	char hex[41];
+	char hex[GIT_SHA1_HEXSZ + 1];
 
-	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
+	sha1_to_hex_to(hex, suspect->commit->object.sha1);
 	printf("%s %d %d %d\n",
 	       hex,
 	       ent->s_lno + 1,
@@ -1905,11 +1905,11 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 	const char *cp;
 	struct origin *suspect = ent->suspect;
 	struct commit_info ci;
-	char hex[41];
+	char hex[GIT_SHA1_HEXSZ + 1];
 	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
 
 	get_commit_info(suspect->commit, &ci, 1);
-	strcpy(hex, sha1_to_hex(suspect->commit->object.sha1));
+	sha1_to_hex_to(hex, suspect->commit->object.sha1);
 
 	cp = nth_line(sb, ent->lno);
 	for (cnt = 0; cnt < ent->num_lines; cnt++) {
diff --git a/builtin/merge-index.c b/builtin/merge-index.c
index 1d66111..4ed0a83 100644
--- a/builtin/merge-index.c
+++ b/builtin/merge-index.c
@@ -9,7 +9,7 @@ static int merge_entry(int pos, const char *path)
 {
 	int found;
 	const char *arguments[] = { pgm, "", "", "", path, "", "", "", NULL };
-	char hexbuf[4][60];
+	char hexbuf[4][GIT_SHA1_HEXSZ + 1];
 	char ownbuf[4][60];
 
 	if (pos >= active_nr)
@@ -22,7 +22,7 @@ static int merge_entry(int pos, const char *path)
 		if (strcmp(ce->name, path))
 			break;
 		found++;
-		strcpy(hexbuf[stage], sha1_to_hex(ce->sha1));
+		sha1_to_hex_to(hexbuf[stage], ce->sha1);
 		xsnprintf(ownbuf[stage], sizeof(ownbuf[stage]), "%o", ce->ce_mode);
 		arguments[stage] = hexbuf[stage];
 		arguments[stage + 4] = ownbuf[stage];
diff --git a/builtin/merge.c b/builtin/merge.c
index a0edaca..af2a2ae 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -1319,13 +1319,13 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 	if (verify_signatures) {
 		for (p = remoteheads; p; p = p->next) {
 			struct commit *commit = p->item;
-			char hex[41];
+			char hex[GIT_SHA1_HEXSZ + 1];
 			struct signature_check signature_check;
 			memset(&signature_check, 0, sizeof(signature_check));
 
 			check_commit_signature(commit, &signature_check);
 
-			strcpy(hex, find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV));
+			find_unique_abbrev_to(hex, commit->object.sha1, DEFAULT_ABBREV);
 			switch (signature_check.result) {
 			case 'G':
 				break;
@@ -1415,15 +1415,15 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 		/* Again the most common case of merging one remote. */
 		struct strbuf msg = STRBUF_INIT;
 		struct commit *commit;
-		char hex[41];
 
-		strcpy(hex, find_unique_abbrev(head_commit->object.sha1, DEFAULT_ABBREV));
-
-		if (verbosity >= 0)
-			printf(_("Updating %s..%s\n"),
-				hex,
-				find_unique_abbrev(remoteheads->item->object.sha1,
-				DEFAULT_ABBREV));
+		if (verbosity >= 0) {
+			char from[GIT_SHA1_HEXSZ + 1], to[GIT_SHA1_HEXSZ + 1];
+			find_unique_abbrev_to(from, head_commit->object.sha1,
+					      DEFAULT_ABBREV);
+			find_unique_abbrev_to(to, remoteheads->item->object.sha1,
+					      DEFAULT_ABBREV);
+			printf(_("Updating %s..%s\n"), from, to);
+		}
 		strbuf_addstr(&msg, "Fast-forward");
 		if (have_message)
 			strbuf_addstr(&msg,
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 04d2bdf..8b50e48 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1071,8 +1071,11 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	const char *dst_name;
 	struct string_list_item *item;
 	struct command *dst_cmd;
-	unsigned char sha1[20];
-	char cmd_oldh[41], cmd_newh[41], dst_oldh[41], dst_newh[41];
+	unsigned char sha1[GIT_SHA1_RAWSZ];
+	char cmd_oldh[GIT_SHA1_HEXSZ + 1],
+	     cmd_newh[GIT_SHA1_HEXSZ + 1],
+	     dst_oldh[GIT_SHA1_HEXSZ + 1],
+	     dst_newh[GIT_SHA1_HEXSZ + 1];
 	int flag;
 
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
@@ -1103,10 +1106,10 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 
 	dst_cmd->skip_update = 1;
 
-	strcpy(cmd_oldh, find_unique_abbrev(cmd->old_sha1, DEFAULT_ABBREV));
-	strcpy(cmd_newh, find_unique_abbrev(cmd->new_sha1, DEFAULT_ABBREV));
-	strcpy(dst_oldh, find_unique_abbrev(dst_cmd->old_sha1, DEFAULT_ABBREV));
-	strcpy(dst_newh, find_unique_abbrev(dst_cmd->new_sha1, DEFAULT_ABBREV));
+	find_unique_abbrev_to(cmd_oldh, cmd->old_sha1, DEFAULT_ABBREV);
+	find_unique_abbrev_to(cmd_newh, cmd->new_sha1, DEFAULT_ABBREV);
+	find_unique_abbrev_to(dst_oldh, dst_cmd->old_sha1, DEFAULT_ABBREV);
+	find_unique_abbrev_to(dst_newh, dst_cmd->new_sha1, DEFAULT_ABBREV);
 	rp_error("refusing inconsistent update between symref '%s' (%s..%s) and"
 		 " its target '%s' (%s..%s)",
 		 cmd->ref_name, cmd_oldh, cmd_newh,
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index d80d1ed..e9b724b 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -217,7 +217,7 @@ static void print_var_int(const char *var, int val)
 static int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 {
 	int cnt, flags = info->flags;
-	char hex[41] = "";
+	char hex[GIT_SHA1_HEXSZ + 1] = "";
 	struct commit_list *tried;
 	struct rev_info *revs = info->revs;
 
@@ -242,7 +242,7 @@ static int show_bisect_vars(struct rev_list_info *info, int reaches, int all)
 		cnt = reaches;
 
 	if (revs->commits)
-		strcpy(hex, sha1_to_hex(revs->commits->item->object.sha1));
+		sha1_to_hex_to(hex, revs->commits->item->object.sha1);
 
 	if (flags & BISECT_SHOW_ALL) {
 		traverse_commit_list(revs, show_commit, show_object, info);
diff --git a/diff.c b/diff.c
index 788e371..6ccd454 100644
--- a/diff.c
+++ b/diff.c
@@ -322,7 +322,7 @@ static struct diff_tempfile {
 	 */
 	const char *name;
 
-	char hex[41];
+	char hex[GIT_SHA1_HEXSZ + 1];
 	char mode[10];
 
 	/*
@@ -2878,8 +2878,7 @@ static void prep_temp_blob(const char *path, struct diff_tempfile *temp,
 		die_errno("unable to write temp-file");
 	close_tempfile(&temp->tempfile);
 	temp->name = get_tempfile_path(&temp->tempfile);
-	strcpy(temp->hex, sha1_to_hex(sha1));
-	temp->hex[40] = 0;
+	sha1_to_hex_to(temp->hex, sha1);
 	xsnprintf(temp->mode, sizeof(temp->mode), "%06o", mode);
 	strbuf_release(&buf);
 	strbuf_release(&template);
@@ -2926,9 +2925,9 @@ static struct diff_tempfile *prepare_temp_file(const char *name,
 			/* we can borrow from the file in the work tree */
 			temp->name = name;
 			if (!one->sha1_valid)
-				strcpy(temp->hex, sha1_to_hex(null_sha1));
+				sha1_to_hex_to(temp->hex, null_sha1);
 			else
-				strcpy(temp->hex, sha1_to_hex(one->sha1));
+				sha1_to_hex_to(temp->hex, one->sha1);
 			/* Even though we may sometimes borrow the
 			 * contents from the work tree, we always want
 			 * one->mode.  mode is trustworthy even when
-- 
2.6.0.rc2.408.ga2926b9
