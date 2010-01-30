From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH v5] add --summary option to git-push and git-fetch
Date: Fri, 29 Jan 2010 20:10:56 -0500
Message-ID: <20100130011056.GA20463@cthulhu>
References: <7viqhzm454.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 30 02:11:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nb1rn-0007Yw-A9
	for gcvg-git-2@lo.gmane.org; Sat, 30 Jan 2010 02:11:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755966Ab0A3BK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Jan 2010 20:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755963Ab0A3BK6
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jan 2010 20:10:58 -0500
Received: from cthulhu.elder-gods.org ([140.239.99.253]:54229 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755944Ab0A3BK5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jan 2010 20:10:57 -0500
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id 13CF9822012; Fri, 29 Jan 2010 20:10:56 -0500 (EST)
Mail-Followup-To: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <7viqhzm454.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138416>

--summary will cause git-push to output a one-line of each commit pushed.
--summary=n will display at most n commits for each ref pushed.

$ git push --dry-run --summary origin :
To /home/larry/gitsandbox/a
   80f0e50..5593a38  master -> master
    > 5593a38 foo
    > 81c03f8 bar

Fetch works the same way.

Signed-off-by: Larry D'Anna <larry@elder-gods.org>
---
 Changes since last version: 

  * added more tests
  * use clear_commit_marks instead of sledgehammer
  * moved declaration of print_summary_for_push_or_fetch to the top of the header
  * use egrep instead of grep -E

 Documentation/fetch-options.txt |    6 ++
 Documentation/git-push.txt      |    6 ++
 builtin-fetch.c                 |   24 ++++++--
 builtin-log.c                   |   35 +++++++++++
 builtin-push.c                  |   17 ++++--
 builtin.h                       |    2 +
 revision.c                      |   35 ++++++++++--
 revision.h                      |    1 +
 t/t5516-fetch-push.sh           |  121 +++++++++++++++++++++++++++++++++++++++
 transport.c                     |   42 +++++++++-----
 transport.h                     |    3 +-
 11 files changed, 260 insertions(+), 32 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index fe716b2..53bf049 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -25,6 +25,12 @@ endif::git-pull[]
 	fetches is a descendant of `<lbranch>`.  This option
 	overrides that check.
 
+--summary::
+	Print a one-line summary of each commit fetched.
+
+--summary=<n>::
+	Like --summary, but with a limit of <n> commits per ref.
+
 -k::
 --keep::
 	Keep downloaded pack.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 73a921c..25e0dec 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -86,6 +86,12 @@ nor in any Push line of the corresponding remotes file---see below).
 --dry-run::
 	Do everything except actually send the updates.
 
+--summary::
+	Print a one-line summary of each commit pushed.
+
+--summary=<n>::
+	Like --summary, but with a limit of <n> commits per ref.
+
 --porcelain::
 	Produce machine-readable output.  The output status line for each ref
 	will be tab-separated and sent to stdout instead of stderr.  The full
diff --git a/builtin-fetch.c b/builtin-fetch.c
index 8654fa7..4f56162 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -32,6 +32,7 @@ static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *transport;
+static int summary;
 
 static struct option builtin_fetch_options[] = {
 	OPT__VERBOSITY(&verbosity),
@@ -58,6 +59,9 @@ static struct option builtin_fetch_options[] = {
 		    "allow updating of HEAD ref"),
 	OPT_STRING(0, "depth", &depth, "DEPTH",
 		   "deepen history of shallow clone"),
+	{ OPTION_INTEGER, 0, "summary", &summary, "n", "print a summary of [at most n] fetched commits",
+	  PARSE_OPT_OPTARG, NULL, 20
+	},
 	OPT_END()
 };
 
@@ -210,7 +214,8 @@ static int s_update_ref(const char *action,
 
 static int update_local_ref(struct ref *ref,
 			    const char *remote,
-			    char *display)
+			    char *display,
+			    char *quickref)
 {
 	struct commit *current = NULL, *updated;
 	enum object_type type;
@@ -273,11 +278,12 @@ static int update_local_ref(struct ref *ref,
 		sprintf(display, "%c %-*s %-*s -> %s%s", r ? '!' : '*',
 			SUMMARY_WIDTH, what, REFCOL_WIDTH, remote, pretty_ref,
 			r ? "  (unable to update local ref)" : "");
+		if (!r)
+			strcpy(quickref, find_unique_abbrev(ref->new_sha1, DEFAULT_ABBREV));
 		return r;
 	}
 
 	if (in_merge_bases(current, &updated, 1)) {
-		char quickref[83];
 		int r;
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
 		strcat(quickref, "..");
@@ -288,7 +294,6 @@ static int update_local_ref(struct ref *ref,
 			pretty_ref, r ? "  (unable to update local ref)" : "");
 		return r;
 	} else if (force || ref->force) {
-		char quickref[84];
 		int r;
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
 		strcat(quickref, "...");
@@ -314,6 +319,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	struct commit *commit;
 	int url_len, i, note_len, shown_url = 0, rc = 0;
 	char note[1024];
+	char quickref[84];
 	const char *what, *kind;
 	struct ref *rm;
 	char *url, *filename = dry_run ? "/dev/null" : git_path("FETCH_HEAD");
@@ -389,12 +395,15 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 				fputc(url[i], fp);
 		fputc('\n', fp);
 
-		if (ref)
-			rc |= update_local_ref(ref, what, note);
-		else
+		if (ref) {
+			*quickref = 0;
+			rc |= update_local_ref(ref, what, note, quickref);
+		} else {
+			strcpy(quickref, find_unique_abbrev(rm->old_sha1, DEFAULT_ABBREV));
 			sprintf(note, "* %-*s %-*s -> FETCH_HEAD",
 				SUMMARY_WIDTH, *kind ? kind : "branch",
 				 REFCOL_WIDTH, *what ? what : "HEAD");
+		}
 		if (*note) {
 			if (verbosity >= 0 && !shown_url) {
 				fprintf(stderr, "From %.*s\n",
@@ -404,6 +413,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 			if (verbosity >= 0)
 				fprintf(stderr, " %s\n", note);
 		}
+		if (summary && quickref[0])
+			print_summary_for_push_or_fetch(quickref, summary);
+
 	}
 	free(url);
 	fclose(fp);
diff --git a/builtin-log.c b/builtin-log.c
index 8d16832..55ac4e4 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1350,3 +1350,38 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
 	free_patch_ids(&ids);
 	return 0;
 }
+
+
+void print_summary_for_push_or_fetch(const char *quickref, int limit)
+{
+	struct rev_info rev;
+	int i, max;
+	struct object *obj;
+	struct commit *commit;
+
+	init_revisions(&rev, NULL);
+	rev.prune = 0;
+	assert(!handle_revision_arg_clearing_flags(quickref, &rev, 0, ALL_REV_FLAGS, 1));
+	assert(!prepare_revision_walk(&rev));
+
+	while ((commit = get_revision(&rev)) != NULL) {
+		struct strbuf buf = STRBUF_INIT;
+		if (limit == 0) {
+			fprintf(stderr, "    ...\n");
+			break;
+		}
+		if (!commit->buffer) {
+			enum object_type type;
+			unsigned long size;
+			commit->buffer =
+				read_sha1_file(commit->object.sha1, &type, &size);
+			if (!commit->buffer)
+				die("Cannot read commit %s", sha1_to_hex(commit->object.sha1));
+		}
+		format_commit_message(commit, "    %m %h %s\n", &buf, 0);
+		fputs(buf.buf, stderr);
+		strbuf_release(&buf);
+		limit--;
+	}
+	fputs("\n", stderr);
+}
diff --git a/builtin-push.c b/builtin-push.c
index 5df6608..30f5a61 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -101,7 +101,7 @@ static void setup_default_push_refspecs(void)
 	}
 }
 
-static int push_with_options(struct transport *transport, int flags)
+static int push_with_options(struct transport *transport, int flags, int summary)
 {
 	int err;
 	int nonfastforward;
@@ -114,7 +114,7 @@ static int push_with_options(struct transport *transport, int flags)
 	if (flags & TRANSPORT_PUSH_VERBOSE)
 		fprintf(stderr, "Pushing to %s\n", transport->url);
 	err = transport_push(transport, refspec_nr, refspec, flags,
-			     &nonfastforward);
+						 summary, &nonfastforward);
 	if (err != 0)
 		error("failed to push some refs to '%s'", transport->url);
 
@@ -132,7 +132,7 @@ static int push_with_options(struct transport *transport, int flags)
 	return 1;
 }
 
-static int do_push(const char *repo, int flags)
+static int do_push(const char *repo, int flags, int summary)
 {
 	int i, errs;
 	struct remote *remote = remote_get(repo);
@@ -184,14 +184,14 @@ static int do_push(const char *repo, int flags)
 		for (i = 0; i < url_nr; i++) {
 			struct transport *transport =
 				transport_get(remote, url[i]);
-			if (push_with_options(transport, flags))
+			if (push_with_options(transport, flags, summary))
 				errs++;
 		}
 	} else {
 		struct transport *transport =
 			transport_get(remote, NULL);
 
-		if (push_with_options(transport, flags))
+ 		if (push_with_options(transport, flags, summary))
 			errs++;
 	}
 	return !!errs;
@@ -203,6 +203,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int tags = 0;
 	int rc;
 	const char *repo = NULL;	/* default repository */
+	int summary = 0;
+
 	struct option options[] = {
 		OPT_BIT('q', "quiet", &flags, "be quiet", TRANSPORT_PUSH_QUIET),
 		OPT_BIT('v', "verbose", &flags, "be verbose", TRANSPORT_PUSH_VERBOSE),
@@ -218,6 +220,9 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
+		{ OPTION_INTEGER, 0, "summary", &summary, "n", "print a summary of [at most n] pushed commits",
+		  PARSE_OPT_OPTARG, NULL, 20
+		},
 		OPT_BIT('u', "set-upstream", &flags, "set upstream for git pull/status",
 			TRANSPORT_PUSH_SET_UPSTREAM),
 		OPT_END()
@@ -239,7 +244,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1);
 	}
 
-	rc = do_push(repo, flags);
+	rc = do_push(repo, flags, summary);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
diff --git a/builtin.h b/builtin.h
index e8202f3..ec411be 100644
--- a/builtin.h
+++ b/builtin.h
@@ -19,6 +19,7 @@ extern int commit_tree(const char *msg, unsigned char *tree,
 		struct commit_list *parents, unsigned char *ret,
 		const char *author);
 extern int check_pager_config(const char *cmd);
+extern void print_summary_for_push_or_fetch(const char *quickref, int limit);
 
 extern int cmd_add(int argc, const char **argv, const char *prefix);
 extern int cmd_annotate(int argc, const char **argv, const char *prefix);
@@ -122,4 +123,5 @@ extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
 extern int cmd_replace(int argc, const char **argv, const char *prefix);
 
+
 #endif
diff --git a/revision.c b/revision.c
index 3ba6d99..cf3103a 100644
--- a/revision.c
+++ b/revision.c
@@ -768,7 +768,7 @@ static void handle_reflog(struct rev_info *revs, unsigned flags)
 	for_each_reflog(handle_one_reflog, &cb);
 }
 
-static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
+static int add_parents_only(struct rev_info *revs, const char *arg, int flags, int flags_to_clear)
 {
 	unsigned char sha1[20];
 	struct object *it;
@@ -792,6 +792,8 @@ static int add_parents_only(struct rev_info *revs, const char *arg, int flags)
 	if (it->type != OBJ_COMMIT)
 		return 0;
 	commit = (struct commit *)it;
+	if (flags_to_clear)
+	    clear_commit_marks(commit, flags_to_clear); 
 	for (parents = commit->parents; parents; parents = parents->next) {
 		it = &parents->item->object;
 		it->flags |= flags;
@@ -887,9 +889,18 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 			int flags,
 			int cant_be_filename)
 {
+    return handle_revision_arg_clearing_flags (arg, revs, flags, 0, cant_be_filename); 
+}
+
+
+
+int handle_revision_arg_clearing_flags (const char *arg, struct rev_info *revs,
+					int flags,  int flags_to_clear, 
+					int cant_be_filename)
+{
 	unsigned mode;
 	char *dotdot;
-	struct object *object;
+	struct object *object, *object_deref;
 	unsigned char sha1[20];
 	int local_flags;
 
@@ -915,6 +926,10 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 
 			a = lookup_commit_reference(from_sha1);
 			b = lookup_commit_reference(sha1);
+			if (a && flags_to_clear) 
+			    clear_commit_marks(a, flags_to_clear); 
+			if (b && flags_to_clear)
+			    clear_commit_marks(b, flags_to_clear); 
 			if (!a || !b) {
 				die(symmetric ?
 				    "Invalid symmetric difference expression %s...%s" :
@@ -945,14 +960,14 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 	dotdot = strstr(arg, "^@");
 	if (dotdot && !dotdot[2]) {
 		*dotdot = 0;
-		if (add_parents_only(revs, arg, flags))
+		if (add_parents_only(revs, arg, flags, flags_to_clear))
 			return 0;
 		*dotdot = '^';
 	}
 	dotdot = strstr(arg, "^!");
 	if (dotdot && !dotdot[2]) {
 		*dotdot = 0;
-		if (!add_parents_only(revs, arg, flags ^ UNINTERESTING))
+		if (!add_parents_only(revs, arg, flags ^ UNINTERESTING, flags_to_clear))
 			*dotdot = '^';
 	}
 
@@ -965,7 +980,17 @@ int handle_revision_arg(const char *arg, struct rev_info *revs,
 		return -1;
 	if (!cant_be_filename)
 		verify_non_filename(revs->prefix, arg);
-	object = get_reference(revs, arg, sha1, flags ^ local_flags);
+
+	object = parse_object(sha1); 
+	if (!object)
+	    die("bad object %s", arg);
+	
+	object_deref = deref_tag(object, NULL, 0); 
+	if (object_deref && object_deref->type == OBJ_COMMIT)
+	    if (flags_to_clear)
+		clear_commit_marks((struct commit *) object_deref, flags_to_clear); 
+
+	object->flags |= flags ^ local_flags; 
 	add_pending_object_with_mode(revs, object, arg, mode);
 	return 0;
 }
diff --git a/revision.h b/revision.h
index a14deef..36f78bb 100644
--- a/revision.h
+++ b/revision.h
@@ -143,6 +143,7 @@ extern void parse_revision_opt(struct rev_info *revs, struct parse_opt_ctx_t *ct
 				 const struct option *options,
 				 const char * const usagestr[]);
 extern int handle_revision_arg(const char *arg, struct rev_info *revs,int flags,int cant_be_filename);
+extern int handle_revision_arg_clearing_flags(const char *arg, struct rev_info *revs,int flags, int flags_to_clear, int cant_be_filename);
 
 extern int prepare_revision_walk(struct rev_info *revs);
 extern struct commit *get_revision(struct rev_info *revs);
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 0f04b2e..3472aaa 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -91,6 +91,71 @@ test_expect_success 'fetch without wildcard' '
 	)
 '
 
+
+test_expect_success 'fetch --summary branch update' '
+	mk_empty &&
+	(
+		cd testrepo &&
+
+		git fetch  .. refs/heads/master:refs/remotes/origin/master &&
+
+		git update-ref refs/remotes/origin/master refs/remotes/origin/master^ &&
+
+		git fetch --summary .. refs/heads/master:refs/remotes/origin/master 2>stderr &&
+
+		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
+		test "z$r" = "z$the_commit" &&
+
+
+		test 1 = $(git for-each-ref refs/remotes/origin | wc -l) &&
+
+		  egrep  "^    > [a-fA-F0-9]+ second$" stderr &&
+		! egrep  "^    > [a-fA-F0-9]+ repo$" stderr
+	)
+	'
+
+test_expect_success 'fetch --summary new branch' '
+	mk_empty &&p
+	(
+		cd testrepo &&
+		git fetch --summary .. refs/heads/master:refs/remotes/origin/master 2>stderr &&
+
+		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
+		test "z$r" = "z$the_commit" &&
+
+		test 1 = $(git for-each-ref refs/remotes/origin | wc -l) &&
+
+		egrep  "^    > [a-fA-F0-9]+ second$" stderr &&
+		egrep  "^    > [a-fA-F0-9]+ repo$" stderr
+	)
+        '
+
+test_expect_success 'fetch --summary forced update' '
+	mk_empty &&
+	(
+		cd testrepo &&
+		git fetch .. refs/heads/master:refs/remotes/origin/master &&
+
+		git checkout refs/remotes/origin/master^ &&
+		: >path3 &&
+		git add path3 &&
+		test_tick &&
+		git commit -a -m third &&
+		git update-ref refs/remotes/origin/master HEAD &&
+
+		git fetch .. -f --summary refs/heads/master:refs/remotes/origin/master 2>stderr &&
+
+		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
+		test "z$r" = "z$the_commit" &&
+
+		test 1 = $(git for-each-ref refs/remotes/origin | wc -l) &&
+
+		egrep  "^    < [a-fA-F0-9]+ third$" stderr &&
+		egrep  "^    > [a-fA-F0-9]+ second$" stderr
+	)
+
+'
+
 test_expect_success 'fetch with wildcard' '
 	mk_empty &&
 	(
@@ -153,6 +218,62 @@ test_expect_success 'push without wildcard' '
 	)
 '
 
+test_expect_success 'push --summary new branch' '
+	mk_empty &&
+
+	git push --summary testrepo refs/heads/master:refs/remotes/origin/master 2>stderr &&
+	(
+		cd testrepo &&
+		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
+		test "z$r" = "z$the_commit" &&
+
+		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+	) &&
+
+	egrep  "^    > [a-fA-F0-9]+ second$" stderr &&
+	egrep  "^    > [a-fA-F0-9]+ repo$" stderr
+'
+
+test_expect_success 'push --summary branch update' '
+	mk_empty &&
+
+	git push testrepo refs/heads/master:refs/remotes/origin/master &&
+
+	git --git-dir testrepo/.git update-ref refs/remotes/origin/master refs/remotes/origin/master^ &&
+
+	git push --summary testrepo refs/heads/master:refs/remotes/origin/master 2>stderr &&
+	(
+		cd testrepo &&
+		r=$(git show-ref -s --verify refs/remotes/origin/master) &&
+		test "z$r" = "z$the_commit" &&
+
+		test 1 = $(git for-each-ref refs/remotes/origin | wc -l)
+	) &&
+
+	  egrep  "^    > [a-fA-F0-9]+ second$" stderr &&
+	! egrep  "^    > [a-fA-F0-9]+ repo$" stderr
+'
+
+
+test_expect_success 'push --summary forced update' '
+	mk_empty &&
+
+	git push testrepo refs/heads/master:refs/remotes/origin/master &&
+
+	git checkout master^ &&
+	: >path3 &&
+	git add path3 &&
+	test_tick &&
+	git commit -a -m third &&
+
+	git push --summary -f testrepo HEAD:refs/remotes/origin/master 2>stderr &&
+
+	egrep  "^    < [a-fA-F0-9]+ second$" stderr &&
+	egrep  "^    > [a-fA-F0-9]+ third$" stderr &&
+
+	git checkout master
+'
+
 test_expect_success 'push with wildcard' '
 	mk_empty &&
 
diff --git a/transport.c b/transport.c
index 3846aac..1e3fa7a 100644
--- a/transport.c
+++ b/transport.c
@@ -8,6 +8,7 @@
 #include "bundle.h"
 #include "dir.h"
 #include "refs.h"
+#include "builtin.h"
 #include "branch.h"
 
 /* rsync support */
@@ -642,17 +643,20 @@ static const char *status_abbrev(unsigned char sha1[20])
 	return find_unique_abbrev(sha1, DEFAULT_ABBREV);
 }
 
-static void print_ok_ref_status(struct ref *ref, int porcelain)
+static void print_ok_ref_status(struct ref *ref, int porcelain, int summary)
 {
+	char quickref[84];
+	int summary_impossible = 0;
+
 	if (ref->deletion)
 		print_ref_status('-', "[deleted]", ref, NULL, NULL, porcelain);
-	else if (is_null_sha1(ref->old_sha1))
+	else if (is_null_sha1(ref->old_sha1)) {
 		print_ref_status('*',
 			(!prefixcmp(ref->name, "refs/tags/") ? "[new tag]" :
 			"[new branch]"),
 			ref, ref->peer_ref, NULL, porcelain);
-	else {
-		char quickref[84];
+		strcpy(quickref, status_abbrev(ref->new_sha1));
+	} else {
 		char type;
 		const char *msg;
 
@@ -661,6 +665,8 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 			strcat(quickref, "...");
 			type = '+';
 			msg = "forced update";
+			if (!lookup_commit_reference_gently(ref->old_sha1, 1))
+				summary_impossible = 1;
 		} else {
 			strcat(quickref, "..");
 			type = ' ';
@@ -670,9 +676,17 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 
 		print_ref_status(type, quickref, ref, ref->peer_ref, msg, porcelain);
 	}
+
+	if (summary) {
+		if (summary_impossible) {
+			fprintf(stderr, "    %s is unavailable\n", status_abbrev(ref->old_sha1));
+		} else {
+			print_summary_for_push_or_fetch(quickref, summary);
+		}
+	}
 }
 
-static int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain)
+static int print_one_push_status(struct ref *ref, const char *dest, int count, int porcelain, int summary)
 {
 	if (!count)
 		fprintf(stderr, "To %s\n", dest);
@@ -704,7 +718,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 						 "remote failed to report status", porcelain);
 		break;
 	case REF_STATUS_OK:
-		print_ok_ref_status(ref, porcelain);
+		print_ok_ref_status(ref, porcelain, summary);
 		break;
 	}
 
@@ -712,7 +726,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 }
 
 static void print_push_status(const char *dest, struct ref *refs,
-			      int verbose, int porcelain, int * nonfastforward)
+							  int verbose, int porcelain, int summary, int *nonfastforward)
 {
 	struct ref *ref;
 	int n = 0;
@@ -720,19 +734,19 @@ static void print_push_status(const char *dest, struct ref *refs,
 	if (verbose) {
 		for (ref = refs; ref; ref = ref->next)
 			if (ref->status == REF_STATUS_UPTODATE)
-				n += print_one_push_status(ref, dest, n, porcelain);
+				n += print_one_push_status(ref, dest, n, porcelain, summary);
 	}
 
 	for (ref = refs; ref; ref = ref->next)
 		if (ref->status == REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n, porcelain);
+			n += print_one_push_status(ref, dest, n, porcelain, summary);
 
 	*nonfastforward = 0;
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n, porcelain);
+			n += print_one_push_status(ref, dest, n, porcelain, summary);
 		if (ref->status == REF_STATUS_REJECT_NONFASTFORWARD)
 			*nonfastforward = 1;
 	}
@@ -1014,8 +1028,8 @@ int transport_set_option(struct transport *transport,
 }
 
 int transport_push(struct transport *transport,
-		   int refspec_nr, const char **refspec, int flags,
-		   int *nonfastforward)
+				   int refspec_nr, const char **refspec,
+				   int flags, int summary, int *nonfastforward)
 {
 	*nonfastforward = 0;
 	verify_remote_names(refspec_nr, refspec);
@@ -1058,8 +1072,8 @@ int transport_push(struct transport *transport,
 
 		if (!quiet || err)
 			print_push_status(transport->url, remote_refs,
-					verbose | porcelain, porcelain,
-					nonfastforward);
+							  verbose | porcelain, porcelain,
+							  summary, nonfastforward);
 
 		if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
 			set_upstreams(transport, remote_refs, pretend);
diff --git a/transport.h b/transport.h
index 7cea5cc..f87b2e9 100644
--- a/transport.h
+++ b/transport.h
@@ -124,9 +124,10 @@ int transport_set_option(struct transport *transport, const char *name,
 			 const char *value);
 
 int transport_push(struct transport *connection,
-		   int refspec_nr, const char **refspec, int flags,
+		   int refspec_nr, const char **refspec, int flags, int summary,
 		   int * nonfastforward);
 
+
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
 int transport_fetch_refs(struct transport *transport, struct ref *refs);
-- 
1.6.3.3.415.gbe1e
