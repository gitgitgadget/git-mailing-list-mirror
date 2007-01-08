From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 2/2] Teach the revision walker to walk by reflogs with
 --walk-reflogs
Date: Mon, 8 Jan 2007 02:02:50 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701080200090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Jan 08 02:03:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3iue-0006jg-K5
	for gcvg-git@gmane.org; Mon, 08 Jan 2007 02:02:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965281AbXAHBCx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 20:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965282AbXAHBCx
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 20:02:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:55709 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965281AbXAHBCw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 20:02:52 -0500
Received: (qmail invoked by alias); 08 Jan 2007 01:02:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp054) with SMTP; 08 Jan 2007 02:02:50 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36212>


When called with "--walk-reflogs", as long as there are reflogs
available, the walker will take this information into account, rather
than the parent information in the commit object.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---

	I do not have any idea if this will help bisecting through
	reflogs...

	Also, this is only lightly tested on the hard cases: circular 
	reflogs, ranges, and mixed logging (log overlapping reflogged and 
	non-reflogged revisions).

 Makefile      |    2 +-
 log-tree.c    |    3 +
 reflog-walk.c |  249 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 reflog-walk.h |   11 +++
 revision.c    |   11 +++
 revision.h    |    3 +
 6 files changed, 278 insertions(+), 1 deletions(-)

diff --git a/Makefile b/Makefile
index 80c2c65..8914842 100644
--- a/Makefile
+++ b/Makefile
@@ -251,7 +251,7 @@ LIB_OBJS = \
 	interpolate.o \
 	lockfile.o \
 	object.o pack-check.o patch-delta.o path.o pkt-line.o sideband.o \
-	reachable.o \
+	reachable.o reflog-walk.o \
 	quote.o read-cache.o refs.o run-command.o dir.o object-refs.o \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o config.o environment.o ctype.o copy.o \
diff --git a/log-tree.c b/log-tree.c
index 35be33a..f043ad3 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -2,6 +2,7 @@
 #include "diff.h"
 #include "commit.h"
 #include "log-tree.h"
+#include "reflog-walk.h"
 
 static void show_parents(struct commit *commit, int abbrev)
 {
@@ -223,6 +224,8 @@ void show_log(struct rev_info *opt, const char *sep)
 		printf("%s",
 		       diff_get_color(opt->diffopt.color_diff, DIFF_RESET));
 		putchar(opt->commit_format == CMIT_FMT_ONELINE ? ' ' : '\n');
+		if (opt->reflog_info)
+			show_reflog_message(opt->reflog_info);
 	}
 
 	/*
diff --git a/reflog-walk.c b/reflog-walk.c
new file mode 100644
index 0000000..23c19e9
--- /dev/null
+++ b/reflog-walk.c
@@ -0,0 +1,249 @@
+#include "cache.h"
+#include "commit.h"
+#include "refs.h"
+#include "diff.h"
+#include "revision.h"
+#include "path-list.h"
+
+struct complete_reflogs {
+	char *ref;
+	struct reflog_info {
+		unsigned char osha1[20], nsha1[20];
+		char *email;
+		unsigned long timestamp;
+		int tz;
+		char *message;
+	} *items;
+	int nr, alloc;
+};
+
+static int read_one_reflog(unsigned char *osha1, unsigned char *nsha1,
+		const char *email, unsigned long timestamp, int tz,
+		const char *message, void *cb_data)
+{
+	struct complete_reflogs *array = cb_data;
+	struct reflog_info *item;
+
+	if (array->nr >= array->alloc) {
+		array->alloc = alloc_nr(array->nr + 1);
+		array->items = xrealloc(array->items, array->alloc *
+			sizeof(struct reflog_info));
+	}
+	item = array->items + array->nr;
+	memcpy(item->osha1, osha1, 20);
+	memcpy(item->nsha1, nsha1, 20);
+	item->email = xstrdup(email);
+	item->timestamp = timestamp;
+	item->tz = tz;
+	item->message = xstrdup(message);
+	array->nr++;
+	return 0;
+}
+
+static struct complete_reflogs *read_complete_reflog(const char *ref)
+{
+	struct complete_reflogs *reflogs =
+		xcalloc(sizeof(struct complete_reflogs), 1);
+	reflogs->ref = xstrdup(ref);
+	for_each_reflog_ent(ref, read_one_reflog, reflogs);
+	if (reflogs->nr == 0) {
+		unsigned char sha1[20];
+		const char *name = resolve_ref(ref, sha1, 1, NULL);
+		if (name)
+			for_each_reflog_ent(name, read_one_reflog, reflogs);
+	}
+	if (reflogs->nr == 0) {
+		int len = strlen(ref);
+		char *refname = xmalloc(len + 12);
+		sprintf(refname, "refs/%s", ref);
+		for_each_reflog_ent(refname, read_one_reflog, reflogs);
+		if (reflogs->nr == 0) {
+			sprintf(refname, "refs/heads/%s", ref);
+			for_each_reflog_ent(refname, read_one_reflog, reflogs);
+		}
+		free(refname);
+	}
+	return reflogs;
+}
+
+static int get_reflog_recno_by_time(struct complete_reflogs *array,
+	unsigned long timestamp)
+{
+	int i;
+	for (i = array->nr - 1; i >= 0; i++)
+		if (timestamp >= array->items[i].timestamp)
+			return i;
+	return -1;
+}
+
+struct commit_info_lifo {
+	struct commit_info {
+		struct commit *commit;
+		void *util;
+	} *items;
+	int nr, alloc;
+};
+
+static struct commit_info *get_commit_info(struct commit *commit,
+		struct commit_info_lifo *lifo, int pop)
+{
+	int i;
+	for (i = 0; i < lifo->nr; i++)
+		if (lifo->items[i].commit == commit) {
+			struct commit_info *result = &lifo->items[i];
+			if (pop) {
+				if (i + 1 < lifo->nr)
+					memmove(lifo->items + i,
+						lifo->items + i + 1,
+						(lifo->nr - i) *
+						sizeof(struct commit_info));
+				lifo->nr--;
+			}
+			return result;
+		}
+	return NULL;
+}
+
+static void add_commit_info(struct commit *commit, void *util,
+		struct commit_info_lifo *lifo)
+{
+	struct commit_info *info;
+	if (lifo->nr >= lifo->alloc) {
+		lifo->alloc = alloc_nr(lifo->nr + 1);
+		lifo->items = xrealloc(lifo->items,
+			lifo->alloc * sizeof(struct commit_info));
+	}
+	info = lifo->items + lifo->nr;
+	info->commit = commit;
+	info->util = util;
+	lifo->nr++;
+}
+
+struct commit_reflog {
+	int flag, recno;
+	struct complete_reflogs *reflogs;
+};
+
+struct reflog_walk_info {
+	struct commit_info_lifo reflogs, orig_parents;
+	struct path_list complete_reflogs;
+	struct commit_reflog *last_commit_reflog;
+};
+
+void init_reflog_walk(struct reflog_walk_info** info)
+{
+	*info = xcalloc(sizeof(struct reflog_walk_info), 1);
+}
+
+void add_reflog_for_walk(struct reflog_walk_info *info,
+		struct commit *commit, const char *name)
+{
+	unsigned long timestamp = 0;
+	int recno = -1;
+	struct path_list_item *item;
+	struct complete_reflogs *reflogs;
+	char *branch, *at = strchr(name, '@');
+	struct commit_reflog *commit_reflog;
+
+	branch = xstrdup(name);
+	if (at && at[1] == '{') {
+		char *ep;
+		branch[at - name] = '\0';
+		recno = strtoul(at + 2, &ep, 10);
+		if (*ep != '}') {
+			recno = -1;
+			timestamp = approxidate(at + 2);
+		}
+	} else
+		recno = 0;
+
+	item = path_list_lookup(branch, &info->complete_reflogs);
+	if (item)
+		reflogs = item->util;
+	else {
+		reflogs = read_complete_reflog(branch);
+		if (!reflogs) {
+			free(branch);
+			return;
+		}
+		path_list_insert(branch, &info->complete_reflogs)->util
+			= reflogs;
+	}
+
+	commit_reflog = xcalloc(sizeof(struct commit_reflog), 1);
+	if (recno < 0) {
+		commit_reflog->flag = 1;
+		commit_reflog->recno = get_reflog_recno_by_time(reflogs, timestamp);
+		if (commit_reflog->recno < 0) {
+			free(branch);
+			free(commit_reflog);
+			return;
+		}
+	} else
+		commit_reflog->recno = reflogs->nr - recno - 1;
+	commit_reflog->reflogs = reflogs;
+
+	add_commit_info(commit, commit_reflog, &info->reflogs);
+}
+
+void fake_reflog_parent(struct reflog_walk_info *info, struct commit *commit)
+{
+	struct commit_info *commit_info =
+		get_commit_info(commit, &info->reflogs, 0);
+	struct commit_reflog *commit_reflog;
+	struct reflog_info *reflog;
+
+	info->last_commit_reflog = NULL;
+	if (!commit_info)
+		return;
+
+	commit_reflog = commit_info->util;
+	if (commit_reflog->recno < 0) {
+		if (!(commit->object.flags & REFLOG_PARENT))
+			return;
+		commit_info = get_commit_info(commit, &info->orig_parents, 1);
+		if (!commit_info)
+			return;
+		if (commit->parents)
+			free_commit_list(commit->parents);
+		commit->parents = commit_info->util;
+		commit->object.flags &= ~REFLOG_PARENT;
+		free(commit_info);
+		get_commit_info(commit, &info->reflogs, 1);
+		return;
+	}
+
+	reflog = &commit_reflog->reflogs->items[commit_reflog->recno];
+	info->last_commit_reflog = commit_reflog;
+	commit_info->commit = (struct commit *)parse_object(reflog->osha1);
+	if (!commit_info->commit)
+		return;
+
+	commit->parents = xcalloc(sizeof(struct commit_list), 1);
+	commit->parents->item = commit_info->commit;
+	if (!(commit->object.flags & REFLOG_PARENT)) {
+		commit->object.flags |= REFLOG_PARENT;
+		add_commit_info(commit, commit->parents, &info->orig_parents);
+	}
+	commit->object.flags &= ~(SEEN | SHOWN);
+	commit_reflog->recno--;
+}
+
+void show_reflog_message(struct reflog_walk_info* info)
+{
+	if (info && info->last_commit_reflog) {
+		struct commit_reflog *commit_reflog = info->last_commit_reflog;
+		struct reflog_info *info;
+
+		printf("Reflog: %s@{", commit_reflog->reflogs->ref);
+		info = &commit_reflog->reflogs->items[commit_reflog->recno + 1];
+		if (commit_reflog->flag)
+			printf("%s", show_rfc2822_date(info->timestamp,
+						info->tz));
+		else
+			printf("%d", commit_reflog->reflogs->nr
+					- 2 - commit_reflog->recno);
+		printf("} (%s)\nReflog message: %s",
+			info->email, info->message);
+	}
+}
diff --git a/reflog-walk.h b/reflog-walk.h
new file mode 100644
index 0000000..787996b
--- /dev/null
+++ b/reflog-walk.h
@@ -0,0 +1,11 @@
+#ifndef REFLOG_WALK_H
+#define REFLOG_WALK_H
+
+extern void init_reflog_walk(struct reflog_walk_info** info);
+extern void add_reflog_for_walk(struct reflog_walk_info *info,
+		struct commit *commit, const char *name);
+extern void fake_reflog_parent(struct reflog_walk_info *info,
+		struct commit *commit);
+extern void show_reflog_message(struct reflog_walk_info* info);
+
+#endif
diff --git a/revision.c b/revision.c
index 1e3b29a..3d0f061 100644
--- a/revision.c
+++ b/revision.c
@@ -7,6 +7,7 @@
 #include "refs.h"
 #include "revision.h"
 #include "grep.h"
+#include "reflog-walk.h"
 
 static char *path_name(struct name_path *path, const char *name)
 {
@@ -116,6 +117,9 @@ void mark_parents_uninteresting(struct commit *commit)
 void add_pending_object(struct rev_info *revs, struct object *obj, const char *name)
 {
 	add_object_array(obj, name, &revs->pending);
+	if (revs->reflog_info && obj->type == OBJ_COMMIT)
+		add_reflog_for_walk(revs->reflog_info,
+				(struct commit *)obj, name);
 }
 
 static struct object *get_reference(struct rev_info *revs, const char *name, const unsigned char *sha1, unsigned int flags)
@@ -864,6 +868,10 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, const ch
 				handle_reflog(revs, flags);
 				continue;
 			}
+			if (!strcmp(arg, "--walk-reflogs")) {
+				init_reflog_walk(&revs->reflog_info);
+				continue;
+			}
 			if (!strcmp(arg, "--not")) {
 				flags ^= UNINTERESTING;
 				continue;
@@ -1208,6 +1216,9 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		revs->commits = entry->next;
 		free(entry);
 
+		if (revs->reflog_info)
+			fake_reflog_parent(revs->reflog_info, commit);
+
 		/*
 		 * If we haven't done the list limiting, we need to look at
 		 * the parents here. We also need to do the date-based limiting
diff --git a/revision.h b/revision.h
index 8f7907d..ec40af9 100644
--- a/revision.h
+++ b/revision.h
@@ -10,6 +10,7 @@
 #define BOUNDARY_SHOW	(1u<<6)
 #define ADDED		(1u<<7)	/* Parents already parsed and added? */
 #define SYMMETRIC_LEFT	(1u<<8)
+#define REFLOG_PARENT	(1u<<9)
 
 struct rev_info;
 struct log_info;
@@ -89,6 +90,8 @@ struct rev_info {
 
 	topo_sort_set_fn_t topo_setter;
 	topo_sort_get_fn_t topo_getter;
+
+	struct reflog_walk_info *reflog_info;
 };
 
 #define REV_TREE_SAME		0
-- 
1.5.0.rc0.gcbf41-dirty
