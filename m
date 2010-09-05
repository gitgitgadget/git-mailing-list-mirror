From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [demo/PATCH 3/3] Make initialization of string_lists more
 consistent
Date: Sun, 5 Sep 2010 15:08:33 -0500
Message-ID: <20100905200833.GD14497@burratino>
References: <1283709077-5438-1-git-send-email-tfransosi@gmail.com>
 <20100905200323.GA14497@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 05 22:10:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsLXv-0005gW-Ly
	for gcvg-git-2@lo.gmane.org; Sun, 05 Sep 2010 22:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754510Ab0IEUKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 16:10:30 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:45764 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754459Ab0IEUK3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 16:10:29 -0400
Received: by iwn5 with SMTP id 5so3529204iwn.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 13:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=c0W2zm91XC79vSFl3DZ30MVQ/W/L+OF1PpdRwGurcqY=;
        b=SQlEZZgoEDvpNs1Xygb2JcU5k9TsxwhKZ4eaR71w4ADa6lVKqmYXMCYAatWfMyVdEM
         e8+XCwio5gDhkqXLNpx08U4oxuQZqUPTXTnGKbYGqYNgLydHyhBs5AWBOOa/CuUpC2FL
         8aoHGxbX5jBFK3lmfBm7j1hljkefAM/4O3LYo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bUBpdyckNhLB4XrX/ulTgJMu6DOYqyFO/SV/O6jdhKd2V1CgKAbvT4LbidVzt92BGX
         fHjbpwexQFIOk5XVCCC1vsBmloziGJ3UNtTe7UkKseHX4kr7RvW9+0tve7A2mFtfTtRB
         AqoOTDURptS+X5ZXs5gHS10Ks50encIhZcpSc=
Received: by 10.231.58.201 with SMTP id i9mr4929823ibh.98.1283717427609;
        Sun, 05 Sep 2010 13:10:27 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id g31sm4929942ibh.22.2010.09.05.13.10.26
        (version=SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 13:10:26 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100905200323.GA14497@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155483>

The strdup_strings member of a string_list should be constant
from when it is initialized until the string_list_clear() call,
or there can be memory leaks and double-free()ing.  Clarify
some calling conventions to ensure this.

Actually it might be even better to have a completely distinct
string_list_dup type, so the compiler could catch that kind of
error, but this patch doesn't do that.

Possible portability hazard: this casts function pointers in
weird ways.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
but not intended for application yet
---
 builtin/apply.c         |    8 ++++----
 builtin/blame.c         |    4 ++--
 builtin/clean.c         |    2 +-
 builtin/commit.c        |    4 ++--
 builtin/fetch.c         |   13 +++++--------
 builtin/fmt-merge-msg.c |   13 +++++++------
 builtin/log.c           |    9 +++------
 builtin/mailsplit.c     |    1 +
 builtin/notes.c         |    4 ++--
 builtin/remote.c        |   30 +++++++++++++++---------------
 builtin/shortlog.c      |   25 ++++++++++++++-----------
 diff-no-index.c         |    1 +
 mailmap.c               |   17 +++++++++++------
 mailmap.h               |    2 +-
 merge-recursive.c       |   16 +++++++++-------
 notes.c                 |    4 ++--
 pretty.c                |    5 +++--
 reflog-walk.c           |    1 +
 resolve-undo.c          |    8 ++++----
 revision.c              |    7 +++++--
 string-list.c           |   21 +++++++++++++++++----
 string-list.h           |    3 +++
 submodule.c             |    4 ++--
 wt-status.c             |    6 +++---
 24 files changed, 118 insertions(+), 90 deletions(-)

diff --git a/builtin/apply.c b/builtin/apply.c
index 23c18c5..e9f16ce 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -223,7 +223,7 @@ struct image {
  * the case where more than one patches touch the same file.
  */
 
-static struct string_list fn_table;
+static struct string_list fn_table = STRING_LIST_INIT_NODUP;
 
 static uint32_t hash_line(const char *cp, size_t len)
 {
@@ -3560,7 +3560,7 @@ static int write_out_results(struct patch *list, int skipped_patch)
 
 static struct lock_file lock_file;
 
-static struct string_list limit_by_name;
+static struct string_list limit_by_name = STRING_LIST_INIT_NODUP;
 static int has_include;
 static void add_name_limit(const char *name, int exclude)
 {
@@ -3635,8 +3635,8 @@ static int apply_patch(int fd, const char *filename, int options)
 	struct patch *list = NULL, **listp = &list;
 	int skipped_patch = 0;
 
-	/* FIXME - memory leak when using multiple patch files as inputs */
-	memset(&fn_table, 0, sizeof(struct string_list));
+	string_list_clear(&fn_table, 0);
+	string_list_init(&fn_table, 0);
 	patch_input_file = filename;
 	read_patch_file(&buf, fd);
 	offset = 0;
diff --git a/builtin/blame.c b/builtin/blame.c
index 1015354..bc89a48 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -45,7 +45,7 @@ static int xdl_opts;
 static enum date_mode blame_date_mode = DATE_ISO8601;
 static size_t blame_date_width;
 
-static struct string_list mailmap;
+static struct string_list mailmap = STRING_LIST_INIT_DUP;
 
 #ifndef DEBUG
 #define DEBUG 0
@@ -2498,7 +2498,7 @@ parse_done:
 	sb.ent = ent;
 	sb.path = path;
 
-	read_mailmap(&mailmap, NULL);
+	mailmap_read(&mailmap, NULL);
 
 	if (!incremental)
 		setup_pager();
diff --git a/builtin/clean.c b/builtin/clean.c
index b508d2c..c8798f5 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -44,7 +44,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 	struct dir_struct dir;
 	static const char **pathspec;
 	struct strbuf buf = STRBUF_INIT;
-	struct string_list exclude_list = { NULL, 0, 0, 0 };
+	struct string_list exclude_list = STRING_LIST_INIT_NODUP;
 	const char *qname;
 	char *seen = NULL;
 	struct option options[] = {
diff --git a/builtin/commit.c b/builtin/commit.c
index 66fdd22..ab9d974 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -205,6 +205,7 @@ static int list_paths(struct string_list *list, const char *with_tree,
 	int i;
 	char *m;
 
+	assert(list->strdup_strings);
 	for (i = 0; pattern[i]; i++)
 		;
 	m = xcalloc(1, i);
@@ -379,8 +380,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix, int
 	if (in_merge)
 		die("cannot do a partial commit during a merge.");
 
-	memset(&partial, 0, sizeof(partial));
-	partial.strdup_strings = 1;
+	string_list_init(&partial, 1);
 	if (list_paths(&partial, initial_commit ? NULL : "HEAD", prefix, pathspec))
 		exit(1);
 
diff --git a/builtin/fetch.c b/builtin/fetch.c
index fab3fce..9a1c46c 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -732,7 +732,7 @@ static int get_one_remote_for_fetch(struct remote *remote, void *priv)
 {
 	struct string_list *list = priv;
 	if (!remote->skip_default_update)
-		string_list_append(list, remote->name);
+		string_list_append_take_ownership(list, (char *) remote->name);
 	return 0;
 }
 
@@ -751,8 +751,8 @@ static int get_remote_group(const char *key, const char *value, void *priv)
 		int space = strcspn(value, " \t\n");
 		while (*value) {
 			if (space > 1) {
-				string_list_append(g->list,
-						   xstrndup(value, space));
+				string_list_append_take_ownership(
+					g->list, xstrndup(value, space));
 			}
 			value += space + (value[space] != '\0');
 			space = strcspn(value, " \t\n");
@@ -774,7 +774,7 @@ static int add_remote_or_group(const char *name, struct string_list *list)
 		if (!remote_is_configured(name))
 			return 0;
 		remote = remote_get(name);
-		string_list_append(list, remote->name);
+		string_list_append_take_ownership(list, (char *) remote->name);
 	}
 	return 1;
 }
@@ -877,7 +877,7 @@ static int fetch_one(struct remote *remote, int argc, const char **argv)
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	int i;
-	struct string_list list = STRING_LIST_INIT_NODUP;
+	struct string_list list = STRING_LIST_INIT_DUP;
 	struct remote *remote;
 	int result = 0;
 
@@ -921,9 +921,6 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		}
 	}
 
-	/* All names were strdup()ed or strndup()ed */
-	list.strdup_strings = 1;
 	string_list_clear(&list, 0);
-
 	return result;
 }
diff --git a/builtin/fmt-merge-msg.c b/builtin/fmt-merge-msg.c
index e7e12ee..621c074 100644
--- a/builtin/fmt-merge-msg.c
+++ b/builtin/fmt-merge-msg.c
@@ -30,12 +30,13 @@ struct src_data {
 	int head_status;
 };
 
-void init_src_data(struct src_data *data)
+static void init_src_data(struct src_data *data)
 {
-	data->branch.strdup_strings = 1;
-	data->tag.strdup_strings = 1;
-	data->r_branch.strdup_strings = 1;
-	data->generic.strdup_strings = 1;
+	string_list_init(&data->branch, 1);
+	string_list_init(&data->tag, 1);
+	string_list_init(&data->r_branch, 1);
+	string_list_init(&data->generic, 1);
+	data->head_status = 0;
 }
 
 static struct string_list srcs = STRING_LIST_INIT_DUP;
@@ -83,7 +84,7 @@ static int handle_line(char *line)
 	item = unsorted_string_list_lookup(&srcs, src);
 	if (!item) {
 		item = string_list_append(&srcs, src);
-		item->util = xcalloc(1, sizeof(struct src_data));
+		item->util = xmalloc(sizeof(struct src_data));
 		init_src_data(item->util);
 	}
 	src_data = item->util;
diff --git a/builtin/log.c b/builtin/log.c
index eaa1ee0..7e8f0e2 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -521,9 +521,9 @@ static int auto_number = 1;
 
 static char *default_attach = NULL;
 
-static struct string_list extra_hdr;
-static struct string_list extra_to;
-static struct string_list extra_cc;
+static struct string_list extra_hdr = STRING_LIST_INIT_DUP;
+static struct string_list extra_to = STRING_LIST_INIT_DUP;
+static struct string_list extra_cc = STRING_LIST_INIT_DUP;
 
 static void add_header(const char *value)
 {
@@ -1048,9 +1048,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 
-	extra_hdr.strdup_strings = 1;
-	extra_to.strdup_strings = 1;
-	extra_cc.strdup_strings = 1;
 	git_config(git_format_config, NULL);
 	init_revisions(&rev, prefix);
 	rev.commit_format = CMIT_FMT_EMAIL;
diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 99654d0..17f247b 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -108,6 +108,7 @@ static int populate_maildir_list(struct string_list *list, const char *path)
 	char *subs[] = { "cur", "new", NULL };
 	char **sub;
 
+	assert(list->strdup_strings);
 	for (sub = subs; *sub; ++sub) {
 		snprintf(name, sizeof(name), "%s/%s", path, *sub);
 		if ((dir = opendir(name)) == NULL) {
diff --git a/builtin/notes.c b/builtin/notes.c
index fbc347c..35e139f 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -363,8 +363,8 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewrite(const char *cmd)
 	c->cmd = cmd;
 	c->enabled = 1;
 	c->combine = combine_notes_concatenate;
-	c->refs = xcalloc(1, sizeof(struct string_list));
-	c->refs->strdup_strings = 1;
+	c->refs = xmalloc(sizeof(struct string_list));
+	string_list_init(c->refs, 1);
 	c->refs_from_env = 0;
 	c->mode_from_env = 0;
 	if (rewrite_mode_env) {
diff --git a/builtin/remote.c b/builtin/remote.c
index 48e0a6b..9ab36ed 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -230,7 +230,7 @@ struct branch_info {
 	int rebase;
 };
 
-static struct string_list branch_list;
+static struct string_list branch_list = STRING_LIST_INIT_NODUP;
 
 static const char *abbrev_ref(const char *name, const char *prefix)
 {
@@ -302,6 +302,10 @@ struct ref_states {
 	int queried;
 };
 
+#define REF_STATES_INIT { NULL, \
+	STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, STRING_LIST_INIT_DUP, \
+	STRING_LIST_INIT_DUP, 0 }
+
 static int get_ref_states(const struct ref *remote_refs, struct ref_states *states)
 {
 	struct ref *fetch_map = NULL, **tail = &fetch_map;
@@ -313,9 +317,9 @@ static int get_ref_states(const struct ref *remote_refs, struct ref_states *stat
 			die("Could not get fetch map for refspec %s",
 				states->remote->fetch_refspec[i]);
 
-	states->new.strdup_strings = 1;
-	states->tracked.strdup_strings = 1;
-	states->stale.strdup_strings = 1;
+	assert(states->new.strdup_strings);
+	assert(states->tracked.strdup_strings);
+	assert(states->stale.strdup_strings);
 	for (ref = fetch_map; ref; ref = ref->next) {
 		unsigned char sha1[20];
 		if (!ref->peer_ref || read_ref(ref->peer_ref->name, sha1))
@@ -366,7 +370,7 @@ static int get_push_ref_states(const struct ref *remote_refs,
 	match_refs(local_refs, &push_map, remote->push_refspec_nr,
 		   remote->push_refspec, MATCH_REFS_NONE);
 
-	states->push.strdup_strings = 1;
+	assert(states->push.strdup_strings);
 	for (ref = push_map; ref; ref = ref->next) {
 		struct string_list_item *item;
 		struct push_info *info;
@@ -409,7 +413,7 @@ static int get_push_ref_states_noquery(struct ref_states *states)
 	if (remote->mirror)
 		return 0;
 
-	states->push.strdup_strings = 1;
+	assert(states->push.strdup_strings);
 	if (!remote->push_refspec_nr) {
 		item = string_list_append(&states->push, "(matching)");
 		info = item->util = xcalloc(sizeof(struct push_info), 1);
@@ -442,7 +446,7 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
 	refspec.force = 0;
 	refspec.pattern = 1;
 	refspec.src = refspec.dst = "refs/heads/*";
-	states->heads.strdup_strings = 1;
+	assert(states->heads.strdup_strings);
 	get_fetch_map(remote_refs, &refspec, &fetch_map_tail, 0);
 	matches = guess_remote_head(find_ref_by_name(remote_refs, "HEAD"),
 				    fetch_map, 1);
@@ -1043,7 +1047,7 @@ static int show(int argc, const char **argv)
 		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),
 		OPT_END()
 	};
-	struct ref_states states;
+	struct ref_states states = REF_STATES_INIT;
 	struct string_list info_list = STRING_LIST_INIT_NODUP;
 	struct show_info info;
 
@@ -1056,7 +1060,6 @@ static int show(int argc, const char **argv)
 	if (!no_query)
 		query_flag = (GET_REF_STATES | GET_HEAD_NAMES | GET_PUSH_REF_STATES);
 
-	memset(&states, 0, sizeof(states));
 	memset(&info, 0, sizeof(info));
 	info.states = &states;
 	info.list = &info_list;
@@ -1158,8 +1161,7 @@ static int set_head(int argc, const char **argv)
 	if (!opt_a && !opt_d && argc == 2) {
 		head_name = xstrdup(argv[1]);
 	} else if (opt_a && !opt_d && argc == 1) {
-		struct ref_states states;
-		memset(&states, 0, sizeof(states));
+		struct ref_states states = REF_STATES_INIT;
 		get_remote_ref_states(argv[0], &states, GET_HEAD_NAMES);
 		if (!states.heads.nr)
 			result |= error("Cannot determine remote HEAD");
@@ -1219,12 +1221,11 @@ static int prune(int argc, const char **argv)
 static int prune_remote(const char *remote, int dry_run)
 {
 	int result = 0, i;
-	struct ref_states states;
+	struct ref_states states = REF_STATES_INIT;
 	const char *dangling_msg = dry_run
 		? " %s will become dangling!\n"
 		: " %s has become dangling!\n";
 
-	memset(&states, 0, sizeof(states));
 	get_remote_ref_states(remote, &states, GET_REF_STATES);
 
 	if (states.stale.nr) {
@@ -1483,10 +1484,9 @@ static int get_one_entry(struct remote *remote, void *priv)
 
 static int show_all(void)
 {
-	struct string_list list = STRING_LIST_INIT_NODUP;
+	struct string_list list = STRING_LIST_INIT_DUP;
 	int result;
 
-	list.strdup_strings = 1;
 	result = for_each_remote(get_one_entry, &list);
 
 	if (!result) {
diff --git a/builtin/shortlog.c b/builtin/shortlog.c
index 2135b0d..5843c0a 100644
--- a/builtin/shortlog.c
+++ b/builtin/shortlog.c
@@ -16,9 +16,9 @@ static char const * const shortlog_usage[] = {
 	NULL
 };
 
-static int compare_by_number(const void *a1, const void *a2)
+static int compare_by_number(const struct string_list_item *i1,
+			     const struct string_list_item *i2)
 {
-	const struct string_list_item *i1 = a1, *i2 = a2;
 	const struct string_list *l1 = i1->util, *l2 = i2->util;
 
 	if (l1->nr < l2->nr)
@@ -84,9 +84,12 @@ static void insert_one_record(struct shortlog *log,
 		snprintf(namebuf + len, room, " <%.*s>", maillen, emailbuf);
 	}
 
+	assert(log->list.strdup_strings);
 	item = string_list_insert(&log->list, namebuf);
-	if (item->util == NULL)
-		item->util = xcalloc(1, sizeof(struct string_list));
+	if (!item->util) {
+		item->util = xmalloc(sizeof(struct string_list));
+		string_list_init(item->util, 1);
+	}
 
 	/* Skip any leading whitespace, including any blank lines. */
 	while (*oneline && isspace(*oneline))
@@ -115,7 +118,7 @@ static void insert_one_record(struct shortlog *log,
 		}
 	}
 
-	string_list_append(item->util, buffer);
+	string_list_append_take_ownership(item->util, buffer);
 }
 
 static void read_from_stdin(struct shortlog *log)
@@ -236,10 +239,11 @@ static int parse_wrap_args(const struct option *opt, const char *arg, int unset)
 void shortlog_init(struct shortlog *log)
 {
 	memset(log, 0, sizeof(*log));
+	string_list_init(&log->list, 1);
+	string_list_init(&log->mailmap, 1);
 
-	read_mailmap(&log->mailmap, &log->common_repo_prefix);
+	mailmap_read(&log->mailmap, &log->common_repo_prefix);
 
-	log->list.strdup_strings = 1;
 	log->wrap = DEFAULT_WRAPLEN;
 	log->in1 = DEFAULT_INDENT1;
 	log->in2 = DEFAULT_INDENT2;
@@ -320,8 +324,7 @@ void shortlog_output(struct shortlog *log)
 	struct strbuf sb = STRBUF_INIT;
 
 	if (log->sort_by_number)
-		qsort(log->list.items, log->list.nr, sizeof(struct string_list_item),
-			compare_by_number);
+		sort_string_list_by(&log->list, compare_by_number);
 	for (i = 0; i < log->list.nr; i++) {
 		struct string_list *onelines = log->list.items[i].util;
 
@@ -343,14 +346,14 @@ void shortlog_output(struct shortlog *log)
 			putchar('\n');
 		}
 
-		onelines->strdup_strings = 1;
+		assert(onelines->strdup_strings);
 		string_list_clear(onelines, 0);
 		free(onelines);
 		log->list.items[i].util = NULL;
 	}
 
 	strbuf_release(&sb);
-	log->list.strdup_strings = 1;
+	assert(log->list.strdup_strings);
 	string_list_clear(&log->list, 1);
 	clear_mailmap(&log->mailmap);
 }
diff --git a/diff-no-index.c b/diff-no-index.c
index ce9e783..68da01a 100644
--- a/diff-no-index.c
+++ b/diff-no-index.c
@@ -24,6 +24,7 @@ static int read_directory(const char *path, struct string_list *list)
 	if (!(dir = opendir(path)))
 		return error("Could not open directory %s", path);
 
+	assert(list->strdup_strings);
 	while ((e = readdir(dir)))
 		if (strcmp(".", e->d_name) && strcmp("..", e->d_name))
 			string_list_insert(list, e->d_name);
diff --git a/mailmap.c b/mailmap.c
index f80b701..b7f2796 100644
--- a/mailmap.c
+++ b/mailmap.c
@@ -33,6 +33,12 @@ static void free_mailmap_info(void *p, const char *s)
 	free(mi->email);
 }
 
+static void init_mailmap_entry(struct mailmap_entry *p)
+{
+	p->name = p->email = NULL;
+	string_list_init(&p->namemap, 1);
+}
+
 static void free_mailmap_entry(void *p, const char *s)
 {
 	struct mailmap_entry *me = (struct mailmap_entry *)p;
@@ -41,7 +47,7 @@ static void free_mailmap_entry(void *p, const char *s)
 	free(me->name);
 	free(me->email);
 
-	me->namemap.strdup_strings = 1;
+	assert(me->namemap.strdup_strings);
 	string_list_clear_func(&me->namemap, free_mailmap_info);
 }
 
@@ -71,8 +77,7 @@ static void add_mapping(struct string_list *map,
 		/* create mailmap entry */
 		struct string_list_item *item = string_list_insert_at_index(map, index, old_email);
 		item->util = xmalloc(sizeof(struct mailmap_entry));
-		memset(item->util, 0, sizeof(struct mailmap_entry));
-		((struct mailmap_entry *)item->util)->namemap.strdup_strings = 1;
+		init_mailmap_entry((struct mailmap_entry *)item->util);
 	}
 	me = (struct mailmap_entry *)map->items[index].util;
 
@@ -170,9 +175,9 @@ static int read_single_mailmap(struct string_list *map, const char *filename, ch
 	return 0;
 }
 
-int read_mailmap(struct string_list *map, char **repo_abbrev)
+int mailmap_read(struct string_list *map, char **repo_abbrev)
 {
-	map->strdup_strings = 1;
+	assert(map->strdup_strings);
 	/* each failure returns 1, so >1 means both calls failed */
 	return read_single_mailmap(map, ".mailmap", repo_abbrev) +
 	       read_single_mailmap(map, git_mailmap_file, repo_abbrev) > 1;
@@ -181,7 +186,7 @@ int read_mailmap(struct string_list *map, char **repo_abbrev)
 void clear_mailmap(struct string_list *map)
 {
 	debug_mm("mailmap: clearing %d entries...\n", map->nr);
-	map->strdup_strings = 1;
+	assert(map->strdup_strings);
 	string_list_clear_func(map, free_mailmap_entry);
 	debug_mm("mailmap: cleared\n");
 }
diff --git a/mailmap.h b/mailmap.h
index d5c3664..f0b3861 100644
--- a/mailmap.h
+++ b/mailmap.h
@@ -1,7 +1,7 @@
 #ifndef MAILMAP_H
 #define MAILMAP_H
 
-int read_mailmap(struct string_list *map, char **repo_abbrev);
+int mailmap_read(struct string_list *map, char **repo_abbrev);
 void clear_mailmap(struct string_list *map);
 
 int map_user(struct string_list *mailmap,
diff --git a/merge-recursive.c b/merge-recursive.c
index 20e1779..7a44e25 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -232,6 +232,9 @@ static int save_files_dirs(const unsigned char *sha1,
 	memcpy(newpath + baselen, path, len);
 	newpath[baselen + len] = '\0';
 
+	assert(o->current_directory_set.strdup_strings);
+	assert(o->current_file_set.strdup_strings);
+
 	if (S_ISDIR(mode))
 		string_list_insert(&o->current_directory_set, newpath);
 	else
@@ -277,10 +280,10 @@ static struct stage_data *insert_stage_data(const char *path,
  */
 static struct string_list *get_unmerged(void)
 {
-	struct string_list *unmerged = xcalloc(1, sizeof(struct string_list));
+	struct string_list *unmerged = xmalloc(sizeof(struct string_list));
 	int i;
 
-	unmerged->strdup_strings = 1;
+	string_list_init(unmerged, 1);
 
 	for (i = 0; i < active_nr; i++) {
 		struct string_list_item *item;
@@ -327,7 +330,8 @@ static struct string_list *get_renames(struct merge_options *o,
 	struct string_list *renames;
 	struct diff_options opts;
 
-	renames = xcalloc(1, sizeof(struct string_list));
+	renames = xmalloc(sizeof(struct string_list));
+	string_list_init(renames, 0);
 	diff_setup(&opts);
 	DIFF_OPT_SET(&opts, RECURSIVE);
 	opts.detect_rename = DIFF_DETECT_RENAME;
@@ -1539,8 +1543,6 @@ void init_merge_options(struct merge_options *o)
 	if (o->verbosity >= 5)
 		o->buffer_output = 0;
 	strbuf_init(&o->obuf, 0);
-	memset(&o->current_file_set, 0, sizeof(struct string_list));
-	o->current_file_set.strdup_strings = 1;
-	memset(&o->current_directory_set, 0, sizeof(struct string_list));
-	o->current_directory_set.strdup_strings = 1;
+	string_list_init(&o->current_file_set, 1);
+	string_list_init(&o->current_directory_set, 1);
 }
diff --git a/notes.c b/notes.c
index 7fd2035..2ab0bb1 100644
--- a/notes.c
+++ b/notes.c
@@ -70,7 +70,7 @@ struct non_note {
 
 struct notes_tree default_notes_tree;
 
-static struct string_list display_notes_refs;
+static struct string_list display_notes_refs = STRING_LIST_INIT_DUP;
 static struct notes_tree **display_notes_trees;
 
 static void load_subtree(struct notes_tree *t, struct leaf_node *subtree,
@@ -958,8 +958,8 @@ void init_display_notes(struct display_notes_opt *opt)
 {
 	char *display_ref_env;
 	int load_config_refs = 0;
-	display_notes_refs.strdup_strings = 1;
 
+	assert(display_notes_refs.strdup_strings);
 	assert(!display_notes_trees);
 
 	if (!opt || !opt->suppress_default_notes) {
diff --git a/pretty.c b/pretty.c
index f85444b..89b37eb 100644
--- a/pretty.c
+++ b/pretty.c
@@ -434,8 +434,9 @@ static int mailmap_name(char *email, int email_len, char *name, int name_len)
 {
 	static struct string_list *mail_map;
 	if (!mail_map) {
-		mail_map = xcalloc(1, sizeof(*mail_map));
-		read_mailmap(mail_map, NULL);
+		mail_map = xmalloc(sizeof(*mail_map));
+		string_list_init(mail_map, 1);
+		mailmap_read(mail_map, NULL);
 	}
 	return mail_map->nr && map_user(mail_map, email, email_len, name, name_len);
 }
diff --git a/reflog-walk.c b/reflog-walk.c
index 4879615..a2ccdea 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -135,6 +135,7 @@ struct reflog_walk_info {
 void init_reflog_walk(struct reflog_walk_info** info)
 {
 	*info = xcalloc(sizeof(struct reflog_walk_info), 1);
+	string_list_init(&(*info)->complete_reflogs, 0);
 }
 
 int add_reflog_for_walk(struct reflog_walk_info *info,
diff --git a/resolve-undo.c b/resolve-undo.c
index 72b4612..6ba8538 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -15,8 +15,8 @@ void record_resolve_undo(struct index_state *istate, struct cache_entry *ce)
 		return;
 
 	if (!istate->resolve_undo) {
-		resolve_undo = xcalloc(1, sizeof(*resolve_undo));
-		resolve_undo->strdup_strings = 1;
+		resolve_undo = xmalloc(sizeof(*resolve_undo));
+		string_list_init(resolve_undo, 1);
 		istate->resolve_undo = resolve_undo;
 	}
 	resolve_undo = istate->resolve_undo;
@@ -56,8 +56,8 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
 	char *endptr;
 	int i;
 
-	resolve_undo = xcalloc(1, sizeof(*resolve_undo));
-	resolve_undo->strdup_strings = 1;
+	resolve_undo = xmalloc(sizeof(*resolve_undo));
+	string_list_init(resolve_undo, 1);
 
 	while (size) {
 		struct string_list_item *lost;
diff --git a/revision.c b/revision.c
index b1c1890..e18522c 100644
--- a/revision.c
+++ b/revision.c
@@ -1319,8 +1319,10 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		struct strbuf buf = STRBUF_INIT;
 		revs->show_notes = 1;
 		revs->show_notes_given = 1;
-		if (!revs->notes_opt.extra_notes_refs)
-			revs->notes_opt.extra_notes_refs = xcalloc(1, sizeof(struct string_list));
+		if (!revs->notes_opt.extra_notes_refs) {
+			revs->notes_opt.extra_notes_refs = xmalloc(sizeof(struct string_list));
+			string_list_init(revs->notes_opt.extra_notes_refs, 0);
+		}
 		if (!prefixcmp(arg+13, "refs/"))
 			/* happy */;
 		else if (!prefixcmp(arg+13, "notes/"))
@@ -1328,6 +1330,7 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		else
 			strbuf_addstr(&buf, "refs/notes/");
 		strbuf_addstr(&buf, arg+13);
+		/* NEEDSWORK: leak. */
 		string_list_append(revs->notes_opt.extra_notes_refs,
 				   strbuf_detach(&buf, NULL));
 	} else if (!strcmp(arg, "--no-notes")) {
diff --git a/string-list.c b/string-list.c
index 8e992a7..9684819 100644
--- a/string-list.c
+++ b/string-list.c
@@ -163,16 +163,29 @@ struct string_list_item *string_list_append(struct string_list *list, const char
 	return list->items + list->nr++;
 }
 
-static int cmp_items(const void *a, const void *b)
+struct string_list_item *string_list_append_take_ownership(struct string_list *list, char *string)
+{
+	assert(list->strdup_strings);
+	ALLOC_GROW(list->items, list->nr + 1, list->alloc);
+	list->items[list->nr].string = string;
+	return list->items + list->nr++;
+}
+
+
+static int cmp_items(const struct string_list_item *one, const struct string_list_item *two)
 {
-	const struct string_list_item *one = a;
-	const struct string_list_item *two = b;
 	return strcmp(one->string, two->string);
 }
 
 void sort_string_list(struct string_list *list)
 {
-	qsort(list->items, list->nr, sizeof(*list->items), cmp_items);
+	sort_string_list_by(list, cmp_items);
+}
+
+void sort_string_list_by(struct string_list *list, string_list_compare_func compare)
+{
+	qsort(list->items, list->nr, sizeof(*list->items),
+				(int(*)(const void *, const void *)) compare);
 }
 
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
diff --git a/string-list.h b/string-list.h
index 07e075c..d14f3e0 100644
--- a/string-list.h
+++ b/string-list.h
@@ -42,7 +42,10 @@ struct string_list_item *string_list_lookup(struct string_list *list, const char
 
 /* Use these functions only on unsorted lists: */
 struct string_list_item *string_list_append(struct string_list *list, const char *string);
+struct string_list_item *string_list_append_take_ownership(struct string_list *list, char *string);
 void sort_string_list(struct string_list *list);
+typedef int (*string_list_compare_func)(const struct string_list_item *a, const struct string_list_item *b);
+void sort_string_list_by(struct string_list *list, string_list_compare_func compare);
 int unsorted_string_list_has_string(struct string_list *list, const char *string);
 struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
 						     const char *string);
diff --git a/submodule.c b/submodule.c
index 91a4758..1c7ab8c 100644
--- a/submodule.c
+++ b/submodule.c
@@ -9,8 +9,8 @@
 #include "refs.h"
 #include "string-list.h"
 
-struct string_list config_name_for_path;
-struct string_list config_ignore_for_name;
+struct string_list config_name_for_path = STRING_LIST_INIT_NODUP;
+struct string_list config_ignore_for_name = STRING_LIST_INIT_NODUP;
 
 static int add_submodule_odb(const char *path)
 {
diff --git a/wt-status.c b/wt-status.c
index 54b6b03..0e137b8 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -44,9 +44,9 @@ void wt_status_prepare(struct wt_status *s)
 	s->reference = "HEAD";
 	s->fp = stdout;
 	s->index_file = get_index_file();
-	s->change.strdup_strings = 1;
-	s->untracked.strdup_strings = 1;
-	s->ignored.strdup_strings = 1;
+	string_list_init(&s->change, 1);
+	string_list_init(&s->untracked, 1);
+	string_list_init(&s->ignored, 1);
 }
 
 static void wt_status_print_unmerged_header(struct wt_status *s)
-- 
1.7.2.3
