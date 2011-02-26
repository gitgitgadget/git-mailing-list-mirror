From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 5/5] commit, status: use status_printf{,_ln,_more} helpers
Date: Fri, 25 Feb 2011 23:11:37 -0600
Message-ID: <20110226051137.GE27887@elie>
References: <20110226050723.GA27864@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 06:11:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtCRc-0008Cf-0Q
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 06:11:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053Ab1BZFLr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 00:11:47 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:52326 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695Ab1BZFLq (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 00:11:46 -0500
Received: by vxi39 with SMTP id 39so1976506vxi.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 21:11:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=8xEGUJu70ffg8jZOlAGCrUGySbdTsCqX/0cjJCzRZP8=;
        b=nL9PGkJUioPKAaeVx/SSy4B9bhUHW988ppk6OrEqQSj4gyRrWptT0csJM3Ukrcx2a0
         UrWCW3CDbN7PeIN1cWACuEiTHSOPDm86imc2YBrL0s4OWZxnlanMg95vnZkAYVNPlB/+
         ey/l3zeRlCnD3yJwRhRdcFD0jANnOephlbuNw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=wjjMu098s4JQMyclHCzI1BntD7sjhBzSYno5OxvedrFlXzZj4hXApdGwDPCVahNUVg
         ep0TdsASDZXyFBKV+Ez+Hq/nEEX2I5uJ/AAwXyfZ6daMi/zagzRSWoDbS4xKTwMGr618
         GX4VAUcSUVfVHmnD5O82vKYaKSXi8tSeTbmcI=
Received: by 10.52.88.225 with SMTP id bj1mr4807773vdb.224.1298697105754;
        Fri, 25 Feb 2011 21:11:45 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id c8sm717564vcc.33.2011.02.25.21.11.43
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 21:11:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110226050723.GA27864@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167959>

wt-status code is used to provide a reminder of changes included and
not included for the commit message template opened in the operator's
text editor by "git commit".  Therefore each line of its output begins
with the comment character "#":

	# Please enter the commit message for your changes. Lines starting

Use the new status_printf{,_ln,_more} functions to take care of adding
"#" to the beginning of such status lines automatically.  Using these
will have two advantages over the current code:

 - The obvious one is to force separation of the "#" from the
   translatable part of the message when git learns to translate its
   output.

 - Another advantage is that this makes it easier for us to drop "#"
   prefix in "git status" output in later versions of git if we want
   to.

Explained-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Thanks for reading.

 builtin/commit.c |   47 +++++++++++++++--------------
 wt-status.c      |   86 +++++++++++++++++++++++++++---------------------------
 2 files changed, 67 insertions(+), 66 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index ef5f0b2..ae62a25 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -694,50 +694,51 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	if (use_editor && include_status) {
 		char *ai_tmp, *ci_tmp;
 		if (in_merge)
-			fprintf(s->fp,
-				"#\n"
-				"# It looks like you may be committing a MERGE.\n"
-				"# If this is not correct, please remove the file\n"
-				"#	%s\n"
-				"# and try again.\n"
-				"#\n",
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+				"\n"
+				"It looks like you may be committing a MERGE.\n"
+				"If this is not correct, please remove the file\n"
+				"	%s\n"
+				"and try again.\n"
+				"",
 				git_path("MERGE_HEAD"));
 
-		fprintf(s->fp,
-			"\n"
-			"# Please enter the commit message for your changes.");
+		fprintf(s->fp, "\n");
+		status_printf(s, GIT_COLOR_NORMAL,
+			"Please enter the commit message for your changes.");
 		if (cleanup_mode == CLEANUP_ALL)
-			fprintf(s->fp,
+			status_printf_more(s, GIT_COLOR_NORMAL,
 				" Lines starting\n"
-				"# with '#' will be ignored, and an empty"
+				"with '#' will be ignored, and an empty"
 				" message aborts the commit.\n");
 		else /* CLEANUP_SPACE, that is. */
-			fprintf(s->fp,
+			status_printf_more(s, GIT_COLOR_NORMAL,
 				" Lines starting\n"
-				"# with '#' will be kept; you may remove them"
+				"with '#' will be kept; you may remove them"
 				" yourself if you want to.\n"
-				"# An empty message aborts the commit.\n");
+				"An empty message aborts the commit.\n");
 		if (only_include_assumed)
-			fprintf(s->fp, "# %s\n", only_include_assumed);
+			status_printf_ln(s, GIT_COLOR_NORMAL,
+					"%s", only_include_assumed);
 
 		ai_tmp = cut_ident_timestamp_part(author_ident->buf);
 		ci_tmp = cut_ident_timestamp_part(committer_ident.buf);
 		if (strcmp(author_ident->buf, committer_ident.buf))
-			fprintf(s->fp,
+			status_printf_ln(s, GIT_COLOR_NORMAL,
 				"%s"
-				"# Author:    %s\n",
-				ident_shown++ ? "" : "#\n",
+				"Author:    %s",
+				ident_shown++ ? "" : "\n",
 				author_ident->buf);
 
 		if (!user_ident_sufficiently_given())
-			fprintf(s->fp,
+			status_printf_ln(s, GIT_COLOR_NORMAL,
 				"%s"
-				"# Committer: %s\n",
-				ident_shown++ ? "" : "#\n",
+				"Committer: %s",
+				ident_shown++ ? "" : "\n",
 				committer_ident.buf);
 
 		if (ident_shown)
-			fprintf(s->fp, "#\n");
+			status_printf_ln(s, GIT_COLOR_NORMAL, "");
 
 		saved_color_setting = s->use_color;
 		s->use_color = 0;
diff --git a/wt-status.c b/wt-status.c
index 1abd7c3..c14cbe4 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -131,33 +131,33 @@ static void wt_status_print_unmerged_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 
-	color_fprintf_ln(s->fp, c, "# Unmerged paths:");
+	status_printf_ln(s, c, "Unmerged paths:");
 	if (!advice_status_hints)
 		return;
 	if (s->in_merge)
 		;
 	else if (!s->is_initial)
-		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
+		status_printf_ln(s, c, "  (use \"git reset %s <file>...\" to unstage)", s->reference);
 	else
-		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" to unstage)");
-	color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" as appropriate to mark resolution)");
-	color_fprintf_ln(s->fp, c, "#");
+		status_printf_ln(s, c, "  (use \"git rm --cached <file>...\" to unstage)");
+	status_printf_ln(s, c, "  (use \"git add/rm <file>...\" as appropriate to mark resolution)");
+	status_printf_ln(s, c, "");
 }
 
 static void wt_status_print_cached_header(struct wt_status *s)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 
-	color_fprintf_ln(s->fp, c, "# Changes to be committed:");
+	status_printf_ln(s, c, "Changes to be committed:");
 	if (!advice_status_hints)
 		return;
 	if (s->in_merge)
 		; /* NEEDSWORK: use "git reset --unresolve"??? */
 	else if (!s->is_initial)
-		color_fprintf_ln(s->fp, c, "#   (use \"git reset %s <file>...\" to unstage)", s->reference);
+		status_printf_ln(s, c, "  (use \"git reset %s <file>...\" to unstage)", s->reference);
 	else
-		color_fprintf_ln(s->fp, c, "#   (use \"git rm --cached <file>...\" to unstage)");
-	color_fprintf_ln(s->fp, c, "#");
+		status_printf_ln(s, c, "  (use \"git rm --cached <file>...\" to unstage)");
+	status_printf_ln(s, c, "");
 }
 
 static void wt_status_print_dirty_header(struct wt_status *s,
@@ -166,17 +166,17 @@ static void wt_status_print_dirty_header(struct wt_status *s,
 {
 	const char *c = color(WT_STATUS_HEADER, s);
 
-	color_fprintf_ln(s->fp, c, "# Changes not staged for commit:");
+	status_printf_ln(s, c, "Changes not staged for commit:");
 	if (!advice_status_hints)
 		return;
 	if (!has_deleted)
-		color_fprintf_ln(s->fp, c, "#   (use \"git add <file>...\" to update what will be committed)");
+		status_printf_ln(s, c, "  (use \"git add <file>...\" to update what will be committed)");
 	else
-		color_fprintf_ln(s->fp, c, "#   (use \"git add/rm <file>...\" to update what will be committed)");
-	color_fprintf_ln(s->fp, c, "#   (use \"git checkout -- <file>...\" to discard changes in working directory)");
+		status_printf_ln(s, c, "  (use \"git add/rm <file>...\" to update what will be committed)");
+	status_printf_ln(s, c, "  (use \"git checkout -- <file>...\" to discard changes in working directory)");
 	if (has_dirty_submodules)
-		color_fprintf_ln(s->fp, c, "#   (commit or discard the untracked or modified content in submodules)");
-	color_fprintf_ln(s->fp, c, "#");
+		status_printf_ln(s, c, "  (commit or discard the untracked or modified content in submodules)");
+	status_printf_ln(s, c, "");
 }
 
 static void wt_status_print_other_header(struct wt_status *s,
@@ -184,16 +184,16 @@ static void wt_status_print_other_header(struct wt_status *s,
 					 const char *how)
 {
 	const char *c = color(WT_STATUS_HEADER, s);
-	color_fprintf_ln(s->fp, c, "# %s files:", what);
+	status_printf_ln(s, c, "%s files:", what);
 	if (!advice_status_hints)
 		return;
-	color_fprintf_ln(s->fp, c, "#   (use \"git %s <file>...\" to include in what will be committed)", how);
-	color_fprintf_ln(s->fp, c, "#");
+	status_printf_ln(s, c, "  (use \"git %s <file>...\" to include in what will be committed)", how);
+	status_printf_ln(s, c, "");
 }
 
 static void wt_status_print_trailer(struct wt_status *s)
 {
-	color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
+	status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
 }
 
 #define quote_path quote_path_relative
@@ -207,7 +207,7 @@ static void wt_status_print_unmerged_data(struct wt_status *s,
 	const char *one, *how = "bug";
 
 	one = quote_path(it->string, -1, &onebuf, s->prefix);
-	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
+	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	switch (d->stagemask) {
 	case 1: how = "both deleted:"; break;
 	case 2: how = "added by us:"; break;
@@ -217,7 +217,7 @@ static void wt_status_print_unmerged_data(struct wt_status *s,
 	case 6: how = "both added:"; break;
 	case 7: how = "both modified:"; break;
 	}
-	color_fprintf(s->fp, c, "%-20s%s\n", how, one);
+	status_printf_more(s, c, "%-20s%s\n", how, one);
 	strbuf_release(&onebuf);
 }
 
@@ -260,40 +260,40 @@ static void wt_status_print_change_data(struct wt_status *s,
 	one = quote_path(one_name, -1, &onebuf, s->prefix);
 	two = quote_path(two_name, -1, &twobuf, s->prefix);
 
-	color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
+	status_printf(s, color(WT_STATUS_HEADER, s), "\t");
 	switch (status) {
 	case DIFF_STATUS_ADDED:
-		color_fprintf(s->fp, c, "new file:   %s", one);
+		status_printf_more(s, c, "new file:   %s", one);
 		break;
 	case DIFF_STATUS_COPIED:
-		color_fprintf(s->fp, c, "copied:     %s -> %s", one, two);
+		status_printf_more(s, c, "copied:     %s -> %s", one, two);
 		break;
 	case DIFF_STATUS_DELETED:
-		color_fprintf(s->fp, c, "deleted:    %s", one);
+		status_printf_more(s, c, "deleted:    %s", one);
 		break;
 	case DIFF_STATUS_MODIFIED:
-		color_fprintf(s->fp, c, "modified:   %s", one);
+		status_printf_more(s, c, "modified:   %s", one);
 		break;
 	case DIFF_STATUS_RENAMED:
-		color_fprintf(s->fp, c, "renamed:    %s -> %s", one, two);
+		status_printf_more(s, c, "renamed:    %s -> %s", one, two);
 		break;
 	case DIFF_STATUS_TYPE_CHANGED:
-		color_fprintf(s->fp, c, "typechange: %s", one);
+		status_printf_more(s, c, "typechange: %s", one);
 		break;
 	case DIFF_STATUS_UNKNOWN:
-		color_fprintf(s->fp, c, "unknown:    %s", one);
+		status_printf_more(s, c, "unknown:    %s", one);
 		break;
 	case DIFF_STATUS_UNMERGED:
-		color_fprintf(s->fp, c, "unmerged:   %s", one);
+		status_printf_more(s, c, "unmerged:   %s", one);
 		break;
 	default:
 		die("bug: unhandled diff status %c", status);
 	}
 	if (extra.len) {
-		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "%s", extra.buf);
+		status_printf_more(s, color(WT_STATUS_HEADER, s), "%s", extra.buf);
 		strbuf_release(&extra);
 	}
-	fprintf(s->fp, "\n");
+	status_printf_more(s, GIT_COLOR_NORMAL, "\n");
 	strbuf_release(&onebuf);
 	strbuf_release(&twobuf);
 }
@@ -647,9 +647,9 @@ static void wt_status_print_other(struct wt_status *s,
 	for (i = 0; i < l->nr; i++) {
 		struct string_list_item *it;
 		it = &(l->items[i]);
-		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "#\t");
-		color_fprintf_ln(s->fp, color(WT_STATUS_UNTRACKED, s), "%s",
-				 quote_path(it->string, strlen(it->string),
+		status_printf(s, color(WT_STATUS_HEADER, s), "\t");
+		status_printf_more(s, color(WT_STATUS_UNTRACKED, s),
+			"%s\n", quote_path(it->string, strlen(it->string),
 					    &buf, s->prefix));
 	}
 	strbuf_release(&buf);
@@ -716,17 +716,17 @@ void wt_status_print(struct wt_status *s)
 			branch_status_color = color(WT_STATUS_NOBRANCH, s);
 			on_what = "Not currently on any branch.";
 		}
-		color_fprintf(s->fp, color(WT_STATUS_HEADER, s), "# ");
-		color_fprintf(s->fp, branch_status_color, "%s", on_what);
-		color_fprintf_ln(s->fp, branch_color, "%s", branch_name);
+		status_printf(s, color(WT_STATUS_HEADER, s), "");
+		status_printf_more(s, branch_status_color, "%s", on_what);
+		status_printf_more(s, branch_color, "%s\n", branch_name);
 		if (!s->is_initial)
 			wt_status_print_tracking(s);
 	}
 
 	if (s->is_initial) {
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "# Initial commit");
-		color_fprintf_ln(s->fp, color(WT_STATUS_HEADER, s), "#");
+		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
+		status_printf_ln(s, color(WT_STATUS_HEADER, s), "Initial commit");
+		status_printf_ln(s, color(WT_STATUS_HEADER, s), "");
 	}
 
 	wt_status_print_updated(s);
@@ -743,7 +743,7 @@ void wt_status_print(struct wt_status *s)
 		if (s->show_ignored_files)
 			wt_status_print_other(s, &s->ignored, "Ignored", "add -f");
 	} else if (s->commitable)
-		fprintf(s->fp, "# Untracked files not listed%s\n",
+		status_printf_ln(s, GIT_COLOR_NORMAL, "Untracked files not listed%s",
 			advice_status_hints
 			? " (use -u option to show untracked files)" : "");
 
@@ -751,7 +751,7 @@ void wt_status_print(struct wt_status *s)
 		wt_status_print_verbose(s);
 	if (!s->commitable) {
 		if (s->amend)
-			fprintf(s->fp, "# No changes\n");
+			status_printf_ln(s, GIT_COLOR_NORMAL, "No changes");
 		else if (s->nowarn)
 			; /* nothing */
 		else if (s->workdir_dirty)
-- 
1.7.4.1
