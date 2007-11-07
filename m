From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] Make git-clean a builtin
Date: Tue,  6 Nov 2007 23:18:51 -0600
Message-ID: <11944127311587-git-send-email-shawn.bohrer@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Nov 07 06:18:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IpdJN-0000yc-UO
	for gcvg-git-2@gmane.org; Wed, 07 Nov 2007 06:18:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbXKGFSb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Nov 2007 00:18:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbXKGFSb
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Nov 2007 00:18:31 -0500
Received: from wx-out-0506.google.com ([66.249.82.231]:10759 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750821AbXKGFS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Nov 2007 00:18:29 -0500
Received: by wx-out-0506.google.com with SMTP id h31so2344733wxd
        for <git@vger.kernel.org>; Tue, 06 Nov 2007 21:18:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bN/yZXLwjWKBnPcTB1wHAKoHdEqmv5YoH4y3jm7MosA=;
        b=RRXXKVq4i9dm6Usc5nBoXNyfxg+AKCL2KMqAWTsJCw8T943q2iE3R5XfcQDKSIn1E6q+3n3aGS/UPdn66l5ZQfkiFzAX+UWIkK/4HyvtqP5npTcSGzwb2bs7qkthd0vx+Q9YI3qCR7yWQ+ahUzI2yZZ1j60grVTsw08PGxpJwaA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Wprh8UCrk0TohJ+0ZRHQZJZIuleK+dzMrtlrY29tOK990h4ZdnURHRoAw1vXZShqBbDY64ojDh1coede7239fCIeSzNA8uYOtjYhZqvPna58Ugnv/voJzpJNyMdWYJKy+W3OrCQOmyNyYAqX/qn3odKGtoDoTAjvuPo9j6Djjso=
Received: by 10.70.118.4 with SMTP id q4mr11550652wxc.1194412708287;
        Tue, 06 Nov 2007 21:18:28 -0800 (PST)
Received: from mediacenter ( [70.112.149.232])
        by mx.google.com with ESMTPS id h12sm11459890wxd.2007.11.06.21.18.24
        (version=SSLv3 cipher=OTHER);
        Tue, 06 Nov 2007 21:18:25 -0800 (PST)
Received: by mediacenter (sSMTP sendmail emulation); Tue,  6 Nov 2007 23:18:52 -0600
X-Mailer: git-send-email 1.5.3.GIT
In-Reply-To: 7vbqa8j5yr.fsf@gitster.siamese.dyndns.org
References: 7vbqa8j5yr.fsf@gitster.siamese.dyndns.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63771>

This replaces git-clean.sh with builtin-clean.c, and moves
git-clean.sh to the examples.

This also introduces a change in behavior where the -d parameter is
required to remove an entire directory of untracked files even when
the directory is passed as a path.  For example:

   git clean dir/

Now requires

   git clean -d dir/

if 'dir' only contains untracked files.  This is consistent with the
old behavior when two or more paths were specified.

Thanks to Johannes Schindelin for the conversion to using the
parse-options API.

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---
 Makefile                                      |    3 +-
 builtin-clean.c                               |  134 +++++++++++++++++++++++++
 builtin.h                                     |    1 +
 git-clean.sh => contrib/examples/git-clean.sh |    0 
 git.c                                         |    1 +
 5 files changed, 138 insertions(+), 1 deletions(-)
 create mode 100644 builtin-clean.c
 rename git-clean.sh => contrib/examples/git-clean.sh (100%)

diff --git a/Makefile b/Makefile
index c427fee..932ff08 100644
--- a/Makefile
+++ b/Makefile
@@ -209,7 +209,7 @@ BASIC_LDFLAGS =
 
 SCRIPT_SH = \
 	git-bisect.sh git-checkout.sh \
-	git-clean.sh git-clone.sh git-commit.sh \
+	git-clone.sh git-commit.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
 	git-repack.sh git-request-pull.sh \
@@ -325,6 +325,7 @@ BUILTIN_OBJS = \
 	builtin-check-attr.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
+	builtin-clean.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
 	builtin-describe.o \
diff --git a/builtin-clean.c b/builtin-clean.c
new file mode 100644
index 0000000..fb2feb5
--- /dev/null
+++ b/builtin-clean.c
@@ -0,0 +1,134 @@
+/*
+ * "git clean" builtin command
+ *
+ * Copyright (C) 2007 Shawn Bohrer
+ *
+ * Based on git-clean.sh by Pavel Roskin
+ */
+
+#include "builtin.h"
+#include "cache.h"
+#include "dir.h"
+#include "parse-options.h"
+
+static int force;
+
+static const char *const builtin_clean_usage[] = {
+	"git-clean [-d] [-f] [-n] [-q] [-x | -X] [--] <paths>...",
+	NULL
+};
+
+static int git_clean_config(const char *var, const char *value)
+{
+	if (!strcmp(var, "clean.requireforce")) {
+		force = !git_config_bool(var, value);
+	}
+	return 0;
+}
+
+int cmd_clean(int argc, const char **argv, const char *prefix)
+{
+	int j;
+	int show_only = 0, remove_directories = 0, quiet = 0, ignored = 0;
+	int ignored_only = 0, baselen = 0;
+	struct strbuf directory;
+	struct dir_struct dir;
+	const char *path = ".";
+	const char *base = "";
+	static const char **pathspec;
+	struct option options[] = {
+		OPT__QUIET(&quiet),
+		OPT__DRY_RUN(&show_only),
+		OPT_BOOLEAN('f', NULL, &force, "force"),
+		OPT_BOOLEAN('d', NULL, &remove_directories,
+				"remove whole directories"),
+		OPT_BOOLEAN('x', NULL, &ignored, "remove ignored files, too"),
+		OPT_BOOLEAN('X', NULL, &ignored_only,
+				"remove only ignored files"),
+		OPT_END()
+	};
+
+	git_config(git_clean_config);
+	argc = parse_options(argc, argv, options, builtin_clean_usage, 0);
+
+	memset(&dir, 0, sizeof(dir));
+	if (ignored_only) {
+		dir.show_ignored =1;
+		dir.exclude_per_dir = ".gitignore";
+	}
+
+	if (ignored && ignored_only)
+		die("-x and -X cannot be used together");
+
+	if (!show_only && !force)
+		die("clean.requireForce set and -n or -f not given; refusing to clean");
+
+	dir.show_other_directories = 1;
+
+	if (!ignored) {
+		dir.exclude_per_dir = ".gitignore";
+		if (!access(git_path("info/exclude"), F_OK)) {
+			char *exclude_path = git_path("info/exclude");
+			add_excludes_from_file(&dir, exclude_path);
+		}
+	}
+
+	pathspec = get_pathspec(prefix, argv);
+	read_cache();
+	read_directory(&dir, path, base, baselen, pathspec);
+	strbuf_init(&directory, 0);
+
+	for (j = 0; j < dir.nr; ++j) {
+		struct dir_entry *ent = dir.entries[j];
+		int len, pos;
+		struct cache_entry *ce;
+		struct stat st;
+
+		/*
+		 * Remove the '/' at the end that directory
+		 * walking adds for directory entries.
+		 */
+		len = ent->len;
+		if (len && ent->name[len-1] == '/')
+			len--;
+		pos = cache_name_pos(ent->name, len);
+		if (0 <= pos)
+			continue;	/* exact match */
+		pos = -pos - 1;
+		if (pos < active_nr) {
+			ce = active_cache[pos];
+			if (ce_namelen(ce) == len &&
+			    !memcmp(ce->name, ent->name, len))
+				continue; /* Yup, this one exists unmerged */
+		}
+
+		/* remove the files */
+		if (!lstat(ent->name, &st) && (S_ISDIR(st.st_mode))) {
+			strbuf_addstr(&directory, ent->name);
+			if (show_only && remove_directories) {
+				printf("Would remove %s\n", directory.buf);
+			} else if (quiet && remove_directories) {
+				remove_dir_recursively(&directory, 0);
+			} else if (remove_directories) {
+				printf("Removing %s\n", ent->name);
+				remove_dir_recursively(&directory, 0);
+			} else if (show_only) {
+				printf("Would not remove %s\n", directory.buf);
+			} else {
+				printf("Not removing %s\n", directory.buf);
+			}
+			strbuf_reset(&directory);
+		} else {
+			if (show_only) {
+				printf("Would remove %s\n", ent->name);
+				continue;
+			} else if (!quiet) {
+				printf("Removing %s\n", ent->name);
+			}
+			unlink(ent->name);
+		}
+	}
+
+	strbuf_release(&directory);
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 525107f..5476a92 100644
--- a/builtin.h
+++ b/builtin.h
@@ -24,6 +24,7 @@ extern int cmd_check_attr(int argc, const char **argv, const char *prefix);
 extern int cmd_check_ref_format(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry(int argc, const char **argv, const char *prefix);
 extern int cmd_cherry_pick(int argc, const char **argv, const char *prefix);
+extern int cmd_clean(int argc, const char **argv, const char *prefix);
 extern int cmd_commit_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_count_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_describe(int argc, const char **argv, const char *prefix);
diff --git a/git-clean.sh b/contrib/examples/git-clean.sh
similarity index 100%
rename from git-clean.sh
rename to contrib/examples/git-clean.sh
diff --git a/git.c b/git.c
index 204a6f7..3fa8e4d 100644
--- a/git.c
+++ b/git.c
@@ -293,6 +293,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "check-attr", cmd_check_attr, RUN_SETUP | NEED_WORK_TREE },
 		{ "cherry", cmd_cherry, RUN_SETUP },
 		{ "cherry-pick", cmd_cherry_pick, RUN_SETUP | NEED_WORK_TREE },
+		{ "clean", cmd_clean, RUN_SETUP | NEED_WORK_TREE },
 		{ "commit-tree", cmd_commit_tree, RUN_SETUP },
 		{ "config", cmd_config },
 		{ "count-objects", cmd_count_objects, RUN_SETUP },
-- 
1.5.3.GIT
