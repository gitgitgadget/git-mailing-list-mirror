Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 77B192047F
	for <e@80x24.org>; Fri, 29 Sep 2017 06:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752111AbdI2Gtv (ORCPT <rfc822;e@80x24.org>);
        Fri, 29 Sep 2017 02:49:51 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:56866
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750709AbdI2Gtl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 29 Sep 2017 02:49:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1506667780;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=Gxn0/bJPzDSTN9WyR+CbZhaOP36SnTvqK913IKNDMUE=;
        b=GQLdtDl953B0MUL4kkaZdxi9Yhge6tLZIARL9sQcNp0jOZis00G4bEAH3ZlvFITO
        e2r36z3DfSJYmF55kBKpcXtj+gxCEyCLv/Is3VBg2OEhItCzR3JJThX7YBUe330AEzK
        sY/UDCmoiUPz4ExupB+4RlwsQfEx2NydZjejYceQ=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015ecc65d750-d709dbe2-d386-406a-8dc3-326920c92cb1-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
References: <0102015ecc65d695-22151d3b-752b-4c10-a3a3-b8ef52491664-000000@eu-west-1.amazonses.com>
Subject: [PATCH v16 4/6] bisect--helper: `bisect_clean_state` shell function
 in C
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 29 Sep 2017 06:49:39 +0000
X-SES-Outgoing: 2017.09.29-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Reimplement `bisect_clean_state` shell function in C and add a
`bisect-clean-state` subcommand to `git bisect--helper` to call it from
git-bisect.sh .

Using `--bisect-clean-state` subcommand is a measure to port shell
function to C so as to use the existing test suite. As more functions
are ported, this subcommand will be retired but its implementation  will
be called by bisect_reset() and bisect_start().

Also introduce a function `mark_for_removal` to store the refs which
need to be removed while iterating through the refs.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 bisect.c                 | 42 ++++++++++++++++++++++++++++++++++++++++++
 bisect.h                 |  2 ++
 builtin/bisect--helper.c | 10 +++++++++-
 git-bisect.sh            | 26 +++-----------------------
 4 files changed, 56 insertions(+), 24 deletions(-)

diff --git a/bisect.c b/bisect.c
index 2549eaf7b1515..d8c4425812eb0 100644
--- a/bisect.c
+++ b/bisect.c
@@ -433,7 +433,12 @@ static int read_bisect_refs(void)
 
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
 static GIT_PATH_FUNC(git_path_bisect_expected_rev, "BISECT_EXPECTED_REV")
+static GIT_PATH_FUNC(git_path_bisect_ancestors_ok, "BISECT_ANCESTORS_OK")
+static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
+static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
+static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
+static GIT_PATH_FUNC(git_path_head_name, "head-name")
 
 static void read_bisect_paths(struct argv_array *array)
 {
@@ -1043,3 +1048,40 @@ int estimate_bisect_steps(int all)
 
 	return (e < 3 * x) ? n : n - 1;
 }
+
+static int mark_for_removal(const char *refname, const struct object_id *oid,
+			    int flag, void *cb_data)
+{
+	struct string_list *refs = cb_data;
+	char *ref = xstrfmt("refs/bisect%s", refname);
+	string_list_append(refs, ref);
+	return 0;
+}
+
+int bisect_clean_state(void)
+{
+	int result = 0;
+
+	/* There may be some refs packed during bisection */
+	struct string_list refs_for_removal = STRING_LIST_INIT_NODUP;
+	for_each_ref_in("refs/bisect", mark_for_removal, (void *) &refs_for_removal);
+	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
+	result = delete_refs("bisect: remove", &refs_for_removal, REF_NODEREF);
+	refs_for_removal.strdup_strings = 1;
+	string_list_clear(&refs_for_removal, 0);
+	unlink_or_warn(git_path_bisect_expected_rev());
+	unlink_or_warn(git_path_bisect_ancestors_ok());
+	unlink_or_warn(git_path_bisect_log());
+	unlink_or_warn(git_path_bisect_names());
+	unlink_or_warn(git_path_bisect_run());
+	unlink_or_warn(git_path_bisect_terms());
+	/* Cleanup head-name if it got left by an old version of git-bisect */
+	unlink_or_warn(git_path_head_name());
+	/*
+	 * Cleanup BISECT_START last to support the --no-checkout option
+	 * introduced in the commit 4796e823a.
+	 */
+	unlink_or_warn(git_path_bisect_start());
+
+	return result;
+}
diff --git a/bisect.h b/bisect.h
index acd12ef802c61..0ae63d4616dc6 100644
--- a/bisect.h
+++ b/bisect.h
@@ -28,4 +28,6 @@ extern int estimate_bisect_steps(int all);
 
 extern void read_bisect_terms(const char **bad, const char **good);
 
+extern int bisect_clean_state(void);
+
 #endif
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 2bd2d396e335d..0f4d4e41cf233 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -9,6 +9,7 @@ static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
 	N_("git bisect--helper --write-terms <bad_term> <good_term>"),
+	N_("git bisect--helper --bisect-clean-state"),
 	NULL
 };
 
@@ -83,7 +84,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
 	enum {
 		NEXT_ALL = 1,
-		WRITE_TERMS
+		WRITE_TERMS,
+		BISECT_CLEAN_STATE
 	} cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
@@ -91,6 +93,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_CMDMODE(0, "write-terms", &cmdmode,
 			 N_("write the terms to .git/BISECT_TERMS"), WRITE_TERMS),
+		OPT_CMDMODE(0, "bisect-clean-state", &cmdmode,
+			 N_("cleanup the bisection state"), BISECT_CLEAN_STATE),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -109,6 +113,10 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		if (argc != 2)
 			return error(_("--write-terms requires two arguments"));
 		return write_terms(argv[0], argv[1]);
+	case BISECT_CLEAN_STATE:
+		if (argc != 0)
+			return error(_("--bisect-clean-state requires no arguments"));
+		return bisect_clean_state();
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
 	}
diff --git a/git-bisect.sh b/git-bisect.sh
index a80fc44e524f2..045830c399873 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -186,7 +186,7 @@ bisect_start() {
 	#
 	# Get rid of any old bisect state.
 	#
-	bisect_clean_state || exit
+	git bisect--helper --bisect-clean-state || exit
 
 	#
 	# Change state.
@@ -195,7 +195,7 @@ bisect_start() {
 	# We have to trap this to be able to clean up using
 	# "bisect_clean_state".
 	#
-	trap 'bisect_clean_state' 0
+	trap 'git bisect--helper --bisect-clean-state' 0
 	trap 'exit 255' 1 2 3 15
 
 	#
@@ -430,27 +430,7 @@ bisect_reset() {
 		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
 Try 'git bisect reset <commit>'.")"
 	fi
-	bisect_clean_state
-}
-
-bisect_clean_state() {
-	# There may be some refs packed during bisection.
-	git for-each-ref --format='%(refname) %(objectname)' refs/bisect/\* |
-	while read ref hash
-	do
-		git update-ref -d $ref $hash || exit
-	done
-	rm -f "$GIT_DIR/BISECT_EXPECTED_REV" &&
-	rm -f "$GIT_DIR/BISECT_ANCESTORS_OK" &&
-	rm -f "$GIT_DIR/BISECT_LOG" &&
-	rm -f "$GIT_DIR/BISECT_NAMES" &&
-	rm -f "$GIT_DIR/BISECT_RUN" &&
-	rm -f "$GIT_DIR/BISECT_TERMS" &&
-	# Cleanup head-name if it got left by an old version of git-bisect
-	rm -f "$GIT_DIR/head-name" &&
-	git update-ref -d --no-deref BISECT_HEAD &&
-	# clean up BISECT_START last
-	rm -f "$GIT_DIR/BISECT_START"
+	git bisect--helper --bisect-clean-state || exit
 }
 
 bisect_replay () {

--
https://github.com/git/git/pull/410
