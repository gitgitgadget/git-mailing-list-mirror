From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 4/6] Make git-remote a builtin
Date: Wed, 5 Dec 2007 19:02:15 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712051902080.27959@racer.site>
References: <Pine.LNX.4.64.0712051858270.27959@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Dec 05 20:03:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzzWp-0001zS-1d
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 20:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbXLETCq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 14:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbXLETCq
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 14:02:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:42468 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751939AbXLETCo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 14:02:44 -0500
Received: (qmail invoked by alias); 05 Dec 2007 19:02:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp036) with SMTP; 05 Dec 2007 20:02:42 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+QL4UVWS2Q++Hn/2PHNwUTRKxbeP9eO9I2r8Rr4p
	5lkQsnlMm/E4/Q
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0712051858270.27959@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67176>


Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                                           |    3 +-
 builtin-remote.c                                   |  517 ++++++++++++++++++++
 builtin.h                                          |    1 +
 .../examples/git-remote.perl                       |    0 
 git.c                                              |    1 +
 remote.c                                           |    3 +-
 remote.h                                           |    1 +
 t/t5505-remote.sh                                  |    4 +-
 8 files changed, 526 insertions(+), 4 deletions(-)
 create mode 100644 builtin-remote.c
 rename git-remote.perl => contrib/examples/git-remote.perl (100%)

diff --git a/Makefile b/Makefile
index 233bb5f..e840ca3 100644
--- a/Makefile
+++ b/Makefile
@@ -228,7 +228,7 @@ SCRIPT_SH = \
 SCRIPT_PERL = \
 	git-add--interactive.perl \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
-	git-cvsserver.perl git-remote.perl git-cvsexportcommit.perl \
+	git-cvsserver.perl git-cvsexportcommit.perl \
 	git-send-email.perl git-svn.perl
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
@@ -362,6 +362,7 @@ BUILTIN_OBJS = \
 	builtin-push.o \
 	builtin-read-tree.o \
 	builtin-reflog.o \
+	builtin-remote.o \
 	builtin-send-pack.o \
 	builtin-config.o \
 	builtin-rerere.o \
diff --git a/builtin-remote.c b/builtin-remote.c
new file mode 100644
index 0000000..41ac4a1
--- /dev/null
+++ b/builtin-remote.c
@@ -0,0 +1,517 @@
+#include "cache.h"
+#include "parse-options.h"
+#include "transport.h"
+#include "remote.h"
+#include "path-list.h"
+#include "strbuf.h"
+#include "run-command.h"
+#include "refs.h"
+
+static const char * const builtin_remote_usage[] = {
+	"git remote",
+        "git remote add <name> <url>",
+        "git remote rm <name>",
+        "git remote show <name>",
+        "git remote prune <name>",
+        "git remote update [group]",
+	NULL
+};
+
+static int verbose;
+
+static inline int postfixcmp(const char *string, const char *postfix)
+{
+	int len1 = strlen(string), len2 = strlen(postfix);
+	if (len1 < len2)
+		return 1;
+	return strcmp(string + len1 - len2, postfix);
+}
+
+static inline const char *skip_prefix(const char *name, const char *prefix)
+{
+	return !name ? "" :
+		prefixcmp(name, prefix) ?  name : name + strlen(prefix);
+}
+
+static int opt_parse_track(const struct option *opt, const char *arg, int not)
+{
+	struct path_list *list = opt->value;
+	if (not)
+		path_list_clear(list, 0);
+	else
+		path_list_append(arg, list);
+	return 0;
+}
+
+static int fetch_remote(const char *name)
+{
+	const char *argv[] = { "fetch", name, NULL };
+	if (run_command_v_opt(argv, RUN_GIT_CMD))
+		return error ("Could not fetch %s", name);
+	return 0;
+}
+
+static int add(int argc, const char **argv)
+{
+	int fetch = 0, mirror = 0;
+	struct path_list track = { NULL, 0, 0 };
+	const char *master = NULL;
+	struct remote *remote;
+	struct strbuf buf, buf2;
+	const char *name, *url;
+	int i;
+
+	struct option options[] = {
+		OPT_GROUP("add specific options"),
+		OPT_BOOLEAN('f', "fetch", &fetch, "fetch the remote branches"),
+		OPT_CALLBACK('t', "track", &track, "branch",
+			"branch(es) to track", opt_parse_track),
+		OPT_STRING('m', "master", &master, "branch", "master branch"),
+		OPT_BOOLEAN(0, "mirror", &mirror, "no separate remotes"),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
+
+	if (argc < 2)
+		usage_with_options(builtin_remote_usage, options);
+
+	name = argv[0];
+	url = argv[1];
+
+	remote = remote_get(name);
+	if (remote && (remote->url_nr > 1 || strcmp(name, remote->url[0]) ||
+			remote->fetch_refspec_nr))
+		die ("remote %s already exists.", name);
+
+	strbuf_init(&buf, 0);
+	strbuf_init(&buf2, 0);
+
+	strbuf_addf(&buf, "remote.%s.url", name);
+	if (git_config_set(buf.buf, url))
+		return 1;
+
+	if (track.nr == 0)
+		path_list_append("*", &track);
+	for (i = 0; i < track.nr; i++) {
+		struct path_list_item *item = track.items + i;
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "remote.%s.fetch", name);
+
+		strbuf_reset(&buf2);
+		if (mirror)
+			strbuf_addf(&buf2, "refs/%s:refs/%s",
+					item->path, item->path);
+		else
+			strbuf_addf(&buf2, "refs/heads/%s:refs/remotes/%s/%s",
+					item->path, name, item->path);
+		if (git_config_set_multivar(buf.buf, buf2.buf, "^$", 0))
+			return 1;
+	}
+
+	if (fetch && fetch_remote(name))
+		return 1;
+
+	if (master) {
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "refs/remotes/%s/HEAD", name);
+
+		strbuf_reset(&buf2);
+		strbuf_addf(&buf2, "refs/remotes/%s/%s", name, master);
+
+		if (create_symref(buf.buf, buf2.buf, "remote add"))
+			return error ("Could not setup master '%s'", master);
+	}
+
+	strbuf_release(&buf);
+	strbuf_release(&buf2);
+	path_list_clear(&track, 0);
+
+	return 0;
+}
+
+struct branch_info {
+	char *remote;
+	struct path_list merge;
+};
+
+static struct path_list branch_list;
+
+static int config_read_branches(const char *key, const char *value)
+{
+	if (!prefixcmp(key, "branch.")) {
+		char *name;
+		struct path_list_item *item;
+		struct branch_info *info;
+		enum { REMOTE, MERGE } type;
+
+		key += 7;
+		if (!postfixcmp(key, ".remote")) {
+			name = xstrndup(key, strlen(key) - 7);
+			type = REMOTE;
+		} else if (!postfixcmp(key, ".merge")) {
+			name = xstrndup(key, strlen(key) - 6);
+			type = MERGE;
+		} else
+			return 0;
+
+		item = path_list_insert(name, &branch_list);
+
+		if (!item->util)
+			item->util = xcalloc(sizeof(struct branch_info), 1);
+		info = item->util;
+		if (type == REMOTE) {
+			if (info->remote)
+				warning ("more than one branch.%s", key);
+			info->remote = xstrdup(value);
+		} else {
+			char *space = strchr(value, ' ');
+			value = skip_prefix(value, "refs/heads/");
+			while (space) {
+				char *merge;
+				merge = xstrndup(value, space - value);
+				path_list_append(merge, &info->merge);
+				value = skip_prefix(space + 1, "refs/heads/");
+				space = strchr(value, ' ');
+			}
+			path_list_append(xstrdup(value), &info->merge);
+		}
+	}
+	return 0;
+}
+
+static void read_branches()
+{
+	if (branch_list.nr)
+		return;
+	git_config(config_read_branches);
+	sort_path_list(&branch_list);
+}
+
+struct ref_states {
+	struct remote *remote;
+	struct strbuf remote_prefix;
+	struct path_list new, stale, tracked;
+};
+
+static int handle_one_branch(const char *refname,
+	const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct ref_states *states = cb_data;
+	struct refspec refspec;
+
+	memset(&refspec, 0, sizeof(refspec));
+	refspec.dst = (char *)refname;
+	if (!remote_find_tracking(states->remote, &refspec)) {
+		struct path_list_item *item;
+		const char *name = skip_prefix(refspec.src, "refs/heads/");
+		if (unsorted_path_list_has_path(&states->tracked, name) ||
+				unsorted_path_list_has_path(&states->new,
+					name))
+			return 0;
+		item = path_list_append(name, &states->stale);
+		item->util = xstrdup(refname);
+	}
+	return 0;
+}
+
+static int get_ref_states(const struct ref *ref, struct ref_states *states)
+{
+	struct ref *fetch_map = NULL, **tail = &fetch_map;
+	int i;
+
+	for (i = 0; i < states->remote->fetch_refspec_nr; i++)
+		if (get_fetch_map(ref, states->remote->fetch +i, &tail, 1))
+			die ("Could not get fetch map for refspec %s",
+				states->remote->fetch_refspec[i]);
+
+	states->new.strdup_paths = states->tracked.strdup_paths = 1;
+	for (ref = fetch_map; ref; ref = ref->next) {
+		struct path_list *target = &states->tracked;
+		unsigned char sha1[20];
+		void *util = NULL;
+
+		if (!ref->peer_ref || read_ref(ref->peer_ref->name, sha1))
+			target = &states->new;
+		else {
+			target = &states->tracked;
+			if (hashcmp(sha1, ref->new_sha1))
+				util = &states;
+		}
+		path_list_append(skip_prefix(ref->name, "refs/heads/"),
+				target)->util = util;
+	}
+	free_refs(fetch_map);
+
+	strbuf_addf(&states->remote_prefix,
+		"refs/remotes/%s/", states->remote->name);
+	for_each_ref(handle_one_branch, states);
+	sort_path_list(&states->stale);
+
+	return 0;
+}
+
+static int remove_tracking_branch(const char *refname,
+	const unsigned char *sha1, int flags, void *cb_data)
+{
+	const char *remote_prefix = cb_data;
+
+	if (!prefixcmp(refname, remote_prefix) &&
+			delete_ref(refname, sha1))
+		return error("Could not remove branch %s", refname);
+	return 0;
+}
+
+static int rm(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	struct remote *remote;
+	struct strbuf buf;
+	int i;
+
+	if (argc != 2)
+		usage_with_options(builtin_remote_usage, options);
+
+	remote = remote_get(argv[1]);
+	if (!remote)
+		die ("No such remote: %s", argv[1]);
+
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "remote.%s", remote->name);
+	if (git_config_rename_section(buf.buf, NULL) < 1)
+		return error("Could not remove config section '%s'", buf.buf);
+
+	read_branches();
+	for (i = 0; i < branch_list.nr; i++) {
+		struct path_list_item *item = branch_list.items +i;
+		struct branch_info *info = item->util;
+		if (info->remote && !strcmp(info->remote, remote->name)) {
+			const char *keys[] = { "remote", "merge", NULL }, **k;
+			for (k = keys; *k; k++) {
+				strbuf_reset(&buf);
+				strbuf_addf(&buf, "branch.%s.%s",
+						item->path, *k);
+				if (git_config_set(buf.buf, NULL)) {
+					strbuf_release(&buf);
+					return -1;
+				}
+			}
+		}
+	}
+
+	/*
+	 * NEEDSTHOUGHT: this could check something like
+	 * !remote_find_tracking(remote, &refspec) to know if the
+	 * branch was really tracked.  But then we'll have to make
+	 * sure that no other remote writes into that branch.
+	 * Probably not worth it.
+	 */
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "refs/remotes/%s/", remote->name);
+	i = for_each_ref(remove_tracking_branch, buf.buf);
+	strbuf_release(&buf);
+
+	return i;
+}
+
+static void show_list(const char *title, struct path_list *list)
+{
+	int i;
+
+	if (!list->nr)
+		return;
+
+	printf(title, list->nr > 1 ? "es" : "");
+	printf("\n    ");
+	for (i = 0; i < list->nr; i++)
+		printf("%s%s", i ? " " : "", list->items[i].path);
+	printf("\n");
+}
+
+static int show_or_prune(int argc, const char **argv, int prune)
+{
+	int dry_run = 0, result = 0;
+	struct option options[] = {
+		OPT_GROUP("show specific options"),
+		OPT__DRY_RUN(&dry_run),
+		OPT_END()
+	};
+	struct ref_states states;
+
+	argc = parse_options(argc, argv, options, builtin_remote_usage, 0);
+
+	if (argc < 1)
+		usage_with_options(builtin_remote_usage, options);
+
+	memset(&states, 0, sizeof(states));
+	for (; argc; argc--, argv++) {
+		struct transport *transport;
+		const struct ref *ref;
+		struct strbuf buf;
+		int i, got_states;
+
+		states.remote = remote_get(*argv);
+		if (!states.remote)
+			return error("No such remote: %s", *argv);
+		transport = transport_get(NULL, states.remote->url[0]);
+		ref = transport_get_remote_refs(transport);
+
+		read_branches();
+		got_states = get_ref_states(ref, &states);
+		if (got_states)
+			result = error("Error getting local info for '%s'",
+					states.remote->name);
+
+		if (prune) {
+			struct strbuf buf;
+
+			strbuf_init(&buf, 0);
+			for (i = 0; i < states.stale.nr; i++) {
+				strbuf_reset(&buf);
+				strbuf_addf(&buf, "refs/remotes/%s/%s", *argv,
+						states.stale.items[i].path);
+				result |= delete_ref(buf.buf, NULL);
+			}
+
+			strbuf_release(&buf);
+			goto cleanup_states;
+		}
+
+		printf("* remote %s\n  URL: %s\n", *argv,
+			states.remote->url[0] ?
+				states.remote->url[0] : "(no URL)");
+
+		for (i = 0; i < branch_list.nr; i++) {
+			struct path_list_item *branch = branch_list.items + i;
+			struct branch_info *info = branch->util;
+			int j;
+
+			if (!info->merge.nr || strcmp(*argv, info->remote))
+				continue;
+			printf("  Remote branch%s merged with 'git pull' "
+				"while on branch %s\n   ",
+				info->merge.nr > 1 ? "es" : "",
+				branch->path);
+			for (j = 0; j < info->merge.nr; j++)
+				printf(" %s", info->merge.items[j].path);
+			printf("\n");
+		}
+
+		if (got_states)
+			continue;
+		strbuf_init(&buf, 0);
+		strbuf_addf(&buf, "  New remote branch%%s (next fetch will "
+			"store in remotes/%s)", states.remote->name);
+		show_list(buf.buf, &states.new);
+		strbuf_release(&buf);
+		show_list("  Stale tracking branch%s (use 'git remote prune')",
+				&states.stale);
+		show_list("  Tracked remote branch%s",
+				&states.tracked);
+
+		if (states.remote->push_refspec_nr) {
+			printf("  Local branch%s pushed with 'git push'\n   ",
+				states.remote->push_refspec_nr > 1 ?
+					"es" : "");
+			for (i = 0; i < states.remote->push_refspec_nr; i++) {
+				struct refspec *spec = states.remote->push + i;
+				printf(" %s%s%s%s", spec->force ? "+" : "",
+					skip_prefix(spec->src, "refs/heads/"),
+					spec->dst ? ":" : "",
+					skip_prefix(spec->dst, "refs/heads/"));
+			}
+		}
+cleanup_states:
+		/* NEEDSWORK: free remote */
+		path_list_clear(&states.new, 0);
+		path_list_clear(&states.stale, 0);
+		path_list_clear(&states.tracked, 0);
+	}
+
+	return result;
+}
+
+static int update_one(struct remote *remote, void *priv)
+{
+	if (!remote->skip_default_update)
+		return fetch_remote(remote->name);
+	return 0;
+}
+
+static int update(int argc, const char **argv)
+{
+	int i;
+
+	if (argc < 2)
+		return for_each_remote(update_one, NULL);
+
+	for (i = 1; i < argc; i++)
+		if (fetch_remote(argv[i]))
+			return 1;
+	return 0;
+}
+
+static int get_one_entry(struct remote *remote, void *priv)
+{
+	struct path_list *list = priv;
+
+	path_list_append(remote->name, list)->util = (void *)remote->url[0];
+	if (remote->url[0] && remote->url[1])
+		warning ("Remote %s has more than one URL", remote->name);
+
+	return 0;
+}
+
+static int show_all()
+{
+	struct path_list list = { NULL, 0, 0 };
+	int result = for_each_remote(get_one_entry, &list);
+
+	if (!result) {
+		int i;
+
+		sort_path_list(&list);
+		for (i = 0; i < list.nr; i++) {
+			struct path_list_item *item = list.items + i;
+			printf("%s%s%s\n", item->path,
+				verbose ? "\t" : "",
+				verbose && item->util ?
+					(const char *)item->util : "");
+		}
+	}
+	return result;
+}
+
+int cmd_remote(int argc, const char **argv, const char *prefix)
+{
+	struct option options[] = {
+		OPT__VERBOSE(&verbose),
+		OPT_END()
+	};
+	int result;
+
+	argc = parse_options(argc, argv, options, builtin_remote_usage,
+		PARSE_OPT_STOP_AT_NON_OPTION);
+
+	if (argc < 1)
+		result = show_all();
+	else if (!strcmp(argv[0], "add"))
+		result = add(argc, argv);
+	else if (!strcmp(argv[0], "rm"))
+		result = rm(argc, argv);
+	else if (!strcmp(argv[0], "show"))
+		result = show_or_prune(argc, argv, 0);
+	else if (!strcmp(argv[0], "prune"))
+		result = show_or_prune(argc, argv, 1);
+	else if (!strcmp(argv[0], "update"))
+		result = update(argc, argv);
+	else {
+		error ("Unknown subcommand: %s", argv[0]);
+		usage_with_options(builtin_remote_usage, options);
+	}
+
+	return result ? 1 : 0;
+}
diff --git a/builtin.h b/builtin.h
index cb675c4..20b6e75 100644
--- a/builtin.h
+++ b/builtin.h
@@ -66,6 +66,7 @@ extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
 extern int cmd_push(int argc, const char **argv, const char *prefix);
 extern int cmd_read_tree(int argc, const char **argv, const char *prefix);
 extern int cmd_reflog(int argc, const char **argv, const char *prefix);
+extern int cmd_remote(int argc, const char **argv, const char *prefix);
 extern int cmd_config(int argc, const char **argv, const char *prefix);
 extern int cmd_rerere(int argc, const char **argv, const char *prefix);
 extern int cmd_reset(int argc, const char **argv, const char *prefix);
diff --git a/git-remote.perl b/contrib/examples/git-remote.perl
similarity index 100%
rename from git-remote.perl
rename to contrib/examples/git-remote.perl
diff --git a/git.c b/git.c
index c8b7e74..80e9082 100644
--- a/git.c
+++ b/git.c
@@ -349,6 +349,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "push", cmd_push, RUN_SETUP },
 		{ "read-tree", cmd_read_tree, RUN_SETUP },
 		{ "reflog", cmd_reflog, RUN_SETUP },
+		{ "remote", cmd_remote, RUN_SETUP },
 		{ "repo-config", cmd_config },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
diff --git a/remote.c b/remote.c
index 3fb0f99..ae7abe4 100644
--- a/remote.c
+++ b/remote.c
@@ -280,7 +280,8 @@ static int handle_config(const char *key, const char *value)
 			remote->fetch_tags = -1;
 	} else if (!strcmp(subkey, ".proxy")) {
 		remote->http_proxy = xstrdup(value);
-	}
+	} else if (!strcmp(subkey, ".skipdefaultupdate"))
+		remote->skip_default_update = 1;
 	return 0;
 }
 
diff --git a/remote.h b/remote.h
index 86e036d..bb26d3c 100644
--- a/remote.h
+++ b/remote.h
@@ -22,6 +22,7 @@ struct remote {
 	 * 2 to always fetch tags
 	 */
 	int fetch_tags;
+	int skip_default_update;
 
 	const char *receivepack;
 	const char *uploadpack;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index c7d7242..d343a96 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -100,9 +100,9 @@ test_expect_success 'remove remote' '
 cat > test/expect << EOF
 * remote origin
   URL: $(pwd)/one/.git
-  Remote branch(es) merged with 'git pull' while on branch master
+  Remote branch merged with 'git pull' while on branch master
     master
-  New remote branches (next fetch will store in remotes/origin)
+  New remote branch (next fetch will store in remotes/origin)
     master
   Tracked remote branches
     side master
-- 
1.5.3.7.2157.g9598e
