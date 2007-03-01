From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: [PATCH/RFC] statplot: a tool for mining repository statistics.
Date: Thu, 1 Mar 2007 02:29:53 -0500
Message-ID: <20070301072953.GA8730@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 08:30:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMfjk-0002Dk-WB
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 08:30:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933077AbXCAH37 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 02:29:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933040AbXCAH37
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 02:29:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:51130 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933077AbXCAH36 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 02:29:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HMfjf-0007Rk-M5; Thu, 01 Mar 2007 02:29:56 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0AAFC20FBAE; Thu,  1 Mar 2007 02:29:53 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41042>

This is a simple program to dump statistics about number of objects
per day, and how much disk space is used per day.  It can be used
to generate data files suitable for plotting repository growth
over time.

This program avoids displaying information about tags, but it does
cover the commits referenced by those tags.  Since annotated tags
are a very small portion of most projects I don't consider this to
be a major issue at this time.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---

 This is on top of Nico's cleanups that are currently in next,
 as I'm using the newer read_sha1_file interface.  Otherwise it
 has no dependencies on stuff in next.

 I am normally very anti-self-linking, but I have posted graphs from
 git.git and linux-2.6.git on my website if people are interested,
 so I'm self-linking:

   http://www.spearce.org/2007/03/git-and-linux-repository-growth.html

 I figured a link in email would be better than an attachment.  ;-)

 This is a toy, but its more than good enough for production, so uh,
 here it is.  Should it be included in git.git?  Don't know....

 .gitignore                     |    1 +
 Documentation/git-statplot.txt |   63 ++++++++
 Makefile                       |    1 +
 builtin-statplot.c             |  318 ++++++++++++++++++++++++++++++++++++++++
 builtin.h                      |    1 +
 git.c                          |    1 +
 6 files changed, 385 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-statplot.txt
 create mode 100644 builtin-statplot.c

diff --git a/.gitignore b/.gitignore
index 0eaba0a..4c73efb 100644
--- a/.gitignore
+++ b/.gitignore
@@ -119,6 +119,7 @@ git-ssh-fetch
 git-ssh-pull
 git-ssh-push
 git-ssh-upload
+git-statplot
 git-status
 git-stripspace
 git-svn
diff --git a/Documentation/git-statplot.txt b/Documentation/git-statplot.txt
new file mode 100644
index 0000000..77dd0d4
--- /dev/null
+++ b/Documentation/git-statplot.txt
@@ -0,0 +1,63 @@
+git-statplot(1)
+=========
+
+NAME
+----
+git-statplot - Generate repository statistics for plotting
+
+
+SYNOPSIS
+--------
+'git-statplot' [<commit-ish>*] >repo.dat
+
+DESCRIPTION
+-----------
+Scans all current packs and all reachable objects (optionally
+starting from <object>* rather than all refs) and determines the
+earliest date that each object was referenced by a commit.
+
+For each date, the number of new commits, number of new objects,
+and total bytes used within the packfile are reported to standard
+output.  The output format is suitable for plotting with Gnuplot,
+or any number of other popular plotting and analysis tools.
+
+A sample output follows, taken from the early days of git's own
+history:
+
+....
+	# Total days:    2
+	# Total commits: 5
+	# Date range: ["2005-04-06":"2005-04-07"]
+	# <date> <new_commits> <new_trees> <new_blobs> <new_objects> <new_bytes>
+	2005-04-06 2 2 19 23 8219
+	2005-04-07 3 3 11 17 4742
+....
+
+Here we see that during Git's first day developers created 23 objects
+(2 commits, 2 trees, 19 blobs), and these objects currently occupy
+8,219 bytes of disk space.
+
+During the second day an additional 17 objects and these objects
+currently occupy 4,742 bytes of disk space.
+
+Notes
+-----
+This program only examines packed objects.  If unpacked objects
+are reachable from the input arguments these will not be counted in
+the output.  Running only on a fully packed repository is suggested.
+
+Commit counts, object counts and bytes can vary between runs
+for several reasons.  One cause of this change can be merging of
+long-lived branches. The merged commits will count on the day they
+were committed, not on the day they arrived in this repository.
+Another cause can be from repacking with the -f option, as deltas
+may be recomputed and recompressed, possibly altering the amount
+of space used by an object.
+
+Author
+------
+Written by Shawn O. Pearce <spearce@spearce.org>
+
+GIT
+---
+Part of the gitlink:git[7] suite
diff --git a/Makefile b/Makefile
index e4bb865..83da7fd 100644
--- a/Makefile
+++ b/Makefile
@@ -317,6 +317,7 @@ BUILTIN_OBJS = \
 	builtin-runstatus.o \
 	builtin-shortlog.o \
 	builtin-show-branch.o \
+	builtin-statplot.o \
 	builtin-stripspace.o \
 	builtin-symbolic-ref.o \
 	builtin-tar-tree.o \
diff --git a/builtin-statplot.c b/builtin-statplot.c
new file mode 100644
index 0000000..7f5323f
--- /dev/null
+++ b/builtin-statplot.c
@@ -0,0 +1,318 @@
+/*
+ * Computes the earliest commit that can reach each object, then
+ * summarizes this for each day found within the commit history.
+ *
+ * Produces a datafile to stdout suitable for Gnuplot.
+ */
+#include "cache.h"
+#include "commit.h"
+#include "refs.h"
+#include "pack.h"
+#include "tree-walk.h"
+
+#define SEEN      (1u<<0)
+
+struct packed_object {
+	unsigned char sha1[20];
+	unsigned int packed_bytes;
+	unsigned int type : 2;
+	unsigned int date : 30;
+};
+
+struct days_total {
+	unsigned long packed_bytes;
+	unsigned long new_objects[4];
+};
+
+static const unsigned long one_day = 24 * 60 * 60;
+static struct commit **all_commits;
+static struct packed_object *all_objs;
+static unsigned long nr_commits;
+static unsigned long max_commits;
+static unsigned long nr_objects;
+static unsigned long nr_unpacked;
+static unsigned int earliest_date;
+static unsigned int latest_date;
+
+static int sort_by_sha1(const void *a_, const void *b_)
+{
+	const struct packed_object *a = a_;
+	const struct packed_object *b = b_;
+	return hashcmp(a->sha1, b->sha1);
+}
+
+static int sort_by_offset(const void *a_, const void *b_)
+{
+	const struct packed_object *a = a_;
+	const struct packed_object *b = b_;
+	if (a->packed_bytes < b->packed_bytes)
+		return -1;
+	else if (a->packed_bytes > b->packed_bytes)
+		return 1;
+	return 0;
+}
+
+static void index_one_pack(struct packed_git *p)
+{
+	int i, num = num_packed_objects(p);
+	unsigned long s = nr_objects;
+	struct packed_object *o, *last;
+
+	if (num < 1)
+		return;
+
+	nr_objects += num;
+	all_objs = xrealloc(all_objs, nr_objects * sizeof(*all_objs));
+	for (i = 0, o = all_objs + s; i < num; i++, o++) {
+		nth_packed_object_sha1(p, i, o->sha1);
+		o->packed_bytes = find_pack_entry_one(o->sha1, p);
+		o->type = 0;
+		o->date = 0;
+	}
+
+	qsort(all_objs + s, num, sizeof(*all_objs), sort_by_offset);
+
+	last = all_objs + s;
+	for (i = 1, o = last + 1; i < num; i++, o++) {
+		last->packed_bytes = o->packed_bytes - last->packed_bytes;
+		last = o;
+	}
+	last->packed_bytes = p->pack_size - last->packed_bytes - 32;
+}
+
+static void scan_commit(struct commit *commit)
+{
+	if (!commit || commit->object.flags & SEEN)
+		return;
+
+	parse_commit(commit);
+	commit->object.flags |= SEEN;
+
+	if (nr_commits == max_commits) {
+		max_commits *= 2;
+		if (max_commits < 1024)
+			max_commits = 1024;
+		all_commits = xrealloc(all_commits,
+			sizeof(*all_commits) * max_commits);
+	}
+	all_commits[nr_commits++] = commit;
+}
+
+static int stat_handle_reflog_ent(unsigned char *osha1,
+	unsigned char *nsha1,
+	const char *email,
+	unsigned long timestamp,
+	int tz,
+	const char *message,
+	void *cb_data)
+{
+	scan_commit(lookup_commit_reference_gently(nsha1, 1));
+	return 0;
+}
+
+static int stat_handle_reflog(const char *logname,
+	const unsigned char *sha1,
+	int flag,
+	void *cb_data)
+{
+	for_each_reflog_ent(logname, stat_handle_reflog_ent, NULL);
+	return 0;
+}
+
+static int stat_handle_ref(const char *refname,
+	const unsigned char *sha1,
+	int flag,
+	void *cb_data)
+{
+	scan_commit(lookup_commit_reference_gently(sha1, 1));
+	return 0;
+}
+
+static int sort_by_cdate(const void *a_, const void *b_)
+{
+	const struct commit *a = *((const struct commit**)a_);
+	const struct commit *b = *((const struct commit**)b_);
+	if (a->date < b->date)
+		return -1;
+	else if (a->date > b->date)
+		return 1;
+	return 0;
+}
+
+static void list_all_commits()
+{
+	unsigned long i;
+
+	for (i = 0; i < nr_commits; i++) {
+		struct commit_list *parents = all_commits[i]->parents;
+		while (parents) {
+			scan_commit(parents->item);
+			parents = parents->next;
+		}
+	}
+
+	qsort(all_commits, nr_commits, sizeof(*all_commits), sort_by_cdate);
+}
+
+static struct packed_object* find_one(const unsigned char *sha1)
+{
+	unsigned long hi = nr_objects;
+	unsigned long lo = 0;
+	do {
+		unsigned long mi = (lo + hi) / 2;
+		int cmp = hashcmp(all_objs[mi].sha1, sha1);
+		if (!cmp)
+			return all_objs + mi;
+		if (cmp > 0)
+			hi = mi;
+		else
+			lo = mi + 1;
+	} while (lo < hi);
+	return NULL;
+}
+
+static int mark_one(
+	const unsigned char *sha1,
+	unsigned int date,
+	enum object_type type)
+{
+	struct packed_object *obj = find_one(sha1);
+	if (!obj) {
+		nr_unpacked++;
+		return 1;
+	}
+	if (obj->type)
+		return 1;
+	obj->date = date;
+	obj->type = type;
+	return 0;
+}
+
+static void mark_tree(const unsigned char *sha1, unsigned int date)
+{
+	struct tree_desc desc;
+	struct name_entry name_entry;
+	enum object_type type;
+	void *buf;
+
+	if (mark_one(sha1, date, OBJ_TREE))
+		return;
+
+	buf = read_sha1_file(sha1, &type, &desc.size);
+	if (!buf || type != OBJ_TREE)
+		die("missing/corrupt tree object %s", sha1_to_hex(sha1));
+	desc.buf = buf;
+	while (tree_entry(&desc, &name_entry)) {
+		if (S_ISDIR(name_entry.mode))
+			mark_tree(name_entry.sha1, date);
+		else
+			mark_one(name_entry.sha1, date, OBJ_BLOB);
+	}
+	free(buf);
+}
+
+static void compute_earliest_dates()
+{
+	unsigned long i;
+
+	if (!nr_commits)
+		die("No commits?");
+
+	for (i = 0; i < nr_commits; i++) {
+		struct commit *commit = all_commits[i];
+		unsigned int day = commit->date / one_day;
+		mark_one(commit->object.sha1, day, OBJ_COMMIT);
+		mark_tree(commit->tree->object.sha1, day);
+	}
+
+	earliest_date = all_commits[0]->date / one_day;
+	latest_date = all_commits[nr_commits - 1]->date / one_day;
+}
+
+static void print_yyyymmdd(unsigned int day)
+{
+	time_t date = day * one_day;
+	struct tm *when = localtime(&date);
+	printf("%4.4i-%2.2i-%2.2i",
+		when->tm_year + 1900,
+		when->tm_mon + 1,
+		when->tm_mday);
+}
+
+static void compute_date_buckets()
+{
+	unsigned long days = latest_date - earliest_date + 1;
+	unsigned long i;
+	struct days_total *totals;
+	struct packed_object *o;
+
+	totals = xcalloc(days, sizeof(*totals));
+	for (i = 0, o = all_objs; i < nr_objects; i++, o++) {
+		if (o->date) {
+			struct days_total* t = &totals[o->date - earliest_date];
+			t->packed_bytes += o->packed_bytes;
+			t->new_objects[OBJ_NONE]++;
+			t->new_objects[o->type]++;
+		}
+	}
+
+	printf("# Total days:    %lu\n", days);
+	printf("# Total commits: %lu\n", nr_commits);
+	printf("# Date range: [\"");
+	print_yyyymmdd(earliest_date);
+	printf("\":\"");
+	print_yyyymmdd(latest_date);
+	printf("\"]\n");
+
+	printf("# <date> <new_commits> <new_trees> <new_blobs>"
+		" <new_objects> <new_bytes>\n");
+	for (i = 0; i < days; i++) {
+		print_yyyymmdd(earliest_date + i);
+		printf(" %lu %lu %lu %lu %lu\n",
+			totals[i].new_objects[OBJ_COMMIT],
+			totals[i].new_objects[OBJ_TREE],
+			totals[i].new_objects[OBJ_BLOB],
+			totals[i].new_objects[OBJ_NONE],
+			totals[i].packed_bytes);
+	}
+
+	free(totals);
+}
+
+int cmd_statplot(int argc, char **argv, const char *prefix)
+{
+	int i;
+	struct packed_git *p;
+
+	for (i = 1; i < argc; i++) {
+		const char *arg = argv[i];
+		unsigned char head_sha1[20];
+
+		if (*arg == '-')
+			continue;
+		else if (!get_sha1(arg, head_sha1))
+			scan_commit(lookup_commit_reference(head_sha1));
+		else
+			error("invalid parameter: expected sha1, got '%s'", arg);
+	}
+
+	if (!nr_commits) {
+		for_each_ref(stat_handle_ref, NULL);
+		for_each_reflog(stat_handle_reflog, NULL);
+	}
+
+	prepare_packed_git();
+	for (p = packed_git; p; p = p->next)
+		index_one_pack(p);
+	qsort(all_objs, nr_objects, sizeof(*all_objs), sort_by_sha1);
+
+	list_all_commits();
+	compute_earliest_dates();
+	compute_date_buckets();
+
+	if (nr_unpacked)
+		warn("%lu unpacked objects were not included in output.\n",
+			nr_unpacked);
+
+	return 0;
+}
diff --git a/builtin.h b/builtin.h
index 48d68c8..8a6ee95 100644
--- a/builtin.h
+++ b/builtin.h
@@ -66,6 +66,7 @@ extern int cmd_runstatus(int argc, const char **argv, const char *prefix);
 extern int cmd_shortlog(int argc, const char **argv, const char *prefix);
 extern int cmd_show(int argc, const char **argv, const char *prefix);
 extern int cmd_show_branch(int argc, const char **argv, const char *prefix);
+extern int cmd_statplot(int argc, const char **argv, const char *prefix);
 extern int cmd_stripspace(int argc, const char **argv, const char *prefix);
 extern int cmd_symbolic_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_tar_tree(int argc, const char **argv, const char *prefix);
diff --git a/git.c b/git.c
index 008e016..994f22e 100644
--- a/git.c
+++ b/git.c
@@ -278,6 +278,7 @@ static void handle_internal_command(int argc, const char **argv, char **envp)
 		{ "shortlog", cmd_shortlog, RUN_SETUP | USE_PAGER },
 		{ "show-branch", cmd_show_branch, RUN_SETUP },
 		{ "show", cmd_show, RUN_SETUP | USE_PAGER },
+		{ "statplot", cmd_statplot, RUN_SETUP },
 		{ "stripspace", cmd_stripspace },
 		{ "symbolic-ref", cmd_symbolic_ref, RUN_SETUP },
 		{ "tar-tree", cmd_tar_tree },
-- 
1.5.0.2.809.g0f936
