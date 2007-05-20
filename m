From: skimo@liacs.nl
Subject: [PATCH 13/15] unpack-trees.c: optionally clone submodules for later checkout
Date: Sun, 20 May 2007 20:04:46 +0200
Message-ID: <11796842904194-git-send-email-skimo@liacs.nl>
References: <11796842882917-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:06:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hppmu-0007La-PD
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757058AbXETSFZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:05:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757383AbXETSFY
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:05:24 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37219 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757058AbXETSFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:05:04 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KI4sWg007827;
	Sun, 20 May 2007 20:04:59 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 271347DDAC; Sun, 20 May 2007 20:04:50 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11796842882917-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47871>

From: Sven Verdoolaege <skimo@kotnet.org>

When the --submodules option is specified and a submodule
to be checked out is not available locally, git-checkout will
search for submodule.<submodule>.url options in the remote
configuration and clone each submodule using the first url that
it can use from the local site.

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 Documentation/config.txt |    3 +
 Makefile                 |    5 +-
 submodules.c             |  209 ++++++++++++++++++++++++++++++++++++++++++++++
 submodules.h             |    6 ++
 unpack-trees.c           |   51 +++++++++++
 5 files changed, 272 insertions(+), 2 deletions(-)
 create mode 100644 submodules.c
 create mode 100644 submodules.h

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 5d891ac..cee9e40 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -610,6 +610,9 @@ showbranch.default::
 	The default set of branches for gitlink:git-show-branch[1].
 	See gitlink:git-show-branch[1].
 
+submodule.<submodule>.url
+	The URL of a submodule.  See gitlink:git-clone[1].
+
 tar.umask::
 	By default, gitlink:git-tar-tree[1] sets file and directories modes
 	to 0666 or 0777. While this is both useful and acceptable for projects
diff --git a/Makefile b/Makefile
index bce8514..c79e636 100644
--- a/Makefile
+++ b/Makefile
@@ -297,7 +297,8 @@ LIB_H = \
 	diff.h object.h pack.h pkt-line.h quote.h refs.h list-objects.h sideband.h \
 	run-command.h strbuf.h tag.h tree.h git-compat-util.h revision.h \
 	tree-walk.h log-tree.h dir.h path-list.h unpack-trees.h builtin.h \
-	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h mailmap.h
+	utf8.h reflog-walk.h patch-ids.h attr.h decorate.h progress.h mailmap.h \
+	submodules.h
 
 DIFF_OBJS = \
 	diff.o diff-lib.o diffcore-break.o diffcore-order.o \
@@ -320,7 +321,7 @@ LIB_OBJS = \
 	alloc.o merge-file.o path-list.o help.o unpack-trees.o $(DIFF_OBJS) \
 	color.o wt-status.o archive-zip.o archive-tar.o shallow.o utf8.o \
 	convert.o attr.o decorate.o progress.o mailmap.o symlinks.o \
-	$(HTTP_CONFIG_OBJ)
+	$(HTTP_CONFIG_OBJ) submodules.o
 
 BUILTIN_OBJS = \
 	builtin-add.o \
diff --git a/submodules.c b/submodules.c
new file mode 100644
index 0000000..5035a05
--- /dev/null
+++ b/submodules.c
@@ -0,0 +1,209 @@
+#include "cache.h"
+#include "submodules.h"
+#include "run-command.h"
+
+struct key_val_list {
+	struct key_val_list *next;
+	char *key;
+	char *val;
+};
+
+static void free_key_val_list(struct key_val_list *list)
+{
+	struct key_val_list *next;
+	for (; list; list = next) {
+		next = list->next;
+		free(list->key);
+		free(list->val);
+		free(list);
+	}
+}
+
+static struct key_val_list *find_key_val_list(struct key_val_list *list,
+						const char *key)
+{
+	while (list && strcmp(list->key, key))
+		list = list->next;
+	return list;
+}
+
+struct collect_urls_data {
+	struct key_val_list **next;
+
+	const char *type;
+};
+
+static int collect_urls(const char *var, const char *value, void *cb_data)
+{
+	struct collect_urls_data *cb = (struct collect_urls_data*)cb_data;
+	int typelen = strlen(cb->type);
+	int len;
+	char *doturl;
+	struct key_val_list *item;
+
+	if (prefixcmp(var, cb->type))
+		return 0;
+
+	if (var[typelen] != '.')
+		return 0;
+
+	var += typelen+1;
+
+	doturl = strrchr(var, '.');
+	if (!doturl || strcmp(doturl, ".url"))
+		return 0;
+
+	len = doturl-var;
+	if (len <= 0)
+		return 0;
+
+	item = xmalloc(sizeof(struct key_val_list));
+	item->key = xmalloc(len+1);
+	memcpy(item->key, var, len);
+	item->key[len] = 0;
+	item->val = xstrdup(value);
+	item->next = NULL;
+	*cb->next = item;
+	cb->next = &item->next;
+
+	return 0;
+}
+
+static const char *local_URL(const char *remote, const char *url)
+{
+	static char local_url[PATH_MAX];
+
+	if (!prefixcmp(url, "https://"))
+		return url;
+
+	if (!prefixcmp(url, "http://"))
+		return url;
+
+	if (!prefixcmp(url, "ftp://"))
+		return url;
+
+	if (!prefixcmp(remote, "/"))
+		return url;
+
+	if (!prefixcmp(remote, "ssh://") && !prefixcmp(url, "/")) {
+		char *slash;
+		int len = strlen(url);
+
+		slash = strchr(remote+6, '/');
+		if (!slash || (slash-remote)+len+1 > sizeof(local_url))
+			return NULL;
+		memcpy(local_url, remote, slash-remote);
+		memcpy(local_url+(slash-remote), url, len+1);
+		return local_url;
+	}
+
+	return NULL;
+}
+
+static int fetch_submodule_urls(struct key_val_list **next_url)
+{
+	struct key_val_list *remotes = NULL;
+	struct collect_urls_data remotes_data = { &remotes, "remote" };
+	struct key_val_list *remote;
+	static char key[1024];
+
+	git_config(collect_urls, &remotes_data);
+	for (remote = remotes; remote; remote = remote->next) {
+		struct key_val_list *submodules = NULL;
+		struct collect_urls_data submodules_data =
+			{ &submodules, "submodule" };
+		struct key_val_list *submodule;
+		char *dest;
+
+		dest = xstrdup(remote->val);
+		git_config_from_remote(collect_urls, dest, &submodules_data);
+		free(dest);
+		for (submodule = submodules; submodule; submodule = submodule->next) {
+			const char *local_url;
+			struct key_val_list *item;
+
+			local_url = local_URL(remote->val, submodule->val);
+			if (!local_url)
+				continue;
+
+			if (snprintf(key, sizeof(key),
+			    "submodule.%s.url", submodule->key) > sizeof(key))
+				return error("submodule name too long");
+
+			git_config_set(key, local_url);
+
+			item = xmalloc(sizeof(struct key_val_list));
+			item->key = xstrdup(submodule->key);
+			item->val = xstrdup(local_url);
+			item->next = NULL;
+			*next_url = item;
+			next_url = &item->next;
+		}
+
+		free_key_val_list(submodules);
+	}
+
+	free_key_val_list(remotes);
+
+	return 0;
+}
+
+int clone_submodule(const char *submodule)
+{
+	struct key_val_list *submodules = NULL;
+	struct collect_urls_data submodules_data = { &submodules, "submodule" };
+	struct key_val_list *item;
+	char *path;
+	int err;
+	const char *gitdirenv;
+	const char *args[10];
+	int argc;
+
+	git_config(collect_urls, &submodules_data);
+	item = find_key_val_list(submodules, submodule);
+	if (!item) {
+		err = fetch_submodule_urls(submodules_data.next);
+		if (err)
+			return err;
+		item = find_key_val_list(*submodules_data.next, submodule);
+		if (!item)
+			return error("don't know where to get submodule '%s'",
+					submodule);
+	}
+
+	path = git_path("submodules/%s", submodule);
+
+	argc = 0;
+	args[argc++] = "clone";
+	args[argc++] = "--submodules";
+	args[argc++] = "-n";
+	args[argc++] = item->val;
+	args[argc++] = path;
+	args[argc] = NULL;
+
+	gitdirenv = getenv(GIT_DIR_ENVIRONMENT);
+	unsetenv(GIT_DIR_ENVIRONMENT);
+	err = run_command_v_opt(args, RUN_GIT_CMD);
+
+	setenv(GIT_DIR_ENVIRONMENT,
+		git_path("submodules/%s/.git", submodule), 1);
+
+	argc = 0;
+	args[argc++] = "update-ref";
+	args[argc++] = "--no-deref";
+	args[argc++] = "HEAD";
+	args[argc++] = "0000000000000000000000000000000000000000";
+	args[argc] = NULL;
+
+	if (!err)
+		err = run_command_v_opt(args, RUN_GIT_CMD);
+
+	setenv(GIT_DIR_ENVIRONMENT, gitdirenv, 1);
+
+	if (err)
+		return error("failed to clone submodule '%s'", submodule);
+
+	free_key_val_list(submodules);
+
+	return 0;
+}
diff --git a/submodules.h b/submodules.h
new file mode 100644
index 0000000..56590e7
--- /dev/null
+++ b/submodules.h
@@ -0,0 +1,6 @@
+#ifndef SUBMODULES_H
+#define SUBMODULES_H
+
+int clone_submodule(const char *submodule);
+
+#endif
diff --git a/unpack-trees.c b/unpack-trees.c
index 3dadebb..f9865b9 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -6,6 +6,7 @@
 #include "unpack-trees.h"
 #include "progress.h"
 #include "refs.h"
+#include "submodules.h"
 
 #define DBRT_DEBUG 1
 
@@ -808,6 +809,36 @@ int threeway_merge(struct cache_entry **stages,
 	return count;
 }
 
+static int ensure_submodule(struct cache_entry *ce,
+			    struct unpack_trees_options *o)
+{
+	struct stat st;
+	char *path;
+
+	if (!ce)
+		return 0;
+
+	if (!S_ISDIRLNK(ntohl(ce->ce_mode)))
+		return 0;
+
+	path = mkpath("%s/.git", ce->name);
+	fprintf(stderr, "path: %s\n", path);
+	if (lstat(path, &st)) {
+		path = git_path("submodules/%s/.git", ce->name);
+		fprintf(stderr, "path: %s\n", path);
+		if (lstat(path, &st)) {
+			int err;
+			err = clone_submodule(ce->name);
+			if (err)
+				return err;
+		}
+	}
+
+	/* Now check that the commit is available and fetch if needed */
+
+	return 0;
+}
+
 /*
  * Two-way merge.
  *
@@ -833,6 +864,17 @@ int twoway_merge(struct cache_entry **src,
 	if (newtree == o->df_conflict_entry)
 		newtree = NULL;
 
+	if (o->submodules && o->update) {
+		int err;
+		err = ensure_submodule(current, o);
+		if (!err)
+			err = ensure_submodule(oldtree, o);
+		if (!err)
+			err = ensure_submodule(newtree, o);
+		if (err)
+			return err;
+	}
+
 	if (current) {
 		if ((!oldtree && !newtree) || /* 4 and 5 */
 		    (!oldtree && newtree &&
@@ -909,6 +951,15 @@ int oneway_merge(struct cache_entry **src,
 		return error("Cannot do a oneway merge of %d trees",
 			     o->merge_size);
 
+	if (o->submodules && o->update) {
+		int err;
+		err = ensure_submodule(old, o);
+		if (!err)
+			err = ensure_submodule(a, o);
+		if (err)
+			return err;
+	}
+
 	if (!a)
 		return deleted_entry(old, old, o);
 	if (old && same(old, a)) {
-- 
1.5.2.rc3.815.g8fc2
