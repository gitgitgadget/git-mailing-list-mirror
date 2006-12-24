From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [RFC/PATCH] Enhance git-reflog with 'show' subcommand.
Date: Sun, 24 Dec 2006 05:02:15 -0500
Message-ID: <20061224100215.GA25522@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 24 11:02:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyQBg-0003uT-0V
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 11:02:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750849AbWLXKCV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 05:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750844AbWLXKCV
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 05:02:21 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60466 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750804AbWLXKCU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 05:02:20 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GyQBM-0005y3-El; Sun, 24 Dec 2006 05:02:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BFC0620FB65; Sun, 24 Dec 2006 05:02:16 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35353>

We now have a 'show' subcommand to 'git reflog' which dumps out the
contents of the reflog for each ref supplied on the command line,
or 'HEAD' if no ref is supplied.

Entries from the reflogs are sorted by reverse timestamp and then
by reverse order of appearance within the reflog.  This replicates
the behavior of 'git log' where newer commits are shown first and
commits are ordered by timestamp when multiple refs are specified
on the command line.

Points in time in the reflog where a non-linear change occurred
(due to for example a rebase, reset or amend) are highlighed by
inserting 'R' in the first column of every line associated with
that log entry.

For example:

  $ git reflog show sp/reflog-show
    ref sp/reflog-show@{0}
    commit 87d8af1.. -> f8ef360..
    User: Shawn O. Pearce <spearce@spearce.org>
    Date: Sun Dec 24 04:39:36 2006 -0500

      commit: Enhance git-reflog with 'show' subcommand.

  R ref sp/reflog-show@{1}
  R commit 57e846c.. -> 87d8af1..
  R User: Shawn O. Pearce <spearce@spearce.org>
  R Date: Sun Dec 24 00:49:47 2006 -0500
  R
  R   reset --soft
  R   to "fix macos x build"

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is an updated version of my earlier '[RFC] git reflog show'
 patch.  Lots of bugs have been fixed, I removed the totally
 unnecessary need for qsort(), and refs can now be supplied in
 shorthand format just like with 'git log'.

 One of the _really_ ugly parts of this patch is the duplication
 of the fmt table from sha1_refs.c.  The shorthand ref -> full ref
 name code should be refactored out first.  I'm being lazy and not
 doing it right now.  :-)

 I have taken Junio's suggestion of making non-linear changes stand
 out more by placing 'R' in the first column of every relevant line
 in the log, this visually stands out pretty good without applying
 any coloring.  Coloring would be nice for people who do that sort
 of thing.  ;-)

 Earlier Junio had suggested that the reflog display should use some
 form of graphical (albeit text mode) representation to indicate
 how entries relate to each other within the reflog.  I'm not sure
 that's possible when you get into complex logs where resets and
 rebases happen frequently.  I for one am not sure how I would
 draw some logs.

 builtin-reflog.c |  269 +++++++++++++++++++++++++++++++++++++++++++++++++++++-
 git.c            |    2 +-
 2 files changed, 269 insertions(+), 2 deletions(-)

diff --git a/builtin-reflog.c b/builtin-reflog.c
index de31967..6ee7fd3 100644
--- a/builtin-reflog.c
+++ b/builtin-reflog.c
@@ -198,8 +198,273 @@ static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
 	return status;
 }
 
+struct cmd_reflog_list_ref {
+	struct cmd_reflog_list_ref *next;
+	struct cmd_reflog_list_ent *entries;
+	const char *name;
+	unsigned int ent_cnt;
+};
+
+struct cmd_reflog_list_ent {
+	struct cmd_reflog_list_ent *next;
+	struct commit *old;
+	struct commit *new;
+	char *cmd;
+	char *user;
+	unsigned long timestamp;
+	int tz;
+	unsigned int pos;
+	unsigned linear:1;
+	unsigned char old_sha1[20];
+	unsigned char new_sha1[20];
+};
+
+struct cmd_reflog_list_cb {
+	struct cmd_reflog_list_ref *refs;
+	struct cmd_reflog_list_ref *cur_ref;
+	unsigned include_linear_commits:1;
+};
+
+static int list_reflog_ent(unsigned char *osha1, unsigned char *nsha1,
+		char *data, void *cb_data)
+{
+	struct cmd_reflog_list_cb *cb = cb_data;
+	struct cmd_reflog_list_ref *cur_ref = cb->cur_ref;
+	struct cmd_reflog_list_ent *e;
+	struct commit *old, *new;
+	unsigned long timestamp;
+	int tz;
+	char *user_end, *cp, *ep;
+
+	cur_ref->ent_cnt++;
+	cp = strchr(data, '>');
+	if (!cp || *++cp != ' ')
+		return 0; /* corrupt line? */
+	user_end = cp;
+	timestamp = strtoul(cp, &ep, 10);
+	if (*ep++ != ' ')
+		return 0; /* corrupt line? */
+	tz = strtol(ep, &cp, 10);
+	if (*cp++ != '\t')
+		return 0; /* corrupt line? */
+	while (isspace(*cp))
+		cp++;
+
+	if (is_null_sha1(osha1))
+		old = NULL;
+	else
+		old = lookup_commit_reference_gently(osha1, 1);
+
+	if (is_null_sha1(nsha1))
+		new = NULL;
+	else
+		new = lookup_commit_reference_gently(nsha1, 1);
+
+	if (!cb->include_linear_commits
+		&& old && new && new->parents
+		&& new->parents->item == old
+		&& !new->parents->next
+		&& cur_ref->entries && cur_ref->entries->new == old
+		&& (!strncmp(cp, "commit", 6) || !strncmp(cp, "am: ", 4)))
+		return 0;
+
+	e = xmalloc(sizeof(*e));
+	e->cmd = xstrdup(cp);
+	cp = strrchr(e->cmd, '\n');
+	if (cp)
+		*cp = 0;
+	if (*e->cmd) {
+		cp = e->cmd + strlen(e->cmd) - 1;
+		while (isspace(*cp))
+			*cp-- = 0;
+	}
+	e->user = xmalloc(user_end - data + 1);
+	strncpy(e->user, data, user_end - data);
+	e->user[user_end - data] = 0;
+	e->timestamp = timestamp;
+	e->tz = tz;
+	e->pos = cur_ref->ent_cnt - 1;
+	e->old = old;
+	e->new = new;
+	hashcpy(e->old_sha1, osha1);
+	hashcpy(e->new_sha1, nsha1);
+
+	if (new && cur_ref->entries && cur_ref->entries->new)
+		e->linear = in_merge_bases(cur_ref->entries->new, new);
+	else if (!e->pos)
+		e->linear = 1;
+	else
+		e->linear = 0;
+
+	e->next = cur_ref->entries;
+	cur_ref->entries = e;
+	return 0;
+}
+
+static int list_reflog(const char *ref, const unsigned char *sha1,
+		int unused, void *cb_data)
+{
+	struct cmd_reflog_list_cb *cb = cb_data;
+
+	cb->cur_ref = xmalloc(sizeof(*cb->cur_ref));
+	cb->cur_ref->name = xstrdup(ref);
+	cb->cur_ref->ent_cnt = 0;
+	cb->cur_ref->entries = NULL;
+	cb->cur_ref->next = cb->refs;
+	cb->refs = cb->cur_ref;
+
+	for_each_reflog_ent(ref, list_reflog_ent, cb);
+	return 0;
+}
+
+static void reflog_show_pfx(struct cmd_reflog_list_ent *e)
+{
+	printf("%c ", e->linear ? ' ' : 'R');
+}
+
+static void reflog_show_cmtid(int abbrev,
+	unsigned char *sha1,
+	struct commit *cmt)
+{
+	if (cmt)
+		printf("%s..", find_unique_abbrev(sha1, abbrev));
+	else if (!is_null_sha1(sha1))
+		printf("%s (missing)", sha1_to_hex(sha1));
+	else
+		printf("deleted");
+}
+
+static void reflog_show(int abbrev,
+	struct cmd_reflog_list_ref *ref,
+	struct cmd_reflog_list_ent *e)
+{
+	const char *name = ref->name;
+	if (!strncmp("refs/tags/", name, 10))
+		name += 10;
+	else if (!strncmp("refs/heads/", name, 11))
+		name += 11;
+	else if (!strncmp("refs/remotes/", name, 13))
+		name += 13;
+
+	reflog_show_pfx(e);
+	printf("ref %s@{%u}\n", name, ref->ent_cnt - e->pos - 1);
+
+	reflog_show_pfx(e);
+	printf("commit ");
+	reflog_show_cmtid(abbrev, e->old_sha1, e->old);
+	printf(" -> ");
+	reflog_show_cmtid(abbrev, e->new_sha1, e->new);
+	printf("\n");
+
+	reflog_show_pfx(e);
+	printf("User: %s\n", e->user);
+
+	reflog_show_pfx(e);
+	printf("Date: %s\n", show_date(e->timestamp, e->tz, 0));
+
+	reflog_show_pfx(e);
+	printf("\n");
+
+	reflog_show_pfx(e);
+	printf("  %s\n", e->cmd);
+
+	/* Historically some commands have not logged very much detail.
+	 * We should dump out the oneline of the new commit to help.
+	 */
+	if (e->new && (!strcmp(e->cmd, "reset --hard")
+		|| !strcmp(e->cmd, "reset --soft")
+		|| !strncmp(e->cmd, "fetch ", 6)
+		|| !strncmp(e->cmd, "merge ", 6)
+		|| !strncmp(e->cmd, "pull ", 5))) {
+		char subject[256];
+		pretty_print_commit(CMIT_FMT_ONELINE, e->new, ~0,
+			subject, sizeof(subject), 0,
+			NULL, NULL, 0);
+		reflog_show_pfx(e);
+		printf("  to \"%s\"\n", subject);
+	}
+
+	printf("\n");
+}
+
+static const char reflog_show_usage[] =
+"git-reflog show [--all|<refs>...]";
+
+static int cmd_reflog_show(int argc, const char **argv, const char *prefix)
+{
+	struct cmd_reflog_list_cb cb;
+	unsigned char sha1[20];
+	int i, do_all = 0, status = 0;
+
+	cb.refs = NULL;
+	cb.cur_ref = NULL;
+	cb.include_linear_commits = 1;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		if (!strcmp(arg, "--all"))
+			do_all = 1;
+		else if (!strcmp(arg, "--no-commits"))
+			cb.include_linear_commits = 0;
+		else if (arg[0] == '-')
+			usage(reflog_show_usage);
+		else
+			break;
+	}
+	if (do_all)
+		status |= for_each_ref(list_reflog, &cb);
+	if (i == argc) {
+		const char *ref = resolve_ref("HEAD", sha1, 1, NULL);
+		if (ref)
+			status |= list_reflog(ref, sha1, 0, &cb);
+		else
+			status |= error("no such ref: HEAD");
+	}
+	while (i < argc) {
+		static const char *fmt[] = {
+			"%.*s",
+			"refs/%.*s",
+			"refs/tags/%.*s",
+			"refs/heads/%.*s",
+			"refs/remotes/%.*s",
+			"refs/remotes/%.*s/HEAD",
+			NULL
+		};
+		const char *arg = argv[i++], **p;
+		for (p = fmt; *p; p++) {
+			const char *ref = mkpath(*p, strlen(arg), arg);
+			ref = resolve_ref(ref, sha1, 1, NULL);
+			if (ref) {
+				status |= list_reflog(ref, sha1, 0, &cb);
+				break;
+			}
+		}
+		if (!*p)
+			status |= error("no such ref: %s", arg);
+	}
+
+	for (;;) {
+		struct cmd_reflog_list_ref *r, *min_r = NULL;
+		struct cmd_reflog_list_ent *e;
+		for (r = cb.refs; r; r = r->next) {
+			if (!r->entries)
+				continue;
+			if (!min_r
+				|| r->entries->timestamp > min_r->entries->timestamp)
+				min_r = r;
+		}
+		if (!min_r)
+			break;
+		e = min_r->entries;
+		min_r->entries = e->next;
+		reflog_show(DEFAULT_ABBREV, min_r, e);
+	}
+
+	return status;
+}
+
 static const char reflog_usage[] =
-"git-reflog (expire | ...)";
+"git-reflog (expire | show | ...)";
 
 int cmd_reflog(int argc, const char **argv, const char *prefix)
 {
@@ -207,6 +472,8 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
 		usage(reflog_usage);
 	else if (!strcmp(argv[1], "expire"))
 		return cmd_reflog_expire(argc - 1, argv + 1, prefix);
+	else if (!strcmp(argv[1], "show"))
+		return cmd_reflog_show(argc - 1, argv + 1, prefix);
 	else
 		usage(reflog_usage);
 }
diff --git a/git.c b/git.c
index 50ebd86..27bbc75 100644
--- a/git.c
+++ b/git.c
@@ -246,7 +246,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "prune-packed", cmd_prune_packed, RUN_SETUP },
 		{ "push", cmd_push, RUN_SETUP },
 		{ "read-tree", cmd_read_tree, RUN_SETUP },
-		{ "reflog", cmd_reflog, RUN_SETUP },
+		{ "reflog", cmd_reflog, RUN_SETUP | USE_PAGER },
 		{ "repo-config", cmd_repo_config },
 		{ "rerere", cmd_rerere, RUN_SETUP },
 		{ "rev-list", cmd_rev_list, RUN_SETUP },
-- 
1.4.4.3.g389e
