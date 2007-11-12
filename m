From: Shawn Bohrer <shawn.bohrer@gmail.com>
Subject: [PATCH] Make git-clean a builtin
Date: Sun, 11 Nov 2007 19:48:47 -0600
Message-ID: <11948321274147-git-send-email-shawn.bohrer@gmail.com>
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	Shawn Bohrer <shawn.bohrer@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 12 02:48:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrOPb-0006Yv-Vh
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 02:48:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752943AbXKLBsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Nov 2007 20:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752543AbXKLBsL
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 20:48:11 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:16218 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbXKLBsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 20:48:09 -0500
Received: by an-out-0708.google.com with SMTP id b36so169866ana
        for <git@vger.kernel.org>; Sun, 11 Nov 2007 17:48:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=KUcqrsnlxT4rhoDc9CRl9ZZAXrvi3t1Xi3p92ADxjps=;
        b=Lm0Q/qGZUE57ciNdfo0uiRrAkggXLd0HQcdSdwQmFBSSz8HhV77EUeWyEPAASAjlVRItvNOPLGVctvn2aieXsFfkGIHH1kyDMgCawVj+Az04H7MpnBm706O/GojBjOA8R7CA+kylkYSqT4HOHkdQ26GefuA3hfz/66ms8ovyM3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JmOjw0a+vBDbFAvbo+A77r+V9EWBROlemDxvE0HRCbdL29oIfo2eleipzXy8R/ZCMiKu6CaRkLsC59ckIxgubgwax/LPz8/2nC+qaK8diJ4HS5+M8xPo+oqgw+/ahU6bPvw9jmrE4Z6HFaefFhIJUQrMzcshpCmktZk5u68qSMs=
Received: by 10.100.206.11 with SMTP id d11mr6482036ang.1194832088266;
        Sun, 11 Nov 2007 17:48:08 -0800 (PST)
Received: from mediacenter ( [70.112.149.232])
        by mx.google.com with ESMTPS id 15sm6005318wrl.2007.11.11.17.48.05
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2007 17:48:06 -0800 (PST)
Received: by mediacenter (sSMTP sendmail emulation); Sun, 11 Nov 2007 19:48:47 -0600
X-Mailer: git-send-email 1.5.3.GIT
In-Reply-To: 20071108053750.GC6768@mediacenter.austin.rr.com
References: 20071108053750.GC6768@mediacenter.austin.rr.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64549>

This replaces git-clean.sh with builtin-clean.c, and moves
git-clean.sh to the examples.

This also introduces a change in behavior when removing directories
explicitly specified as a path.  For example currently:

1. When dir has only untracked files, these two behave differently:

    $ git clean -n dir
    $ git clean -n dir/

the former says "Would not remove dir/", while the latter would say
"Would remove dir/untracked" for all paths under it, but not the
directory itself.

With -d, the former would stop refusing, however since the user
explicitly asked to remove the directory the -d is no longer required.

2. When there are more parameters:

    $ git clean -n dir foo
    $ git clean -n dir/ foo

both cases refuse to remove dir/ unless -d is specified.  Once again
since both cases requested to remove dir the -d is no longer required.

Thanks to Johannes Schindelin for the conversion to using the
parse-options API.

Signed-off-by: Shawn Bohrer <shawn.bohrer@gmail.com>
---

On Wed, Nov 07, 2007 at 11:37:50PM -0600, Shawn Bohrer wrote:
> On Wed, Nov 07, 2007 at 12:42:16PM -0800, Junio C Hamano wrote:
> >
> > Having said that, I do not particularly agree with the way the
> > new implementation resolves the existing inconsistencies.
> >
> > Wouldn't it be better to remove "dir" when the user explicitly
> > told you to clean "dir", with or without the trailing slash?
> > That's what the user asked you to do, isn't it?
>
> Yes I suppose I agree.  Of course I need to spend some more time staring
> at the code to figure out how to do so.  Perhaps I can figure out what
> is causing the original inconsistency in git-ls-files while I'm at it.

OK, I failed to fix the inconsistency between a single and multiple
paths so I'm not sure if this patch is much better.  The problem appears
to be that when dir.show_others_directories is set directories that only
contain untracked files are not recursed, which is fine with a single
path because you can adjust the path, base and baselen to
read_directory().  With multiple paths you need to find a common prefix
to all of the paths before calling read_directory() which causes the
inconsistency.

If anyone as a suggestion on how to fix this I'm all for it, but even
with the inconsistency we are no worse than we were with git-clean.sh

 Makefile                                      |    3 +-
 builtin-clean.c                               |  154 +++++++++++++++++++++++++
 builtin.h                                     |    1 +
 git-clean.sh => contrib/examples/git-clean.sh |    0 
 git.c                                         |    1 +
 5 files changed, 158 insertions(+), 1 deletions(-)
 create mode 100644 builtin-clean.c
 rename git-clean.sh => contrib/examples/git-clean.sh (100%)

diff --git a/Makefile b/Makefile
index a2fcdb8..ef7420d 100644
--- a/Makefile
+++ b/Makefile
@@ -213,7 +213,7 @@ BASIC_LDFLAGS =
 
 SCRIPT_SH = \
 	git-bisect.sh git-checkout.sh \
-	git-clean.sh git-clone.sh git-commit.sh \
+	git-clone.sh git-commit.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
 	git-repack.sh git-request-pull.sh \
@@ -329,6 +329,7 @@ BUILTIN_OBJS = \
 	builtin-check-attr.o \
 	builtin-checkout-index.o \
 	builtin-check-ref-format.o \
+	builtin-clean.o \
 	builtin-commit-tree.o \
 	builtin-count-objects.o \
 	builtin-describe.o \
diff --git a/builtin-clean.c b/builtin-clean.c
new file mode 100644
index 0000000..55658e7
--- /dev/null
+++ b/builtin-clean.c
@@ -0,0 +1,154 @@
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
+	if (!strcmp(var, "clean.requireforce"))
+		force = !git_config_bool(var, value);
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
+	const char *path, *base;
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
+
+	/*
+	 * Calculate common prefix for the pathspec, and
+	 * use that to optimize the directory walk
+	 */
+	baselen = common_prefix(pathspec);
+	path = ".";
+	base = "";
+	if (baselen)
+		path = base = xmemdupz(*pathspec, baselen);
+	read_directory(&dir, path, base, baselen, pathspec);
+	strbuf_init(&directory, 0);
+
+	for (j = 0; j < dir.nr; ++j) {
+		struct dir_entry *ent = dir.entries[j];
+		int len, pos, specs;
+		struct cache_entry *ce;
+		struct stat st;
+		char *seen;
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
+		if (!lstat(ent->name, &st) && (S_ISDIR(st.st_mode))) {
+			int matched_path = 0;
+			strbuf_addstr(&directory, ent->name);
+			if (pathspec) {
+				for (specs =0; pathspec[specs]; ++specs)
+					/* nothing */;
+				seen = xcalloc(specs, 1);
+				/* Check if directory was explictly passed as
+				 * pathspec.  If so we want to remove it */
+				if (match_pathspec(pathspec, ent->name, ent->len,
+						   baselen, seen))
+					matched_path = 1;
+				free(seen);
+			}
+			if (show_only && (remove_directories || matched_path)) {
+				printf("Would remove %s\n", directory.buf);
+			} else if (quiet && (remove_directories || matched_path)) {
+				remove_dir_recursively(&directory, 0);
+			} else if (remove_directories || matched_path) {
+				printf("Removing %s\n", directory.buf);
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
