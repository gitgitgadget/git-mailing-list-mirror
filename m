From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH 1/5] check-ignore: move setup into cmd_check_ignore()
Date: Thu, 11 Apr 2013 02:59:31 +0100
Message-ID: <1365645575-11428-1-git-send-email-git@adamspiers.org>
References: <20130408181311.GA14903@pacific.linksys.moosehall>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 03:59:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQ6ng-0007GP-J9
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 03:59:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935698Ab3DKB7i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Apr 2013 21:59:38 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:58202 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933295Ab3DKB7h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Apr 2013 21:59:37 -0400
Received: from localhost (5.c.4.3.a.a.9.7.2.0.8.9.d.e.c.b.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:bced:9802:79aa:34c5])
	by coral.adamspiers.org (Postfix) with ESMTPSA id 7AF842EAD5
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 02:59:36 +0100 (BST)
X-Mailer: git-send-email 1.8.2.1.347.g37e0606
In-Reply-To: <20130408181311.GA14903@pacific.linksys.moosehall>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220803>

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
 builtin/check-ignore.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/builtin/check-ignore.c b/builtin/check-ignore.c
index 0240f99..0a4eef1 100644
--- a/builtin/check-ignore.c
+++ b/builtin/check-ignore.c
@@ -53,30 +53,20 @@ static void output_exclude(const char *path, struct exclude *exclude)
 	}
 }
 
-static int check_ignore(const char *prefix, const char **pathspec)
+static int check_ignore(struct path_exclude_check check,
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
@@ -100,13 +90,11 @@ static int check_ignore(const char *prefix, const char **pathspec)
 		}
 	}
 	free(seen);
-	clear_directory(&dir);
-	path_exclude_check_clear(&check);
 
 	return num_ignored;
 }
 
-static int check_ignore_stdin_paths(const char *prefix)
+static int check_ignore_stdin_paths(struct path_exclude_check check, const char *prefix)
 {
 	struct strbuf buf, nbuf;
 	char **pathspec = NULL;
@@ -129,17 +117,18 @@ static int check_ignore_stdin_paths(const char *prefix)
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
 
@@ -162,12 +151,24 @@ int cmd_check_ignore(int argc, const char **argv, const char *prefix)
 			die(_("cannot have both --quiet and --verbose"));
 	}
 
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
+		num_ignored = check_ignore_stdin_paths(check, prefix);
 	} else {
-		num_ignored = check_ignore(prefix, argv);
+		num_ignored = check_ignore(check, prefix, argv);
 		maybe_flush_or_die(stdout, "ignore to stdout");
 	}
 
+	clear_directory(&dir);
+	path_exclude_check_clear(&check);
+
 	return !num_ignored;
 }
-- 
1.8.2.1.347.g37e0606
