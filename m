From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-pickaxe: blame rewritten.
Date: Thu, 12 Oct 2006 22:35:19 -0700
Message-ID: <7vbqogeq20.fsf@assigned-by-dhcp.cox.net>
References: <7v7iz5rk4b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0610120854440.3952@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 13 07:35:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GYFhl-000394-31
	for gcvg-git@gmane.org; Fri, 13 Oct 2006 07:35:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750973AbWJMFfa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Oct 2006 01:35:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750964AbWJMFf3
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Oct 2006 01:35:29 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:10220 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750826AbWJMFf2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Oct 2006 01:35:28 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061013053528.NVXK6235.fed1rmmtao06.cox.net@fed1rmimpo02.cox.net>;
          Fri, 13 Oct 2006 01:35:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ZhbU1V00N1kojtg0000000
	Fri, 13 Oct 2006 01:35:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610120854440.3952@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 12 Oct 2006 08:58:54 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28830>

Linus Torvalds <torvalds@osdl.org> writes:

> On Thu, 12 Oct 2006, Junio C Hamano wrote:
>> +
>> +SYNOPSIS
>> +--------
>> +'git-pickaxe' [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [--] <file> [<rev>]
>
> Btw, could we please get rid of this horrible command line syntax.
>
> Pretty much _every_ other git command takes the form
>
> 	git cmd [<rev>] [--] <path>
>
> but for some reason annotate and blame (and now pickaxe) do it the wrong 
> way around, and do
>
> 	git cmd [--] <path> [<rev>]
>
> which is just irritating to somebody who has grown very used to being able 
> to specify revisions first.
>
> (I'd actually also like to have a range-modifier, so that I could do
>
> 	git annotate --since=2.weeks.ago v2.6.18.. <path>
>
> that didn't go back beyond a certain point, so the command line syntax 
> actually _does_ matter - even if we don't support that now, having the 
> regular command line syntax means that we -could- support it some day).
>
> 		Linus

So here it is.  I did not think "-n 20" would make sense for
this application so the code does not do anything about it.

This will be parked on "pu" for now.

-- >8 --
[PATCH] git-pickaxe: minimally use revision machinery.

This rewrites pickaxe argument parser to use revision machinery,
so that you can say something like:

	git pickaxe --since=2.weeks master commit.c
	git pickaxe -L 20,40 v1.4.0..master -- commit.c

The traditional parameter order (path first then optional rev)
is supported but cannot be mixed with revision limiting
parameters.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 Documentation/git-pickaxe.txt |    2 +-
 builtin-pickaxe.c             |  221 ++++++++++++++++++++++++++++++++---------
 2 files changed, 173 insertions(+), 50 deletions(-)

diff --git a/Documentation/git-pickaxe.txt b/Documentation/git-pickaxe.txt
index 7f30cdf..7685bd0 100644
--- a/Documentation/git-pickaxe.txt
+++ b/Documentation/git-pickaxe.txt
@@ -7,7 +7,7 @@ git-pickaxe - Show what revision and aut
 
 SYNOPSIS
 --------
-'git-pickaxe' [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [--] <file> [<rev>]
+'git-pickaxe' [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [<rev>] [--] <file>
 
 DESCRIPTION
 -----------
diff --git a/builtin-pickaxe.c b/builtin-pickaxe.c
index 0e26308..0aa4565 100644
--- a/builtin-pickaxe.c
+++ b/builtin-pickaxe.c
@@ -11,13 +11,14 @@ #include "commit.h"
 #include "tree-walk.h"
 #include "diff.h"
 #include "diffcore.h"
+#include "revision.h"
 #include "xdiff-interface.h"
 
 #include <time.h>
 #include <sys/time.h>
 
 static char pickaxe_usage[] =
-"git-pickaxe [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [--] file [commit]\n"
+"git-pickaxe [-c] [-l] [-t] [-f] [-n] [-p] [-L n,m] [-S <revs-file>] [commit] [--] file\n"
 "  -c, --compatibility Use the same output mode as git-annotate (Default: off)\n"
 "  -l, --long          Show long commit SHA1 (Default: off)\n"
 "  -t, --time          Show raw timestamp (Default: off)\n"
@@ -109,7 +110,8 @@ static void coalesce(struct scoreboard *
 	for (o = 0, i = 0; i < num; i++) {
 		if (o &&
 		    ent[o-1]->suspect == ent[i]->suspect &&
-		    ent[o-1]->s_lno + ent[o-1]->num_lines == ent[i]->s_lno) {
+		    ent[o-1]->s_lno + ent[o-1]->num_lines == ent[i]->s_lno &&
+		    ent[o-1]->guilty == ent[i]->guilty) {
 			ent[o-1]->num_lines += ent[i]->num_lines;
 			free(ent[i]);
 			continue;
@@ -220,7 +222,8 @@ static void process_u0_diff(void *state_
 	struct chunk *chunk;
 	int off1, off2, len1, len2;
 
-if(DEBUG) fprintf(stderr, "%.*s", (int) len, line);
+	if (DEBUG)
+		fprintf(stderr, "%.*s", (int) len, line);
 
 	if (len < 4 || line[0] != '@' || line[1] != '@')
 		return;
@@ -256,17 +259,23 @@ static struct patch *get_patch(struct or
 	mmfile_t file_p, file_o;
 	xdemitcb_t ecb;
 	char type[10];
-
-if(DEBUG) fprintf(stderr, "get patch %.8s %.8s\n",
-		sha1_to_hex(parent->commit->object.sha1),
-		sha1_to_hex(origin->commit->object.sha1));
-
-	file_p.ptr = read_sha1_file(parent->blob_sha1, type,
-				    (unsigned long *) &file_p.size);
-	file_o.ptr = read_sha1_file(origin->blob_sha1, type,
-				    (unsigned long *) &file_o.size);
-	if (!file_p.ptr || !file_o.ptr)
+	char *blob_p, *blob_o;
+
+	if (DEBUG) fprintf(stderr, "get patch %.8s %.8s\n",
+			   sha1_to_hex(parent->commit->object.sha1),
+			   sha1_to_hex(origin->commit->object.sha1));
+
+	blob_p = read_sha1_file(parent->blob_sha1, type,
+				(unsigned long *) &file_p.size);
+	blob_o = read_sha1_file(origin->blob_sha1, type,
+				(unsigned long *) &file_o.size);
+	file_p.ptr = blob_p;
+	file_o.ptr = blob_o;
+	if (!file_p.ptr || !file_o.ptr) {
+		free(blob_p);
+		free(blob_o);
 		return NULL;
+	}
 
 	xpp.flags = XDF_NEED_MINIMAL;
 	xecfg.ctxlen = 0;
@@ -280,6 +289,8 @@ if(DEBUG) fprintf(stderr, "get patch %.8
 	state.ret->num = 0;
 
 	xdl_diff(&file_p, &file_o, &xpp, &xecfg, &ecb);
+	free(blob_p);
+	free(blob_o);
 	return state.ret;
 }
 
@@ -417,11 +428,12 @@ static int pass_blame_to_parent(struct s
 	for (i = 0; i < patch->num; i++) {
 		struct chunk *chunk = &patch->chunks[i];
 
-if(DEBUG)	fprintf(stderr,
-			"plno = %d, tlno = %d, "
-			"same as parent up to %d, resync %d and %d\n",
-			plno, tlno,
-			chunk->same, chunk->p_next, chunk->t_next);
+		if (DEBUG)
+			fprintf(stderr,
+				"plno = %d, tlno = %d, "
+				"same as parent up to %d, resync %d and %d\n",
+				plno, tlno,
+				chunk->same, chunk->p_next, chunk->t_next);
 		blame_chunk(sb, tlno, plno, chunk->same, target, parent);
 		plno = chunk->p_next;
 		tlno = chunk->t_next;
@@ -434,7 +446,8 @@ if(DEBUG)	fprintf(stderr,
 }
 
 #define MAXPARENT 16
-static void pass_blame(struct scoreboard *sb, struct origin *origin)
+static void pass_blame(struct scoreboard *sb, struct origin *origin,
+		       struct rev_info *revs)
 {
 	int i, parent_ix;
 	struct commit *commit = origin->commit;
@@ -448,8 +461,15 @@ static void pass_blame(struct scoreboard
 	for (parent_ix = 0, parent = commit->parents;
 	     parent_ix < MAXPARENT && parent;
 	     parent = parent->next, parent_ix++) {
-		if (parse_commit(parent->item))
+		struct commit *p = parent->item;
+
+		if (parse_commit(p))
+			continue;
+		if (p->object.flags & UNINTERESTING)
 			continue;
+		if (revs->max_age != -1 && p->date  < revs->max_age)
+			continue;
+
 		porigin = find_origin(sb, parent->item, origin->path);
 		if (!porigin)
 			porigin = find_rename(sb, parent->item, origin);
@@ -485,14 +505,9 @@ static void pass_blame(struct scoreboard
 	 * Optionally run "ciff" to find copies from parents' files here
 	 */
 
-	/* Take responsibility for the remaining entries */
-	for (i = 0; i < sb->num_entries; i++)
-		if (!sb->entries[i]->guilty &&
-		    sb->entries[i]->suspect == origin)
-			sb->entries[i]->guilty = 1;
 }
 
-static void assign_blame(struct scoreboard *sb)
+static void assign_blame(struct scoreboard *sb, struct rev_info *revs)
 {
 	while (1) {
 		int i;
@@ -506,7 +521,13 @@ static void assign_blame(struct scoreboa
 		if (!suspect)
 			return; /* all done */
 
-		pass_blame(sb, suspect);
+		pass_blame(sb, suspect, revs);
+
+		/* Take responsibility for the remaining entries */
+		for (i = 0; i < sb->num_entries; i++)
+			if (!sb->entries[i]->guilty &&
+			    sb->entries[i]->suspect == suspect)
+				sb->entries[i]->guilty = 1;
 	}
 }
 
@@ -829,23 +850,29 @@ static void find_alignment(struct scoreb
 	max_digits = lineno_width(longest_dst_lines);
 }
 
+static int has_path_in_work_tree(const char *path)
+{
+	struct stat st;
+	return !lstat(path, &st);
+}
+
 int cmd_pickaxe(int argc, const char **argv, const char *prefix)
 {
-	const char *path = argv[1];
-	unsigned char sha1[20];
+	struct rev_info revs;
+	const char *path;
 	struct scoreboard sb;
 	struct origin *o;
 	struct blame_entry *ent;
-	int i, seen_dashdash;
+	int i, seen_dashdash, unk;
 	long bottom, top, lno;
 	int output_option = 0;
 	const char *revs_file = NULL;
-	const char *final_commit_name = "HEAD";
+	const char *final_commit_name = NULL;
 	char type[10];
 
 	bottom = top = 0;
 	seen_dashdash = 0;
-	for (i = 1; i < argc; i++) {
+	for (unk = i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 		if (*arg != '-')
 			break;
@@ -887,28 +914,121 @@ int cmd_pickaxe(int argc, const char **a
 			break;
 		}
 		else
+			argv[unk++] = arg;
+	}
+
+	/* We have collected options unknown to us in argv[1..unk]
+	 * which are to be passed to revision machinery if we are
+	 * going to do the "bottom" procesing.
+	 *
+	 * The remaining are:
+	 *
+	 * (1) if seen_dashdash, its either
+	 *     "-options -- <path>" or
+	 *     "-options -- <path> <rev>".
+	 *     but the latter is allowed only if there is no
+	 *     options that we passed to revision machinery.
+	 *
+	 * (2) otherwise, we may have "--" somewhere later and
+	 *     might be looking at the first one of multiple 'rev'
+	 *     parameters (e.g. " master ^next ^maint -- path").
+	 *     See if there is a dashdash first, and give the
+	 *     arguments before that to revision machinery.
+	 *     After that there must be one 'path'.
+	 *
+	 * (3) otherwise, its one of the three:
+	 *     "-options <path> <rev>"
+	 *     "-options <rev> <path>"
+	 *     "-options <path>"
+	 *     but again the first one is allowed only if
+	 *     there is no options that we passed to revision
+	 *     machinery.
+	 */
+
+	if (seen_dashdash) {
+		/* (1) */
+		if (argc <= i)
+			usage(pickaxe_usage);
+		path = argv[i];
+		if (i + 1 == argc - 1) {
+			if (unk != 1)
+				usage(pickaxe_usage);
+			argv[unk++] = argv[i + 1];
+		}
+		else if (i + 1 != argc)
+			/* garbage at end */
 			usage(pickaxe_usage);
 	}
+	else {
+		int j;
+		for (j = i; !seen_dashdash && j < argc; j++)
+			if (!strcmp(argv[j], "--"))
+				seen_dashdash = j;
+		if (seen_dashdash) {
+			if (seen_dashdash + 1 != argc - 1)
+				usage(pickaxe_usage);
+			path = argv[seen_dashdash + 1];
+			for (j = i; j < seen_dashdash; j++)
+				argv[unk++] = argv[j];
+		}
+		else {
+			/* (3) */
+			path = argv[i];
+			if (i + 1 == argc - 1) {
+				final_commit_name = argv[i + 1];
+
+				/* if (unk == 1) we could be getting
+				 * old-style
+				 */
+				if (unk == 1 && !has_path_in_work_tree(path)) {
+					path = argv[i + 1];
+					final_commit_name = argv[i];
+				}
+			}
+			else if (i != argc - 1)
+				usage(pickaxe_usage); /* garbage at end */
 
-	/* argv[i] is filename, argv[i+1] if exists is the commit */
-	if (i >= argc)
-		usage(pickaxe_usage);
-	path = argv[i++];
-	if (!seen_dashdash) {
-		struct stat st;
-		if (lstat(path, &st))
-			die("cannot stat path %s: %s", path, strerror(errno));
+			if (!has_path_in_work_tree(path))
+				die("cannot stat path %s: %s",
+				    path, strerror(errno));
+		}
 	}
 
-	if (i == argc - 1)
-		final_commit_name = argv[i];
-	else if (i != argc)
-		usage(pickaxe_usage);
+	if (final_commit_name)
+		argv[unk++] = final_commit_name;
 
+	/* Now we got rev and path.  We do not want the path pruning
+	 * but we may want "bottom" processing.
+	 */
+	argv[unk] = NULL;
+
+	init_revisions(&revs, NULL);
+	setup_revisions(unk, argv, &revs, "HEAD");
 	memset(&sb, 0, sizeof(sb));
-	if (get_sha1(final_commit_name, sha1) ||
-	    !(sb.final = lookup_commit_reference(sha1)))
-		die("no such commit %s", final_commit_name);
+
+	/* There must be one and only one positive commit in the
+	 * revs->pending array.
+	 */
+	for (i = 0; i < revs.pending.nr; i++) {
+		struct object *obj = revs.pending.objects[i].item;
+		if (obj->flags & UNINTERESTING)
+			continue;
+		if (obj->type != OBJ_COMMIT)
+			die("Non commit %s?",
+			    revs.pending.objects[i].name);
+		if (sb.final)
+			die("More than one commit to dig from %s and %s?",
+			    revs.pending.objects[i].name,
+			    final_commit_name);
+		sb.final = (struct commit *) obj;
+		final_commit_name = revs.pending.objects[i].name;
+	}
+	/* If we have bottom, this will mark the ancestors of the
+	 * bottom commits we would reach while traversing as
+	 * uninteresting.
+	 */
+	prepare_revision_walk(&revs);
+
 	o = find_origin(&sb, sb.final, path);
 	if (!o)
 		die("no such path %s in %s", path, final_commit_name);
@@ -939,7 +1059,7 @@ int cmd_pickaxe(int argc, const char **a
 		die("reading graft file %s failed: %s",
 		    revs_file, strerror(errno));
 
-	assign_blame(&sb);
+	assign_blame(&sb, &revs);
 
 	coalesce(&sb);
 
@@ -947,6 +1067,9 @@ int cmd_pickaxe(int argc, const char **a
 		find_alignment(&sb, &output_option);
 
 	output(&sb, output_option);
-
+	free((void *)sb.final_buf);
+	for (i = 0; i < sb.num_entries; i++)
+		free(sb.entries[i]);
+	free(sb.entries);
 	return 0;
 }
-- 
1.4.3.rc2.g51ca
