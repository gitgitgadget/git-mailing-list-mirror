From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add git-name-rev
Date: Wed, 26 Oct 2005 15:10:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0510261509060.31868@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0510260103570.27364@wbgn013.biozentrum.uni-wuerzburg.de>
 <20051026083625.GD30889@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Oct 26 15:11:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUl3K-0002aT-V5
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 15:10:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488AbVJZNKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 09:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbVJZNKX
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 09:10:23 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:30411 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S1751488AbVJZNKW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 09:10:22 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 97F3013F303; Wed, 26 Oct 2005 15:10:21 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 795329CC78; Wed, 26 Oct 2005 15:10:21 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4F91E9ABBB; Wed, 26 Oct 2005 15:10:21 +0200 (CEST)
Received: from dumbo2 (wbgn013.biozentrum.uni-wuerzburg.de [132.187.25.13])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 1566113F303; Wed, 26 Oct 2005 15:10:21 +0200 (CEST)
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20051026083625.GD30889@pasky.or.cz>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10664>

[PATCH] Add git-name-rev

git-name-rev tries to find nice symbolic names for commits. It does so by
walking the commits from the refs. When the symbolic name is ambiguous, the
following heuristic is applied: Try to avoid too many ~'s, and if two ambiguous
names have the same count of ~'s, take the one whose last number is smaller.

With "--tags", the names are derived only from tags.

With "--stdin", the stdin is parsed, and after every sha1 for which a name
could be found, the name is appended. (Try "git log | git name-rev --stdin".)

Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
---

	On Wed, 26 Oct 2005, Petr Baudis wrote:

	> I think you should either add this to git-findtags.perl or 
	> (better) add git-findtags.perl's functionality (i.e. a switch to 
	> search only in the tags) to this and obsolete/kill 
	> git-findtags.perl. It is pretty new (from Oct 13) so killing it 
	> shouldn't break anything.

	Ask, and it shall be given you.

 Documentation/git-name-rev.txt |   66 +++++++++++
 Makefile                       |    2 
 name-rev.c                     |  246 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 313 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
new file mode 100644
index 0000000..e37b0b8
--- /dev/null
+++ b/Documentation/git-name-rev.txt
@@ -0,0 +1,66 @@
+git-name-rev(1)
+===============
+
+NAME
+----
+git-name-rev - Find symbolic names for given revs.
+
+
+SYNOPSIS
+--------
+'git-name-rev' [--tags] ( --all | --stdin | <commitish>... )
+
+DESCRIPTION
+-----------
+Finds symbolic names suitable for human digestion for revisions given in any
+format parsable by git-rev-parse.
+
+
+OPTIONS
+-------
+
+--tags::
+	Do not use branch names, but only tags to name the commits
+
+--all::
+	List all commits reachable from all refs
+
+--stdin::
+	Read from stdin, append "(<rev_name>)" to all sha1's of name'able
+	commits, and pass to stdout
+
+EXAMPLE
+-------
+
+Given a commit, find out where it is relative to the local refs. Say somebody
+wrote you about that phantastic commit 33db5f4d9027a10e477ccf054b2c1ab94f74c85a.
+Of course, you look into the commit, but that only tells you what happened, but
+not the context.
+
+Enter git-name-rev:
+
+------------
+% git name-rev 33db5f4d9027a10e477ccf054b2c1ab94f74c85a
+------------
+
+Now you are wiser, because you know that it happened 940 revisions before v0.99.
+
+Another nice thing you can do is:
+
+------------
+% git log | git name-rev --stdin
+------------
+
+
+Author
+------
+Written by Johannes Schindelin <Johannes.Schindelin@gmx.de>
+
+Documentation
+--------------
+Documentation by Johannes Schindelin.
+
+GIT
+---
+Part of the gitlink:git[7] suite
+
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -122,7 +122,7 @@ PROGRAMS = \
 	git-unpack-objects$X git-update-index$X git-update-server-info$X \
 	git-upload-pack$X git-verify-pack$X git-write-tree$X \
 	git-update-ref$X git-symbolic-ref$X git-check-ref-format$X \
-	$(SIMPLE_PROGRAMS)
+	git-name-rev$X $(SIMPLE_PROGRAMS)
 
 # Backward compatibility -- to be removed after 1.0
 PROGRAMS += git-ssh-pull$X git-ssh-push$X
diff --git a/name-rev.c b/name-rev.c
new file mode 100644
index 0000000..21fecdf
--- /dev/null
+++ b/name-rev.c
@@ -0,0 +1,246 @@
+#include <stdlib.h>
+#include "cache.h"
+#include "commit.h"
+#include "tag.h"
+#include "refs.h"
+
+static const char name_rev_usage[] =
+	"git-name-rev [--tags] ( --all | --stdin | commitish [commitish...] )\n";
+
+typedef struct rev_name {
+	const char *tip_name;
+	int merge_traversals;
+	int generation;
+} rev_name;
+
+static long cutoff = LONG_MAX;
+
+static void name_rev(struct commit *commit,
+		const char *tip_name, int merge_traversals, int generation,
+		int deref)
+{
+	struct rev_name *name = (struct rev_name *)commit->object.util;
+	struct commit_list *parents;
+	int parent_number = 0;
+
+	if (!commit->object.parsed)
+		parse_commit(commit);
+
+	if (commit->date < cutoff)
+		return;
+
+	if (deref) {
+		char *new_name = xmalloc(strlen(tip_name)+3);
+		strcpy(new_name, tip_name);
+		strcat(new_name, "^0");
+		tip_name = new_name;
+
+		if (generation)
+			die("generation: %d, but deref?", generation);
+	}
+
+	if (name == NULL) {
+		name = xmalloc(sizeof(rev_name));
+		commit->object.util = name;
+		goto copy_data;
+	} else if (name->merge_traversals > merge_traversals ||
+			(name->merge_traversals == merge_traversals &&
+			 name->generation > generation)) {
+copy_data:
+		name->tip_name = tip_name;
+		name->merge_traversals = merge_traversals;
+		name->generation = generation;
+	} else
+		return;
+
+	for (parents = commit->parents;
+			parents;
+			parents = parents->next, parent_number++) {
+		if (parent_number > 0) {
+			char *new_name = xmalloc(strlen(tip_name)+8);
+
+			if (generation > 0)
+				sprintf(new_name, "%s~%d^%d", tip_name,
+						generation, parent_number);
+			else
+				sprintf(new_name, "%s^%d", tip_name, parent_number);
+
+			name_rev(parents->item, new_name,
+				merge_traversals + 1 , 0, 0);
+		} else {
+			name_rev(parents->item, tip_name, merge_traversals,
+				generation + 1, 0);
+		}
+	}
+}
+
+static int tags_only = 0;
+
+static int name_ref(const char *path, const unsigned char *sha1)
+{
+	struct object *o = parse_object(sha1);
+	int deref = 0;
+
+	if (tags_only && strncmp(path, "refs/tags/", 10))
+		return 0;
+
+	while (o && o->type == tag_type) {
+		struct tag *t = (struct tag *) o;
+		if (!t->tagged)
+			break; /* broken repository */
+		o = parse_object(t->tagged->sha1);
+		deref = 1;
+	}
+	if (o && o->type == commit_type) {
+		struct commit *commit = (struct commit *)o;
+		const char *p;
+
+		while ((p = strchr(path, '/')))
+			path = p+1;
+
+		name_rev(commit, strdup(path), 0, 0, deref);
+	}
+	return 0;
+}
+
+/* returns a static buffer */
+static const char* get_rev_name(struct object *o)
+{
+	static char buffer[1024];
+	struct rev_name *n = (struct rev_name *)o->util;
+	if (!n)
+		return "undefined";
+
+	if (!n->generation)
+		return n->tip_name;
+
+	snprintf(buffer, sizeof(buffer), "%s~%d", n->tip_name, n->generation);
+
+	return buffer;
+}
+	
+int main(int argc, char **argv)
+{
+	struct object_list *revs = NULL;
+	struct object_list **walker = &revs;
+	int as_is = 0, all = 0, transform_stdin = 0;
+
+	setup_git_directory();
+
+	if (argc < 2)
+		usage(name_rev_usage);
+
+	for (--argc, ++argv; argc; --argc, ++argv) {
+		unsigned char sha1[20];
+		struct object *o;
+		struct commit *commit;
+
+		if (!as_is && (*argv)[0] == '-') {
+			if (!strcmp(*argv, "--")) {
+				as_is = 1;
+				continue;
+			} else if (!strcmp(*argv, "--tags")) {
+				tags_only = 1;
+				continue;
+			} else if (!strcmp(*argv, "--all")) {
+				if (argc > 1)
+					die("Specify either a list, or --all, not both!");
+				all = 1;
+				cutoff = 0;
+				continue;
+			} else if (!strcmp(*argv, "--stdin")) {
+				if (argc > 1)
+					die("Specify either a list, or --stdin, not both!");
+				transform_stdin = 1;
+				cutoff = 0;
+				continue;
+			}
+			usage(name_rev_usage);
+		}
+
+		if (get_sha1(*argv, sha1)) {
+			fprintf(stderr, "Could not get sha1 for %s. Skipping.\n",
+					*argv);
+			continue;
+		}
+
+		o = deref_tag(parse_object(sha1));
+		if (!o || o->type != commit_type) {
+			fprintf(stderr, "Could not get commit for %s. Skipping.\n",
+					*argv);
+			continue;
+		}
+
+		commit = (struct commit *)o;
+
+		if (cutoff > commit->date)
+			cutoff = commit->date;
+
+		object_list_append((struct object *)commit, walker);
+		(*walker)->name = *argv;
+		walker = &((*walker)->next);
+	}
+
+	for_each_ref(name_ref);
+
+	if (transform_stdin) {
+		char buffer[2048];
+		char *p, *p_start;
+
+		while (!feof(stdin)) {
+			int forty = 0;
+			p = fgets(buffer, sizeof(buffer), stdin);
+			if (!p)
+				break;
+
+			for (p_start = p; *p; p++) {
+#define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
+				if (!ishex(*p))
+					forty = 0;
+				else if (++forty == 40 &&
+						!ishex(*(p+1))) {
+					unsigned char sha1[40];
+					const char *name = "undefined";
+					char c = *(p+1);
+
+					forty = 0;
+
+					*(p+1) = 0;
+					if (!get_sha1(p - 39, sha1)) {
+						struct object *o =
+							lookup_object(sha1);
+						if (o)
+							name = get_rev_name(o);
+					}
+					*(p+1) = c;
+
+					if (!strcmp(name, "undefined"))
+						continue;
+
+					fwrite(p_start, p - p_start, 1, stdout);
+					fputc('(', stdout);
+					fputs(name, stdout);
+					fputc(')', stdout);
+					p_start = p + 1;
+				}
+			}
+
+			/* flush */
+			if (p_start != p)
+				fwrite(p_start, p - p_start, 1, stdout);
+		}
+	} else if (all) {
+		extern struct object **objs;
+		extern int nr_objs;
+		int i;
+
+		for (i = 0; i < nr_objs; i++)
+			printf("%s %s\n", sha1_to_hex(objs[i]->sha1),
+					get_rev_name(objs[i]));
+	} else
+		for ( ; revs; revs = revs->next)
+			printf("%s %s\n", revs->name, get_rev_name(revs->item));
+
+	return 0;
+}
+
