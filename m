From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 4/4] Make fetch a builtin
Date: Wed, 11 Jul 2007 21:37:11 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0707112111270.6977@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jul 12 03:37:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I8ncW-0000Fq-V4
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 03:37:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932269AbXGLBhU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 Jul 2007 21:37:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763094AbXGLBhT
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Jul 2007 21:37:19 -0400
Received: from iabervon.org ([66.92.72.58]:1591 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763262AbXGLBhO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jul 2007 21:37:14 -0400
Received: (qmail 31942 invoked by uid 1000); 12 Jul 2007 01:37:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 12 Jul 2007 01:37:11 -0000
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52232>

As an implementation of fetch, this changes a few small bits of behavior:

branch.<name>.merge is parsed as if it were the lhs of a fetch
refspec, and does not have to exactly match the actual lhs of a
refspec, so long as it is a valid abbreviation for the same ref.

branch.<name>.merge is no longer ignored if the remote is configured
with a branches/* file. Neither behavior is useful, because there can
only be one ref that gets fetched, but this is more consistant.

Changes to the tests and documentation are included in this patch. Without 
a fetch-from-bundle implementation, one of the tests will fail with this 
patch applied.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/config.txt                           |    9 +-
 Makefile                                           |    2 +-
 builtin-fetch.c                                    |  552 ++++++++++++++++++++
 builtin.h                                          |    1 +
 cache.h                                            |    1 +
 git-fetch.sh                                       |  377 -------------
 git.c                                              |    1 +
 t/t5515/fetch.br-branches-default-merge            |    2 +-
 ...etch.br-branches-default-merge_branches-default |    2 +-
 t/t5515/fetch.br-branches-default-octopus          |    2 +-
 ...ch.br-branches-default-octopus_branches-default |    2 +-
 t/t5515/fetch.br-branches-one-merge                |    2 +-
 t/t5515/fetch.br-branches-one-merge_branches-one   |    2 +-
 t/t5515/fetch.br-config-glob-octopus               |    2 +-
 t/t5515/fetch.br-config-glob-octopus_config-glob   |    2 +-
 t/t5515/fetch.br-remote-glob-octopus               |    2 +-
 t/t5515/fetch.br-remote-glob-octopus_remote-glob   |    2 +-
 17 files changed, 571 insertions(+), 392 deletions(-)
 create mode 100644 builtin-fetch.c
 delete mode 100755 git-fetch.sh

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 50503e8..389b21d 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -312,10 +312,11 @@ branch.<name>.remote::
 	If this option is not given, `git fetch` defaults to remote "origin".
 
 branch.<name>.merge::
-	When in branch <name>, it tells `git fetch` the default refspec to
-	be marked for merging in FETCH_HEAD. The value has exactly to match
-	a remote part of one of the refspecs which are fetched from the remote
-	given by "branch.<name>.remote".
+	When in branch <name>, it tells `git fetch` the default
+	refspec to be marked for merging in FETCH_HEAD. The value is
+	handled like the remote part of a refspec, and must match a
+	ref which is fetched from the remote given by
+	"branch.<name>.remote".
 	The merge information is used by `git pull` (which at first calls
 	`git fetch`) to lookup the default branch for merging. Without
 	this option, `git pull` defaults to merge the first refspec fetched.
diff --git a/Makefile b/Makefile
index 83e699f..899e8c1 100644
--- a/Makefile
+++ b/Makefile
@@ -201,7 +201,6 @@ BASIC_LDFLAGS =
 SCRIPT_SH = \
 	git-bisect.sh git-checkout.sh \
 	git-clean.sh git-clone.sh git-commit.sh \
-	git-fetch.sh \
 	git-ls-remote.sh \
 	git-merge-one-file.sh git-mergetool.sh git-parse-remote.sh \
 	git-pull.sh git-rebase.sh git-rebase--interactive.sh \
@@ -340,6 +339,7 @@ BUILTIN_OBJS = \
 	builtin-diff-files.o \
 	builtin-diff-index.o \
 	builtin-diff-tree.o \
+	builtin-fetch.o \
 	builtin-fetch-pack.o \
 	builtin-fetch--tool.o \
 	builtin-fmt-merge-msg.o \
diff --git a/builtin-fetch.c b/builtin-fetch.c
new file mode 100644
index 0000000..2f24c22
--- /dev/null
+++ b/builtin-fetch.c
@@ -0,0 +1,552 @@
+/*
+ * "git fetch"
+ */
+#include "cache.h"
+#include "refs.h"
+#include "commit.h"
+#include "builtin.h"
+#include "path-list.h"
+#include "remote.h"
+#include "transport.h"
+
+static const char fetch_usage[] = "git-fetch [-a | --append] [--upload-pack <upload-pack>] [-f | --force] [--no-tags] [-t | --tags] [-k | --keep] [-u | --update-head-ok] [--depth <depth>] [-v | --verbose] [<repository> <refspec>...]";
+
+static int append, force, tags, no_tags, update_head_ok, verbose, quiet;
+
+static int unpacklimit;
+
+static char *default_rla = NULL;
+
+static void find_merge_config(struct ref *ref_map, struct remote *remote)
+{
+	struct ref *rm = ref_map;
+	struct branch *branch = branch_get(NULL);
+
+	for (rm = ref_map; rm; rm = rm->next) {
+		if (!branch_has_merge_config(branch)) {
+			if (remote && remote->fetch &&
+			    !strcmp(remote->fetch[0].src, rm->name))
+				rm->merge = 1;
+		} else {
+			if (branch_merges(branch, rm->name))
+				rm->merge = 1;
+		}
+	}
+}
+
+static struct ref *get_ref_map(struct transport *transport,
+			       struct refspec *refs, int ref_count, int tags,
+			       int *autotags)
+{
+	int i;
+	struct ref *rm;
+	struct ref *ref_map = NULL;
+	struct ref **tail = &ref_map;
+
+	struct ref *remote_refs = transport_get_remote_refs(transport);
+
+	if (ref_count || tags) {
+		for (i = 0; i < ref_count; i++) {
+			get_fetch_map(remote_refs, &refs[i], &tail);
+			if (refs[i].dst && refs[i].dst[0])
+				*autotags = 1;
+		}
+		/* Merge everything on the command line, but not --tags */
+		for (rm = ref_map; rm; rm = rm->next)
+			rm->merge = 1;
+		if (tags) {
+			struct refspec refspec;
+			refspec.src = "refs/tags/";
+			refspec.dst = "refs/tags/";
+			refspec.pattern = 1;
+			refspec.force = 0;
+			get_fetch_map(remote_refs, &refspec, &tail);
+		}
+	} else {
+		/* Use the defaults */
+		struct remote *remote = transport->remote;
+		if (remote->fetch_refspec_nr) {
+			for (i = 0; i < remote->fetch_refspec_nr; i++) {
+				get_fetch_map(remote_refs, &remote->fetch[i], &tail);
+				if (remote->fetch[i].dst &&
+				    remote->fetch[i].dst[0])
+					*autotags = 1;
+			}
+			find_merge_config(ref_map, remote);
+		} else {
+			ref_map = get_remote_ref(remote_refs, "HEAD");
+
+			ref_map->merge = 1;
+		}
+	}
+
+	return ref_map;
+}
+
+static void show_new(enum object_type type, unsigned char *sha1_new)
+{
+	fprintf(stderr, "  %s: %s\n", typename(type),
+		find_unique_abbrev(sha1_new, DEFAULT_ABBREV));
+}
+
+static int update_ref(const char *action,
+		      struct ref *ref,
+		      int check_old)
+{
+	char msg[1024];
+	char *rla = getenv("GIT_REFLOG_ACTION");
+	static struct ref_lock *lock;
+
+	if (!rla)
+		rla = default_rla;
+	snprintf(msg, sizeof(msg), "%s: %s", rla, action);
+	lock = lock_any_ref_for_update(ref->name,
+				       check_old ? ref->old_sha1 : NULL, 0);
+	if (!lock)
+		return 1;
+	if (write_ref_sha1(lock, ref->new_sha1, msg) < 0)
+		return 1;
+	return 0;
+}
+
+static int update_local_ref(struct ref *ref,
+			    const char *note,
+			    int verbose)
+{
+	char oldh[41], newh[41];
+	struct commit *current = NULL, *updated;
+	enum object_type type;
+	struct branch *current_branch = branch_get(NULL);
+
+	type = sha1_object_info(ref->new_sha1, NULL);
+	if (type < 0)
+		die("object %s not found", sha1_to_hex(ref->new_sha1));
+
+	if (!*ref->name) {
+		/* Not storing */
+		if (verbose) {
+			fprintf(stderr, "* fetched %s\n", note);
+			show_new(type, ref->new_sha1);
+		}
+		return 0;
+	}
+
+	if (!hashcmp(ref->old_sha1, ref->new_sha1)) {
+		if (verbose) {
+			fprintf(stderr, "* %s: same as %s\n",
+				ref->name, note);
+			show_new(type, ref->new_sha1);
+		}
+		return 0;
+	}
+
+	if (!strcmp(ref->name, current_branch->name) &&
+	    !(update_head_ok || is_bare_repository()) &&
+	    !is_null_sha1(ref->old_sha1)) {
+		/*
+		 * If this is the head, and it's not okay to update
+		 * the head, and the old value of the head isn't empty...
+		 */
+		fprintf(stderr,
+			" * %s: Cannot fetch into the current branch.\n",
+			ref->name);
+		return 1;
+	}
+
+	if (!is_null_sha1(ref->old_sha1) &&
+	    !prefixcmp(ref->name, "refs/tags/")) {
+		fprintf(stderr, "* %s: updating with %s\n",
+			ref->name, note);
+		show_new(type, ref->new_sha1);
+		return update_ref("updating tag", ref, 0);
+	}
+
+	current = lookup_commit_reference(ref->old_sha1);
+	updated = lookup_commit_reference(ref->new_sha1);
+	if (!current || !updated) {
+		char *msg;
+		if (!strncmp(ref->name, "refs/tags/", 10))
+			msg = "storing tag";
+		else
+			msg = "storing head";
+		fprintf(stderr, "* %s: storing %s\n",
+			ref->name, note);
+		show_new(type, ref->new_sha1);
+		return update_ref(msg, ref, 0);
+	}
+
+	strcpy(oldh, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
+	strcpy(newh, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
+
+	if (in_merge_bases(current, &updated, 1)) {
+		fprintf(stderr, "* %s: fast forward to %s\n",
+			ref->name, note);
+		fprintf(stderr, "  old..new: %s..%s\n", oldh, newh);
+		return update_ref("fast forward", ref, 1);
+	}
+	if (!force && !ref->force) {
+		fprintf(stderr,
+			"* %s: not updating to non-fast forward %s\n",
+			ref->name, note);
+		fprintf(stderr,
+			"  old...new: %s...%s\n", oldh, newh);
+		return 1;
+	}
+	fprintf(stderr,
+		"* %s: forcing update to non-fast forward %s\n",
+		ref->name, note);
+	fprintf(stderr, "  old...new: %s...%s\n", oldh, newh);
+	return update_ref("forced-update", ref, 1);
+}
+
+static void store_updated_refs(const char *url, struct ref *ref_map)
+{
+	FILE *fp;
+	struct commit *commit;
+	int url_len, i, note_len;
+	char note[1024];
+	const char *what, *kind;
+	struct ref *rm;
+
+	fp = fopen(git_path("FETCH_HEAD"), "a");
+	for (rm = ref_map; rm; rm = rm->next) {
+		struct ref *ref = NULL;
+
+		if (rm->peer_ref) {
+			ref = xcalloc(1, sizeof(*ref) + strlen(rm->peer_ref->name) + 1);
+			strcpy(ref->name, rm->peer_ref->name);
+			hashcpy(ref->old_sha1, rm->peer_ref->old_sha1);
+			hashcpy(ref->new_sha1, rm->old_sha1);
+			ref->force = rm->force;
+		}
+
+		commit = lookup_commit_reference(rm->old_sha1);
+		if (!commit)
+			rm->merge = 0;
+
+		if (!strcmp(rm->name, "HEAD")) {
+			kind = "";
+			what = "";
+		}
+		else if (!prefixcmp(rm->name, "refs/heads/")) {
+			kind = "branch";
+			what = rm->name + 11;
+		}
+		else if (!prefixcmp(rm->name, "refs/tags/")) {
+			kind = "tag";
+			what = rm->name + 10;
+		}
+		else if (!prefixcmp(rm->name, "refs/remotes/")) {
+			kind = "remote branch";
+			what = rm->name + 13;
+		}
+		else {
+			kind = "";
+			what = rm->name;
+		}
+
+		url_len = strlen(url);
+		for (i = url_len - 1; url[i] == '/' && 0 <= i; i--)
+			;
+		url_len = i + 1;
+		if (4 < i && !strncmp(".git", url + i - 3, 4))
+			url_len = i - 3;
+
+		note_len = 0;
+		if (*what) {
+			if (*kind)
+				note_len += sprintf(note + note_len, "%s ",
+						    kind);
+			note_len += sprintf(note + note_len, "'%s' of ", what);
+		}
+		note_len += sprintf(note + note_len, "%.*s", url_len, url);
+		fprintf(fp, "%s\t%s\t%s\n",
+			sha1_to_hex(commit ? commit->object.sha1 :
+				    rm->old_sha1),
+			rm->merge ? "" : "not-for-merge",
+			note);
+
+		if (ref)
+			update_local_ref(ref, note, verbose);
+	}
+	fclose(fp);
+}
+
+static int fetch_refs(struct transport *transport, struct ref *ref_map)
+{
+	int ret = transport_fetch_refs(transport, ref_map);
+	if (!ret)
+		store_updated_refs(transport->url, ref_map);
+	return ret;
+}
+
+static int add_existing(const char *refname, const unsigned char *sha1,
+			int flag, void *cbdata)
+{
+	struct path_list *list = (struct path_list *)cbdata;
+	path_list_insert(refname, list);
+	return 0;
+}
+
+static struct ref *find_non_local_tags(struct transport *transport,
+				       struct ref *fetch_map)
+{
+	static struct path_list existing_refs = { NULL, 0, 0, 0 };
+	struct path_list new_refs = { NULL, 0, 0, 1 };
+	char *ref_name;
+	int ref_name_len;
+	unsigned char *ref_sha1;
+	struct ref *tag_ref;
+	struct ref *rm = NULL;
+	struct ref *ref_map = NULL;
+	struct ref **tail = &ref_map;
+	struct ref *ref;
+
+	for_each_ref(add_existing, &existing_refs);
+	for (ref = transport_get_remote_refs(transport); ref; ref = ref->next) {
+		if (prefixcmp(ref->name, "refs/tags"))
+			continue;
+
+		ref_name = xstrdup(ref->name);
+		ref_name_len = strlen(ref_name);
+		ref_sha1 = ref->old_sha1;
+
+		if (!strcmp(ref_name + ref_name_len - 3, "^{}")) {
+			ref_name[ref_name_len - 3] = 0;
+			tag_ref = transport_get_remote_refs(transport);
+			while (tag_ref) {
+				if (!strcmp(tag_ref->name, ref_name)) {
+					ref_sha1 = tag_ref->old_sha1;
+					break;
+				}
+				tag_ref = tag_ref->next;
+			}
+		}
+
+		if (!path_list_has_path(&existing_refs, ref_name) &&
+		    !path_list_has_path(&new_refs, ref_name) &&
+		    lookup_object(ref->old_sha1)) {
+			fprintf(stderr, "Auto-following %s\n",
+				ref_name);
+
+			path_list_insert(ref_name, &new_refs);
+
+			rm = alloc_ref(strlen(ref_name) + 1);
+			strcpy(rm->name, ref_name);
+			rm->peer_ref = alloc_ref(strlen(ref_name) + 1);
+			strcpy(rm->peer_ref->name, ref_name);
+			hashcpy(rm->old_sha1, ref_sha1);
+
+			*tail = rm;
+			tail = &rm->next;
+		}
+		free(ref_name);
+	}
+
+	return ref_map;
+}
+
+static int do_fetch(struct transport *transport,
+		    struct refspec *refs, int ref_count)
+{
+	struct ref *ref_map, *fetch_map;
+	struct ref *rm;
+	int autotags = (transport->remote->fetch_tags == 1);
+	if (transport->remote->fetch_tags == 2 && !no_tags)
+		tags = 1;
+	if (transport->remote->fetch_tags == -1)
+		no_tags = 1;
+
+	if (!transport->ops || !transport->ops->get_refs_list ||
+	    !(transport->ops->fetch_refs || transport->ops->fetch_objs))
+		die("Don't know how to fetch from %s", transport->url);
+
+	/* if not appending, truncate FETCH_HEAD */
+	if (!append)
+		fclose(fopen(git_path("FETCH_HEAD"), "w"));
+
+	ref_map = get_ref_map(transport, refs, ref_count, tags, &autotags);
+
+	for (rm = ref_map; rm; rm = rm->next) {
+		if (rm->peer_ref)
+			read_ref(rm->peer_ref->name, rm->peer_ref->old_sha1);
+
+		printf("%s : %s\n", rm->name, rm->peer_ref ? rm->peer_ref->name : NULL);
+		printf("  < %s\n", sha1_to_hex(rm->old_sha1));
+		if (rm->peer_ref)
+			printf("  > %s\n", sha1_to_hex(rm->peer_ref->old_sha1));
+		if (!rm->peer_ref ||
+		    hashcmp(rm->old_sha1, rm->peer_ref->old_sha1)) {
+			printf("%s needs update.\n", rm->name);
+		}
+	}
+
+	fetch_refs(transport, ref_map);
+
+	fetch_map = ref_map;
+
+	/* if neither --no-tags nor --tags was specified, do automated tag
+	 * following ... */
+	if (!(tags || no_tags) && autotags) {
+		ref_map = find_non_local_tags(transport, fetch_map);
+		if (ref_map) {
+			transport_set_option(transport, TRANS_OPT_DEPTH, "0");
+			fetch_refs(transport, ref_map);
+		}
+		free_refs(ref_map);
+	}
+
+	free_refs(fetch_map);
+
+	return 0;
+}
+
+static int fetch_config(const char *var, const char *value)
+{
+	if (strcmp(var, "fetch.unpacklimit") == 0) {
+		unpacklimit = git_config_int(var, value);
+		return 0;
+	}
+
+	if (strcmp(var, "transfer.unpacklimit") == 0) {
+		unpacklimit = git_config_int(var, value);
+		return 0;
+	}
+
+	return git_default_config(var, value);
+}
+
+int cmd_fetch(int argc, const char **argv, const char *prefix)
+{
+	struct remote *remote;
+	struct transport *transport;
+	int i, j, rla_offset;
+	static const char **refs = NULL;
+	int ref_nr = 0;
+	int cmd_len = 0;
+	const char *depth = NULL, *upload_pack = NULL;
+	int keep = 0;
+
+	git_config(fetch_config);
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		cmd_len += strlen(arg);
+
+		if (arg[0] != '-') {
+			break;
+		}
+		if (!strcmp(arg, "--append") || !strcmp(arg, "-a")) {
+			append = 1;
+			continue;
+		}
+		if (!prefixcmp(arg, "--upload-pack=")) {
+			upload_pack = arg + 14;
+			continue;
+		}
+		if (!strcmp(arg, "--upload-pack")) {
+			i++;
+			if (i == argc)
+				usage(fetch_usage);
+			upload_pack = argv[i];
+			continue;
+		}
+		if (!strcmp(arg, "--force") || !strcmp(arg, "-f")) {
+			force = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--no-tags")) {
+			no_tags = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--tags") || !strcmp(arg, "-t")) {
+			tags = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--keep") || !strcmp(arg, "-k")) {
+			keep = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--update-head-ok") || !strcmp(arg, "-u")) {
+			update_head_ok = 1;
+			continue;
+		}
+		if (!prefixcmp(arg, "--depth=")) {
+			depth = arg + 8;
+			continue;
+		}
+		if (!strcmp(arg, "--depth")) {
+			i++;
+			if (i == argc)
+				usage(fetch_usage);
+			depth = argv[i];
+			continue;
+		}
+		if (!strcmp(arg, "--quiet")) {
+			quiet = 1;
+			continue;
+		}
+		if (!strcmp(arg, "--verbose") || !strcmp(arg, "-v")) {
+			verbose++;
+			continue;
+		}
+		usage(fetch_usage);
+	}
+
+	for (j = i; j < argc; j++) {
+		cmd_len += strlen(argv[j]);
+	}
+
+	default_rla = xmalloc(cmd_len + 5 + argc + 1);
+	sprintf(default_rla, "fetch");
+	rla_offset = strlen(default_rla);
+	for (j = 1; j < argc; j++) {
+		sprintf(default_rla + rla_offset, " %s", argv[j]);
+		rla_offset += strlen(argv[j]);
+	}
+
+	if (i == argc)
+		remote = remote_get(NULL);
+	else
+		remote = remote_get(argv[i++]);
+
+	transport = transport_get(remote, remote->uri[0], 1);
+	if (verbose >= 2)
+		transport->verbose = 1;
+	if (quiet)
+		transport->verbose = 0;
+	if (upload_pack)
+		transport_set_option(transport, TRANS_OPT_UPLOADPACK, upload_pack);
+	if (keep)
+		transport_set_option(transport, TRANS_OPT_KEEP, "yes");
+	transport_set_option(transport, TRANS_OPT_DEPTH, depth);
+
+	if (!transport->url)
+		die("Where do you want to fetch from today?");
+
+	if (i < argc) {
+		int j = 0;
+		refs = xcalloc(argc - i + 1, sizeof(const char *));
+		while (i < argc) {
+			if (!strcmp(argv[i], "tag")) {
+				char *ref;
+				i++;
+				ref = xmalloc(strlen(argv[i]) * 2 + 22);
+				strcpy(ref, "refs/tags/");
+				strcat(ref, argv[i]);
+				strcat(ref, ":refs/tags/");
+				strcat(ref, argv[i]);
+				refs[j++] = ref;
+			} else
+				refs[j++] = argv[i];
+			i++;
+		}
+		refs[j] = NULL;
+		ref_nr = j;
+		for (j = 0; refs[j]; j++) {
+			printf("ref: %s\n", refs[j]);
+		}
+	}
+
+	return do_fetch(transport, parse_ref_spec(ref_nr, refs), ref_nr);
+}
diff --git a/builtin.h b/builtin.h
index 39564d3..b0c538b 100644
--- a/builtin.h
+++ b/builtin.h
@@ -31,6 +31,7 @@ extern int cmd_diff_files(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_index(int argc, const char **argv, const char *prefix);
 extern int cmd_diff(int argc, const char **argv, const char *prefix);
 extern int cmd_diff_tree(int argc, const char **argv, const char *prefix);
+extern int cmd_fetch(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_fetch__tool(int argc, const char **argv, const char *prefix);
 extern int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix);
diff --git a/cache.h b/cache.h
index 4818c8c..b93b605 100644
--- a/cache.h
+++ b/cache.h
@@ -475,6 +475,7 @@ struct ref {
 	unsigned char old_sha1[20];
 	unsigned char new_sha1[20];
 	unsigned char force;
+	unsigned char merge;
 	struct ref *peer_ref; /* when renaming */
 	char name[FLEX_ARRAY]; /* more */
 };
diff --git a/git-fetch.sh b/git-fetch.sh
deleted file mode 100755
index 6d3a346..0000000
--- a/git-fetch.sh
+++ /dev/null
@@ -1,377 +0,0 @@
-#!/bin/sh
-#
-
-USAGE='<fetch-options> <repository> <refspec>...'
-SUBDIRECTORY_OK=Yes
-. git-sh-setup
-set_reflog_action "fetch $*"
-cd_to_toplevel ;# probably unnecessary...
-
-. git-parse-remote
-_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
-_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
-
-LF='
-'
-IFS="$LF"
-
-no_tags=
-tags=
-append=
-force=
-verbose=
-update_head_ok=
-exec=
-keep=
-shallow_depth=
-no_progress=
-test -t 1 || no_progress=--no-progress
-quiet=
-while case "$#" in 0) break ;; esac
-do
-	case "$1" in
-	-a|--a|--ap|--app|--appe|--appen|--append)
-		append=t
-		;;
-	--upl|--uplo|--uploa|--upload|--upload-|--upload-p|\
-	--upload-pa|--upload-pac|--upload-pack)
-		shift
-		exec="--upload-pack=$1"
-		;;
-	--upl=*|--uplo=*|--uploa=*|--upload=*|\
-	--upload-=*|--upload-p=*|--upload-pa=*|--upload-pac=*|--upload-pack=*)
-		exec=--upload-pack=$(expr "z$1" : 'z-[^=]*=\(.*\)')
-		shift
-		;;
-	-f|--f|--fo|--for|--forc|--force)
-		force=t
-		;;
-	-t|--t|--ta|--tag|--tags)
-		tags=t
-		;;
-	-n|--n|--no|--no-|--no-t|--no-ta|--no-tag|--no-tags)
-		no_tags=t
-		;;
-	-u|--u|--up|--upd|--upda|--updat|--update|--update-|--update-h|\
-	--update-he|--update-hea|--update-head|--update-head-|\
-	--update-head-o|--update-head-ok)
-		update_head_ok=t
-		;;
-	-q|--q|--qu|--qui|--quie|--quiet)
-		quiet=--quiet
-		;;
-	-v|--verbose)
-		verbose="$verbose"Yes
-		;;
-	-k|--k|--ke|--kee|--keep)
-		keep='-k -k'
-		;;
-	--depth=*)
-		shallow_depth="--depth=`expr "z$1" : 'z-[^=]*=\(.*\)'`"
-		;;
-	--depth)
-		shift
-		shallow_depth="--depth=$1"
-		;;
-	-*)
-		usage
-		;;
-	*)
-		break
-		;;
-	esac
-	shift
-done
-
-case "$#" in
-0)
-	origin=$(get_default_remote)
-	test -n "$(get_remote_url ${origin})" ||
-		die "Where do you want to fetch from today?"
-	set x $origin ; shift ;;
-esac
-
-if test -z "$exec"
-then
-	# No command line override and we have configuration for the remote.
-	exec="--upload-pack=$(get_uploadpack $1)"
-fi
-
-remote_nick="$1"
-remote=$(get_remote_url "$@")
-refs=
-rref=
-rsync_slurped_objects=
-
-if test "" = "$append"
-then
-	: >"$GIT_DIR/FETCH_HEAD"
-fi
-
-# Global that is reused later
-ls_remote_result=$(git ls-remote $exec "$remote") ||
-	die "Cannot get the repository state from $remote"
-
-append_fetch_head () {
-	flags=
-	test -n "$verbose" && flags="$flags$LF-v"
-	test -n "$force$single_force" && flags="$flags$LF-f"
-	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION" \
-		git-fetch--tool $flags append-fetch-head "$@"
-}
-
-# updating the current HEAD with git-fetch in a bare
-# repository is always fine.
-if test -z "$update_head_ok" && test $(is_bare_repository) = false
-then
-	orig_head=$(git-rev-parse --verify HEAD 2>/dev/null)
-fi
-
-# Allow --notags from remote.$1.tagopt
-case "$tags$no_tags" in
-'')
-	case "$(git-config --get "remote.$1.tagopt")" in
-	--no-tags)
-		no_tags=t ;;
-	esac
-esac
-
-# If --tags (and later --heads or --all) is specified, then we are
-# not talking about defaults stored in Pull: line of remotes or
-# branches file, and just fetch those and refspecs explicitly given.
-# Otherwise we do what we always did.
-
-reflist=$(get_remote_refs_for_fetch "$@")
-if test "$tags"
-then
-	taglist=`IFS='	' &&
-		  echo "$ls_remote_result" |
-		  git-show-ref --exclude-existing=refs/tags/ |
-	          while read sha1 name
-		  do
-			echo ".${name}:${name}"
-		  done` || exit
-	if test "$#" -gt 1
-	then
-		# remote URL plus explicit refspecs; we need to merge them.
-		reflist="$reflist$LF$taglist"
-	else
-		# No explicit refspecs; fetch tags only.
-		reflist=$taglist
-	fi
-fi
-
-fetch_all_at_once () {
-
-  eval=$(echo "$1" | git-fetch--tool parse-reflist "-")
-  eval "$eval"
-
-    ( : subshell because we muck with IFS
-      IFS=" 	$LF"
-      (
-	if test "$remote" = . ; then
-	    git-show-ref $rref || echo failed "$remote"
-	elif test -f "$remote" ; then
-	    test -n "$shallow_depth" &&
-		die "shallow clone with bundle is not supported"
-	    git-bundle unbundle "$remote" $rref ||
-	    echo failed "$remote"
-	else
-		if	test -d "$remote" &&
-
-			# The remote might be our alternate.  With
-			# this optimization we will bypass fetch-pack
-			# altogether, which means we cannot be doing
-			# the shallow stuff at all.
-			test ! -f "$GIT_DIR/shallow" &&
-			test -z "$shallow_depth" &&
-
-			# See if all of what we are going to fetch are
-			# connected to our repository's tips, in which
-			# case we do not have to do any fetch.
-			theirs=$(echo "$ls_remote_result" | \
-				git-fetch--tool -s pick-rref "$rref" "-") &&
-
-			# This will barf when $theirs reach an object that
-			# we do not have in our repository.  Otherwise,
-			# we already have everything the fetch would bring in.
-			git-rev-list --objects $theirs --not --all \
-				>/dev/null 2>/dev/null
-		then
-			echo "$ls_remote_result" | \
-				git-fetch--tool pick-rref "$rref" "-"
-		else
-			flags=
-			case $verbose in
-			YesYes*)
-			    flags="-v"
-			    ;;
-			esac
-			git-fetch-pack --thin $exec $keep $shallow_depth \
-				$quiet $no_progress $flags "$remote" $rref ||
-			echo failed "$remote"
-		fi
-	fi
-      ) |
-      (
-	flags=
-	test -n "$verbose" && flags="$flags -v"
-	test -n "$force" && flags="$flags -f"
-	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION" \
-		git-fetch--tool $flags native-store \
-			"$remote" "$remote_nick" "$refs"
-      )
-    ) || exit
-
-}
-
-fetch_per_ref () {
-  reflist="$1"
-  refs=
-  rref=
-
-  for ref in $reflist
-  do
-      refs="$refs$LF$ref"
-
-      # These are relative path from $GIT_DIR, typically starting at refs/
-      # but may be HEAD
-      if expr "z$ref" : 'z\.' >/dev/null
-      then
-	  not_for_merge=t
-	  ref=$(expr "z$ref" : 'z\.\(.*\)')
-      else
-	  not_for_merge=
-      fi
-      if expr "z$ref" : 'z+' >/dev/null
-      then
-	  single_force=t
-	  ref=$(expr "z$ref" : 'z+\(.*\)')
-      else
-	  single_force=
-      fi
-      remote_name=$(expr "z$ref" : 'z\([^:]*\):')
-      local_name=$(expr "z$ref" : 'z[^:]*:\(.*\)')
-
-      rref="$rref$LF$remote_name"
-
-      # There are transports that can fetch only one head at a time...
-      case "$remote" in
-      http://* | https://* | ftp://*)
-	  test -n "$shallow_depth" &&
-		die "shallow clone with http not supported"
-	  proto=`expr "$remote" : '\([^:]*\):'`
-	  if [ -n "$GIT_SSL_NO_VERIFY" ]; then
-	      curl_extra_args="-k"
-	  fi
-	  if [ -n "$GIT_CURL_FTP_NO_EPSV" -o \
-		"`git-config --bool http.noEPSV`" = true ]; then
-	      noepsv_opt="--disable-epsv"
-	  fi
-
-	  # Find $remote_name from ls-remote output.
-	  head=$(echo "$ls_remote_result" | \
-		git-fetch--tool -s pick-rref "$remote_name" "-")
-	  expr "z$head" : "z$_x40\$" >/dev/null ||
-		die "No such ref $remote_name at $remote"
-	  echo >&2 "Fetching $remote_name from $remote using $proto"
-	  case "$quiet" in '') v=-v ;; *) v= ;; esac
-	  git-http-fetch $v -a "$head" "$remote" || exit
-	  ;;
-      rsync://*)
-	  test -n "$shallow_depth" &&
-		die "shallow clone with rsync not supported"
-	  TMP_HEAD="$GIT_DIR/TMP_HEAD"
-	  rsync -L -q "$remote/$remote_name" "$TMP_HEAD" || exit 1
-	  head=$(git-rev-parse --verify TMP_HEAD)
-	  rm -f "$TMP_HEAD"
-	  case "$quiet" in '') v=-v ;; *) v= ;; esac
-	  test "$rsync_slurped_objects" || {
-	      rsync -a $v --ignore-existing --exclude info \
-		  "$remote/objects/" "$GIT_OBJECT_DIRECTORY/" || exit
-
-	      # Look at objects/info/alternates for rsync -- http will
-	      # support it natively and git native ones will do it on
-	      # the remote end.  Not having that file is not a crime.
-	      rsync -q "$remote/objects/info/alternates" \
-		  "$GIT_DIR/TMP_ALT" 2>/dev/null ||
-		  rm -f "$GIT_DIR/TMP_ALT"
-	      if test -f "$GIT_DIR/TMP_ALT"
-	      then
-		  resolve_alternates "$remote" <"$GIT_DIR/TMP_ALT" |
-		  while read alt
-		  do
-		      case "$alt" in 'bad alternate: '*) die "$alt";; esac
-		      echo >&2 "Getting alternate: $alt"
-		      rsync -av --ignore-existing --exclude info \
-		      "$alt" "$GIT_OBJECT_DIRECTORY/" || exit
-		  done
-		  rm -f "$GIT_DIR/TMP_ALT"
-	      fi
-	      rsync_slurped_objects=t
-	  }
-	  ;;
-      esac
-
-      append_fetch_head "$head" "$remote" \
-	  "$remote_name" "$remote_nick" "$local_name" "$not_for_merge" || exit
-
-  done
-
-}
-
-fetch_main () {
-	case "$remote" in
-	http://* | https://* | ftp://* | rsync://* )
-		fetch_per_ref "$@"
-		;;
-	*)
-		fetch_all_at_once "$@"
-		;;
-	esac
-}
-
-fetch_main "$reflist" || exit
-
-# automated tag following
-case "$no_tags$tags" in
-'')
-	case "$reflist" in
-	*:refs/*)
-		# effective only when we are following remote branch
-		# using local tracking branch.
-		taglist=$(IFS='	' &&
-		echo "$ls_remote_result" |
-		git-show-ref --exclude-existing=refs/tags/ |
-		while read sha1 name
-		do
-			git-cat-file -t "$sha1" >/dev/null 2>&1 || continue
-			echo >&2 "Auto-following $name"
-			echo ".${name}:${name}"
-		done)
-	esac
-	case "$taglist" in
-	'') ;;
-	?*)
-		# do not deepen a shallow tree when following tags
-		shallow_depth=
-		fetch_main "$taglist" || exit ;;
-	esac
-esac
-
-# If the original head was empty (i.e. no "master" yet), or
-# if we were told not to worry, we do not have to check.
-case "$orig_head" in
-'')
-	;;
-?*)
-	curr_head=$(git-rev-parse --verify HEAD 2>/dev/null)
-	if test "$curr_head" != "$orig_head"
-	then
-	    git-update-ref \
-			-m "$GIT_REFLOG_ACTION: Undoing incorrectly fetched HEAD." \
-			HEAD "$orig_head"
-		die "Cannot fetch into the current branch."
-	fi
-	;;
-esac
diff --git a/git.c b/git.c
index 71fa9c7..7ae9230 100644
--- a/git.c
+++ b/git.c
@@ -307,6 +307,7 @@ static void handle_internal_command(int argc, const char **argv)
 		{ "diff-files", cmd_diff_files },
 		{ "diff-index", cmd_diff_index, RUN_SETUP },
 		{ "diff-tree", cmd_diff_tree, RUN_SETUP },
+		{ "fetch", cmd_fetch, RUN_SETUP },
 		{ "fetch-pack", cmd_fetch_pack, RUN_SETUP },
 		{ "fetch--tool", cmd_fetch__tool, RUN_SETUP },
 		{ "fmt-merge-msg", cmd_fmt_merge_msg, RUN_SETUP },
diff --git a/t/t5515/fetch.br-branches-default-merge b/t/t5515/fetch.br-branches-default-merge
index ea65f31..828bfd8 100644
--- a/t/t5515/fetch.br-branches-default-merge
+++ b/t/t5515/fetch.br-branches-default-merge
@@ -1,5 +1,5 @@
 # br-branches-default-merge
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-default-merge_branches-default b/t/t5515/fetch.br-branches-default-merge_branches-default
index 7b5fa94..f148673 100644
--- a/t/t5515/fetch.br-branches-default-merge_branches-default
+++ b/t/t5515/fetch.br-branches-default-merge_branches-default
@@ -1,5 +1,5 @@
 # br-branches-default-merge branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus b/t/t5515/fetch.br-branches-default-octopus
index 128397d..bb1a191 100644
--- a/t/t5515/fetch.br-branches-default-octopus
+++ b/t/t5515/fetch.br-branches-default-octopus
@@ -1,5 +1,5 @@
 # br-branches-default-octopus
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-default-octopus_branches-default b/t/t5515/fetch.br-branches-default-octopus_branches-default
index 4b37cd4..970fc93 100644
--- a/t/t5515/fetch.br-branches-default-octopus_branches-default
+++ b/t/t5515/fetch.br-branches-default-octopus_branches-default
@@ -1,5 +1,5 @@
 # br-branches-default-octopus branches-default
-754b754407bf032e9a2f9d5a9ad05ca79a6b228f		branch 'master' of ../
+754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge b/t/t5515/fetch.br-branches-one-merge
index 3a4e77e..24099fd 100644
--- a/t/t5515/fetch.br-branches-one-merge
+++ b/t/t5515/fetch.br-branches-one-merge
@@ -1,5 +1,5 @@
 # br-branches-one-merge
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-branches-one-merge_branches-one b/t/t5515/fetch.br-branches-one-merge_branches-one
index 00e04b4..e4b4fde 100644
--- a/t/t5515/fetch.br-branches-one-merge_branches-one
+++ b/t/t5515/fetch.br-branches-one-merge_branches-one
@@ -1,5 +1,5 @@
 # br-branches-one-merge branches-one
-8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
+8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	branch 'one' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-config-glob-octopus b/t/t5515/fetch.br-config-glob-octopus
index 9ee213e..938e532 100644
--- a/t/t5515/fetch.br-config-glob-octopus
+++ b/t/t5515/fetch.br-config-glob-octopus
@@ -2,7 +2,7 @@
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-config-glob-octopus_config-glob b/t/t5515/fetch.br-config-glob-octopus_config-glob
index 44bd0ec..c9225bf 100644
--- a/t/t5515/fetch.br-config-glob-octopus_config-glob
+++ b/t/t5515/fetch.br-config-glob-octopus_config-glob
@@ -2,7 +2,7 @@
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus b/t/t5515/fetch.br-remote-glob-octopus
index c1554f8..b08e046 100644
--- a/t/t5515/fetch.br-remote-glob-octopus
+++ b/t/t5515/fetch.br-remote-glob-octopus
@@ -2,7 +2,7 @@
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
diff --git a/t/t5515/fetch.br-remote-glob-octopus_remote-glob b/t/t5515/fetch.br-remote-glob-octopus_remote-glob
index e613434..d4d547c 100644
--- a/t/t5515/fetch.br-remote-glob-octopus_remote-glob
+++ b/t/t5515/fetch.br-remote-glob-octopus_remote-glob
@@ -2,7 +2,7 @@
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	branch 'master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689		branch 'one' of ../
 0567da4d5edd2ff4bb292a465ba9e64dcad9536b	not-for-merge	branch 'three' of ../
-6134ee8f857693b96ff1cc98d3e2fd62b199e5a8	not-for-merge	branch 'two' of ../
+6134ee8f857693b96ff1cc98d3e2fd62b199e5a8		branch 'two' of ../
 754b754407bf032e9a2f9d5a9ad05ca79a6b228f	not-for-merge	tag 'tag-master' of ../
 8e32a6d901327a23ef831511badce7bf3bf46689	not-for-merge	tag 'tag-one' of ../
 22feea448b023a2d864ef94b013735af34d238ba	not-for-merge	tag 'tag-one-tree' of ../
-- 
1.5.2.2.1600.ga4e5
