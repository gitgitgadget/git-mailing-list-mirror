From: Adam Spiers <git@adamspiers.org>
Subject: [PATCH] clean.c, ls-files.c: respect encapsulation of exclude_list_groups
Date: Wed, 16 Jan 2013 13:25:58 +0000
Message-ID: <1358342758-30503-1-git-send-email-git@adamspiers.org>
References: <CAOkDyE-p9WLrsFZjPb9sY+YEypkF2wDxMybBkCT-76jBbKOmCA@mail.gmail.com>
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jan 16 14:26:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvT0Y-0004BD-3C
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jan 2013 14:26:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757194Ab3APN0A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 08:26:00 -0500
Received: from coral.adamspiers.org ([85.119.82.20]:34266 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752429Ab3APNZ7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Jan 2013 08:25:59 -0500
Received: from localhost (e.6.2.e.6.c.9.b.d.c.e.3.4.0.d.0.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d04:3ecd:b9c6:e26e])
	by coral.adamspiers.org (Postfix) with ESMTPSA id B68212E332
	for <git@vger.kernel.org>; Wed, 16 Jan 2013 13:25:58 +0000 (GMT)
X-Mailer: git-send-email 1.8.1.291.g0730ed6
In-Reply-To: <CAOkDyE-p9WLrsFZjPb9sY+YEypkF2wDxMybBkCT-76jBbKOmCA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213753>

Consumers of the dir.c traversal API should avoid assuming knowledge
of the internal implementation of exclude_list_groups.  Therefore
when adding items to an exclude list, it should be accessed via the
pointer returned from add_exclude_list(), rather than by referencing
a location within dir.exclude_list_groups[EXC_CMDL].

Signed-off-by: Adam Spiers <git@adamspiers.org>
---
 builtin/clean.c    |  6 +++---
 builtin/ls-files.c | 15 ++++++++++-----
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index b098288..b9cb7ad 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -45,6 +45,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	static const char **pathspec;
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
+	struct exclude_list *el;
 	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
@@ -97,10 +98,9 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	if (!ignored)
 		setup_standard_excludes(&dir);
 
-	add_exclude_list(&dir, EXC_CMDL, "--exclude option");
+	el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
 	for (i = 0; i < exclude_list.nr; i++)
-		add_exclude(exclude_list.items[i].string, "", 0,
-			    &dir.exclude_list_group[EXC_CMDL].el[0], -(i+1));
+		add_exclude(exclude_list.items[i].string, "", 0, el, -(i+1));
 
 	pathspec = get_pathspec(prefix, argv);
 
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index fa9ccb8..b4d8b01 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -421,10 +421,10 @@ static int option_parse_z(const struct option *opt,
 static int option_parse_exclude(const struct option *opt,
 				const char *arg, int unset)
 {
-	struct exclude_list_group *group = opt->value;
+	struct string_list *exclude_list = opt->value;
 
 	exc_given = 1;
-	add_exclude(arg, "", 0, &group->el[0], --exclude_args);
+	string_list_append(exclude_list, arg);
 
 	return 0;
 }
@@ -453,9 +453,11 @@ static int option_parse_exclude_standard(const struct option *opt,
 
 int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 {
-	int require_work_tree = 0, show_tag = 0;
+	int require_work_tree = 0, show_tag = 0, i;
 	const char *max_prefix;
 	struct dir_struct dir;
+	struct exclude_list *el;
+	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	struct option builtin_ls_files_options[] = {
 		{ OPTION_CALLBACK, 'z', NULL, NULL, NULL,
 			"paths are separated with NUL character",
@@ -490,7 +492,7 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 		OPT_BOOLEAN(0, "resolve-undo", &show_resolve_undo,
 			    "show resolve-undo information"),
 		{ OPTION_CALLBACK, 'x', "exclude",
-			&dir.exclude_list_group[EXC_CMDL], "pattern",
+			&exclude_list, "pattern",
 			"skip files matching pattern",
 			0, option_parse_exclude },
 		{ OPTION_CALLBACK, 'X', "exclude-from", &dir, "file",
@@ -525,9 +527,12 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
 	if (read_cache() < 0)
 		die("index file corrupt");
 
-	add_exclude_list(&dir, EXC_CMDL, "--exclude option");
 	argc = parse_options(argc, argv, prefix, builtin_ls_files_options,
 			ls_files_usage, 0);
+	el = add_exclude_list(&dir, EXC_CMDL, "--exclude option");
+	for (i = 0; i < exclude_list.nr; i++) {
+		add_exclude(exclude_list.items[i].string, "", 0, el, --exclude_args);
+	}
 	if (show_tag || show_valid_bit) {
 		tag_cached = "H ";
 		tag_unmerged = "M ";
-- 
1.8.1.291.g0730ed6
