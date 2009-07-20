From: Paolo Bonzini <bonzini@gnu.org>
Subject: [PATCH 2/3] push: add --current
Date: Mon, 20 Jul 2009 13:58:13 +0200
Message-ID: <1248091094-31485-3-git-send-email-bonzini@gnu.org>
References: <1248091094-31485-1-git-send-email-bonzini@gnu.org>
Cc: gitster@pobox.com, Tay Ray Chuan <rctay89@gmail.com>,
	Bjoern Steinbrink <b.steinbrink@gmx.de>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jul 20 13:58:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MSrVz-0003gb-18
	for gcvg-git-2@gmane.org; Mon, 20 Jul 2009 13:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752988AbZGTL6Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Jul 2009 07:58:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752857AbZGTL6Z
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jul 2009 07:58:25 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:45705 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752543AbZGTL6X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Jul 2009 07:58:23 -0400
Received: from bonzini by fencepost.gnu.org with local (Exim 4.67)
	(envelope-from <bonzini@gnu.org>)
	id 1MSrVe-0001uw-Bd; Mon, 20 Jul 2009 07:58:22 -0400
X-Mailer: git-send-email 1.6.2.5
In-Reply-To: <1248091094-31485-1-git-send-email-bonzini@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123592>

This patch adds the --current option to git-push.  The option restricts
pushing to the current HEAD, even in the presence of wildcard refspecs
in the configuration.  This achieves an effect similar to the "tracking"
value of push.default, in that git push only pushes a subset of the
entire push possibilities (the difference, of course, is that these
are implicitly taken from remote.*.merge in the case of push.default =
tracking).

A secondary effect of --current is that, if there is no push.default
specified, the default push refspec will be "HEAD".  This conforms to the
idea of pushing the current branch only and is in general more intuitive.
For example in a normal configuration, "git push --current FOO" would
give an error when pushing to an empty destination if this special
behavior was not there.

The option does not make sense, and is thus disabled, if explicit refspecs
are given on the command line.

Signed-off-by: Paolo Bonzini <bonzini@gnu.org>
Cc: Tay Ray Chuan <rctay89@gmail.com>
Cc: Bjoern Steinbrink <b.steinbrink@gmx.de>
---
	In the end, I decided not to mention *how* git achieves the DWIM
	effect for 'git push --current origin', but rather just say what
	it does in which circumstances.  Having both "magic" refspecs
	'HEAD' and ':' in the same sentence was too heavy.

 Documentation/git-push.txt |   17 +++++++++++++-
 builtin-push.c             |   16 ++++++++++---
 http-push.c                |   27 ++++++++++++++++++-----
 remote.c                   |   40 +++++++++++++++++++++++++++++------
 remote.h                   |    2 +
 t/t5516-fetch-push.sh      |   50 ++++++++++++++++++++++++++++++++++++++++++++
 t/t5540-http-push.sh       |   32 ++++++++++++++++++++++++++++
 transport.c                |   22 ++++++++++++++++++-
 transport.h                |    1 +
 9 files changed, 187 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 2653388..7b1f085 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,8 +9,9 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [--dry-run] [--receive-pack=<git-receive-pack>]
-	   [--repo=<repository>] [-f | --force] [-v | --verbose]
+'git push' [--all | --mirror | --tags | --current] [--dry-run]
+	   [--receive-pack=<git-receive-pack>] [--repo=<repository>]
+	   [-f | --force] [-v | --verbose]
 	   [<repository> <refspec>...]
 
 DESCRIPTION
@@ -71,6 +72,18 @@ nor in any Push line of the corresponding remotes file---see below).
 	Instead of naming each ref to push, specifies that all
 	refs under `$GIT_DIR/refs/heads/` be pushed.
 
+--current::
+	Restrict pushing to the currently checked out branch head.
+	`git push` will determine the destination name of the current
+	branch as usual, and then push it to the given remote.  In
+	addition, if there is no refspec in the configuration, no
+	`push.default` configuration, and no remote branch whose
+	name matches the currently checked out branch, git will
+	create the current branch in the remote with the same name.
++
+This option cannot be specified if an explicit refspec is given on the
+command line, because it would be useless and possibly confusing.
+
 --mirror::
 	Instead of naming each ref to push, specifies that all
 	refs under `$GIT_DIR/refs/` (which includes but is not
diff --git a/builtin-push.c b/builtin-push.c
index e678a9d..71d94a5 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git push [--all | --mirror] [--dry-run] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git push [--all | --mirror] [--current] [--dry-run] [--porcelain] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
 
@@ -64,12 +64,17 @@ static void setup_push_tracking(void)
 	add_refspec(refspec.buf);
 }
 
-static void setup_default_push_refspecs(void)
+static void setup_default_push_refspecs(int flags)
 {
+	push_default = PUSH_DEFAULT_UNSPECIFIED;
 	git_config(git_default_config, NULL);
+	if (push_default == PUSH_DEFAULT_UNSPECIFIED)
+		push_default = (flags & TRANSPORT_PUSH_CURRENT
+				? PUSH_DEFAULT_CURRENT
+				: PUSH_DEFAULT_MATCHING);
+
 	switch (push_default) {
 	default:
-	case PUSH_DEFAULT_UNSPECIFIED:
 	case PUSH_DEFAULT_MATCHING:
 		add_refspec(":");
 		break;
@@ -127,7 +132,7 @@ static int do_push(const char *repo, int flags)
 			refspec = remote->push_refspec;
 			refspec_nr = remote->push_refspec_nr;
 		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
-			setup_default_push_refspecs();
+			setup_default_push_refspecs(flags);
 	}
 	errs = 0;
 	if (remote->pushurl_nr) {
@@ -175,6 +180,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BIT( 0 , "mirror", &flags, "mirror all refs",
 			    (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE)),
 		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
+		OPT_BIT( 0 , "current", &flags, "push current HEAD only", TRANSPORT_PUSH_CURRENT),
 		OPT_BIT( 0 , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT( 0,  "porcelain", &flags, "machine-readable output", TRANSPORT_PUSH_PORCELAIN),
 		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE),
@@ -186,6 +192,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, push_usage, 0);
 
+	if ((argc > 1 || tags) && (flags & TRANSPORT_PUSH_CURRENT))
+		return error ("Cannot give --current together with --tags or a refspec.");
 	if (tags)
 		add_refspec("refs/tags/*");
 
diff --git a/http-push.c b/http-push.c
index 00e83dc..9c93e91 100644
--- a/http-push.c
+++ b/http-push.c
@@ -14,7 +14,7 @@
 #include <expat.h>
 
 static const char http_push_usage[] =
-"git http-push [--all] [--dry-run] [--force] [--verbose] <remote> [<head>...]\n";
+"git http-push [--all] [--current] [--dry-run] [--force] [--verbose] <remote> [<head>...]\n";
 
 #ifndef XML_STATUS_OK
 enum XML_Status {
@@ -75,7 +75,7 @@ static int aborted;
 static signed char remote_dir_exists[256];
 
 static int push_verbosely;
-static int push_all = MATCH_REFS_NONE;
+static int match_flags = MATCH_REFS_NONE;
 static int force_all;
 static int dry_run;
 
@@ -1802,7 +1802,11 @@ int main(int argc, char **argv)
 
 		if (*arg == '-') {
 			if (!strcmp(arg, "--all")) {
-				push_all = MATCH_REFS_ALL;
+				match_flags |= MATCH_REFS_ALL;
+				continue;
+			}
+			if (!strcmp(arg, "--current")) {
+				match_flags |= MATCH_REFS_HEAD_ONLY;
 				continue;
 			}
 			if (!strcmp(arg, "--force")) {
@@ -1904,7 +1908,17 @@ int main(int argc, char **argv)
 		fetch_indices();
 
 	/* Get a list of all local and remote heads to validate refspecs */
-	local_refs = get_local_heads();
+	if (match_flags && MATCH_REFS_HEAD_ONLY) {
+		local_refs = get_current_head();
+		if (!local_refs) {
+			fprintf(stderr, "--current specified with no current branch.\n");
+			rc = -1;
+			goto cleanup;
+		}
+	}
+	else
+		local_refs = get_local_heads();
+
 	fprintf(stderr, "Fetching remote heads...\n");
 	get_dav_remote_heads();
 	run_request_queue();
@@ -1919,7 +1933,7 @@ int main(int argc, char **argv)
 
 	/* match them up */
 	if (match_refs(local_refs, &remote_refs,
-		       nr_refspec, (const char **) refspec, push_all)) {
+		       nr_refspec, (const char **) refspec, match_flags)) {
 		rc = -1;
 		goto cleanup;
 	}
@@ -2005,7 +2019,8 @@ int main(int argc, char **argv)
 		old_sha1_hex = NULL;
 		commit_argv[1] = "--objects";
 		commit_argv[2] = new_sha1_hex;
-		if (!push_all && !is_null_sha1(ref->old_sha1)) {
+		if (!(match_flags & MATCH_REFS_ALL)
+		    && !is_null_sha1(ref->old_sha1)) {
 			old_sha1_hex = xmalloc(42);
 			sprintf(old_sha1_hex, "^%s",
 				sha1_to_hex(ref->old_sha1));
diff --git a/remote.c b/remote.c
index c3ada2d..b5bf9a6 100644
--- a/remote.c
+++ b/remote.c
@@ -990,7 +990,7 @@ static char *guess_ref(const char *name, struct ref *peer)
 
 static int match_explicit(struct ref *src, struct ref *dst,
 			  struct ref ***dst_tail,
-			  struct refspec *rs)
+			  struct refspec *rs, int head_only)
 {
 	struct ref *matched_src, *matched_dst;
 	int copy_src;
@@ -1007,14 +1007,26 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		copy_src = 1;
 		break;
 	case 0:
-		/* The source could be in the get_sha1() format
+		/*
+		 * The source could be in the get_sha1() format,
 		 * not a reference name.  :refs/other is a
 		 * way to delete 'other' ref at the remote end.
+		 * This case however could cause unwanted references
+		 * to be stored in matched_dst->peer_ref for --current.
+		 * In that case, all we can/want handle is HEAD.
 		 */
-		matched_src = try_explicit_object_name(rs->src);
+		if (head_only) {
+			assert (!src->next);
+			if (strcmp(rs->src, "HEAD"))
+				return 0;
+			matched_src = src;
+			copy_src = 1;
+		} else {
+			matched_src = try_explicit_object_name(rs->src);
+			copy_src = 0;
+		}
 		if (!matched_src)
 			return error("src refspec %s does not match any.", rs->src);
-		copy_src = 0;
 		break;
 	default:
 		return error("src refspec %s matches more than one.", rs->src);
@@ -1068,11 +1080,11 @@ static int match_explicit(struct ref *src, struct ref *dst,
 
 static int match_explicit_refs(struct ref *src, struct ref *dst,
 			       struct ref ***dst_tail, struct refspec *rs,
-			       int rs_nr)
+			       int rs_nr, int head_only)
 {
 	int i, errs;
 	for (i = errs = 0; i < rs_nr; i++)
-		errs += match_explicit(src, dst, dst_tail, &rs[i]);
+		errs += match_explicit(src, dst, dst_tail, &rs[i], head_only);
 	return errs;
 }
 
@@ -1118,6 +1130,7 @@ int match_refs(struct ref *src, struct ref **dst,
 	struct refspec *rs;
 	int send_all = flags & MATCH_REFS_ALL;
 	int send_mirror = flags & MATCH_REFS_MIRROR;
+	int head_only = flags & MATCH_REFS_HEAD_ONLY;
 	int errs;
 	static const char *default_refspec[] = { ":", NULL };
 	struct ref **dst_tail = tail_ref(dst);
@@ -1127,7 +1140,8 @@ int match_refs(struct ref *src, struct ref **dst,
 		refspec = default_refspec;
 	}
 	rs = parse_push_refspec(nr_refspec, (const char **) refspec);
-	errs = match_explicit_refs(src, *dst, &dst_tail, rs, nr_refspec);
+	errs = match_explicit_refs(src, *dst, &dst_tail, rs, nr_refspec,
+				   head_only);
 
 	/* pick the remainder */
 	for ( ; src; src = src->next) {
@@ -1527,6 +1541,18 @@ struct ref *get_local_heads(void)
 	return local_refs;
 }
 
+struct ref *get_current_head(void)
+{
+	struct ref *local_refs = NULL, **local_tail = &local_refs;
+	struct branch *branch = branch_get(NULL);
+	unsigned char sha1[20];
+	if (branch) {
+		get_sha1(branch->refname, sha1);
+		one_local_ref(branch->refname, sha1, 0, &local_tail);
+	}
+	return local_refs;
+}
+
 struct ref *guess_remote_head(const struct ref *head,
 			      const struct ref *refs,
 			      int all)
diff --git a/remote.h b/remote.h
index 5db8420..8e5d5b4 100644
--- a/remote.h
+++ b/remote.h
@@ -137,6 +137,7 @@ enum match_refs_flags {
 	MATCH_REFS_NONE		= 0,
 	MATCH_REFS_ALL 		= (1 << 0),
 	MATCH_REFS_MIRROR	= (1 << 1),
+	MATCH_REFS_HEAD_ONLY	= (1 << 2),
 };
 
 /* Reporting of tracking info */
@@ -144,6 +145,7 @@ int stat_tracking_info(struct branch *branch, int *num_ours, int *num_theirs);
 int format_tracking_info(struct branch *branch, struct strbuf *sb);
 
 struct ref *get_local_heads(void);
+struct ref *get_current_head(void);
 /*
  * Find refs from a list which are likely to be pointed to by the given HEAD
  * ref. If 'all' is false, returns the most likely ref; otherwise, returns a
diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index 2d2633f..a480cb2 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -586,4 +586,54 @@ test_expect_success 'push with branches containing #' '
 	git checkout master
 '
 
+test_expect_success 'push --current succeeds on empty repository' '
+	git init &&
+	mkdir b.git &&
+	(cd b.git && git init --bare) &&
+	echo a > b &&
+	git add b &&
+	git commit -m a &&
+	git checkout -b branch &&
+	echo bb > b &&
+	git add b &&
+	git commit -m branch &&
+	git checkout master &&
+	git push --current b.git
+	test $(git rev-parse master) = $(cd b.git && git rev-parse master)
+'
+
+test_expect_success 'push --current always creates current branch' '
+	git checkout branch &&
+	git push --current b.git &&
+	test $(git rev-parse branch) = $(cd b.git && git rev-parse branch)
+'
+
+test_expect_success 'push --current does not push other branches' '
+	git checkout master &&
+	echo aa > b &&
+	git commit -m master2 b &&
+	git checkout branch &&
+	git push --current b.git 2>&1 | grep "Everything up-to-date" &&
+	test $(git rev-parse master^) = $(cd b.git && git rev-parse master)
+'
+
+test_expect_success 'push --current does update the current branches' '
+	echo cc > b &&
+	git commit -m branch2 b &&
+	git checkout master &&
+	git push --current b.git &&
+	test $(git rev-parse master) = $(cd b.git && git rev-parse master) &&
+	test $(git rev-parse branch^) = $(cd b.git && git rev-parse branch)
+'
+
+test_expect_success 'push --current respects configuration' '
+	git config remote.bremote.url b.git &&
+	git config remote.bremote.push refs/heads/master:refs/heads/master2 &&
+	git push --current bremote &&
+	test $(git rev-parse master) = $(cd b.git && git rev-parse master2)
+	git checkout branch &&
+	git push --current bremote 2>&1 | grep "Everything up-to-date" &&
+	test $(git rev-parse branch^) = $(cd b.git && git rev-parse branch)
+'
+
 test_done
diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index f4a2cf6..a70d13a 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -118,6 +118,38 @@ test_expect_success 'create and delete remote branch' '
 	test_must_fail git show-ref --verify refs/remotes/origin/dev
 '
 
+test_expect_success 'push --current and branch creation' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	git checkout dev &&
+	git push origin HEAD &&
+	: >path4 &&
+	git add path4 &&
+	test_tick &&
+	git commit -m dev &&
+	git checkout -b dev2 &&
+	: >path5 &&
+	git add path5 &&
+	test_tick &&
+	git commit -m dev2 &&
+	git push --current origin &&
+	git fetch &&
+	test $(git rev-parse origin/dev2) = $(git rev-parse dev2) &&
+	test $(git rev-parse origin/dev) = $(git rev-parse dev^)
+'
+
+test_expect_success 'push --current and branch update' '
+	cd "$ROOT_PATH"/test_repo_clone &&
+	: >path6 &&
+	git add path6 &&
+	test_tick &&
+	git commit -m dev2 &&
+	git checkout dev &&
+	git push --current origin &&
+	git fetch &&
+	test $(git rev-parse origin/dev) = $(git rev-parse dev) &&
+	test $(git rev-parse origin/dev2) = $(git rev-parse dev2^)
+'
+
 test_expect_success 'MKCOL sends directory names with trailing slashes' '
 
 	! grep "\"MKCOL.*[^/] HTTP/[^ ]*\"" < "$HTTPD_ROOT_PATH"/access.log
diff --git a/transport.c b/transport.c
index de0d587..c7b6aaa 100644
--- a/transport.c
+++ b/transport.c
@@ -327,6 +327,11 @@ static int rsync_transport_push(struct transport *transport,
 	if (flags & TRANSPORT_PUSH_ALL) {
 		if (for_each_ref(write_one_ref, &temp_dir))
 			return -1;
+	} else if (flags & TRANSPORT_PUSH_CURRENT) {
+		struct branch *branch = branch_get(NULL);
+		unsigned char sha1[20];
+		get_sha1(branch->name, sha1);
+		write_one_ref(branch->name, sha1, 0, &temp_dir);
 	} else if (write_refs_to_temp_dir(&temp_dir, refspec_nr, refspec))
 		return -1;
 
@@ -406,6 +411,8 @@ static int curl_transport_push(struct transport *transport, int refspec_nr, cons
 	argc = 1;
 	if (flags & TRANSPORT_PUSH_ALL)
 		argv[argc++] = "--all";
+	if (flags & TRANSPORT_PUSH_CURRENT)
+		argv[argc++] = "--current";
 	if (flags & TRANSPORT_PUSH_FORCE)
 		argv[argc++] = "--force";
 	if (flags & TRANSPORT_PUSH_DRY_RUN)
@@ -1001,12 +1008,19 @@ int transport_push(struct transport *transport,
 {
 	verify_remote_names(refspec_nr, refspec);
 
+	if (flags & TRANSPORT_PUSH_CURRENT) {
+		struct branch *branch = branch_get(NULL);
+		if (!branch)
+			return error("Tried to push current branch, but there "
+				     "is no current branch!");
+	}
+
 	if (transport->push)
 		return transport->push(transport, refspec_nr, refspec, flags);
 	if (transport->push_refs) {
 		struct ref *remote_refs =
 			transport->get_refs_list(transport, 1);
-		struct ref *local_refs = get_local_heads();
+		struct ref *local_refs;
 		int match_flags = MATCH_REFS_NONE;
 		int verbose = flags & TRANSPORT_PUSH_VERBOSE;
 		int porcelain = flags & TRANSPORT_PUSH_PORCELAIN;
@@ -1017,6 +1031,12 @@ int transport_push(struct transport *transport,
 		if (flags & TRANSPORT_PUSH_MIRROR)
 			match_flags |= MATCH_REFS_MIRROR;
 
+		if (flags & TRANSPORT_PUSH_CURRENT) {
+			local_refs = get_current_head();
+			match_flags |= MATCH_REFS_HEAD_ONLY;
+		} else
+			local_refs = get_local_heads();
+
 		if (match_refs(local_refs, &remote_refs,
 			       refspec_nr, refspec, match_flags)) {
 			return -1;
diff --git a/transport.h b/transport.h
index 51b5397..62aa243 100644
--- a/transport.h
+++ b/transport.h
@@ -36,6 +36,7 @@ struct transport {
 #define TRANSPORT_PUSH_MIRROR 8
 #define TRANSPORT_PUSH_VERBOSE 16
 #define TRANSPORT_PUSH_PORCELAIN 32
+#define TRANSPORT_PUSH_CURRENT 64
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
-- 
1.6.4.rc1.10.g26dbf.dirty
