From: Jonas Fonseca <fonseca@diku.dk>
Subject: [PATCH] Improve parent blame to detect renames by using the previous information
Date: Sat,  5 Jun 2010 15:56:05 -0400
Message-ID: <1275767765-8509-1-git-send-email-fonseca@diku.dk>
References: <20100523075503.GA24598@coredump.intra.peff.net>
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 05 21:56:17 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKzTb-0002vJ-9S
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 21:56:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757505Ab0FET4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 15:56:10 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:59562 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757009Ab0FET4J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 15:56:09 -0400
Received: by vws5 with SMTP id 5so1367593vws.19
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=BgCwIALmAgu2bFe0AeSdXbeE6+pX8PHVGFGcZkuMO3U=;
        b=DXbclwGyOWr6Q6fk9wS0OpLXYgL1nY1mrYJlZucctDJycWaQaW00nDy3Qwy7InH8XM
         zi+oivyXmg3EaH6dauz2iaaVDTMDg40zfCZQM2dybUWiCjiyQuzNQ37djz2jDmdnaTqw
         mHis/HzWxraHSgoYqEO6ZlTz2Y84vwMj9CaY8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=CvMePboQi4fL3TQfbKtCKCpvl7JwSRn6KWk76oin4k2ELr36cB8ra3X4cgvwZS8Fp3
         pfk+rCXpuXLd1I8MrKGph10bB2SF4cj3UPunUqf03nfFaMXiCizFu7xchix/rxjskzCf
         pGvpGpgA3pQBqgoqsBpdPxJn/KeKcQNNl8r1w=
Received: by 10.224.99.148 with SMTP id u20mr6504590qan.360.1275767767787;
        Sat, 05 Jun 2010 12:56:07 -0700 (PDT)
Received: from antimatter.gateway.2wire.net (bas1-montreal42-1178030776.dsl.bell.ca [70.55.82.184])
        by mx.google.com with ESMTPS id 8sm2093446qwj.20.2010.06.05.12.56.06
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 12:56:07 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.354.ge64bd
In-Reply-To: <20100523075503.GA24598@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148491>

>From git commit 96e117099c0e4f7d508eb071f60b6275038f6f37:

 It gives the parent commit of the blamed commit, _and_ a path in that
 parent commit that corresponds to the blamed path --- in short, it is
 the origin that would have been blamed (or passed blame through) for
 the line _if_ the blamed commit did not change that line.

This functionality was released in git version 1.6.3 in 2009-05-06.
---
 NEWS  |    2 +
 tig.c |   99 +++++++++++++++-------------------------------------------------
 2 files changed, 25 insertions(+), 76 deletions(-)

 I finally got some more time to dig around this. What if we simply uses
 the information given by the porcelain output's previous line? It
 handles your simple test case, and navigating in the tig repository. It
 also makes it possible to delete a lot of code.

diff --git a/NEWS b/NEWS
index 190e5dc..499bdbc 100644
--- a/NEWS
+++ b/NEWS
@@ -38,6 +38,8 @@ Bug fixes:
  - Fix unbind to behave as if the keybinding was never defined.
  - Fix unbind to also cover built-in run requests.
  - Fix parsing of unknown keymap names.
+ - Blame view: fix parent blame to detect renames. It uses "previous"
+   line info from the blame porcelain output added in git version 1.6.3.
 
 tig-0.15
 --------
diff --git a/tig.c b/tig.c
index 01f48c3..044da28 100644
--- a/tig.c
+++ b/tig.c
@@ -3977,73 +3977,6 @@ parse_author_line(char *ident, const char **author, struct time *time)
 	}
 }
 
-static bool
-open_commit_parent_menu(char buf[SIZEOF_STR], int *parents)
-{
-	char rev[SIZEOF_REV];
-	const char *revlist_argv[] = {
-		"git", "log", "--no-color", "-1", "--pretty=format:%s", rev, NULL
-	};
-	struct menu_item *items;
-	char text[SIZEOF_STR];
-	bool ok = TRUE;
-	int i;
-
-	items = calloc(*parents + 1, sizeof(*items));
-	if (!items)
-		return FALSE;
-
-	for (i = 0; i < *parents; i++) {
-		string_copy_rev(rev, &buf[SIZEOF_REV * i]);
-		if (!io_run_buf(revlist_argv, text, sizeof(text)) ||
-		    !(items[i].text = strdup(text))) {
-			ok = FALSE;
-			break;
-		}
-	}
-
-	if (ok) {
-		*parents = 0;
-		ok = prompt_menu("Select parent", items, parents);
-	}
-	for (i = 0; items[i].text; i++)
-		free((char *) items[i].text);
-	free(items);
-	return ok;
-}
-
-static bool
-select_commit_parent(const char *id, char rev[SIZEOF_REV], const char *path)
-{
-	char buf[SIZEOF_STR * 4];
-	const char *revlist_argv[] = {
-		"git", "log", "--no-color", "-1",
-			"--pretty=format:%P", id, "--", path, NULL
-	};
-	int parents;
-
-	if (!io_run_buf(revlist_argv, buf, sizeof(buf)) ||
-	    (parents = strlen(buf) / 40) < 0) {
-		report("Failed to get parent information");
-		return FALSE;
-
-	} else if (parents == 0) {
-		if (path)
-			report("Path '%s' does not exist in the parent", path);
-		else
-			report("The selected commit has no parents");
-		return FALSE;
-	}
-
-	if (parents == 1)
-		parents = 0;
-	else if (!open_commit_parent_menu(buf, &parents))
-		return FALSE;
-
-	string_copy_rev(rev, &buf[41 * parents]);
-	return TRUE;
-}
-
 /*
  * Pager backend
  */
@@ -4898,7 +4831,8 @@ struct blame_commit {
 	const char *author;		/* Author of the commit. */
 	struct time time;		/* Date from the author ident. */
 	char filename[128];		/* Name of file. */
-	bool has_previous;		/* Was a "previous" line detected. */
+	char parent_id[SIZEOF_REV];	/* Parent/previous SHA1 ID. */
+	char parent_filename[128];	/* Parent/previous name of file. */
 };
 
 struct blame {
@@ -5097,7 +5031,11 @@ blame_read(struct view *view, char *line)
 		string_ncopy(commit->title, line, strlen(line));
 
 	} else if (match_blame_header("previous ", &line)) {
-		commit->has_previous = TRUE;
+		if (strlen(line) <= SIZEOF_REV)
+			return FALSE;
+		string_copy_rev(commit->parent_id, line);
+		line += SIZEOF_REV;
+		string_ncopy(commit->parent_filename, line, strlen(line));
 
 	} else if (match_blame_header("filename ", &line)) {
 		string_ncopy(commit->filename, line, strlen(line));
@@ -5153,15 +5091,21 @@ check_blame_commit(struct blame *blame, bool check_null_id)
 static void
 setup_blame_parent_line(struct view *view, struct blame *blame)
 {
+	char from[SIZEOF_REF + SIZEOF_STR];
+	char to[SIZEOF_REF + SIZEOF_STR];
 	const char *diff_tree_argv[] = {
-		"git", "diff-tree", "-U0", blame->commit->id,
-			"--", blame->commit->filename, NULL
+		"git", "diff", "--no-textconv", "--no-extdiff", "--no-color",
+			"-U0", from, to, "--", NULL
 	};
 	struct io io;
 	int parent_lineno = -1;
 	int blamed_lineno = -1;
 	char *line;
 
+	snprintf(from, sizeof(from), "%s:%s", opt_ref, opt_file);
+	snprintf(to, sizeof(to), "%s:%s", blame->commit->id,
+		 blame->commit->filename);
+
 	if (!io_run(&io, IO_RD, NULL, diff_tree_argv))
 		return;
 
@@ -5204,10 +5148,13 @@ blame_request(struct view *view, enum request request, struct line *line)
 		break;
 
 	case REQ_PARENT:
-		if (check_blame_commit(blame, TRUE) &&
-		    select_commit_parent(blame->commit->id, opt_ref,
-					 blame->commit->filename)) {
-			string_copy(opt_file, blame->commit->filename);
+		if (!check_blame_commit(blame, TRUE))
+			break;
+		if (!*blame->commit->parent_id) {
+			report("The selected commit has no parents");
+		} else {
+			string_copy_rev(opt_ref, blame->commit->parent_id);
+			string_copy_rev(opt_file, blame->commit->parent_filename);
 			setup_blame_parent_line(view, blame);
 			open_view(view, REQ_VIEW_BLAME, OPEN_REFRESH);
 		}
@@ -5228,7 +5175,7 @@ blame_request(struct view *view, enum request request, struct line *line)
 					"-C", "-M", "HEAD", "--", view->vid, NULL
 			};
 
-			if (!blame->commit->has_previous) {
+			if (!*blame->commit->parent_id) {
 				diff_index_argv[1] = "diff";
 				diff_index_argv[2] = "--no-color";
 				diff_index_argv[6] = "--";
-- 
1.7.1.354.ge64bd
