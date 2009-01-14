From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH 3/3] implement pattern matching in ce_path_match
Date: Wed, 14 Jan 2009 15:54:36 +0100
Message-ID: <1231944876-29930-4-git-send-email-drizzd@aon.at>
References: <1231944876-29930-1-git-send-email-drizzd@aon.at>
 <1231944876-29930-2-git-send-email-drizzd@aon.at>
 <1231944876-29930-3-git-send-email-drizzd@aon.at>
Cc: Junio C Hamano <gitster@pobox.com>, johannes@familieschneider.info,
	Clemens Buchacher <drizzd@aon.at>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 14 15:56:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN79x-0004vJ-Im
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 15:55:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755647AbZANOyg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 09:54:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755547AbZANOyg
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 09:54:36 -0500
Received: from postman.fh-hagenberg.at ([193.170.124.96]:43210 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755378AbZANOyd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 09:54:33 -0500
Received: from darc.dyndns.org ([84.154.84.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 14 Jan 2009 15:54:22 +0100
Received: from drizzd by darc.dyndns.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1LN78e-0007oB-T0; Wed, 14 Jan 2009 15:54:36 +0100
X-Mailer: git-send-email 1.6.1
In-Reply-To: <1231944876-29930-3-git-send-email-drizzd@aon.at>
X-OriginalArrivalTime: 14 Jan 2009 14:54:24.0248 (UTC) FILETIME=[FD686780:01C97657]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105635>

For tracked files, matching globbing pattern in "git add" was broken
by 1e5f764c (builtin-add.c: optimize -A option and "git add ."), which
uses ce_path_match instead of match_pathspec for tracked files.
But ce_path_match does not implement pattern matching.

With this patch ce_path_match uses match_pathspec in order to perform
pattern matching.

This also implies pattern matching for many other git commands, such
as add -u, blame, log, etc.  For "git log --follow", we have to
disallow globbing pattern, because they potentially match more than
one file.

Reported-by: Johannes Schneider <johannes@familieschneider.info>
Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---
 builtin-log.c         |   13 ++++++++++++-
 read-cache.c          |   23 +----------------------
 t/t2200-add-update.sh |   10 ++++++++++
 3 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index c7aa48e..16e9207 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -25,6 +25,17 @@ static int default_show_root = 1;
 static const char *fmt_patch_subject_prefix = "PATCH";
 static const char *fmt_pretty;
 
+static int has_special(const char *p)
+{
+	int x;
+
+	while ((x = *p++) != '\0')
+		if (isspecial(x))
+			return 1;
+
+	return 0;
+}
+
 static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		      struct rev_info *rev)
 {
@@ -49,7 +60,7 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
 		rev->always_show_header = 0;
 	if (DIFF_OPT_TST(&rev->diffopt, FOLLOW_RENAMES)) {
 		rev->always_show_header = 0;
-		if (rev->diffopt.nr_paths != 1)
+		if (rev->diffopt.nr_paths != 1 || has_special(rev->diffopt.paths[0]))
 			usage("git logs can only follow renames on one pathname at a time");
 	}
 	for (i = 1; i < argc; i++) {
diff --git a/read-cache.c b/read-cache.c
index b1475ff..8a5f306 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -640,28 +640,7 @@ int ce_same_name(struct cache_entry *a, struct cache_entry *b)
 
 int ce_path_match(const struct cache_entry *ce, const char **pathspec)
 {
-	const char *match, *name;
-	int len;
-
-	if (!pathspec)
-		return 1;
-
-	len = ce_namelen(ce);
-	name = ce->name;
-	while ((match = *pathspec++) != NULL) {
-		int matchlen = strlen(match);
-		if (matchlen > len)
-			continue;
-		if (memcmp(name, match, matchlen))
-			continue;
-		if (matchlen && name[matchlen-1] == '/')
-			return 1;
-		if (name[matchlen] == '/' || !name[matchlen])
-			return 1;
-		if (!matchlen)
-			return 1;
-	}
-	return 0;
+	return match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, NULL);
 }
 
 /*
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index cd9231c..6d99461 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -128,4 +128,14 @@ test_expect_success 'add -n -u should not add but just report' '
 
 '
 
+test_expect_success 'wildcard update' '
+
+	: >a.x &&
+	git add "*.x" &&
+	echo asdf >a.x &&
+	git add -u "*.x" &&
+	test -z "`git ls-files -m a.x`"
+
+'
+
 test_done
-- 
1.6.1
