From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: [PATCH] RFC Optionally handle symbolic links as copies
Date: Wed,  5 Dec 2012 23:46:15 +0100
Message-ID: <1354747575-89277-1-git-send-email-robin.rosenberg@dewire.com>
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 05 23:46:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TgNjo-000426-Rk
	for gcvg-git-2@plane.gmane.org; Wed, 05 Dec 2012 23:46:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754329Ab2LEWq0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2012 17:46:26 -0500
Received: from smtp-gw21.han.skanova.net ([81.236.55.21]:49873 "EHLO
	smtp-gw21.han.skanova.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752205Ab2LEWqZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2012 17:46:25 -0500
Received: from localhost.localdomain (213.67.12.15) by smtp-gw21.han.skanova.net (8.5.133)
        id 506A33EC019545E0; Wed, 5 Dec 2012 23:46:22 +0100
X-Mailer: git-send-email 1.8.0.msysgit.0.3.gc00b80c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211143>

If core.symlinks is set to copy then symbolic links in a git repository
will be checked out as copies of the file it points to. This allows repos
containing symbolic links to not only be checked out, but also that the
linked content may be used on OS:es and filesystems that do not support
symbolic links.

Plain files will be copied as hard links, directories will be replicated
with files as hard links. Stale links will not be copied and will appear
as missing files.

A git-ln utility whose usage is similar to the standard ln utilty. It will
create symbolic links unless core.symlinks is set to copy.

This patch still contains debug statements and open issues:
- git rm link-to-dir - remove without force or compare
- git status - when do we report a diff. 
	- After checkout we should probably not
	- if the "linked" files change?
	- if a change in the copied directory chsnges
	- if a file in the copied diretory is added/removed
	- update, should we update the copied structure automatically
	  when the link target changes
- git add - just ignore the stat diff for links
- git xxx -- gotchas
- ugly code
- debug statements
- few test cases

---
 .gitignore                          |   1 +
 Makefile                            |  10 +-
 builtin/checkout-index.c            |   1 +
 builtin/checkout.c                  |   2 +
 builtin/rm.c                        |  17 ++-
 cache.h                             |   3 +
 command-list.txt                    |   1 +
 config.c                            |   8 +-
 entry.c                             | 238 +++++++++++++++++++++++++++++++++++-
 environment.c                       |   1 +
 git-ln.sh                           | 132 ++++++++++++++++++++
 read-cache.c                        |  60 +++++----
 t/t2401-checkout-symlink-as-copy.sh | 142 +++++++++++++++++++++
 unpack-trees.c                      |  11 ++
 wrapper.c                           |  19 ++-
 15 files changed, 611 insertions(+), 35 deletions(-)
 create mode 100755 git-ln.sh
 create mode 100755 t/t2401-checkout-symlink-as-copy.sh

diff --git a/.gitignore b/.gitignore
index 5778ce1..0c82778 100644
--- a/.gitignore
+++ b/.gitignore
@@ -72,6 +72,7 @@
 /git-init
 /git-init-db
 /git-instaweb
+/git-ln
 /git-log
 /git-lost-found
 /git-ls-files
diff --git a/Makefile b/Makefile
index 1cff01e..3660597 100644
--- a/Makefile
+++ b/Makefile
@@ -341,10 +341,15 @@ endif
 
 # CFLAGS and LDFLAGS are for the users to override from the command line.
 
-CFLAGS = -g -O2 -Wall -Werror \
+CFLAGS = -g -Wall -Werror \
 	-Wno-pointer-to-int-cast \
 	-Wold-style-definition \
-	-Wdeclaration-after-statement
+	-Wdeclaration-after-statement \
+	-Wno-deprecated-declarations \
+	-Wstrict-prototypes \
+	-Wdeclaration-after-statement \
+	-Wno-pointer-to-int-cast \
+
 LDFLAGS =
 ALL_CFLAGS = $(CPPFLAGS) $(CFLAGS)
 ALL_LDFLAGS = $(LDFLAGS)
@@ -442,6 +447,7 @@ SCRIPT_SH += git-bisect.sh
 SCRIPT_SH += git-difftool--helper.sh
 SCRIPT_SH += git-filter-branch.sh
 SCRIPT_SH += git-lost-found.sh
+SCRIPT_SH += git-ln.sh
 SCRIPT_SH += git-merge-octopus.sh
 SCRIPT_SH += git-merge-one-file.sh
 SCRIPT_SH += git-merge-resolve.sh
diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index b1feda7..aa840b7 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -113,6 +113,7 @@ static void checkout_all(const char *prefix, int prefix_length)
 			errs++;
 		last_ce = ce;
 	}
+	checkout_remaining_link_copies();
 	if (last_ce && to_tempfile)
 		write_tempfile_record(last_ce->name, prefix_length);
 	if (errs)
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 781295b..eafd3d5 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -328,6 +328,8 @@ static int checkout_paths(const struct checkout_opts *opts,
 		}
 	}
 
+	checkout_remaining_link_copies();
+
 	if (write_cache(newfd, active_cache, active_nr) ||
 	    commit_locked_index(lock_file))
 		die(_("unable to write new index file"));
diff --git a/builtin/rm.c b/builtin/rm.c
index b384c4c..14fb399 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -17,6 +17,8 @@ static const char * const builtin_rm_usage[] = {
 
 static struct {
 	int nr, alloc;
+	int nrmode, allocmode;
+	int *mode;
 	const char **name;
 } list;
 
@@ -174,7 +176,10 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		if (!match_pathspec(pathspec, ce->name, ce_namelen(ce), 0, seen))
 			continue;
 		ALLOC_GROW(list.name, list.nr + 1, list.alloc);
-		list.name[list.nr++] = ce->name;
+		ALLOC_GROW(list.mode, list.nrmode + 1, list.allocmode); // ugly
+		list.name[list.nr] = ce->name;
+		list.mode[list.nr] = ce->ce_mode;
+		list.nr++;
 	}
 
 	if (pathspec) {
@@ -245,7 +250,13 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 		int removed = 0;
 		for (i = 0; i < list.nr; i++) {
 			const char *path = list.name[i];
-			if (!remove_path(path)) {
+			if (S_ISLNK(list.mode[i]) && copy_symlinks) {
+				struct strbuf sb = STRBUF_INIT;
+				strbuf_add(&sb, list.name[i], strlen(list.name[i]));
+				remove_dir_recursively(&sb, 0);
+				strbuf_release(&sb);
+				removed = 1;
+			} else if (!remove_path(path)) {
 				removed = 1;
 				continue;
 			}
diff --git a/cache.h b/cache.h
index fe0388c..125929d 100644
--- a/cache.h
+++ b/cache.h
@@ -532,6 +532,7 @@ extern int trust_executable_bit;
 extern int trust_ctime;
 extern int quote_path_fully;
 extern int has_symlinks;
+extern int copy_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
@@ -954,6 +955,8 @@ extern int has_dirs_only_path(const char *name, int len, int prefix_len);
 extern void schedule_dir_for_removal(const char *name, int len);
 extern void remove_scheduled_dirs(void);
 
+extern int checkout_remaining_link_copies(void);
+
 extern struct alternate_object_database {
 	struct alternate_object_database *next;
 	char *name;
diff --git a/command-list.txt b/command-list.txt
index 7e8cfec..0e7e147 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -61,6 +61,7 @@ git-index-pack                          plumbingmanipulators
 git-init                                mainporcelain common
 git-instaweb                            ancillaryinterrogators
 gitk                                    mainporcelain
+git-ln                                  mainporcelain
 git-log                                 mainporcelain common
 git-lost-found                          ancillarymanipulators	deprecated
 git-ls-files                            plumbinginterrogators
diff --git a/config.c b/config.c
index 5ea36a7..e0fd347 100644
--- a/config.c
+++ b/config.c
@@ -576,7 +576,13 @@ static int git_default_core_config(const char *var, const char *value)
 	}
 
 	if (!strcmp(var, "core.symlinks")) {
-		has_symlinks = git_config_bool(var, value);
+		if (0 == strcasecmp("copy", value)) {
+			copy_symlinks = 1;
+			has_symlinks = 1; // TODO: reconsider
+		} else {
+			has_symlinks = git_config_bool(var, value);
+			copy_symlinks = 0;
+		}
 		return 0;
 	}
 
diff --git a/entry.c b/entry.c
index 17a6bcc..b46417a 100644
--- a/entry.c
+++ b/entry.c
@@ -2,6 +2,17 @@
 #include "blob.h"
 #include "dir.h"
 #include "streaming.h"
+#include <string.h>
+#include <stdio.h>
+
+int nnn;
+int xlink(const char *from, const char *to)
+{
+	int ret = link(from,to);
+	printf("#%d,link %s,%s, ret=%d, errno=%d\n", nnn++, from, to, ret, errno);
+	return ret;
+}
+#define link(s,e) xlink(s,e)
 
 static void create_directories(const char *path, int path_len,
 			       const struct checkout *state)
@@ -134,6 +145,209 @@ static int streaming_write_entry(struct cache_entry *ce, char *path,
 	return result;
 }
 
+struct postlink {
+	struct cache_entry *ce;
+	char *from,*to;
+};
+static struct postlink *postlinks = NULL;
+static int npostlinks = 0;
+static int maxpostlinks = 0;
+static int resolved = 0;
+int lasttry = 0;
+
+void add_postlink(struct cache_entry *ce, char *from, char *to)
+{
+	if (npostlinks >= maxpostlinks) {
+		if (maxpostlinks == 0)
+			maxpostlinks = 64;
+		else
+			maxpostlinks *= 2;
+		postlinks = realloc(postlinks, maxpostlinks*sizeof(struct postlink));
+	}
+	postlinks[npostlinks].ce = ce;
+	postlinks[npostlinks].to = xstrdup(to);
+	postlinks[npostlinks].from = xstrdup(from);
+	npostlinks++;
+}
+
+void release_postlink(void)
+{
+	int i;
+	for (i = 0; i < npostlinks; ++i) {
+		free(postlinks[i].from);
+		free(postlinks[i].to);
+	}
+	free(postlinks);
+	postlinks = NULL;
+	npostlinks = 0;
+	maxpostlinks = 0;
+}
+
+static int recursive_link(const char *src, const char *dst) {
+	// printf("recursive_link %s %s\n", src, dst);
+	struct stat buf;
+	struct dirent *dp;
+	struct strbuf dstb = STRBUF_INIT;
+	struct strbuf srcb = STRBUF_INIT;
+	int err = stat(dst, &buf);
+	DIR *d = opendir(src);
+	if (!d)
+		return ENOENT;
+	if (err && errno == ENOENT) {
+		err = mkdir(dst, 0777);
+		if (err)
+			return err;
+		else
+			resolved++;
+	} else if (!(buf.st_mode & S_IFDIR))
+		return EEXIST;
+	err = 0;
+	while ((dp = readdir(d)) != NULL) {
+		if (is_dot_or_dotdot(dp->d_name))
+			continue;
+		strbuf_add(&dstb, dst, strlen(dst));
+		strbuf_add(&dstb, "/", 1);
+		strbuf_add(&dstb, dp->d_name, strlen(dp->d_name));
+		strbuf_add(&srcb, src, strlen(src));
+		strbuf_add(&srcb, "/", 1);
+		strbuf_add(&srcb, dp->d_name, strlen(dp->d_name));
+		if (!stat(srcb.buf, &buf)) {
+			if (buf.st_mode & S_IFDIR) {
+				if (recursive_link(srcb.buf, dstb.buf)) {
+					err = -1;
+				}
+			} else {
+				int r1,r2;
+				r1 = unlink(dstb.buf);
+				if (r1)
+					error("unlink %s = %d, errno=%d\n", dstb.buf, r1, errno);
+				r2 = link(srcb.buf, dstb.buf);
+				if (r2) {
+					if (maxpostlinks >= 0) {
+						error("cannot link %s to %s", srcb.buf, dstb.buf);
+					}
+					err = -1;
+				}
+				if (r1 && !r2)
+					resolved++;
+			}
+		} else {
+			if (maxpostlinks >= 0) {
+				error("cannot link %s to %s", srcb.buf, dstb.buf);
+			}
+			err = -1;
+		}
+		strbuf_reset(&srcb);
+		strbuf_reset(&dstb);
+	}
+	strbuf_release(&dstb);
+	strbuf_release(&srcb);
+	closedir(d);
+	return err;
+}
+
+static void resolvelink(struct strbuf *src, struct strbuf *dst)
+{
+	if (0 == strncmp(src->buf, "../", 3)) {
+		char *p = dst->buf + dst->len - 1;
+		while (p > dst->buf && *p != '/')
+			--p;
+		if (*p != '/')
+			return;
+		--p;
+		while (p > dst->buf && *p != '/')
+			--p;
+		strbuf_remove(src, 0, 3);
+		if (*p == '/')
+			strbuf_insert(src, 0, dst->buf, p - dst->buf + 1);
+		resolvelink(src, dst);
+	} else if (0 == strncmp(src->buf, "./", 2)) {
+		strbuf_remove(src, 0, 2);
+		resolvelink(src, dst);
+	}
+}
+
+static int fakesymlink(const char *old, const char *new)
+{
+	struct stat buf;
+	int st;
+	int err;
+	char dir[MAXPATHLEN];
+	char cdir[MAXPATHLEN];
+	char *dend;
+	struct strbuf src = STRBUF_INIT;
+	struct strbuf dst = STRBUF_INIT;
+	strcpy(dir, new);
+	dend = strrchr(dir, '/');
+	if (dend) {
+		*dend = 0;
+		if (!getcwd(cdir, MAXPATHLEN))
+			return -1;
+	}
+	strbuf_add(&src, old, strlen(old));
+	strbuf_add(&dst, new, strlen(new));
+	resolvelink(&src, &dst);
+	if (0 == (st = stat(src.buf, &buf))) {
+		if (buf.st_mode & (S_IFREG | S_IFLNK)) {
+			int r = unlink(dst.buf);
+			err = link(src.buf, dst.buf);
+			if (!err && !r)
+				resolved++;
+			if (err)
+				error("Failed to link %s %s\n", src.buf, dst.buf);
+		} else if (buf.st_mode & S_IFDIR) {
+			err = recursive_link(src.buf, dst.buf);
+			if (maxpostlinks < 0)
+				err = 1;
+//			printf("%d <- recursive_link\n", err);
+		} else {
+			error("mode:Failed to link %s %s\n", src.buf, dst.buf);
+			err = -1;
+		}
+	} else {
+		error("stat:Failed to link %s %s\n", src.buf, dst.buf);
+		err = -1;
+	}
+	strbuf_release(&src);
+	strbuf_release(&dst);
+	return err;
+}
+
+int checkout_remaining_link_copies(void)
+{
+	int j;
+	int err = 0;
+	maxpostlinks = -1;
+	resolved = 1;
+
+	/* stupid, each iteration should resolve at least one entry */
+	do {
+		if (resolved == 0)
+			lasttry = 1;
+		resolved = 0;
+		for (j = 0; j < npostlinks; ++j) {
+			struct postlink *e = &postlinks[j];
+			if (e->from) {
+				if (0 == fakesymlink(e->from, e->to)) {
+					if (e->ce) {
+						struct stat st;
+						if (0 == stat(e->to, &st))
+							fill_stat_cache_info(e->ce, &st);
+					}
+					free(e->from);
+					e->from = NULL;
+				} else {
+					if (lasttry) {
+						err = 1;
+					}
+				}
+			}
+		}
+	} while (resolved > 0 && !lasttry);
+	release_postlink();
+	return err;
+}
+
 static int write_entry(struct cache_entry *ce, char *path, const struct checkout *state, int to_tempfile)
 {
 	unsigned int ce_mode_s_ifmt = ce->ce_mode & S_IFMT;
@@ -161,8 +375,16 @@ static int write_entry(struct cache_entry *ce, char *path, const struct checkout
 			return error("unable to read sha1 file of %s (%s)",
 				path, sha1_to_hex(ce->sha1));
 
-		if (ce_mode_s_ifmt == S_IFLNK && has_symlinks && !to_tempfile) {
-			ret = symlink(new, path);
+		if (ce_mode_s_ifmt == S_IFLNK && (has_symlinks || copy_symlinks) && !to_tempfile) {
+			if (copy_symlinks) {
+				ret = fakesymlink(new, path);
+				if (ret < 0) {
+					// Could not copy now, assume we can do it later
+					add_postlink(ce, new, path);
+					ret = 0;
+				}
+			} else
+				ret = symlink(new, path);
 			free(new);
 			if (ret)
 				return error("unable to create symlink %s (%s)",
@@ -267,8 +489,16 @@ int checkout_entry(struct cache_entry *ce, const struct checkout *state, char *t
 			if (!state->force)
 				return error("%s is a directory", path);
 			remove_subtree(path);
-		} else if (unlink(path))
-			return error("unable to unlink old '%s' (%s)", path, strerror(errno));
+		} else {
+			if (unlink(path)) {
+//				printf("has_symlinks=%d, copy_symlinks=%d\n", has_symlinks, copy_symlinks);
+				if (copy_symlinks) {
+					remove_subtree(path);
+				} else {
+					return error("unable to unlink old '%s' (%s)", path, strerror(errno));
+				}
+			}
+		}
 	} else if (state->not_new)
 		return 0;
 	create_directories(path, len, state);
diff --git a/environment.c b/environment.c
index 71e438c..a1328ec 100644
--- a/environment.c
+++ b/environment.c
@@ -14,6 +14,7 @@
 int trust_executable_bit = 1;
 int trust_ctime = 1;
 int has_symlinks = 1;
+int copy_symlinks = 0;
 int minimum_abbrev = 4, default_abbrev = 7;
 int ignore_case;
 int assume_unchanged;
diff --git a/git-ln.sh b/git-ln.sh
new file mode 100755
index 0000000..d8df14f
--- /dev/null
+++ b/git-ln.sh
@@ -0,0 +1,132 @@
+#!/bin/sh
+[[ -n $LX ]] && set -x
+#
+# Copyright (C) 2012 Robin Rosenberg
+# Helper for adding symbolic links when file system does not support it
+#
+
+SUBDIRECTORY_OK=Yes
+OPTIONS_KEEPDASHDASH=
+OPTIONS_SPEC="\
+git ln -s [options] target linkname
+--
+f,force	force creating when linkname or target does not exist
+s,symbolic create symbolic link (mandatory)
+cached operate only on index
+"
+#usage() {
+	#	echo >&2 "usage: ln [-fs] target name"
+	#	exit 1
+#}
+
+symbolic=
+force=
+cached=
+copy=
+symlinks=$(git config --get core.symlinks|tr A-Z a-z)
+if [[ $symlinks == copy ]];then copy=1;fi
+
+. git-sh-setup
+. git-sh-i18n
+
+require_work_tree_exists
+if [ $? != 0 ]; then
+	usage
+fi
+while test $# != 0;do
+	case "$1" in
+		-f|--force)
+			force=1
+			shift
+			;;
+		-s|--symbolic)
+			symbolic=1
+			shift
+			;;
+		--cached)
+			cached=1
+			shift
+			;;
+		--)
+			if [[ $# == 3 ]];
+			then
+				target=$2
+				name=$3
+				shift 3
+				break
+			else
+				usage
+				exit 1
+			fi
+			;;
+		*)
+			usage
+			exit 1
+			;;
+		esac
+done
+if [[ -z $symbolic ]];then
+	usage
+fi
+GIT_DIR=$(git rev-parse --git-dir) || exit 1
+cwd=$(pwd)
+wd=$( (cd_to_toplevel && pwd) )
+namedir=$(dirname "$name")
+namebase=$(basename "$name")
+absnamedir=$( (cd "$namedir" && pwd) )
+cd "$namedir" || exit 1
+pwd
+if [[ ${absnamedir:0:${#wd}} != $wd ]]
+then
+	echo >&2 git-ln: $name is outside of working tree
+	exit 1
+fi
+reldir=${absnamedir:${#wd}}
+reldir=${reldir:1}
+if [[ -n $reldir ]];then
+	reldir="$reldir/"
+fi
+if [[ ! -e $target && ! $force ]];then
+	echo >&2 git-ln: $target does not exist
+	exit 1
+fi
+
+if [[ -n $force ]];then
+	if [[ -z $cached ]];then
+		if [[ -d $name && -n $copy ]];then
+			rm -rf "$name"
+		elif [[ ! -d $name ]];then
+			rm -f "$name"
+		fi
+	fi
+	git rm -f --cached "$name" >/dev/null || exit 1
+fi
+sha1=$(printf %s "$target" | git hash-object -w -t blob --stdin)
+if [ $? != 0 ];then exit 1;fi
+git update-index --add --cacheinfo 120000 $sha1 $reldir$name || exit $?
+if [[ -n $copy ]];then
+	cd "$cwd" || exit $?
+	if [[ -d $target ]];
+	then
+		(cd "$target" &&
+		find . -type d)|
+		while read d;do
+			mkdir -p "$name/$d" || exit $?
+		done
+		(cd "$target" &&
+		find . -type f)|
+		while read f;do
+			ln "$target/$f" "$name/$f" || exit $?
+		done
+	else
+		ln "$target" "$name" || exit $?
+	fi
+else
+	if [[ -e $name ]];then
+		echo >&2 git-ln: File $name exists
+		exit 1
+	fi
+	cd "$cwd" || exit $?
+	ln -s $target $name || exit $?
+fi
+exit 0
diff --git a/read-cache.c b/read-cache.c
index fda78bc..9ca8e42 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -181,8 +181,18 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 			changed |= MODE_CHANGED;
 		break;
 	case S_IFLNK:
+		//	ISLNK(st)	hassym	ISREG(st)	ISDIR(st)	copy	->
+		//	y			y		y								changed (old)
+		//	y			n		y								changed (old)
+		//	y			y		n								changed (old)
+		//  =			=		=			y			y		no
+		//  =			=		=			n			n		changed
+		//  =			=		=			y			n		changed
+		//  =			=		=			n			y		changed
+
 		if (!S_ISLNK(st->st_mode) &&
-		    (has_symlinks || !S_ISREG(st->st_mode)))
+		    (has_symlinks || !S_ISREG(st->st_mode))
+		    && !S_ISDIR(st->st_mode) && !copy_symlinks)
 			changed |= TYPE_CHANGED;
 		break;
 	case S_IFGITLINK:
@@ -195,36 +205,38 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	default:
 		die("internal error: ce_mode is %o", ce->ce_mode);
 	}
-	if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
-		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
-		changed |= CTIME_CHANGED;
-
+	/* For copy as symlink we just ignore the lowlevel stat fields */
+	if (!copy_symlinks || !S_ISLNK(ce->ce_mode) || !S_ISDIR(st->st_mode)) {
+		if (ce->ce_mtime.sec != (unsigned int)st->st_mtime)
+			changed |= MTIME_CHANGED;
+		if (trust_ctime && ce->ce_ctime.sec != (unsigned int)st->st_ctime)
+			changed |= CTIME_CHANGED;
 #ifdef USE_NSEC
-	if (ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
-		changed |= MTIME_CHANGED;
-	if (trust_ctime && ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
-		changed |= CTIME_CHANGED;
+		if (ce->ce_mtime.nsec != ST_MTIME_NSEC(*st))
+			changed |= MTIME_CHANGED;
+		if (trust_ctime && ce->ce_ctime.nsec != ST_CTIME_NSEC(*st))
+			changed |= CTIME_CHANGED;
 #endif
 
-	if (ce->ce_uid != (unsigned int) st->st_uid ||
-	    ce->ce_gid != (unsigned int) st->st_gid)
-		changed |= OWNER_CHANGED;
-	if (ce->ce_ino != (unsigned int) st->st_ino)
-		changed |= INODE_CHANGED;
+		if (ce->ce_uid != (unsigned int) st->st_uid ||
+			ce->ce_gid != (unsigned int) st->st_gid)
+			changed |= OWNER_CHANGED;
+		if (ce->ce_ino != (unsigned int) st->st_ino)
+			changed |= INODE_CHANGED;
 
 #ifdef USE_STDEV
-	/*
-	 * st_dev breaks on network filesystems where different
-	 * clients will have different views of what "device"
-	 * the filesystem is on
-	 */
-	if (ce->ce_dev != (unsigned int) st->st_dev)
-		changed |= INODE_CHANGED;
+		/*
+		 * st_dev breaks on network filesystems where different
+		 * clients will have different views of what "device"
+		 * the filesystem is on
+		 */
+		if (ce->ce_dev != (unsigned int) st->st_dev)
+			changed |= INODE_CHANGED;
 #endif
 
-	if (ce->ce_size != (unsigned int) st->st_size)
-		changed |= DATA_CHANGED;
+		if (ce->ce_size != (unsigned int) st->st_size)
+			changed |= DATA_CHANGED;
+	}
 
 	/* Racily smudged entry? */
 	if (!ce->ce_size) {
diff --git a/t/t2401-checkout-symlink-as-copy.sh b/t/t2401-checkout-symlink-as-copy.sh
new file mode 100755
index 0000000..922af9d
--- /dev/null
+++ b/t/t2401-checkout-symlink-as-copy.sh
@@ -0,0 +1,142 @@
+#!/bin/sh
+#
+# Copyright (c) 2012 Robin Rosenberg
+
+test_description='git checkout and reset with symlinks as copy'
+
+. ./test-lib.sh
+
+fullfilelist="a
+linkd
+linkd/reald2
+linkd/reald2/zlink2
+linkd/reald2/zlink3
+linkd/realfile
+linkd/zlink
+linkfile
+reald
+reald/reald2
+reald/reald2/zlink2
+reald/reald2/zlink3
+reald/realfile
+reald/zlink
+text
+z"
+
+fullfilelist_except_linkd="a
+linkfile
+reald
+reald/reald2
+reald/reald2/zlink2
+reald/reald2/zlink3
+reald/realfile
+reald/zlink
+text
+z"
+
+fulllsfiles="a
+linkd
+linkfile
+reald/reald2/zlink2
+reald/reald2/zlink3
+reald/realfile
+reald/zlink
+text
+z"
+
+fulllsfiles_except_linkd="a
+linkfile
+reald/reald2/zlink2
+reald/reald2/zlink3
+reald/realfile
+reald/zlink
+text
+z"
+
+fulllstree="100644 blob 1269488f7fb1f4b56a8c0e5eb48cecbfadfa9219	a
+120000 blob afb748c1b973ba508f014b969b193f5370060583	linkd
+120000 blob 9a5d4d6a54a108d78fd356d95e15612ace0fc7ed	linkfile
+120000 blob bf219293900231f5f9fdb67fa004f2c83bec1635	reald/reald2/zlink2
+120000 blob a240f4229e24dde99ca0293d47d62906907e749c	reald/reald2/zlink3
+100644 blob d95f3ad14dee633a758d2e331151e950dd13e4ed	reald/realfile
+120000 blob 1856dae911a6b4e1a06f19218f97d94d2b1e5a96	reald/zlink
+120000 blob ae1910dff1c8f7f779f2154de8f3902702b90e8b	text
+120000 blob 2e65efe2a145dda7ee51d1741299f848e5bf752e	z"
+
+test_complete_master_state() {
+	test "$(find -L * -print)" = "$fullfilelist" &&
+	test "$(git ls-tree -r HEAD)" = "$fulllstree"
+}
+
+reset_master() {
+	rm -rf * &&
+	git reset --hard &&
+	test_complete_master_state
+}
+
+# setup work with or without real symlink support,
+# by default we use real symlink support
+test_expect_success setup '
+	git commit --allow-empty -m "empty" &&
+	git branch empty &&
+	echo >a data &&
+	git add a &&
+	git ln -s a z &&
+	mkdir reald &&
+	mkdir reald/reald2 &&
+	echo >../textf external_file &&
+	git ln -s ../textf text &&
+	echo >reald/realfile content &&
+	git add reald/realfile &&
+	git ln -s reald/realfile linkfile &&
+	(cd reald/reald2 && git ln -s ../realfile zlink2) &&
+	(cd reald/reald2 && git ln -s ../../z zlink3) &&
+	(cd reald && git ln -s ../z zlink) &&
+	git ln -s reald linkd &&
+	git commit -m "repo with symlinks" &&
+
+	test_complete_master_state &&
+
+	git config core.symlinks copy
+'
+
+test_expect_success 'reset --hard' '
+	rm -rf * &&
+	test "$(find * -print)" = "" &&
+
+	git reset --hard &&
+	test "$(find * -print )" = "$fullfilelist"
+'
+
+test_expect_success 'checkout -f empty' '
+	rm -rf * &&
+	git checkout -f empty &&
+	test "$(find * -print)" = ""
+'
+
+test_expect_success 'checkout -f master' '
+	rm -rf * &&
+	git checkout -f master &&
+	test_complete_master_state
+'
+
+test_expect_success 'rm --cached, i.e. link only ' '
+	git rm --cached linkd &&
+	test "$(find * -print)" = "$fullfilelist" &&
+	test "$(git ls-files)" = "$fulllsfiles_except_linkd"
+'
+
+test_expect_success 'rm copy of linked directory' '
+	reset_master &&
+	git rm linkd &&
+	test "$(find * -print)" = "$fullfilelist_except_linkd" &&
+	test "$(git ls-files)" = "$fulllsfiles_except_linkd"
+'
+
+test_expect_success 'rm without -f for a regular tree should NOT work' '
+	reset_master &&
+	! git rm reald &&
+	test_complete_master_state
+'
+
+test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 6d96366..bb2214d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -229,6 +229,7 @@ static int check_updates(struct unpack_trees_options *o)
 			}
 		}
 	}
+	errs |= checkout_remaining_link_copies();
 	stop_progress(&progress);
 	if (o->update)
 		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
@@ -1226,6 +1227,16 @@ static int verify_uptodate_1(struct cache_entry *ce,
 		 */
 		if (S_ISGITLINK(ce->ce_mode))
 			return 0;
+//
+//		if (copy_symlinks) {
+//			printf("%s, %0x A=%d, B=%d, c=%d\n", ce->name, st.st_mode, S_ISLNK(ce->ce_mode), (ce->ce_flags&CE_VALID), S_ISDIR(st.st_mode));
+//			if (S_ISLNK(ce->ce_mode) /*&& (ce->ce_flags&CE_VALID)*/ && S_ISDIR(st.st_mode))
+//				return 0;
+//			printf("%s, %0x A=%d, B=%d, c=%d\n", ce->name, st.st_mode, S_ISLNK(ce->ce_mode), (ce->ce_flags&CE_VALID), S_ISREG(st.st_mode));
+//			if (S_ISLNK(ce->ce_mode) /*&& (ce->ce_flags&CE_VALID)*/ && S_ISREG(st.st_mode))
+//				return 0;
+//
+//		}
 		errno = 0;
 	}
 	if (errno == ENOENT)
diff --git a/wrapper.c b/wrapper.c
index 68739aa..2a1a483 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -2,6 +2,7 @@
  * Various trivial helper wrappers around standard functions
  */
 #include "cache.h"
+#include "dir.h"
 
 static void do_nothing(size_t size)
 {
@@ -400,7 +401,23 @@ int rmdir_or_warn(const char *file)
 
 int remove_or_warn(unsigned int mode, const char *file)
 {
-	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
+	if (S_ISGITLINK(mode))
+		return rmdir_or_warn(file);
+	if (S_ISLNK(mode) && copy_symlinks) {
+		struct stat sb;
+		if (!stat(file, &sb)) {
+			if (S_IFDIR & sb.st_mode) {
+				struct strbuf dir = STRBUF_INIT;
+				strbuf_add(&dir, file, strlen(file));
+				return remove_dir_recursively(&dir, 0);
+			} else {
+				return unlink_or_warn(file);
+			}
+		} else {
+			perror("oops");
+		}
+	}
+	return unlink_or_warn(file);
 }
 
 void warn_on_inaccessible(const char *path)
-- 
1.8.0.msysgit.0.3.gc00b80c.dirty
