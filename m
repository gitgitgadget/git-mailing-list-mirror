From: Brodie Rao <brodie@sf.io>
Subject: [PATCH] gc: support temporarily preserving garbage
Date: Thu, 13 Nov 2014 17:16:45 -0800
Message-ID: <1415927805-53644-1-git-send-email-brodie@sf.io>
Cc: Bryan Turner <bturner@atlassian.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 14 02:16:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xp5VQ-0003P2-Li
	for gcvg-git-2@plane.gmane.org; Fri, 14 Nov 2014 02:16:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbaKNBQx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Nov 2014 20:16:53 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33898 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965061AbaKNBQt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Nov 2014 20:16:49 -0500
Received: by mail-pa0-f44.google.com with SMTP id et14so1630950pad.17
        for <git@vger.kernel.org>; Thu, 13 Nov 2014 17:16:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=from:to:cc:subject:date:message-id;
        bh=ffSWqfJdcrQsViUnC47Lmb7ETCmB9PAa18oaDsGt86I=;
        b=Jb7+2VRmsAzoCEW+EMtpT16nCD3nYXMiz7piqSqNdBOG/gdF4HKhJLAtMYIS/3ocrZ
         XPGzV55yfYphp8pjxX/ee9G22cd+rZUldNBdIC7OnG5gpoNnIld6dL9dmuaE8932W3N6
         YBTPtWRlYQHMvFPSfqtRFhef0c9dEsVR0Lqjwy0x7PhmpsgASjiEuZPB4LC7AS1ePhps
         oO4tLoTjX6ApJ/I537FEUr55EuBf5e0Jf2TfRNiSGCmmp3murNJexwG3giaE6QcuXyTN
         CA3QIEhTKts6yOL8q6O1E8ZqPjZDNTLag7bmM1wPMC3XF1RIf0bOxxJFL38kwZ+0+EV/
         4IVA==
X-Received: by 10.70.118.1 with SMTP id ki1mr6589507pdb.69.1415927809129;
        Thu, 13 Nov 2014 17:16:49 -0800 (PST)
Received: from localhost (70-35-42-138.static.wiline.com. [70.35.42.138])
        by mx.google.com with ESMTPSA id kk1sm25927143pbd.14.2014.11.13.17.16.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Nov 2014 17:16:48 -0800 (PST)
X-Mailer: git-send-email 2.1.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch adds a gc.garbageexpire setting that, when not set to "now",
makes gc (and prune, prune-packed, and repack) move garbage into a
temporary garbage directory instead of deleting it immediately. The
garbage directory is then cleared out based on gc.garbageexpire.

The motivation for this setting is to work around various NFS servers
not supporting delete-on-last-close semantics between NFS clients.
Without proper support for that, gc could potentially delete objects
and packs that are in use by git processes on other NFS clients. If
another git process has a deleted pack file mmap()ed, it could crash
with a SIGBUS error on Linux.

Signed-off-by: Brodie Rao <brodie@sf.io>
---
 .gitignore                             |  1 +
 Documentation/config.txt               | 20 +++++++++
 Documentation/git-gc.txt               |  7 ++++
 Documentation/git-prune-garbage.txt    | 55 ++++++++++++++++++++++++
 Documentation/git-prune-packed.txt     |  9 ++++
 Documentation/git-prune.txt            |  9 ++++
 Documentation/git-repack.txt           |  6 +++
 Documentation/git.txt                  |  6 +++
 Makefile                               |  2 +
 builtin.h                              |  1 +
 builtin/gc.c                           | 20 +++++++++
 builtin/prune-garbage.c                | 77 ++++++++++++++++++++++++++++++++++
 builtin/prune-packed.c                 |  3 +-
 builtin/prune.c                        |  5 ++-
 builtin/repack.c                       |  7 ++--
 cache.h                                |  2 +
 command-list.txt                       |  1 +
 contrib/completion/git-completion.bash |  2 +
 environment.c                          | 12 +++++-
 gc.c                                   | 60 ++++++++++++++++++++++++++
 gc.h                                   | 16 +++++++
 git.c                                  |  1 +
 t/t6502-gc-garbage-expire.sh           | 60 ++++++++++++++++++++++++++
 23 files changed, 375 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/git-prune-garbage.txt
 create mode 100644 builtin/prune-garbage.c
 create mode 100644 gc.c
 create mode 100644 gc.h
 create mode 100755 t/t6502-gc-garbage-expire.sh

diff --git a/.gitignore b/.gitignore
index a052419..a9a4e30 100644
--- a/.gitignore
+++ b/.gitignore
@@ -107,6 +107,7 @@
 /git-parse-remote
 /git-patch-id
 /git-prune
+/git-prune-garbage
 /git-prune-packed
 /git-pull
 /git-push
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 9220725..0106d8f 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1213,6 +1213,26 @@ gc.autodetach::
 	Make `git gc --auto` return immediately and run in background
 	if the system supports it. Default is true.
 
+gc.garbageexpire::
+	When 'git gc' is run, objects and packs that are pruned are
+	immediately deleted from the file system. This setting can be
+	overridden to move pruned objects and packs to the garbage
+	directory. That leftover garbage will be deleted after the
+	specified grace period. The default value is "now", meaning
+	garbage is deleted immediately.
++
+Setting this to something other than "now" (e.g., "1.day.ago") can help
+work around issues with NFS servers that don't support
+delete-on-last-close semantics between NFS clients. 'git gc' will not
+unlink files immediately, so a git process on another NFS client that
+might be reading a garbage collected file will not crash.
++
+Note that this setting can cause the repository's size to increase as
+garbage collection passes are made. Care should be taken to make sure
+the grace period isn't too long. A grace period of one day might be
+reasonable if you make the assumption that your git processes over NFS
+won't run longer or have files open longer than one day.
+
 gc.packrefs::
 	Running `git pack-refs` in a repository renders it
 	unclonable by Git versions prior to 1.5.1.2 over dumb
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 273c466..f90dc0a 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -131,6 +131,12 @@ The optional configuration variable 'gc.pruneExpire' controls how old
 the unreferenced loose objects have to be before they are pruned.  The
 default is "2 weeks ago".
 
+The optional configurable variable 'gc.garbageexpire' controls how
+pruned objects and packs are deleted. This can be overridden to move
+pruned objects and packs to the garbage directory. That leftover garbage
+will be deleted after the specified grace period. The default value is
+"now", meaning garbage is deleted immediately.
+
 
 Notes
 -----
@@ -156,6 +162,7 @@ linkgit:githooks[5] for more information.
 SEE ALSO
 --------
 linkgit:git-prune[1]
+linkgit:git-prune-garbage[1]
 linkgit:git-reflog[1]
 linkgit:git-repack[1]
 linkgit:git-rerere[1]
diff --git a/Documentation/git-prune-garbage.txt b/Documentation/git-prune-garbage.txt
new file mode 100644
index 0000000..ff130e0
--- /dev/null
+++ b/Documentation/git-prune-garbage.txt
@@ -0,0 +1,55 @@
+git-prune-garbage(1)
+====================
+
+NAME
+----
+git-prune-garbage - Remove garbage objects and pack files
+
+
+SYNOPSIS
+--------
+[verse]
+'git prune-garbage' [-n] [-v] [--expire <expire>]
+
+
+DESCRIPTION
+-----------
+This command deletes objects and pack files in `$GIT_GARBAGE_DIRECTORY`
+that are older than the specified garbage expiration time. This is
+automatically run by linkgit:git-gc[1].
+
+The garbage directory is populated by linkgit:git-gc[1] and the commands
+it runs (linkgit:git-prune[1], linkgit:git-prune-packed[1], and
+linkgit:git-repack[1]).
+
+OPTIONS
+-------
+-n::
+--dry-run::
+	Do not remove anything; just report what it would remove.
+
+-v::
+--verbose::
+	Report all removed objects and packs.
+
+--expire <time>::
+	Only expire garbage objects and packs older than <time> (the
+	default is now, overridable by the config variable
+	`gc.garbageexpire`).
+
+Configuration
+-------------
+The optional configurable variable 'gc.garbageexpire' controls when garbage
+objects and packs are deleted. The default value is "now", meaning garbage
+is deleted immediately.
+
+SEE ALSO
+--------
+linkgit:git-gc[1]
+linkgit:git-prune[1]
+linkgit:git-prune-packed[1]
+linkgit:git-repack[1]
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 9fed59a..2858828 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -37,6 +37,15 @@ OPTIONS
 --quiet::
 	Squelch the progress indicator.
 
+Configuration
+-------------
+
+The optional configurable variable 'gc.garbageexpire' controls how pruned
+objects are deleted. This can be overridden to move redundant objects to
+the garbage directory. That leftover garbage will be deleted by 'git gc'
+after the specified grace period. The default value is "now", meaning
+garbage is deleted immediately.
+
 SEE ALSO
 --------
 linkgit:git-pack-objects[1]
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 7a493c8..a97ff12 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -53,6 +53,15 @@ OPTIONS
 	reachable from any of our references, keep objects
 	reachable from listed <head>s.
 
+Configuration
+-------------
+
+The optional configurable variable 'gc.garbageexpire' controls how pruned
+objects are deleted. This can be overridden to move redundant and
+unreachable objects to the garbage directory. That leftover garbage will
+be deleted by 'git gc' after the specified grace period. The default
+value is "now", meaning garbage is deleted immediately.
+
 EXAMPLE
 -------
 
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 4786a78..d8e17de 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -139,6 +139,12 @@ need to set the configuration variable `repack.UseDeltaBaseOffset` to
 is unaffected by this option as the conversion is performed on the fly
 as needed in that case.
 
+The optional configurable variable 'gc.garbageexpire' controls how
+packs are deleted. This can be overridden to move redundant and unused
+packs to the garbage directory. That leftover garbage will be deleted
+by 'git gc' after the specified grace period. The default value is "now",
+meaning garbage is deleted immediately.
+
 SEE ALSO
 --------
 linkgit:git-pack-objects[1]
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9202010..4cbc582 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -764,6 +764,12 @@ Git so take care if using Cogito etc.
 	of Git object directories which can be used to search for Git
 	objects. New objects will not be written to these directories.
 
+'GIT_GARBAGE_DIRECTORY'::
+	If garbage collection is configured to move pruned objects and
+	packs to the garbage directory (rather than immediately deleting
+	them), they will be stored at this path. Otherwise, the default
+	`$GIT_DIR/garbage` directory is used.
+
 'GIT_DIR'::
 	If the 'GIT_DIR' environment variable is set then it
 	specifies a path to use instead of the default `.git`
diff --git a/Makefile b/Makefile
index 827006b..048369c 100644
--- a/Makefile
+++ b/Makefile
@@ -687,6 +687,7 @@ LIB_OBJS += ewah/ewah_rlw.o
 LIB_OBJS += exec_cmd.o
 LIB_OBJS += fetch-pack.o
 LIB_OBJS += fsck.o
+LIB_OBJS += gc.o
 LIB_OBJS += gettext.o
 LIB_OBJS += gpg-interface.o
 LIB_OBJS += graph.o
@@ -852,6 +853,7 @@ BUILTIN_OBJS += builtin/pack-objects.o
 BUILTIN_OBJS += builtin/pack-redundant.o
 BUILTIN_OBJS += builtin/pack-refs.o
 BUILTIN_OBJS += builtin/patch-id.o
+BUILTIN_OBJS += builtin/prune-garbage.o
 BUILTIN_OBJS += builtin/prune-packed.o
 BUILTIN_OBJS += builtin/prune.o
 BUILTIN_OBJS += builtin/push.o
diff --git a/builtin.h b/builtin.h
index b87df70..c2a7858 100644
--- a/builtin.h
+++ b/builtin.h
@@ -97,6 +97,7 @@ extern int cmd_pack_objects(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_redundant(int argc, const char **argv, const char *prefix);
 extern int cmd_patch_id(int argc, const char **argv, const char *prefix);
 extern int cmd_prune(int argc, const char **argv, const char *prefix);
+extern int cmd_prune_garbage(int argc, const char **argv, const char *prefix);
 extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
diff --git a/builtin/gc.c b/builtin/gc.c
index 005adbe..31756ac 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -33,11 +33,13 @@ static int gc_auto_threshold = 6700;
 static int gc_auto_pack_limit = 50;
 static int detach_auto = 1;
 static const char *prune_expire = "2.weeks.ago";
+static const char *garbage_expire = NULL;
 
 static struct argv_array pack_refs_cmd = ARGV_ARRAY_INIT;
 static struct argv_array reflog = ARGV_ARRAY_INIT;
 static struct argv_array repack = ARGV_ARRAY_INIT;
 static struct argv_array prune = ARGV_ARRAY_INIT;
+static struct argv_array prune_garbage = ARGV_ARRAY_INIT;
 static struct argv_array rerere = ARGV_ARRAY_INIT;
 
 static char *pidfile;
@@ -81,6 +83,17 @@ static void gc_config(void)
 			}
 		}
 	}
+
+	if (!git_config_get_string_const("gc.garbageexpire", &garbage_expire)) {
+		if (strcmp(garbage_expire, "now")) {
+			unsigned long now = approxidate("now");
+			if (approxidate(garbage_expire) >= now) {
+				git_die_config("gc.garbageexpire", _("Invalid gc.garbageexpire: '%s'"),
+						garbage_expire);
+			}
+		}
+	}
+
 	git_config(git_default_config, NULL);
 }
 
@@ -288,6 +301,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	argv_array_pushl(&reflog, "reflog", "expire", "--all", NULL);
 	argv_array_pushl(&repack, "repack", "-d", "-l", NULL);
 	argv_array_pushl(&prune, "prune", "--expire", NULL );
+	argv_array_pushl(&prune_garbage, "prune-garbage", "--expire", NULL );
 	argv_array_pushl(&rerere, "rerere", "gc", NULL);
 
 	gc_config();
@@ -364,5 +378,11 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		warning(_("There are too many unreachable loose objects; "
 			"run 'git prune' to remove them."));
 
+	if (garbage_expire) {
+		argv_array_push(&prune_garbage, garbage_expire);
+		if (run_command_v_opt(prune_garbage.argv, RUN_GIT_CMD))
+			return error(FAILED_RUN, prune_garbage.argv[0]);
+	}
+
 	return 0;
 }
diff --git a/builtin/prune-garbage.c b/builtin/prune-garbage.c
new file mode 100644
index 0000000..1641f13
--- /dev/null
+++ b/builtin/prune-garbage.c
@@ -0,0 +1,77 @@
+#include "cache.h"
+#include "builtin.h"
+#include "parse-options.h"
+#include "dir.h"
+
+static const char * const prune_garbage_usage[] = {
+	N_("git prune-garbage [-n] [-v] [--expire <time>]"),
+	NULL
+};
+static int show_only;
+static int verbose;
+static unsigned long expire;
+
+static int prune_dir(struct strbuf *path, int remove_dir)
+{
+	size_t baselen = path->len;
+	DIR *dir = opendir(path->buf);
+	struct dirent *de;
+	struct stat st;
+
+	if (!dir)
+		return 0;
+
+	while ((de = readdir(dir)) != NULL) {
+		if (is_dot_or_dotdot(de->d_name))
+			continue;
+
+		strbuf_addf(path, "/%s", de->d_name);
+
+		if (lstat(path->buf, &st))
+			return error("Could not stat '%s'", path->buf);
+
+		if (st.st_mode & S_IFDIR)
+			prune_dir(path, 1);
+		else if (st.st_mtime <= expire) {
+			if (show_only || verbose)
+				printf("Removing garbage file %s\n",
+				       path->buf);
+			if (!show_only)
+				unlink_or_warn(path->buf);
+		}
+
+		strbuf_setlen(path, baselen);
+	}
+	closedir(dir);
+	if (!show_only && remove_dir)
+		rmdir(path->buf);
+	return 0;
+}
+
+static void prune_garbage_dir(const char *path)
+{
+	struct strbuf buf = STRBUF_INIT;
+
+	strbuf_addstr(&buf, path);
+	prune_dir(&buf, 0);
+}
+
+int cmd_prune_garbage(int argc, const char **argv, const char *prefix)
+{
+	const struct option options[] = {
+		OPT__DRY_RUN(&show_only, N_("do not remove, show only")),
+		OPT__VERBOSE(&verbose, N_("report pruned garbage")),
+		OPT_EXPIRY_DATE(0, "expire", &expire,
+				N_("expire objects older than <time>")),
+		OPT_END()
+	};
+
+	expire = ULONG_MAX;
+
+	argc = parse_options(argc, argv, prefix, options, prune_garbage_usage,
+			     0);
+
+	prune_garbage_dir(get_garbage_directory());
+
+	return 0;
+}
diff --git a/builtin/prune-packed.c b/builtin/prune-packed.c
index f24a2c2..a1427e8 100644
--- a/builtin/prune-packed.c
+++ b/builtin/prune-packed.c
@@ -1,5 +1,6 @@
 #include "builtin.h"
 #include "cache.h"
+#include "gc.h"
 #include "progress.h"
 #include "parse-options.h"
 
@@ -30,7 +31,7 @@ static int prune_object(const unsigned char *sha1, const char *path,
 	if (*opts & PRUNE_PACKED_DRY_RUN)
 		printf("rm -f %s\n", path);
 	else
-		unlink_or_warn(path);
+		gc_unlink_or_warn(path);
 	return 0;
 }
 
diff --git a/builtin/prune.c b/builtin/prune.c
index 04d3b12..6ba0670 100644
--- a/builtin/prune.c
+++ b/builtin/prune.c
@@ -7,6 +7,7 @@
 #include "parse-options.h"
 #include "progress.h"
 #include "dir.h"
+#include "gc.h"
 
 static const char * const prune_usage[] = {
 	N_("git prune [-n] [-v] [--expire <time>] [--] [<head>...]"),
@@ -27,7 +28,7 @@ static int prune_tmp_file(const char *fullpath)
 	if (show_only || verbose)
 		printf("Removing stale temporary file %s\n", fullpath);
 	if (!show_only)
-		unlink_or_warn(fullpath);
+		gc_unlink_or_warn(fullpath);
 	return 0;
 }
 
@@ -56,7 +57,7 @@ static int prune_object(const unsigned char *sha1, const char *fullpath,
 		       (type > 0) ? typename(type) : "unknown");
 	}
 	if (!show_only)
-		unlink_or_warn(fullpath);
+		gc_unlink_or_warn(fullpath);
 	return 0;
 }
 
diff --git a/builtin/repack.c b/builtin/repack.c
index 2845620..c696ba6 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -7,6 +7,7 @@
 #include "strbuf.h"
 #include "string-list.h"
 #include "argv-array.h"
+#include "gc.h"
 
 static int delta_base_offset = 1;
 static int pack_kept_objects = -1;
@@ -61,7 +62,7 @@ static void remove_temporary_files(void)
 			continue;
 		strbuf_setlen(&buf, dirlen);
 		strbuf_addstr(&buf, e->d_name);
-		unlink(buf.buf);
+		gc_unlink(buf.buf);
 	}
 	closedir(dir);
 	strbuf_release(&buf);
@@ -115,7 +116,7 @@ static void remove_redundant_pack(const char *dir_name, const char *base_name)
 	for (i = 0; i < ARRAY_SIZE(exts); i++) {
 		strbuf_setlen(&buf, plen);
 		strbuf_addstr(&buf, exts[i]);
-		unlink(buf.buf);
+		gc_unlink(buf.buf);
 	}
 	strbuf_release(&buf);
 }
@@ -295,7 +296,7 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 			fname_old = mkpath("%s/old-%s%s", packdir,
 						item->string, exts[ext].name);
 			if (file_exists(fname_old))
-				if (unlink(fname_old))
+				if (gc_unlink(fname_old))
 					failed = 1;
 
 			if (!failed && rename(fname, fname_old)) {
diff --git a/cache.h b/cache.h
index 99ed096..cc66ef5 100644
--- a/cache.h
+++ b/cache.h
@@ -382,6 +382,7 @@ static inline enum object_type object_type(unsigned int mode)
 #define GIT_PREFIX_ENVIRONMENT "GIT_PREFIX"
 #define DEFAULT_GIT_DIR_ENVIRONMENT ".git"
 #define DB_ENVIRONMENT "GIT_OBJECT_DIRECTORY"
+#define GARBAGE_ENVIRONMENT "GIT_GARBAGE_DIRECTORY"
 #define INDEX_ENVIRONMENT "GIT_INDEX_FILE"
 #define GRAFT_ENVIRONMENT "GIT_GRAFT_FILE"
 #define GIT_SHALLOW_FILE_ENVIRONMENT "GIT_SHALLOW_FILE"
@@ -432,6 +433,7 @@ extern int is_inside_work_tree(void);
 extern const char *get_git_dir(void);
 extern int is_git_directory(const char *path);
 extern char *get_object_directory(void);
+extern char *get_garbage_directory(void);
 extern char *get_index_file(void);
 extern char *get_graft_file(void);
 extern int set_git_dir(const char *path);
diff --git a/command-list.txt b/command-list.txt
index f1eae08..dbbf045 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -89,6 +89,7 @@ git-pack-refs                           ancillarymanipulators
 git-parse-remote                        synchelpers
 git-patch-id                            purehelpers
 git-prune                               ancillarymanipulators
+git-prune-garbage                       plumbingmanipulators
 git-prune-packed                        plumbingmanipulators
 git-pull                                mainporcelain common
 git-push                                mainporcelain common
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 2fece98..2946389 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -702,6 +702,7 @@ __git_list_porcelain_commands ()
 		parse-remote)     : plumbing;;
 		patch-id)         : plumbing;;
 		prune)            : plumbing;;
+		prune-garbage)    : plumbing;;
 		prune-packed)     : plumbing;;
 		quiltimport)      : import;;
 		read-tree)        : plumbing;;
@@ -2082,6 +2083,7 @@ _git_config ()
 		gc.aggressiveWindow
 		gc.auto
 		gc.autopacklimit
+		gc.garbageexpire
 		gc.packrefs
 		gc.pruneexpire
 		gc.reflogexpire
diff --git a/environment.c b/environment.c
index 565f652..1148041 100644
--- a/environment.c
+++ b/environment.c
@@ -82,7 +82,8 @@ static const char *namespace;
 static size_t namespace_len;
 
 static const char *git_dir;
-static char *git_object_dir, *git_index_file, *git_graft_file;
+static char *git_object_dir, *git_garbage_dir, *git_index_file,
+	*git_graft_file;
 
 /*
  * Repository-local GIT_* environment variables; see cache.h for details.
@@ -100,6 +101,7 @@ const char * const local_repo_env[] = {
 	NO_REPLACE_OBJECTS_ENVIRONMENT,
 	GIT_PREFIX_ENVIRONMENT,
 	GIT_SHALLOW_FILE_ENVIRONMENT,
+	GARBAGE_ENVIRONMENT,
 	NULL
 };
 
@@ -141,6 +143,7 @@ static void setup_git_env(void)
 	gitfile = read_gitfile(git_dir);
 	git_dir = xstrdup(gitfile ? gitfile : git_dir);
 	git_object_dir = git_path_from_env(DB_ENVIRONMENT, "objects");
+	git_garbage_dir = git_path_from_env(GARBAGE_ENVIRONMENT, "garbage");
 	git_index_file = git_path_from_env(INDEX_ENVIRONMENT, "index");
 	git_graft_file = git_path_from_env(GRAFT_ENVIRONMENT, "info/grafts");
 	if (getenv(NO_REPLACE_OBJECTS_ENVIRONMENT))
@@ -212,6 +215,13 @@ char *get_object_directory(void)
 	return git_object_dir;
 }
 
+char *get_garbage_directory(void)
+{
+	if (!git_garbage_dir)
+		setup_git_env();
+	return git_garbage_dir;
+}
+
 int odb_mkstemp(char *template, size_t limit, const char *pattern)
 {
 	int fd;
diff --git a/gc.c b/gc.c
new file mode 100644
index 0000000..811e83d
--- /dev/null
+++ b/gc.c
@@ -0,0 +1,60 @@
+#include "cache.h"
+#include "git-compat-util.h"
+#include "gc.h"
+
+static int unlink_now(void)
+{
+	const char *garbage_expire = "now";
+	if (!git_config_get_string_const("gc.garbageexpire", &garbage_expire))
+		return !strcmp(garbage_expire, "now");
+	return 1;
+}
+
+static char *garbage_path(const char *path, struct strbuf *buf)
+{
+	const char *rel_path;
+	struct strbuf rel_path_buf = STRBUF_INIT;
+
+	rel_path = relative_path(path, get_git_dir(), &rel_path_buf);
+	strbuf_addstr(buf, get_garbage_directory());
+	strbuf_addch(buf, '/');
+	strbuf_addstr(buf, rel_path);
+	return buf->buf;
+}
+
+static int move_garbage(const char *path)
+{
+	struct strbuf new_path_buf = STRBUF_INIT;
+	char *new_path;
+
+	new_path = garbage_path(path, &new_path_buf);
+	if (safe_create_leading_directories(new_path))
+		return -1;
+
+	return rename(path, new_path);
+}
+
+static int move_garbage_or_warn(const char *path)
+{
+	int err;
+
+	if ((err = move_garbage(path)))
+		warning("unable to rename %s", path);
+	return err;
+}
+
+int gc_unlink(const char *path)
+{
+	if (unlink_now())
+		return unlink(path);
+	else
+		return move_garbage(path);
+}
+
+int gc_unlink_or_warn(const char *path)
+{
+	if (unlink_now())
+		return unlink_or_warn(path);
+	else
+		return move_garbage_or_warn(path);
+}
diff --git a/gc.h b/gc.h
new file mode 100644
index 0000000..5095ac1
--- /dev/null
+++ b/gc.h
@@ -0,0 +1,16 @@
+#ifndef GC_H
+#define GC_H
+
+/*
+ * Like unlink(), but moves the file to the garbage directory instead of
+ * unlinking if appropriate.
+ */
+int gc_unlink(const char *path);
+
+/*
+ * Like unlink_or_warn(), but moves the file to the garbage directory
+ * instead of unlinking if appropriate.
+ */
+int gc_unlink_or_warn(const char *path);
+
+#endif /* GC_H */
diff --git a/git.c b/git.c
index 18fbf79..be01eb0 100644
--- a/git.c
+++ b/git.c
@@ -445,6 +445,7 @@ static struct cmd_struct commands[] = {
 	{ "patch-id", cmd_patch_id },
 	{ "pickaxe", cmd_blame, RUN_SETUP },
 	{ "prune", cmd_prune, RUN_SETUP },
+	{ "prune-garbage", cmd_prune_garbage, RUN_SETUP },
 	{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 	{ "push", cmd_push, RUN_SETUP },
 	{ "read-tree", cmd_read_tree, RUN_SETUP },
diff --git a/t/t6502-gc-garbage-expire.sh b/t/t6502-gc-garbage-expire.sh
new file mode 100755
index 0000000..07dc7bd
--- /dev/null
+++ b/t/t6502-gc-garbage-expire.sh
@@ -0,0 +1,60 @@
+#!/bin/sh
+
+test_description='git gc garbageexpire tests
+'
+
+. ./test-lib.sh
+
+test_expect_success 'gc prune respects gc.garbageexpire' '
+	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
+	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
+	GC_BLOB_FILE=.git/garbage/objects/$(echo $BLOB | sed "s/^../&\//") &&
+	TMP_FILE=.git/objects/tmp_1.pack &&
+	GC_TMP_FILE=.git/garbage/objects/tmp_1.pack &&
+	echo $BLOB | git pack-objects --stdout > $TMP_FILE &&
+	test-chmtime =-86500 $BLOB_FILE $TMP_FILE &&
+	git -c gc.garbageexpire=1.day prune &&
+	test ! -f $BLOB_FILE &&
+	test -f $GC_BLOB_FILE &&
+	test ! -f $TMP_FILE &&
+	test -f $GC_TMP_FILE
+'
+
+test_expect_success 'gc prune-packed respects gc.garbageexpire' '
+	echo content1 > file1 &&
+	git add . &&
+	test_tick &&
+	git commit -m initial_commit &&
+	PACK_SHA1=$(git pack-objects --all .git/objects/pack/pack) &&
+	PACK_IDX=.git/objects/pack/pack-$PACK_SHA1.idx &&
+	PACK_FILE=.git/objects/pack/pack-$PACK_SHA1.pack &&
+	OBJ=$(git rev-parse HEAD) &&
+	OBJ_FILE=.git/objects/$(echo $OBJ | sed "s/^../&\//") &&
+	GC_OBJ_FILE=.git/garbage/objects/$(echo $OBJ | sed "s/^../&\//") &&
+	git -c gc.garbageexpire=1.day prune-packed &&
+	test ! -f $OBJ_FILE &&
+	test -f $GC_OBJ_FILE
+'
+
+test_expect_success 'gc repack respects gc.garbageexpire' '
+	PACK2_SHA1=$(git rev-list --objects --all | grep -v file1 |
+		git pack-objects .git/objects/pack/pack2) &&
+	PACK2_IDX=.git/objects/pack/pack2-$PACK2_SHA1.idx &&
+	PACK2_FILE=.git/objects/pack/pack2-$PACK2_SHA1.pack &&
+	GC_PACK2_IDX=.git/garbage/objects/pack/pack2-$PACK2_SHA1.idx &&
+	GC_PACK2_FILE=.git/garbage/objects/pack/pack2-$PACK2_SHA1.pack &&
+	git -c gc.garbageexpire=1.day repack -A -d -l &&
+	test ! -f $PACK2_IDX &&
+	test -f $GC_PACK2_IDX &&
+	test ! -f $PACK2_FILE &&
+	test -f $GC_PACK2_FILE
+'
+
+test_expect_success 'gc runs prune-garbage' '
+	git -c gc.garbageexpire=1.day gc &&
+	test ! -f $GC_BLOB_FILE &&
+	test ! -f $GC_TMP_FILE &&
+	test -f $GC_OBJ_FILE
+'
+
+test_done
-- 
2.1.3
