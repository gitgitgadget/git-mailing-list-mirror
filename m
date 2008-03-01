From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 5/6] Make git-remote a builtin
Date: Sat, 1 Mar 2008 13:16:46 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0803011316360.22527@racer.site>
References: <alpine.LSU.1.00.0802290144130.22527@racer.site> <alpine.LSU.1.00.0802290144410.22527@racer.site> <7vprugfrgw.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0802290214150.22527@racer.site> <alpine.LSU.1.00.0803011313020.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 14:18:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVRbI-0007fa-Vg
	for gcvg-git-2@gmane.org; Sat, 01 Mar 2008 14:18:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756027AbYCANR2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Mar 2008 08:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755991AbYCANR2
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Mar 2008 08:17:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:43890 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755978AbYCANR0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Mar 2008 08:17:26 -0500
Received: (qmail invoked by alias); 01 Mar 2008 13:17:24 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp001) with SMTP; 01 Mar 2008 14:17:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19gLCVLk2Fg8OS2d1fITdePQypSfFrGDx2d3lqyfi
	2VGt71XczT/Cn0
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803011313020.22527@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75670>


This includes the fix to guard remote->url accesses by checking
remote->url_nr, as suggested by Johannes Sixt.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Makefile                                           |    3 +-
 builtin-remote.c                                   |  547 ++++++++++++++++++++
 builtin.h                                          |    1 +
 .../examples/git-remote.perl                       |    0 
 git.c                                              |    1 +
 remote.c                                           |    3 +-
 remote.h                                           |    1 +
 t/t5505-remote.sh                                  |    4 +-
 8 files changed, 556 insertions(+), 4 deletions(-)
 create mode 100644 builtin-remote.c
 rename git-remote.perl => contrib/examples/git-remote.perl (100%)

diff --git a/Makefile b/Makefile
index ad214d3..8847bbe 100644
--- a/Makefile
+++ b/Makefile
@@ -243,7 +243,7 @@ SCRIPT_SH = \
 SCRIPT_PERL = \
 	git-add--interactive.perl \
 	git-archimport.perl git-cvsimport.perl git-relink.perl \
-	git-cvsserver.perl git-remote.perl git-cvsexportcommit.perl \
+	git-cvsserver.perl git-cvsexportcommit.perl \
 	git-send-email.perl git-svn.perl
 
 SCRIPTS = $(patsubst %.sh,%,$(SCRIPT_SH)) \
@@ -380,6 +380,7 @@ BUILTIN_OBJS = \
 	builtin-push.o \
 	builtin-read-tree.o \
 	builtin-reflog.o \
+	builtin-remote.o \
 	builtin-send-pack.o \
 	builtin-config.o \
 	builtin-rerere.o \
diff --git a/builtin-remote.c b/builtin-remote.c
new file mode 100644
index 0000000..2c10df3
--- /dev/null
+++ b/builtin-remote.c
@@ -0,0 +1,547 @@
+#include "cache.h"
+#include "parse-options.h"
+#include "transport.h"
+#include "remote.h"
+#include "string-list.h"
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
+	struct string_list *list = opt->value;
+	if (not)
+		string_list_clear(list, 0);
+	else
+		string_list_append(arg, list);
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
+	struct string_list track = { NULL, 0, 0 };
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
+		string_list_append("*", &track);
+	for (i = 0; i < track.nr; i++) {
+		struct string_list_item *item = track.items + i;
+
+		strbuf_reset(&buf);
+		strbuf_addf(&buf, "remote.%s.fetch", name);
+
+		strbuf_reset(&buf2);
+		if (mirror)
+			strbuf_addf(&buf2, "refs/%s:refs/%s",
+					item->string, item->string);
+		else
+			strbuf_addf(&buf2, "refs/heads/%s:refs/remotes/%s/%s",
+					item->string, name, item->string);
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
+	string_list_clear(&track, 0);
+
+	return 0;
+}
+
+struct branch_info {
+	char *remote;
+	struct string_list merge;
+};
+
+static struct string_list branch_list;
+
+static int config_read_branches(const char *key, const char *value)
+{
+	if (!prefixcmp(key, "branch.")) {
+		char *name;
+		struct string_list_item *item;
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
+		item = string_list_insert(name, &branch_list);
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
+				string_list_append(merge, &info->merge);
+				value = skip_prefix(space + 1, "refs/heads/");
+				space = strchr(value, ' ');
+			}
+			string_list_append(xstrdup(value), &info->merge);
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
+	sort_string_list(&branch_list);
+}
+
+struct ref_states {
+	struct remote *remote;
+	struct strbuf remote_prefix;
+	struct string_list new, stale, tracked;
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
+		struct string_list_item *item;
+		const char *name = skip_prefix(refspec.src, "refs/heads/");
+		if (unsorted_string_list_has_string(&states->tracked, name) ||
+				unsorted_string_list_has_string(&states->new,
+					name))
+			return 0;
+		item = string_list_append(name, &states->stale);
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
+	states->new.strdup_strings = states->tracked.strdup_strings = 1;
+	for (ref = fetch_map; ref; ref = ref->next) {
+		struct string_list *target = &states->tracked;
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
+		string_list_append(skip_prefix(ref->name, "refs/heads/"),
+				target)->util = util;
+	}
+	free_refs(fetch_map);
+
+	strbuf_addf(&states->remote_prefix,
+		"refs/remotes/%s/", states->remote->name);
+	for_each_ref(handle_one_branch, states);
+	sort_string_list(&states->stale);
+
+	return 0;
+}
+
+struct branches_for_remote {
+	const char *prefix;
+	struct string_list *branches;
+};
+
+static int add_branch_for_removal(const char *refname,
+	const unsigned char *sha1, int flags, void *cb_data)
+{
+	struct branches_for_remote *branches = cb_data;
+
+	if (!prefixcmp(refname, branches->prefix)) {
+		struct string_list_item *item;
+		item = string_list_append(refname, branches->branches);
+		item->util = xmalloc(20);
+		hashcpy(item->util, sha1);
+	}
+
+	return 0;
+}
+
+static int remove_branches(struct string_list *branches)
+{
+	int i, result = 0;
+	for (i = 0; i < branches->nr; i++) {
+		struct string_list_item *item = branches->items + i;
+		const char *refname = item->string;
+		unsigned char *sha1 = item->util;
+
+		if (delete_ref(refname, sha1))
+			result |= error("Could not remove branch %s", refname);
+	}
+	return result;
+}
+
+static int rm(int argc, const char **argv)
+{
+	struct option options[] = {
+		OPT_END()
+	};
+	struct remote *remote;
+	struct strbuf buf;
+	struct string_list branches = { NULL, 0, 0, 1 };
+	struct branches_for_remote cb_data = { NULL, &branches };
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
+		struct string_list_item *item = branch_list.items +i;
+		struct branch_info *info = item->util;
+		if (info->remote && !strcmp(info->remote, remote->name)) {
+			const char *keys[] = { "remote", "merge", NULL }, **k;
+			for (k = keys; *k; k++) {
+				strbuf_reset(&buf);
+				strbuf_addf(&buf, "branch.%s.%s",
+						item->string, *k);
+				if (git_config_set(buf.buf, NULL)) {
+					strbuf_release(&buf);
+					return -1;
+				}
+			}
+		}
+	}
+
+	/*
+	 * We cannot just pass a function to for_each_ref() which deletes
+	 * the branches one by one, since for_each_ref() relies on cached
+	 * refs, which are invalidated when deleting a branch.
+	 */
+	strbuf_reset(&buf);
+	strbuf_addf(&buf, "refs/remotes/%s/", remote->name);
+	cb_data.prefix = buf.buf;
+	i = for_each_ref(add_branch_for_removal, &cb_data);
+	strbuf_release(&buf);
+
+	if (!i)
+		i = remove_branches(&branches);
+	string_list_clear(&branches, 1);
+
+	return i;
+}
+
+static void show_list(const char *title, struct string_list *list)
+{
+	int i;
+
+	if (!list->nr)
+		return;
+
+	printf(title, list->nr > 1 ? "es" : "");
+	printf("\n    ");
+	for (i = 0; i < list->nr; i++)
+		printf("%s%s", i ? " " : "", list->items[i].string);
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
+		transport = transport_get(NULL, states.remote->url_nr > 0 ?
+			states.remote->url[0] : NULL);
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
+						states.stale.items[i].string);
+				result |= delete_ref(buf.buf, NULL);
+			}
+
+			strbuf_release(&buf);
+			goto cleanup_states;
+		}
+
+		printf("* remote %s\n  URL: %s\n", *argv,
+			states.remote->url_nr > 0 ?
+				states.remote->url[0] : "(no URL)");
+
+		for (i = 0; i < branch_list.nr; i++) {
+			struct string_list_item *branch = branch_list.items + i;
+			struct branch_info *info = branch->util;
+			int j;
+
+			if (!info->merge.nr || strcmp(*argv, info->remote))
+				continue;
+			printf("  Remote branch%s merged with 'git pull' "
+				"while on branch %s\n   ",
+				info->merge.nr > 1 ? "es" : "",
+				branch->string);
+			for (j = 0; j < info->merge.nr; j++)
+				printf(" %s", info->merge.items[j].string);
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
+		string_list_clear(&states.new, 0);
+		string_list_clear(&states.stale, 0);
+		string_list_clear(&states.tracked, 0);
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
+	struct string_list *list = priv;
+
+	string_list_append(remote->name, list)->util = remote->url_nr ?
+		(void *)remote->url[0] : NULL;
+	if (remote->url_nr > 1)
+		warning ("Remote %s has more than one URL", remote->name);
+
+	return 0;
+}
+
+static int show_all()
+{
+	struct string_list list = { NULL, 0, 0 };
+	int result = for_each_remote(get_one_entry, &list);
+
+	if (!result) {
+		int i;
+
+		sort_string_list(&list);
+		for (i = 0; i < list.nr; i++) {
+			struct string_list_item *item = list.items + i;
+			printf("%s%s%s\n", item->string,
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
index 674c8a1..95126fd 100644
--- a/builtin.h
+++ b/builtin.h
@@ -67,6 +67,7 @@ extern int cmd_prune_packed(int argc, const char **argv, const char *prefix);
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
index 9cca81a..1e3eb10 100644
--- a/git.c
+++ b/git.c
@@ -334,6 +334,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "push", cmd_push, RUN_SETUP },
 		{ "read-tree", cmd_read_tree, RUN_SETUP },
 		{ "reflog", cmd_reflog, RUN_SETUP },
+		{ "remote", cmd_remote, RUN_SETUP },
 		{ "repo-config", cmd_config },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "reset", cmd_reset, RUN_SETUP },
diff --git a/remote.c b/remote.c
index 7e19372..f3f7375 100644
--- a/remote.c
+++ b/remote.c
@@ -357,7 +357,8 @@ static int handle_config(const char *key, const char *value)
 			remote->fetch_tags = -1;
 	} else if (!strcmp(subkey, ".proxy")) {
 		remote->http_proxy = xstrdup(value);
-	}
+	} else if (!strcmp(subkey, ".skipdefaultupdate"))
+		remote->skip_default_update = 1;
 	return 0;
 }
 
diff --git a/remote.h b/remote.h
index 0f6033f..f1dedf1 100644
--- a/remote.h
+++ b/remote.h
@@ -25,6 +25,7 @@ struct remote {
 	 * 2 to always fetch tags
 	 */
 	int fetch_tags;
+	int skip_default_update;
 
 	const char *receivepack;
 	const char *uploadpack;
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index e1e0a18..5986982 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -97,9 +97,9 @@ test_expect_success 'remove remote' '
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
1.5.4.3.446.gbe8932


