From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH v2 3/5] check-ignore: move setup into cmd_check_ignore()
Date: Thu, 11 Apr 2013 13:05:11 +0100
Message-ID: <1365681913-7059-3-git-send-email-git@adamspiers.org>
References: <20130411110511.GB24296@pacific.linksys.moosehall>
 <1365681913-7059-1-git-send-email-git@adamspiers.org>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 14:05:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQGFy-0002ks-7w
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 14:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935153Ab3DKMFT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 08:05:19 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:59033 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761977Ab3DKMFR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 08:05:17 -0400
Received: from localhost (2.d.c.d.2.5.f.b.c.0.4.8.0.1.4.d.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d410:840c:bf52:dcd2])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 78AF258EB3
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 13:05:16 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.342.gfa7285d
In-Reply-To: <1365681913-7059-1-git-send-email-git@adamspiers.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220849>

Initialisation of the dir_struct and path_exclude_check structs was
previously done within check_ignore().  This was acceptable since
check_ignore() was only called once per check-ignore invocation;
however the next commit will convert it into an inner loop which is
called once per line of STDIN when --stdin is given.  Therefore moving
the initialisation code out into cmd_check_ignore() ensures that
initialisation is still only performed once per check-ignore
invocation, and consequently that the output is identical whether
pathspecs are provided as CLI arguments or via STDIN.

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/check-ignore.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 59acf74..e2d3006 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -63,30 +63,20 @@ static void output_exclude(const char *path, struct exclude *exclude)
 	}
 }
 
-static int check_ignore(const char *prefix, const char **pathspec)
+static int check_ignore(struct path_exclude_check *check,
+			const char *prefix, const char **pathspec)
 {
-	struct dir_struct dir;
 	const char *path, *full_path;
 	char *seen;
 	int num_ignored = 0, dtype = DT_UNKNOWN, i;
-	struct path_exclude_check check;
 	struct exclude *exclude;
 
-	/* read_cache() is only necessary so we can watch out for submodules. */
-	if (read_cache() < 0)
-		die(_("index file corrupt"));
-
-	memset(&dir, 0, sizeof(dir));
-	dir.flags |= DIR_COLLECT_IGNORED;
-	setup_standard_excludes(&dir);
-
 	if (!pathspec || !*pathspec) {
 		if (!quiet)
 			fprintf(stderr, "no pathspec given.\n");
 		return 0;
 	}
 
-	path_exclude_check_init(&check, &dir);
 	/*
 	 * look for pathspecs matching entries in the index, since these
 	 * should not be ignored, in order to be consistent with
@@ -101,7 +91,7 @@ static int check_ignore(const char *prefix, const char **pathspec)
 		die_if_path_beyond_symlink(full_path, prefix);
 		exclude = NULL;
 		if (!seen[i]) {
-			exclude = last_exclude_matching_path(&check, full_path,
+			exclude = last_exclude_matching_path(check, full_path,
 							     -1, &dtype);
 		}
 		if (!quiet && (exclude || show_non_matching))
@@ -110,13 +100,11 @@ static int check_ignore(const char *prefix, const char **pathspec)
 			num_ignored++;
 	}
 	free(seen);
-	clear_directory(&dir);
-	path_exclude_check_clear(&check);
 
 	return num_ignored;
 }
 
-static int check_ignore_stdin_paths(const char *prefix)
+static int check_ignore_stdin_paths(struct path_exclude_check *check, const char *prefix)
 {
 	struct strbuf buf, nbuf;
 	char **pathspec = NULL;
@@ -139,17 +127,18 @@ static int check_ignore_stdin_paths(const char *prefix)
 	}
 	ALLOC_GROW(pathspec, nr + 1, alloc);
 	pathspec[nr] = NULL;
-	num_ignored = check_ignore(prefix, (const char **)pathspec);
+	num_ignored = check_ignore(check, prefix, (const char **)pathspec);
 	maybe_flush_or_die(stdout, "attribute to stdout");
 	strbuf_release(&buf);
 	strbuf_release(&nbuf);
-	free(pathspec);
 	return num_ignored;
 }
 
 int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 {
 	int num_ignored;
+	struct dir_struct dir;
+	struct path_exclude_check check;
 
 	git_config(git_default_config, NULL);
 
@@ -174,12 +163,24 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 	if (show_non_matching && !verbose)
 		die(_("--non-matching is only valid with --verbose"));
 
+	/* read_cache() is only necessary so we can watch out for submodules. */
+	if (read_cache() < 0)
+		die(_("index file corrupt"));
+
+	memset(&dir, 0, sizeof(dir));
+	dir.flags |= DIR_COLLECT_IGNORED;
+	setup_standard_excludes(&dir);
+
+	path_exclude_check_init(&check, &dir);
 	if (stdin_paths) {
-		num_ignored = check_ignore_stdin_paths(prefix);
+		num_ignored = check_ignore_stdin_paths(&check, prefix);
 	} else {
-		num_ignored = check_ignore(prefix, argv);
+		num_ignored = check_ignore(&check, prefix, argv);
 		maybe_flush_or_die(stdout, "ignore to stdout");
 	}
 
+	clear_directory(&dir);
+	path_exclude_check_clear(&check);
+
 	return !num_ignored;
 }
-- 
1.8.2.1.342.gfa7285d
