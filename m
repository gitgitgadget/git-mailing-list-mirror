From: Larry D'Anna <larry@elder-gods.org>
Subject: [PATCH v3] add --summary option to git-push and git-fetch
Date: Mon, 6 Jul 2009 21:59:48 -0400
Message-ID: <20090707015948.GA525@cthulhu>
References: <20090703044801.GA2072@cthulhu> <7viqiat965.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 03:59:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MNzyO-00062w-Kc
	for gcvg-git-2@gmane.org; Tue, 07 Jul 2009 03:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755773AbZGGB7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2009 21:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755571AbZGGB7s
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jul 2009 21:59:48 -0400
Received: from cthulhu.elder-gods.org ([140.239.99.253]:49059 "EHLO
	cthulhu.elder-gods.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755521AbZGGB7r (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2009 21:59:47 -0400
Received: by cthulhu.elder-gods.org (Postfix, from userid 1000)
	id B2BFB822055; Mon,  6 Jul 2009 21:59:48 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7viqiat965.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



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

This patch is meant to be applied on top of 1965ff7 add --porcelain option to git-push

Differences since the last version:

* it will print ... at the end of the summary if it stops because there's too many lines

* it prints an extra newline after each summary to make the output more readable

* --summary now defaults to --summary=20 

* whitespace is fixed 

* no more stdout = stderr shenanigans

* s/static int summary = 0;/static int summary;/

 Documentation/fetch-options.txt |    7 +++++++
 Documentation/git-push.txt      |    6 ++++++
 builtin-fetch.c                 |   24 ++++++++++++++++++------
 builtin-log.c                   |   34 ++++++++++++++++++++++++++++++++++
 builtin-push.c                  |   12 +++++++++---
 builtin.h                       |    2 ++
 transport.c                     |   39 +++++++++++++++++++++++++++------------
 transport.h                     |    2 +-
 8 files changed, 104 insertions(+), 22 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index d313795..2e66d5e 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -27,6 +27,13 @@
 	fetches is a descendant of `<lbranch>`.  This option
 	overrides that check.
 
+--summary::
+	Print a one-line summary of each commit fetched.
+
+--summary=<n>::
+	Like --summary, but with a limit of <n> commits per ref.
+
+
 ifdef::git-pull[]
 --no-tags::
 endif::git-pull[]
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 2653388..803fe36 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -85,6 +85,12 @@ nor in any Push line of the corresponding remotes file---see below).
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
index cd5eb9a..c98d06b 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -29,6 +29,7 @@ static const char *depth;
 static const char *upload_pack;
 static struct strbuf default_rla = STRBUF_INIT;
 static struct transport *transport;
+static int summary;
 
 static struct option builtin_fetch_options[] = {
 	OPT__VERBOSITY(&verbosity),
@@ -47,6 +48,9 @@ static struct option builtin_fetch_options[] = {
 		    "allow updating of HEAD ref"),
 	OPT_STRING(0, "depth", &depth, "DEPTH",
 		   "deepen history of shallow clone"),
+	{ OPTION_INTEGER, 0, "summary", &summary, "n", "print a summary of [at most n] fetched commits",
+	  PARSE_OPT_OPTARG, NULL, 20
+	},
 	OPT_END()
 };
 
@@ -197,7 +201,8 @@ static int s_update_ref(const char *action,
 
 static int update_local_ref(struct ref *ref,
 			    const char *remote,
-			    char *display)
+			    char *display,
+			    char *quickref)
 {
 	struct commit *current = NULL, *updated;
 	enum object_type type;
@@ -260,11 +265,12 @@ static int update_local_ref(struct ref *ref,
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
@@ -275,7 +281,6 @@ static int update_local_ref(struct ref *ref,
 			pretty_ref, r ? "  (unable to update local ref)" : "");
 		return r;
 	} else if (force || ref->force) {
-		char quickref[84];
 		int r;
 		strcpy(quickref, find_unique_abbrev(current->object.sha1, DEFAULT_ABBREV));
 		strcat(quickref, "...");
@@ -301,6 +306,7 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	struct commit *commit;
 	int url_len, i, note_len, shown_url = 0, rc = 0;
 	char note[1024];
+	char quickref[84];
 	const char *what, *kind;
 	struct ref *rm;
 	char *url, *filename = git_path("FETCH_HEAD");
@@ -373,12 +379,15 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
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
@@ -388,6 +397,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
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
index 0c2fa0a..e25285b 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -1293,3 +1293,37 @@ int cmd_cherry(int argc, const char **argv, const char *prefix)
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
+	max = get_max_object_index();
+	for (i = 0; i < max; i++)  {
+		obj = get_indexed_object(i);
+		if (obj)
+			obj->flags &= ~ALL_REV_FLAGS;
+	}
+
+	init_revisions(&rev, NULL);
+	rev.prune = 0;
+	assert(!handle_revision_arg(quickref, &rev, 0, 1));
+	assert(!prepare_revision_walk(&rev));
+
+	while ((commit = get_revision(&rev)) != NULL) {
+		struct strbuf buf = STRBUF_INIT;
+		if (limit == 0) {
+			fprintf(stderr, "    ...\n");
+			break;
+		}
+		format_commit_message(commit, "    %m %h %s\n", &buf, 0);
+		fputs(buf.buf, stderr);
+		strbuf_release(&buf);
+		limit--;
+	}
+	fputs("\n", stderr);
+}
diff --git a/builtin-push.c b/builtin-push.c
index 0a0297f..d38f9a8 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -113,7 +113,7 @@ static void setup_default_push_refspecs(void)
 	}
 }
 
-static int do_push(const char *repo, int flags)
+static int do_push(const char *repo, int flags, int summary)
 {
 	int i, errs;
 	struct remote *remote = remote_get(repo);
@@ -173,7 +173,7 @@ static int do_push(const char *repo, int flags)
 
 		if (flags & TRANSPORT_PUSH_VERBOSE)
 			fprintf(stderr, "Pushing to %s\n", url[i]);
-		err = transport_push(transport, refspec_nr, refspec, flags);
+		err = transport_push(transport, refspec_nr, refspec, flags, summary);
 		err |= transport_disconnect(transport);
 
 		if (!err)
@@ -192,6 +192,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 	int rc;
 	const char *repo = NULL;	/* default repository */
 
+	int summary = 0;
+
 	struct option options[] = {
 		OPT_BIT('v', "verbose", &flags, "be verbose", TRANSPORT_PUSH_VERBOSE),
 		OPT_STRING( 0 , "repo", &repo, "repository", "repository"),
@@ -205,6 +207,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
+		{ OPTION_INTEGER, 0, "summary", &summary, "n", "print a summary of [at most n] pushed commits",
+		  PARSE_OPT_OPTARG, NULL, 20
+		},
+
 		OPT_END()
 	};
 
@@ -218,7 +224,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		set_refspecs(argv + 1, argc - 1);
 	}
 
-	rc = do_push(repo, flags);
+	rc = do_push(repo, flags, summary);
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
diff --git a/builtin.h b/builtin.h
index 20427d2..5aea3a3 100644
--- a/builtin.h
+++ b/builtin.h
@@ -113,4 +113,6 @@ extern int cmd_verify_pack(int argc, const char **argv, const char *prefix);
 extern int cmd_show_ref(int argc, const char **argv, const char *prefix);
 extern int cmd_pack_refs(int argc, const char **argv, const char *prefix);
 
+extern void print_summary_for_push_or_fetch(const char *quickref, int limit);
+
 #endif
diff --git a/transport.c b/transport.c
index de0d587..80105ae 100644
--- a/transport.c
+++ b/transport.c
@@ -11,6 +11,7 @@
 #include "bundle.h"
 #include "dir.h"
 #include "refs.h"
+#include "builtin.h"
 
 /* rsync support */
 
@@ -750,17 +751,20 @@ static const char *status_abbrev(unsigned char sha1[20])
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
 
@@ -769,6 +773,8 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 			strcat(quickref, "...");
 			type = '+';
 			msg = "forced update";
+			if (!lookup_commit_reference_gently(ref->old_sha1, 1))
+				summary_impossible = 1;
 		} else {
 			strcat(quickref, "..");
 			type = ' ';
@@ -778,9 +784,17 @@ static void print_ok_ref_status(struct ref *ref, int porcelain)
 
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
@@ -812,7 +826,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 						 "remote failed to report status", porcelain);
 		break;
 	case REF_STATUS_OK:
-		print_ok_ref_status(ref, porcelain);
+		print_ok_ref_status(ref, porcelain, summary);
 		break;
 	}
 
@@ -820,7 +834,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count, i
 }
 
 static void print_push_status(const char *dest, struct ref *refs,
-							  int verbose, int porcelain)
+							  int verbose, int porcelain, int summary)
 {
 	struct ref *ref;
 	int n = 0;
@@ -828,18 +842,18 @@ static void print_push_status(const char *dest, struct ref *refs,
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
 
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
 		    ref->status != REF_STATUS_OK)
-			n += print_one_push_status(ref, dest, n, porcelain);
+			n += print_one_push_status(ref, dest, n, porcelain, summary);
 	}
 }
 
@@ -997,7 +1011,8 @@ int transport_set_option(struct transport *transport,
 }
 
 int transport_push(struct transport *transport,
-		   int refspec_nr, const char **refspec, int flags)
+				   int refspec_nr, const char **refspec,
+				   int flags, int summary)
 {
 	verify_remote_names(refspec_nr, refspec);
 
@@ -1024,7 +1039,7 @@ int transport_push(struct transport *transport,
 
 		ret = transport->push_refs(transport, remote_refs, flags);
 
-		print_push_status(transport->url, remote_refs, verbose | porcelain, porcelain);
+		print_push_status(transport->url, remote_refs, verbose | porcelain, porcelain, summary);
 
 		if (!(flags & TRANSPORT_PUSH_DRY_RUN)) {
 			struct ref *ref;
diff --git a/transport.h b/transport.h
index 51b5397..360051e 100644
--- a/transport.h
+++ b/transport.h
@@ -68,7 +68,7 @@ int transport_set_option(struct transport *transport, const char *name,
 			 const char *value);
 
 int transport_push(struct transport *connection,
-		   int refspec_nr, const char **refspec, int flags);
+				   int refspec_nr, const char **refspec, int flags, int summary);
 
 const struct ref *transport_get_remote_refs(struct transport *transport);
 
-- 
1.6.3.3.409.g4a08
