From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/2] pack-object: run rev-list equivalent internally.
Date: Tue, 05 Sep 2006 00:30:40 -0700
Message-ID: <7v64g2kbxb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 05 09:33:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKVQl-00055F-3b
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 09:33:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751502AbWIEHdI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 5 Sep 2006 03:33:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751496AbWIEHdH
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Sep 2006 03:33:07 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:15752 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751502AbWIEHaM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Sep 2006 03:30:12 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060905073012.JLXJ20060.fed1rmmtao12.cox.net@fed1rmimpo02.cox.net>;
          Tue, 5 Sep 2006 03:30:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id JXWD1V0021kojtg0000000
	Tue, 05 Sep 2006 03:30:13 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26463>

Instead of piping the rev-list output from its standard input,
you can say:

	pack-object --revs pack --all

I am not happy about the command line parameter handling of this
patch, so the syntax is very likely to change by the final
version.  Currently it understands the following:

	pack-object [options including --stdout]
	pack-object [options] pack-base-name
	pack-object [options] --revs pack-base-name [list options] refs...
	pack-object [options including --stdout] --revs [list options] refs...

The first two are for traditional behaviour and the latter two
are the new ones.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 * This does not contain the "pretend that objects in these
   packs are loose when handing --unpacked requests" I've sent
   earlier.  I've also considered doing without --revs but the
   parser can quickly get confused between pack-base-name and a
   ref given to (internal) rev-list.  "pack-object foobla" might
   be reading from standard input and creating foobla-*.pack, or
   the user wanted to do a rev-list starting from foobla and
   forgot to specify the base name, for example.

 builtin-pack-objects.c |  273 ++++++++++++++++++++++++++++++++++--------------
 1 files changed, 192 insertions(+), 81 deletions(-)

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 149fa28..74daf37 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -9,10 +9,13 @@ #include "delta.h"
 #include "pack.h"
 #include "csum-file.h"
 #include "tree-walk.h"
+#include "diff.h"
+#include "revision.h"
+#include "list-objects.h"
 #include <sys/time.h>
 #include <signal.h>
 
-static const char pack_usage[] = "git-pack-objects [-q] [--no-reuse-delta] [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} < object-list";
+static const char pack_usage[] = "git-pack-objects [-q] [--no-reuse-delta] [--non-empty] [--local] [--incremental] [--window=N] [--depth=N] {--stdout | base-name} [ --revs [--unpacked | --all | --not | <ref>]* | <object-list]";
 
 struct object_entry {
 	unsigned char sha1[20];
@@ -1326,13 +1329,109 @@ static int git_pack_config(const char *k
 	return git_default_config(k, v);
 }
 
+static void read_object_list_from_stdin(void)
+{
+	int num_preferred_base = 0;
+	char line[40 + 1 + PATH_MAX + 2];
+	unsigned char sha1[20];
+	unsigned hash;
+
+	for (;;) {
+		if (!fgets(line, sizeof(line), stdin)) {
+			if (feof(stdin))
+				break;
+			if (!ferror(stdin))
+				die("fgets returned NULL, not EOF, not error!");
+			if (errno != EINTR)
+				die("fgets: %s", strerror(errno));
+			clearerr(stdin);
+			continue;
+		}
+		if (line[0] == '-') {
+			if (get_sha1_hex(line+1, sha1))
+				die("expected edge sha1, got garbage:\n %s",
+				    line);
+			if (num_preferred_base++ < window)
+				add_preferred_base(sha1);
+			continue;
+		}
+		if (get_sha1_hex(line, sha1))
+			die("expected sha1, got garbage:\n %s", line);
+
+		hash = name_hash(line+41);
+		add_preferred_base_object(line+41, hash);
+		add_object_entry(sha1, hash, 0);
+	}
+}
+
+/* copied from rev-list but needs to do things slightly differently */
+static void mark_edge_parents_uninteresting(struct commit *commit)
+{
+	struct commit_list *parents;
+
+	for (parents = commit->parents; parents; parents = parents->next) {
+		struct commit *parent = parents->item;
+		if (!(parent->object.flags & UNINTERESTING))
+			continue;
+		mark_tree_uninteresting(parent->tree);
+	}
+}
+
+static void mark_edges_uninteresting(struct commit_list *list)
+{
+	for ( ; list; list = list->next) {
+		struct commit *commit = list->item;
+
+		if (commit->object.flags & UNINTERESTING) {
+			mark_tree_uninteresting(commit->tree);
+			continue;
+		}
+		mark_edge_parents_uninteresting(commit);
+	}
+}
+
+static void show_commit(struct commit *commit)
+{
+	unsigned hash = name_hash("");
+	add_object_entry(commit->object.sha1, hash, 0);
+}
+
+static void show_object(struct object_array_entry *p)
+{
+	unsigned hash = name_hash(p->name);
+	add_object_entry(p->item->sha1, hash, 0);
+}
+
+static void get_object_list(int ac, const char **av)
+{
+	struct rev_info revs;
+	const char **revav = xcalloc(ac + 3, sizeof(*revav));
+
+	revav[0] = "pack-objects";
+	revav[1] = "--objects";
+	memcpy(revav + 2, av, sizeof(*av) * ac);
+
+	init_revisions(&revs, NULL);
+	save_commit_buffer = 0;
+	track_object_refs = 0;
+	setup_revisions(ac + 2, revav, &revs, NULL);
+
+	/* make sure we did not get pathspecs */
+	if (revs.prune_data)
+		die("pathspec given");
+
+	prepare_revision_walk(&revs);
+	mark_edges_uninteresting(revs.commits);
+
+	traverse_commit_list(&revs, show_commit, show_object);
+}
+
 int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 {
 	SHA_CTX ctx;
-	char line[40 + 1 + PATH_MAX + 2];
 	int depth = 10;
 	struct object_entry **list;
-	int num_preferred_base = 0;
+	int read_from_stdin = 1;
 	int i;
 
 	git_config(git_pack_config);
@@ -1341,58 +1440,94 @@ int cmd_pack_objects(int argc, const cha
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
-		if (*arg == '-') {
-			if (!strcmp("--non-empty", arg)) {
-				non_empty = 1;
-				continue;
-			}
-			if (!strcmp("--local", arg)) {
-				local = 1;
-				continue;
-			}
-			if (!strcmp("--progress", arg)) {
-				progress = 1;
-				continue;
-			}
-			if (!strcmp("--incremental", arg)) {
-				incremental = 1;
-				continue;
-			}
-			if (!strncmp("--window=", arg, 9)) {
-				char *end;
-				window = strtoul(arg+9, &end, 0);
-				if (!arg[9] || *end)
-					usage(pack_usage);
-				continue;
-			}
-			if (!strncmp("--depth=", arg, 8)) {
-				char *end;
-				depth = strtoul(arg+8, &end, 0);
-				if (!arg[8] || *end)
-					usage(pack_usage);
-				continue;
-			}
-			if (!strcmp("--progress", arg)) {
-				progress = 1;
-				continue;
-			}
-			if (!strcmp("-q", arg)) {
-				progress = 0;
-				continue;
-			}
-			if (!strcmp("--no-reuse-delta", arg)) {
-				no_reuse_delta = 1;
-				continue;
-			}
-			if (!strcmp("--stdout", arg)) {
-				pack_to_stdout = 1;
+		if (*arg != '-')
+			break;
+
+		if (!strcmp("--non-empty", arg)) {
+			non_empty = 1;
+			continue;
+		}
+		if (!strcmp("--local", arg)) {
+			local = 1;
+			continue;
+		}
+		if (!strcmp("--progress", arg)) {
+			progress = 1;
+			continue;
+		}
+		if (!strcmp("--incremental", arg)) {
+			incremental = 1;
+			continue;
+		}
+		if (!strncmp("--window=", arg, 9)) {
+			char *end;
+			window = strtoul(arg+9, &end, 0);
+			if (!arg[9] || *end)
+				usage(pack_usage);
+			continue;
+		}
+		if (!strncmp("--depth=", arg, 8)) {
+			char *end;
+			depth = strtoul(arg+8, &end, 0);
+			if (!arg[8] || *end)
+				usage(pack_usage);
+			continue;
+		}
+		if (!strcmp("--progress", arg)) {
+			progress = 1;
+			continue;
+		}
+		if (!strcmp("-q", arg)) {
+			progress = 0;
+			continue;
+		}
+		if (!strcmp("--no-reuse-delta", arg)) {
+			no_reuse_delta = 1;
+			continue;
+		}
+		if (!strcmp("--stdout", arg)) {
+			pack_to_stdout = 1;
+			continue;
+		}
+		if (!strcmp("--revs", arg)) {
+			read_from_stdin = 0;
+			i++;
+			break;
+		}
+		usage(pack_usage);
+	}
+
+	/* Traditionally "pack-objects [options] base extra" failed;
+	 * we would however want to take refs parameter that would
+	 * have been given to upstream rev-list ourselves, which means
+	 * we somehow want to say what the base name is.  So the
+	 * syntax would be:
+	 *
+	 * pack-objects [options] base <refs...>
+	 *
+	 * in other words, we would treat the first non-option as the
+	 * base_name and send everything else to the internal revision
+	 * walker.
+	 */
+
+	if (!pack_to_stdout)
+		base_name = argv[i++];
+
+	if (!read_from_stdin) {
+		int j;
+		/* the rest are used as refs parameter to rev-list;
+		 * we only allow refs (including a..b and a...b notation),
+		 * --all, --not, and --unpacked.
+		 */
+		for (j = i; j < argc; j++) {
+			const char *arg = argv[j];
+			if ((arg[0] != '-') ||
+			    !strcmp(arg, "--unpacked") ||
+			    !strcmp(arg, "--all") ||
+			    !strcmp(arg, "--not"))
 				continue;
-			}
-			usage(pack_usage);
+			die("cannot use --revs with %s", arg);
 		}
-		if (base_name)
-			usage(pack_usage);
-		base_name = arg;
 	}
 
 	if (pack_to_stdout != !base_name)
@@ -1405,35 +1540,11 @@ int cmd_pack_objects(int argc, const cha
 		setup_progress_signal();
 	}
 
-	for (;;) {
-		unsigned char sha1[20];
-		unsigned hash;
-
-		if (!fgets(line, sizeof(line), stdin)) {
-			if (feof(stdin))
-				break;
-			if (!ferror(stdin))
-				die("fgets returned NULL, not EOF, not error!");
-			if (errno != EINTR)
-				die("fgets: %s", strerror(errno));
-			clearerr(stdin);
-			continue;
-		}
+	if (read_from_stdin)
+		read_object_list_from_stdin();
+	else
+		get_object_list(argc - i, argv + i);
 
-		if (line[0] == '-') {
-			if (get_sha1_hex(line+1, sha1))
-				die("expected edge sha1, got garbage:\n %s",
-				    line+1);
-			if (num_preferred_base++ < window)
-				add_preferred_base(sha1);
-			continue;
-		}
-		if (get_sha1_hex(line, sha1))
-			die("expected sha1, got garbage:\n %s", line);
-		hash = name_hash(line+41);
-		add_preferred_base_object(line+41, hash);
-		add_object_entry(sha1, hash, 0);
-	}
 	if (progress)
 		fprintf(stderr, "Done counting %d objects.\n", nr_objects);
 	sorted_by_sha = create_final_object_list();
-- 
1.4.2.g552e5
