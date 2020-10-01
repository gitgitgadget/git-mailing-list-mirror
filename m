Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B238C4727F
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 21:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41BC82075F
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 21:48:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733123AbgJAVr7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 17:47:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:63157 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgJAVr5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 17:47:57 -0400
IronPort-SDR: IXGmTuQqa4dmFIlUrrVIleJquvOvh+lFkDFLKcJ58MB0rTlBlBOE3uTq9/mvAbKNEjU9Quhwuz
 y4V830c25p9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160181040"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160181040"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 14:47:57 -0700
IronPort-SDR: YINxTK+UE60dr50PjGgZqUjfAJt3oVlvxZoUCkwN7FLwZPkdMOLQGv07+cme1Wgjw/ucG/dtP6
 TPhvGp78cc+w==
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="515689665"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.4])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 14:47:56 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 1/1] format-patch: teach format.useAutoBase "whenAble" option
Date:   Thu,  1 Oct 2020 14:46:53 -0700
Message-Id: <20201001214653.1609405-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.28.0.497.g54e85e7af1ac
In-Reply-To: <20201001214653.1609405-1-jacob.e.keller@intel.com>
References: <20201001214653.1609405-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

The format.useAutoBase configuration option exists to allow users to
enable '--base=auto' for format-patch by default.

This can sometimes lead to poor workflow, due to unexpected failures
when attempting to format an ancient patch:

    $ git format-patch -1 <an old commit>
    fatal: base commit shouldn't be in revision list

This can be very confusing, as it is not necessarily immediately obvious
that the user requested a --base (since this was in the configuration,
not on the command line).

We do want --base=auto to fail when it cannot provide a suitable base,
as it would be equally confusing if a formatted patch did not include
the base information when it was requested.

Teach format.useAutoBase a new mode, "whenAble". This mode will cause
format-patch to attempt to include a base commit when it can. However,
if no valid base commit can be found, then format-patch will continue
formatting the patch without a base commit.

In order to avoid making yet another branch name unusable with --base,
do not teach --base=whenAble or --base=whenable.

Instead, refactor the base_commit option to use a callback, and rely on
the global configuration variable auto_base.

This does mean that a user cannot request this optional base commit
generation from the command line. However, this is likely not too
valuable. If the user requests base information manually, they will be
immediately informed of the failure to acquire a suitable base commit.
This allows the user to make an informed choice about whether to
continue the format.

Add tests to cover the new mode of operation for --base.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 Documentation/config/format.txt |   4 +-
 builtin/log.c                   | 130 ++++++++++++++++++++++++++------
 t/t4014-format-patch.sh         |  22 ++++++
 3 files changed, 130 insertions(+), 26 deletions(-)

diff --git a/Documentation/config/format.txt b/Documentation/config/format.txt
index 564e8091ba5c..c2efd8758a58 100644
--- a/Documentation/config/format.txt
+++ b/Documentation/config/format.txt
@@ -96,7 +96,9 @@ format.outputDirectory::
 
 format.useAutoBase::
 	A boolean value which lets you enable the `--base=auto` option of
-	format-patch by default.
+	format-patch by default. Can also be set to "whenAble" to allow
+	enabling `--base=auto` if a suitable base is available, but to skip
+	adding base info otherwise without the format dying.
 
 format.notes::
 	Provides the default value for the `--notes` option to
diff --git a/builtin/log.c b/builtin/log.c
index b8824d898f49..55a4fd9eafeb 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -805,9 +805,15 @@ enum cover_from_description {
 	COVER_FROM_AUTO
 };
 
+enum auto_base_setting {
+	AUTO_BASE_NEVER,
+	AUTO_BASE_ALWAYS,
+	AUTO_BASE_WHEN_ABLE
+};
+
 static enum thread_level thread;
 static int do_signoff;
-static int base_auto;
+static enum auto_base_setting auto_base;
 static char *from;
 static const char *signature = git_version_string;
 static const char *signature_file;
@@ -906,7 +912,11 @@ static int git_format_config(const char *var, const char *value, void *cb)
 	if (!strcmp(var, "format.outputdirectory"))
 		return git_config_string(&config_output_directory, var, value);
 	if (!strcmp(var, "format.useautobase")) {
-		base_auto = git_config_bool(var, value);
+		if (value && !strcasecmp(value, "whenAble")) {
+			auto_base = AUTO_BASE_WHEN_ABLE;
+			return 0;
+		}
+		auto_base = git_config_bool(var, value) ? AUTO_BASE_ALWAYS : AUTO_BASE_NEVER;
 		return 0;
 	}
 	if (!strcmp(var, "format.from")) {
@@ -1424,6 +1434,23 @@ static int from_callback(const struct option *opt, const char *arg, int unset)
 	return 0;
 }
 
+static int base_callback(const struct option *opt, const char *arg, int unset)
+{
+	const char **base_commit = opt->value;
+
+	if (unset) {
+		auto_base = AUTO_BASE_NEVER;
+		*base_commit = NULL;
+	} else if (!strcmp(arg, "auto")) {
+		auto_base = AUTO_BASE_ALWAYS;
+		*base_commit = NULL;
+	} else {
+		auto_base = AUTO_BASE_NEVER;
+		*base_commit = arg;
+	}
+	return 0;
+}
+
 struct base_tree_info {
 	struct object_id base_commit;
 	int nr_patch_id, alloc_patch_id;
@@ -1436,13 +1463,36 @@ static struct commit *get_base_commit(const char *base_commit,
 {
 	struct commit *base = NULL;
 	struct commit **rev;
-	int i = 0, rev_nr = 0;
+	int i = 0, rev_nr = 0, auto_select, die_on_failure;
 
-	if (base_commit && strcmp(base_commit, "auto")) {
+	switch (auto_base) {
+	case AUTO_BASE_NEVER:
+		if (base_commit) {
+			auto_select = 0;
+			die_on_failure = 1;
+		} else {
+			/* no base information is requested */
+			return NULL;
+		}
+		break;
+	case AUTO_BASE_ALWAYS:
+	case AUTO_BASE_WHEN_ABLE:
+		if (base_commit) {
+			BUG("requested automatic base selection but a commit was provided");
+		} else {
+			auto_select = 1;
+			die_on_failure = auto_base == AUTO_BASE_ALWAYS;
+		}
+		break;
+	default:
+		BUG("unexpected automatic base selection method");
+	}
+
+	if (!auto_select) {
 		base = lookup_commit_reference_by_name(base_commit);
 		if (!base)
 			die(_("unknown commit %s"), base_commit);
-	} else if ((base_commit && !strcmp(base_commit, "auto"))) {
+	} else {
 		struct branch *curr_branch = branch_get(NULL);
 		const char *upstream = branch_get_upstream(curr_branch, NULL);
 		if (upstream) {
@@ -1450,19 +1500,32 @@ static struct commit *get_base_commit(const char *base_commit,
 			struct commit *commit;
 			struct object_id oid;
 
-			if (get_oid(upstream, &oid))
-				die(_("failed to resolve '%s' as a valid ref"), upstream);
+			if (get_oid(upstream, &oid)) {
+				if (die_on_failure)
+					die(_("failed to resolve '%s' as a valid ref"), upstream);
+				else
+					return NULL;
+			}
 			commit = lookup_commit_or_die(&oid, "upstream base");
 			base_list = get_merge_bases_many(commit, total, list);
 			/* There should be one and only one merge base. */
-			if (!base_list || base_list->next)
-				die(_("could not find exact merge base"));
+			if (!base_list || base_list->next) {
+				if (die_on_failure) {
+					die(_("could not find exact merge base"));
+				} else {
+					free_commit_list(base_list);
+					return NULL;
+				}
+			}
 			base = base_list->item;
 			free_commit_list(base_list);
 		} else {
-			die(_("failed to get upstream, if you want to record base commit automatically,\n"
-			      "please use git branch --set-upstream-to to track a remote branch.\n"
-			      "Or you could specify base commit by --base=<base-commit-id> manually"));
+			if (die_on_failure)
+				die(_("failed to get upstream, if you want to record base commit automatically,\n"
+				      "please use git branch --set-upstream-to to track a remote branch.\n"
+				      "Or you could specify base commit by --base=<base-commit-id> manually"));
+			else
+				return NULL;
 		}
 	}
 
@@ -1479,8 +1542,14 @@ static struct commit *get_base_commit(const char *base_commit,
 		for (i = 0; i < rev_nr / 2; i++) {
 			struct commit_list *merge_base;
 			merge_base = get_merge_bases(rev[2 * i], rev[2 * i + 1]);
-			if (!merge_base || merge_base->next)
-				die(_("failed to find exact merge base"));
+			if (!merge_base || merge_base->next) {
+				if (die_on_failure) {
+					die(_("failed to find exact merge base"));
+				} else {
+					free(rev);
+					return NULL;
+				}
+			}
 
 			rev[i] = merge_base->item;
 		}
@@ -1490,12 +1559,24 @@ static struct commit *get_base_commit(const char *base_commit,
 		rev_nr = DIV_ROUND_UP(rev_nr, 2);
 	}
 
-	if (!in_merge_bases(base, rev[0]))
-		die(_("base commit should be the ancestor of revision list"));
+	if (!in_merge_bases(base, rev[0])) {
+		if (die_on_failure) {
+			die(_("base commit should be the ancestor of revision list"));
+		} else {
+			free(rev);
+			return NULL;
+		}
+	}
 
 	for (i = 0; i < total; i++) {
-		if (base == list[i])
-			die(_("base commit shouldn't be in revision list"));
+		if (base == list[i]) {
+			if (die_on_failure) {
+				die(_("base commit shouldn't be in revision list"));
+			} else {
+				free(rev);
+				return NULL;
+			}
+		}
 	}
 
 	free(rev);
@@ -1638,6 +1719,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	char *branch_name = NULL;
 	char *base_commit = NULL;
 	struct base_tree_info bases;
+	struct commit *base;
 	int show_progress = 0;
 	struct progress *progress = NULL;
 	struct oid_array idiff_prev = OID_ARRAY_INIT;
@@ -1714,8 +1796,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    PARSE_OPT_OPTARG, thread_callback),
 		OPT_STRING(0, "signature", &signature, N_("signature"),
 			    N_("add a signature")),
-		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
-			   N_("add prerequisite tree info to the patch series")),
+		OPT_CALLBACK_F(0, "base", &base_commit, N_("base-commit"),
+			       N_("add prerequisite tree info to the patch series"),
+			       0, base_callback),
 		OPT_FILENAME(0, "signature-file", &signature_file,
 				N_("add a signature from a file")),
 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
@@ -1752,9 +1835,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	s_r_opt.def = "HEAD";
 	s_r_opt.revarg_opt = REVARG_COMMITTISH;
 
-	if (base_auto)
-		base_commit = "auto";
-
 	if (default_attach) {
 		rev.mime_boundary = default_attach;
 		rev.no_inline = 1;
@@ -2018,8 +2098,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	}
 
 	memset(&bases, 0, sizeof(bases));
-	if (base_commit) {
-		struct commit *base = get_base_commit(base_commit, list, nr);
+	base = get_base_commit(base_commit, list, nr);
+	if (base) {
 		reset_revision_walk();
 		clear_object_flags(UNINTERESTING);
 		prepare_bases(&bases, base, list, nr);
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 958c2da56ec6..294e76c860cf 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -2037,6 +2037,12 @@ test_expect_success 'format-patch errors out when history involves criss-cross'
 	test_must_fail 	git format-patch --base=auto -1
 '
 
+test_expect_success 'format-patch format.useAutoBase whenAble history involves criss-cross' '
+	test_config format.useAutoBase whenAble &&
+	git format-patch -1 >patch &&
+	! grep "^base-commit:" patch
+'
+
 test_expect_success 'format-patch format.useAutoBase option' '
 	git checkout local &&
 	test_config format.useAutoBase true &&
@@ -2047,6 +2053,16 @@ test_expect_success 'format-patch format.useAutoBase option' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format-patch format.useAutoBase option with whenAble' '
+	git checkout local &&
+	test_config format.useAutoBase whenAble &&
+	git format-patch --stdout -1 >patch &&
+	grep "^base-commit:" patch >actual &&
+	git rev-parse upstream >commit-id-base &&
+	echo "base-commit: $(cat commit-id-base)" >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'format-patch --base overrides format.useAutoBase' '
 	test_config format.useAutoBase true &&
 	git format-patch --stdout --base=HEAD~1 -1 >patch &&
@@ -2062,6 +2078,12 @@ test_expect_success 'format-patch --no-base overrides format.useAutoBase' '
 	! grep "^base-commit:" patch
 '
 
+test_expect_success 'format-patch --no-base overrides format.useAutoBase whenAble' '
+	test_config format.useAutoBase whenAble &&
+	git format-patch --stdout --no-base -1 >patch &&
+	! grep "^base-commit:" patch
+'
+
 test_expect_success 'format-patch --base with --attach' '
 	git format-patch --attach=mimemime --stdout --base=HEAD~ -1 >patch &&
 	sed -n -e "/^base-commit:/s/.*/1/p" -e "/^---*mimemime--$/s/.*/2/p" \
-- 
2.28.0.497.g54e85e7af1ac

