From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Teach --[no-]rerere-autoupdate option to merge, revert and
 friends
Date: Tue, 05 Jan 2010 00:16:35 -0800
Message-ID: <7viqbh2cgs.fsf_-_@alter.siamese.dyndns.org>
References: <7vljgei7rs.fsf@alter.siamese.dyndns.org>
 <7vskal5c11.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 05 09:16:54 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NS4ax-0003eZ-8L
	for gcvg-git-2@lo.gmane.org; Tue, 05 Jan 2010 09:16:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485Ab0AEIQp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jan 2010 03:16:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754421Ab0AEIQo
	(ORCPT <rfc822;git-outgoing>); Tue, 5 Jan 2010 03:16:44 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33813 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754475Ab0AEIQm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jan 2010 03:16:42 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 9B759ADDC3;
	Tue,  5 Jan 2010 03:16:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=86w3KbOVsSuMEaSjlh+flwZjAEk=; b=TbLYE+
	z9lq4IhETVYxqD7Kh4E/AO+rJE1ThlKxPvRyXgVSUhbX6xLzI4/2dOD6566BKK2a
	b1BWpAZ+RRr2nj6LC7NQUpZcibJEwdQPPfDeUdg5fkG6CbPf9vJpdnJOq+3OuWrW
	IYXvFbQL1Eqdjw5AljetA/wf1m4196zJ/3V1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YO0L+vquFUNM/5bGlpioY+WfI9VhuuOR
	iUj2YC3mzcbhRTRjxXPfP341OI1mdmGbkBqlQXs88mBAXw7lM68FOy+xln+qZhGj
	EYYsyGggpHl4LeNc074RAW4ghvXKHkbU5RUABUBdT16g8vQOGJ1A9IWPTRuJRMLj
	xLfKAxcXTZE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 891E6ADDC2;
	Tue,  5 Jan 2010 03:16:39 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 46C2AADDBE; Tue,  5 Jan 2010
 03:16:36 -0500 (EST)
In-Reply-To: <7vskal5c11.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Mon\, 04 Jan 2010 21\:57\:46 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A63BDBB8-F9D2-11DE-82A7-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136176>

Introduce a command line option to override rerere.autoupdate configuration
variable to make it more useful.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 I've had this in my private tree for quite a while and just noticed that
 I haven't sent it out.  A convenince configuration option to allow a
 potentially dangerous mode of operation must always come with an explicit
 way to disable it when necessary.

 Documentation/git-merge.txt |    7 ++++++-
 builtin-commit.c            |    2 +-
 builtin-merge.c             |    4 +++-
 builtin-rerere.c            |   23 ++++++++++++++++-------
 builtin-revert.c            |    4 +++-
 git-am.sh                   |    6 +++++-
 git-rebase.sh               |    6 +++++-
 parse-options.c             |    7 +++++++
 parse-options.h             |    3 +++
 rerere.c                    |    8 +++++---
 rerere.h                    |   10 ++++++++--
 t/t4200-rerere.sh           |   15 +++++++++++++++
 12 files changed, 77 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index e886c2e..6747031 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [-s <strategy>]...
-	[-m <msg>] <remote>...
+	 [--[no-]rerere-autoupdate] [-m <msg>] <remote>...
 'git merge' <msg> HEAD <remote>...
 
 DESCRIPTION
@@ -33,6 +33,11 @@ include::merge-options.txt[]
 	used to give a good default for automated 'git merge'
 	invocations.
 
+--rerere-autoupdate::
+--no-rerere-autoupdate::
+	Allow the rerere mechanism to update the index with the
+	result of auto-conflict resolution if possible.
+
 <remote>...::
 	Other branch heads to merge into our branch.  You need at
 	least one <remote>.  Specifying more than one <remote>
diff --git a/builtin-commit.c b/builtin-commit.c
index e93a647..72e0f0b 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -1150,7 +1150,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		     "new_index file. Check that disk is not full or quota is\n"
 		     "not exceeded, and then \"git reset HEAD\" to recover.");
 
-	rerere();
+	rerere(0);
 	run_hook(get_index_file(), "post-commit", NULL);
 	if (!quiet)
 		print_summary(prefix, commit_sha1);
diff --git a/builtin-merge.c b/builtin-merge.c
index 56a1bb6..c3faa6b 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -52,6 +52,7 @@ static struct strategy **use_strategies;
 static size_t use_strategies_nr, use_strategies_alloc;
 static const char *branch;
 static int verbosity;
+static int allow_rerere_auto;
 
 static struct strategy all_strategy[] = {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -170,6 +171,7 @@ static struct option builtin_merge_options[] = {
 		"allow fast-forward (default)"),
 	OPT_BOOLEAN(0, "ff-only", &fast_forward_only,
 		"abort if fast-forward is not possible"),
+	OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 	OPT_CALLBACK('s', "strategy", &use_strategies, "strategy",
 		"merge strategy to use", option_parse_strategy),
 	OPT_CALLBACK('m', "message", &merge_msg, "message",
@@ -790,7 +792,7 @@ static int suggest_conflicts(void)
 		}
 	}
 	fclose(fp);
-	rerere();
+	rerere(allow_rerere_auto);
 	printf("Automatic merge failed; "
 			"fix conflicts and then commit the result.\n");
 	return 1;
diff --git a/builtin-rerere.c b/builtin-rerere.c
index 343d6cd..7ec602c 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -101,15 +101,24 @@ static int diff_two(const char *file1, const char *label1,
 int cmd_rerere(int argc, const char **argv, const char *prefix)
 {
 	struct string_list merge_rr = { NULL, 0, 0, 1 };
-	int i, fd;
-
+	int i, fd, flags = 0;
+
+	if (2 < argc) {
+		if (!strcmp(argv[1], "-h"))
+			usage(git_rerere_usage);
+		if (!strcmp(argv[1], "--rerere-autoupdate"))
+			flags = RERERE_AUTOUPDATE;
+		else if (!strcmp(argv[1], "--no-rerere-autoupdate"))
+			flags = RERERE_NOAUTOUPDATE;
+		if (flags) {
+			argc--;
+			argv++;
+		}
+	}
 	if (argc < 2)
-		return rerere();
-
-	if (!strcmp(argv[1], "-h"))
-		usage(git_rerere_usage);
+		return rerere(flags);
 
-	fd = setup_rerere(&merge_rr);
+	fd = setup_rerere(&merge_rr, flags);
 	if (fd < 0)
 		return 0;
 
diff --git a/builtin-revert.c b/builtin-revert.c
index 151aa6a..857ca2e 100644
--- a/builtin-revert.c
+++ b/builtin-revert.c
@@ -38,6 +38,7 @@ static const char * const cherry_pick_usage[] = {
 static int edit, no_replay, no_commit, mainline, signoff;
 static enum { REVERT, CHERRY_PICK } action;
 static struct commit *commit;
+static int allow_rerere_auto;
 
 static const char *me;
 
@@ -57,6 +58,7 @@ static void parse_args(int argc, const char **argv)
 		OPT_BOOLEAN('r', NULL, &noop, "no-op (backward compatibility)"),
 		OPT_BOOLEAN('s', "signoff", &signoff, "add Signed-off-by:"),
 		OPT_INTEGER('m', "mainline", &mainline, "parent number"),
+		OPT_RERERE_AUTOUPDATE(&allow_rerere_auto),
 		OPT_END(),
 	};
 
@@ -395,7 +397,7 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 			die ("Error wrapping up %s", defmsg);
 		fprintf(stderr, "Automatic %s failed.%s\n",
 			me, help_msg(commit->object.sha1));
-		rerere();
+		rerere(allow_rerere_auto);
 		exit(1);
 	}
 	if (commit_lock_file(&msg_file) < 0)
diff --git a/git-am.sh b/git-am.sh
index 4838cdb..2f46fda 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -30,6 +30,7 @@ skip            skip the current patch
 abort           restore the original branch and abort the patching operation.
 committer-date-is-author-date    lie about committer date
 ignore-date     use current timestamp for author date
+rerere-autoupdate update the index with reused conflict resolution if possible
 rebasing*       (internal use for git-rebase)"
 
 . git-sh-setup
@@ -135,7 +136,7 @@ It does not apply to blobs recorded in its index."
 	    export GIT_MERGE_VERBOSITY=0
     fi
     git-merge-recursive $orig_tree -- HEAD $his_tree || {
-	    git rerere
+	    git rerere $allow_rerere_autoupdate
 	    echo Failed to merge in the changes.
 	    exit 1
     }
@@ -293,6 +294,7 @@ resolvemsg= resume= scissors= no_inbody_headers=
 git_apply_opt=
 committer_date_is_author_date=
 ignore_date=
+allow_rerere_autoupdate=
 
 while test $# != 0
 do
@@ -340,6 +342,8 @@ do
 		committer_date_is_author_date=t ;;
 	--ignore-date)
 		ignore_date=t ;;
+	--rerere-autoupdate|--no-rerere-autoupdate)
+		allow_rerere_autoupdate="$1" ;;
 	-q|--quiet)
 		GIT_QUIET=t ;;
 	--)
diff --git a/git-rebase.sh b/git-rebase.sh
index b121f45..398ea73 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -50,6 +50,7 @@ diffstat=$(git config --bool rebase.stat)
 git_am_opt=
 rebase_root=
 force_rebase=
+allow_rerere_autoupdate=
 
 continue_merge () {
 	test -n "$prev_head" || die "prev_head must be defined"
@@ -118,7 +119,7 @@ call_merge () {
 		return
 		;;
 	1)
-		git rerere
+		git rerere $allow_rerere_autoupdate
 		die "$RESOLVEMSG"
 		;;
 	2)
@@ -349,6 +350,9 @@ do
 	-f|--f|--fo|--for|--forc|force|--force-r|--force-re|--force-reb|--force-reba|--force-rebas|--force-rebase)
 		force_rebase=t
 		;;
+	--rerere-autoupdate|--no-rerere-autoupdate)
+		allow_rerere_autoupdate="$1"
+		;;
 	-*)
 		usage
 		;;
diff --git a/parse-options.c b/parse-options.c
index f559411..10ec21f 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -633,3 +633,10 @@ int parse_opt_with_commit(const struct option *opt, const char *arg, int unset)
 	commit_list_insert(commit, opt->value);
 	return 0;
 }
+
+int parse_opt_tertiary(const struct option *opt, const char *arg, int unset)
+{
+	int *target = opt->value;
+	*target = unset ? 2 : 1;
+	return 0;
+}
diff --git a/parse-options.h b/parse-options.h
index f295a2c..91c1500 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -123,6 +123,8 @@ struct option {
 				      (h), PARSE_OPT_NOARG, NULL, (p) }
 #define OPT_INTEGER(s, l, v, h)     { OPTION_INTEGER, (s), (l), (v), "n", (h) }
 #define OPT_STRING(s, l, v, a, h)   { OPTION_STRING,  (s), (l), (v), (a), (h) }
+#define OPT_UYN(s, l, v, h)         { OPTION_CALLBACK, (s), (l), (v), NULL, \
+				      (h), PARSE_OPT_NOARG, &parse_opt_tertiary }
 #define OPT_DATE(s, l, v, h) \
 	{ OPTION_CALLBACK, (s), (l), (v), "time",(h), 0, \
 	  parse_opt_approxidate_cb }
@@ -190,6 +192,7 @@ extern int parse_opt_abbrev_cb(const struct option *, const char *, int);
 extern int parse_opt_approxidate_cb(const struct option *, const char *, int);
 extern int parse_opt_verbosity_cb(const struct option *, const char *, int);
 extern int parse_opt_with_commit(const struct option *, const char *, int);
+extern int parse_opt_tertiary(const struct option *, const char *, int);
 
 #define OPT__VERBOSE(var)  OPT_BOOLEAN('v', "verbose", (var), "be verbose")
 #define OPT__QUIET(var)    OPT_BOOLEAN('q', "quiet",   (var), "be quiet")
diff --git a/rerere.c b/rerere.c
index 29f95f6..e0ac5bc 100644
--- a/rerere.c
+++ b/rerere.c
@@ -367,7 +367,7 @@ static int is_rerere_enabled(void)
 	return 1;
 }
 
-int setup_rerere(struct string_list *merge_rr)
+int setup_rerere(struct string_list *merge_rr, int flags)
 {
 	int fd;
 
@@ -375,6 +375,8 @@ int setup_rerere(struct string_list *merge_rr)
 	if (!is_rerere_enabled())
 		return -1;
 
+	if (flags & (RERERE_AUTOUPDATE|RERERE_NOAUTOUPDATE))
+		rerere_autoupdate = !!(flags & RERERE_AUTOUPDATE);
 	merge_rr_path = git_pathdup("MERGE_RR");
 	fd = hold_lock_file_for_update(&write_lock, merge_rr_path,
 				       LOCK_DIE_ON_ERROR);
@@ -382,12 +384,12 @@ int setup_rerere(struct string_list *merge_rr)
 	return fd;
 }
 
-int rerere(void)
+int rerere(int flags)
 {
 	struct string_list merge_rr = { NULL, 0, 0, 1 };
 	int fd;
 
-	fd = setup_rerere(&merge_rr);
+	fd = setup_rerere(&merge_rr, flags);
 	if (fd < 0)
 		return 0;
 	return do_plain_rerere(&merge_rr, fd);
diff --git a/rerere.h b/rerere.h
index 13313f3..10a94a4 100644
--- a/rerere.h
+++ b/rerere.h
@@ -3,9 +3,15 @@
 
 #include "string-list.h"
 
-extern int setup_rerere(struct string_list *);
-extern int rerere(void);
+#define RERERE_AUTOUPDATE   01
+#define RERERE_NOAUTOUPDATE 02
+
+extern int setup_rerere(struct string_list *, int);
+extern int rerere(int);
 extern const char *rerere_path(const char *hex, const char *file);
 extern int has_rerere_resolution(const char *hex);
 
+#define OPT_RERERE_AUTOUPDATE(v) OPT_UYN(0, "rerere-autoupdate", (v), \
+	"update the index with reused conflict resolution if possible")
+
 #endif
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index a6bc028..bb402c3 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -217,7 +217,22 @@ test_expect_success 'rerere.autoupdate' '
 	git checkout version2 &&
 	test_must_fail git merge fifth &&
 	test 0 = $(git ls-files -u | wc -l)
+'
 
+test_expect_success 'merge --rerere-autoupdate' '
+	git config --unset rerere.autoupdate
+	git reset --hard &&
+	git checkout version2 &&
+	test_must_fail git merge --rerere-autoupdate fifth &&
+	test 0 = $(git ls-files -u | wc -l)
+'
+
+test_expect_success 'merge --no-rerere-autoupdate' '
+	git config rerere.autoupdate true
+	git reset --hard &&
+	git checkout version2 &&
+	test_must_fail git merge --no-rerere-autoupdate fifth &&
+	test 2 = $(git ls-files -u | wc -l)
 '
 
 test_done
-- 
1.6.6.158.g8bda6.dirty
