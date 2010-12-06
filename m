From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] logging branch deletion to help recovering from mistakes
Date: Mon, 06 Dec 2010 13:16:18 -0800
Message-ID: <7vlj42siu5.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 06 22:16:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PPiQC-0003Ro-Pz
	for gcvg-git-2@lo.gmane.org; Mon, 06 Dec 2010 22:16:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625Ab0LFVQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Dec 2010 16:16:26 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47490 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399Ab0LFVQZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Dec 2010 16:16:25 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D91026F2;
	Mon,  6 Dec 2010 16:16:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:from:date:message-id:mime-version:content-type; s=sasl; bh=g4h+
	SsDjTTXDmKDkuKdhXrTSW7I=; b=H6c0b/ZTvvP/sdpMrQ+q+LJ/sTRl4ZQxdG/4
	mvDjGovWIQjdDbfbnUqSLwEdXYPchbchI+gQzVPvSxJME6JRTLGtKvYcUlieS/p6
	mRdocMrj0R1CdOZRFu4zLG4y25PP7enaqTt/AoV0hmOkmRcQ936SxanY8Xa4f5qR
	u5mKZLA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject:from
	:date:message-id:mime-version:content-type; q=dns; s=sasl; b=DqY
	kt8lN+GRJNBQ/3J8EZ+ehKKTPZt3wvvvZS3BI47Yv64hIcQbZ2nQGrXf+stHaPmL
	qLwRBoYWvLueVfcMuYyGWV3GRvz0wW0nkmJ3RYvm7cYWLV5Akuk09LmjVXI39UZN
	6l5H1Sc2wKQdpKQ92+E0cXZIoh/mWNfmAnv4q2gs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A05626F1;
	Mon,  6 Dec 2010 16:16:46 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 6EB1826F0; Mon,  6 Dec 2010
 16:16:43 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 215DC2A8-017E-11E0-B484-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163023>

This adds core.logrefdeletion configuration variable (enabled by default
in a repository with a work tree, just like core.logallrefupdates), and
logs deletion of refs via "update-ref -d", "branch -d", etc.

"git branch" learns a new "--list-deleted" option to help users view the
names of branches and the commit objects that were at the tip of them when
the branches were deleted.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This recently came up at $dayjob.  The new option is not '--undelete'
   and this is deliberate, as we do not have any information other than
   the tip of the branch to recreate tracking and other frills.

 Documentation/config.txt             |    6 +
 Documentation/git-branch.txt         |    6 +
 builtin/branch.c                     |   21 ++++-
 cache.h                              |    1 +
 config.c                             |    5 +
 environment.c                        |    1 +
 refs.c                               |  167 +++++++++++++++++++++++++---------
 refs.h                               |    2 +
 t/t1400-update-ref.sh                |   53 ++++++++++-
 t/t7701-repack-unpack-unreachable.sh |    4 +
 10 files changed, 219 insertions(+), 47 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d82c0da..bdf90eb 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -351,6 +351,12 @@ This value is true by default in a repository that has
 a working directory associated with it, and false by
 default in a bare repository.
 
+core.logRefDeletion::
+	Enable logging of eletion of refs (e.g. branches), allowing `git
+	branch --list-deleted` to help you recover branches lost by
+	running `git branch -d` by mistake.  This is enabled in a
+	repository that has a working tree associated with it by default.
+
 core.repositoryFormatVersion::
 	Internal variable identifying the repository format and layout
 	version.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 1940256..07ec47b 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -14,6 +14,7 @@ SYNOPSIS
 'git branch' [--set-upstream | --track | --no-track] [-l] [-f] <branchname> [<start-point>]
 'git branch' (-m | -M) [<oldbranch>] <newbranch>
 'git branch' (-d | -D) [-r] <branchname>...
+'git branch' --list-deleted [<pattern>...]
 
 DESCRIPTION
 -----------
@@ -70,6 +71,11 @@ OPTIONS
 -D::
 	Delete a branch irrespective of its merged status.
 
+--list-deleted::
+	List names of recently deleted branches together with the object
+	names of the commits that were at the tip of them.  Glob patterns
+	can be used to limit the branches that are shown.
+
 -l::
 	Create the branch's reflog.  This activates recording of
 	all changes made to the branch ref, enabling use of date
diff --git a/builtin/branch.c b/builtin/branch.c
index 87976f0..68604c2 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -15,6 +15,7 @@
 #include "branch.h"
 #include "diff.h"
 #include "revision.h"
+#include "string-list.h"
 
 static const char * const builtin_branch_usage[] = {
 	"git branch [options] [-r | -a] [--merged | --no-merged]",
@@ -144,6 +145,19 @@ static int branch_merged(int kind, const char *name,
 	return merged;
 }
 
+static int show_deleted(struct string_list_item *item, void *cb_data)
+{
+	printf("%s %s\n", (char *)item->util, item->string);
+	return 0;
+}
+
+static int list_deleted_branches(const char **argv)
+{
+	struct string_list *deleted = list_deleted_refs("refs/heads/", argv);
+	for_each_string_list(deleted, show_deleted, NULL);
+	return 0;
+}
+
 static int delete_branches(int argc, const char **argv, int force, int kinds)
 {
 	struct commit *rev, *head_rev = NULL;
@@ -612,7 +626,7 @@ static int opt_parse_merge_filter(const struct option *opt, const char *arg, int
 
 int cmd_branch(int argc, const char **argv, const char *prefix)
 {
-	int delete = 0, rename = 0, force_create = 0;
+	int delete = 0, rename = 0, force_create = 0, list_deleted = 0;
 	int verbose = 0, abbrev = DEFAULT_ABBREV, detached = 0;
 	int reflog = 0;
 	enum branch_track track;
@@ -652,6 +666,7 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 		OPT_BIT('M', NULL, &rename, "move/rename a branch, even if target exists", 2),
 		OPT_BOOLEAN('l', NULL, &reflog, "create the branch's reflog"),
 		OPT_BOOLEAN('f', "force", &force_create, "force creation (when already exists)"),
+		OPT_BOOLEAN(0, "list-deleted", &list_deleted, "list deleted branches"),
 		{
 			OPTION_CALLBACK, 0, "no-merged", &merge_filter_ref,
 			"commit", "print only not merged branches",
@@ -689,11 +704,13 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 
 	argc = parse_options(argc, argv, prefix, options, builtin_branch_usage,
 			     0);
-	if (!!delete + !!rename + !!force_create > 1)
+	if (!!list_deleted + !!delete + !!rename + !!force_create > 1)
 		usage_with_options(builtin_branch_usage, options);
 
 	if (delete)
 		return delete_branches(argc, argv, delete > 1, kinds);
+	else if (list_deleted)
+		return list_deleted_branches(argv);
 	else if (argc == 0)
 		return print_ref_list(kinds, detached, verbose, abbrev, with_commit);
 	else if (rename && (argc == 1))
diff --git a/cache.h b/cache.h
index 2ef2fa3..0a82612 100644
--- a/cache.h
+++ b/cache.h
@@ -537,6 +537,7 @@ extern int ignore_case;
 extern int assume_unchanged;
 extern int prefer_symlink_refs;
 extern int log_all_ref_updates;
+extern int log_ref_deletion;
 extern int warn_ambiguous_refs;
 extern int shared_repository;
 extern const char *apply_default_whitespace;
diff --git a/config.c b/config.c
index 4b0a820..cfa162a 100644
--- a/config.c
+++ b/config.c
@@ -509,6 +509,11 @@ static int git_default_core_config(const char *var, const char *value)
 		return 0;
 	}
 
+	if (!strcmp(var, "core.logrefdeletion")) {
+		log_ref_deletion = git_config_bool(var, value);
+		return 0;
+	}
+
 	if (!strcmp(var, "core.warnambiguousrefs")) {
 		warn_ambiguous_refs = git_config_bool(var, value);
 		return 0;
diff --git a/environment.c b/environment.c
index 2d0c315..12166d9 100644
--- a/environment.c
+++ b/environment.c
@@ -20,6 +20,7 @@ int assume_unchanged;
 int prefer_symlink_refs;
 int is_bare_repository_cfg = -1; /* unspecified */
 int log_all_ref_updates = -1; /* unspecified */
+int log_ref_deletion = -1; /* unspecified */
 int warn_ambiguous_refs = 1;
 int repository_format_version;
 const char *git_commit_encoding;
diff --git a/refs.c b/refs.c
index e3c0511..afdd634 100644
--- a/refs.c
+++ b/refs.c
@@ -3,11 +3,14 @@
 #include "object.h"
 #include "tag.h"
 #include "dir.h"
+#include "string-list.h"
 
 /* ISSYMREF=01 and ISPACKED=02 are public interfaces */
 #define REF_KNOWS_PEELED 04
 #define REF_BROKEN 010
 
+#define BRANCH_DELETION_LOG "DELETED-REFS"
+
 struct ref_list {
 	struct ref_list *next;
 	unsigned char flag; /* ISSYMREF? ISPACKED? */
@@ -1137,44 +1140,6 @@ static int repack_without_ref(const char *refname)
 	return commit_lock_file(&packlock);
 }
 
-int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
-{
-	struct ref_lock *lock;
-	int err, i = 0, ret = 0, flag = 0;
-
-	lock = lock_ref_sha1_basic(refname, sha1, 0, &flag);
-	if (!lock)
-		return 1;
-	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
-		/* loose */
-		const char *path;
-
-		if (!(delopt & REF_NODEREF)) {
-			i = strlen(lock->lk->filename) - 5; /* .lock */
-			lock->lk->filename[i] = 0;
-			path = lock->lk->filename;
-		} else {
-			path = git_path("%s", refname);
-		}
-		err = unlink_or_warn(path);
-		if (err && errno != ENOENT)
-			ret = 1;
-
-		if (!(delopt & REF_NODEREF))
-			lock->lk->filename[i] = '.';
-	}
-	/* removing the loose one could have resurrected an earlier
-	 * packed one.  Also, if it was not loose we need to repack
-	 * without it.
-	 */
-	ret |= repack_without_ref(refname);
-
-	unlink_or_warn(git_path("logs/%s", lock->ref_name));
-	invalidate_cached_refs();
-	unlock_ref(lock);
-	return ret;
-}
-
 /*
  * People using contrib's git-new-workdir have .git/logs/refs ->
  * /some/other/path/.git/logs/refs, and that may live on another device.
@@ -1361,11 +1326,13 @@ int log_ref_setup(const char *ref_name, char *logfile, int bufsize)
 	int logfd, oflags = O_APPEND | O_WRONLY;
 
 	git_snpath(logfile, bufsize, "logs/%s", ref_name);
-	if (log_all_ref_updates &&
-	    (!prefixcmp(ref_name, "refs/heads/") ||
-	     !prefixcmp(ref_name, "refs/remotes/") ||
-	     !prefixcmp(ref_name, "refs/notes/") ||
-	     !strcmp(ref_name, "HEAD"))) {
+	if ((log_all_ref_updates &&
+	     (!prefixcmp(ref_name, "refs/heads/") ||
+	      !prefixcmp(ref_name, "refs/remotes/") ||
+	      !prefixcmp(ref_name, "refs/notes/") ||
+	      !strcmp(ref_name, "HEAD"))) ||
+	    (log_ref_deletion &&
+	     !strcmp(ref_name, BRANCH_DELETION_LOG))) {
 		if (safe_create_leading_directories(logfile) < 0)
 			return error("unable to create directory for %s",
 				     logfile);
@@ -1407,6 +1374,8 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 
 	if (log_all_ref_updates < 0)
 		log_all_ref_updates = !is_bare_repository();
+	if (log_ref_deletion < 0)
+		log_ref_deletion = !is_bare_repository();
 
 	result = log_ref_setup(ref_name, log_file, sizeof(log_file));
 	if (result)
@@ -1432,6 +1401,118 @@ static int log_ref_write(const char *ref_name, const unsigned char *old_sha1,
 	return 0;
 }
 
+struct filter_deleted {
+	const char *pfx;
+	const char **pattern;
+	size_t pfxlen;
+	struct string_list *list;
+};
+
+static int collect_deleted(unsigned char *osha1, unsigned char *nsha1,
+			   const char *ident,
+			   unsigned long timestamp, int tz,
+			   const char *msg, void *cb_data)
+{
+	struct filter_deleted *filter = cb_data;
+	struct string_list_item *item;
+	const char *nameloc;
+	char *namebody;
+	char namebody_buf[1024];
+	size_t namebodylen;
+
+	if (prefixcmp(msg, "delete ") ||
+	    memcmp(msg + 7, filter->pfx, filter->pfxlen) ||
+	    !is_null_sha1(nsha1))
+		return 0;
+	nameloc = msg + 7 + filter->pfxlen;
+	namebodylen = strlen(nameloc); /* counts final LF */
+	if (!namebodylen || nameloc[namebodylen - 1] != '\n')
+		return 0;
+	if (sizeof(namebody_buf) <= namebodylen)
+		namebody = xmalloc(namebodylen);
+	else
+		namebody = namebody_buf;
+	memcpy(namebody, nameloc, namebodylen);
+	namebody[namebodylen - 1] = '\0';
+	if (filter->pattern[0]) {
+		int i, matches;
+		for (i = matches = 0; !matches && filter->pattern[i]; i++)
+			if (fnmatch(filter->pattern[i], namebody, 0))
+				matches = 1;
+		if (!matches)
+			goto free_return;
+	}
+	item = string_list_insert(filter->list, namebody);
+	if (!item->util)
+		item->util = xmalloc(41);
+	strcpy(item->util, sha1_to_hex(osha1));
+free_return:
+	if (namebody != namebody_buf)
+		free(namebody);
+	return 0;
+}
+
+struct string_list *list_deleted_refs(const char *pfx, const char **pattern)
+{
+	struct filter_deleted filter = { pfx, pattern };
+	filter.list = xcalloc(1, sizeof(*(filter.list)));
+	filter.list->strdup_strings = 1;
+	filter.pfxlen = strlen(pfx);
+
+	for_each_reflog_ent(BRANCH_DELETION_LOG, collect_deleted, &filter);
+	return filter.list;
+}
+
+int delete_ref(const char *refname, const unsigned char *sha1, int delopt)
+{
+	struct ref_lock *lock;
+	int err, i = 0, ret = 0, flag = 0;
+	struct strbuf logmsg = STRBUF_INIT;
+
+	lock = lock_ref_sha1_basic(refname, sha1, 0, &flag);
+	if (!lock)
+		return 1;
+	if (!(flag & REF_ISPACKED) || flag & REF_ISSYMREF) {
+		/* loose */
+		const char *path;
+
+		if (!(delopt & REF_NODEREF)) {
+			i = strlen(lock->lk->filename) - 5; /* .lock */
+			lock->lk->filename[i] = 0;
+			path = lock->lk->filename;
+		} else {
+			path = git_path("%s", refname);
+		}
+		err = unlink_or_warn(path);
+		if (err && errno != ENOENT)
+			ret = 1;
+
+		if (!(delopt & REF_NODEREF))
+			lock->lk->filename[i] = '.';
+	}
+	/*
+	 * removing the loose one could have resurrected an earlier
+	 * packed one.  Also, if it was not loose we need to repack
+	 * without it.
+	 */
+	ret |= repack_without_ref(refname);
+
+	unlink_or_warn(git_path("logs/%s", lock->ref_name));
+	invalidate_cached_refs();
+
+	strbuf_addf(&logmsg, "delete %s", refname);
+	if (log_ref_write(BRANCH_DELETION_LOG,
+			  lock->old_sha1, null_sha1, logmsg.buf))
+		/*
+		 * there isn't much we can do at this point upon
+		 * failing to record the branch deletion, and an error
+		 * messages have been already issued.
+		 */
+		;
+	unlock_ref(lock);
+	return ret;
+}
+
 static int is_branch(const char *refname)
 {
 	return !strcmp(refname, "HEAD") || !prefixcmp(refname, "refs/heads/");
diff --git a/refs.h b/refs.h
index 5e7a9a5..9fcf7ac 100644
--- a/refs.h
+++ b/refs.h
@@ -87,6 +87,8 @@ typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const
 int for_each_reflog_ent(const char *ref, each_reflog_ent_fn fn, void *cb_data);
 int for_each_recent_reflog_ent(const char *ref, each_reflog_ent_fn fn, long, void *cb_data);
 
+struct string_list *list_deleted_refs(const char *prefix, const char **pattern);
+
 /*
  * Calls the specified function for each reflog file until it returns nonzero,
  * and returns the value
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 54ba3df..ad9f461 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -9,6 +9,7 @@ test_description='Test git update-ref and basic ref logging'
 Z=0000000000000000000000000000000000000000
 
 test_expect_success setup '
+	git config core.logrefdeletion false &&
 
 	for name in A B C D E F
 	do
@@ -38,7 +39,8 @@ test_expect_success "fail to delete $m with stale ref" '
 '
 test_expect_success "delete $m" '
 	git update-ref -d $m $B &&
-	! test -f .git/$m
+	! test -f .git/$m &&
+	! test -f .git/logs/DELETED-REFS
 '
 rm -f .git/$m
 
@@ -46,7 +48,8 @@ test_expect_success "delete $m without oldvalue verification" "
 	git update-ref $m $A &&
 	test $A = \$(cat .git/$m) &&
 	git update-ref -d $m &&
-	! test -f .git/$m
+	! test -f .git/$m &&
+	! test -f .git/logs/DELETED-REFS
 "
 rm -f .git/$m
 
@@ -285,4 +288,50 @@ test_expect_success \
 	'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER)' \
 	'test OTHER = $(git cat-file blob "master@{2005-05-26 23:42}:F")'
 
+test_expect_success 'reflog for deletion' '
+	git config core.logrefdeletion yes &&
+
+	git branch frotz HEAD &&
+	git branch nitfol $A &&
+	git branch xyzzy $B &&
+
+	git branch -d frotz &&
+	git branch -D nitfol &&
+	git update-ref -d refs/heads/xyzzy &&
+	{
+		echo "$(git rev-parse HEAD) frotz"
+		echo "$A nitfol"
+		echo "$B xyzzy"
+	} >expect &&
+	git branch --list-deleted >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'reflog for deletion disabled by default in a bare repo' '
+	rm -fr test &&
+	mkdir test &&
+	(
+		cd test && git --bare init &&
+		git fetch .. HEAD:refs/heads/master HEAD:refs/heads/slave &&
+		git update-ref -d refs/heads/slave &&
+		git branch --list-deleted >actual &&
+		>expect &&
+		test_cmp expect actual
+	)
+'
+
+test_expect_success 'reflog for deletion can be enabled in a bare repo' '
+	rm -fr test &&
+	mkdir test &&
+	(
+		cd test && git --bare init &&
+		git config core.logrefdeletion yes &&
+		git fetch .. HEAD:refs/heads/master HEAD:refs/heads/slave &&
+		git update-ref -d refs/heads/slave &&
+		git branch --list-deleted >actual &&
+		echo "$(git rev-parse master) slave" >expect &&
+		test_cmp expect actual
+	)
+'
+
 test_done
diff --git a/t/t7701-repack-unpack-unreachable.sh b/t/t7701-repack-unpack-unreachable.sh
index 200ab61..f6209d2 100755
--- a/t/t7701-repack-unpack-unreachable.sh
+++ b/t/t7701-repack-unpack-unreachable.sh
@@ -9,6 +9,10 @@ csha1=
 tsha1=
 
 test_expect_success '-A with -d option leaves unreachable objects unpacked' '
+	# The test expects branch removal to lose the last reference to
+	# lost objects.  Disable branch deletion log to achieve this.
+	git config core.logrefdeletion false &&
+
 	echo content > file1 &&
 	git add . &&
 	test_tick &&
