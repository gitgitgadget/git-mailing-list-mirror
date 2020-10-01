Return-Path: <SRS0=yenB=DI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEE7C4727E
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 21:47:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF4A206A2
	for <git@archiver.kernel.org>; Thu,  1 Oct 2020 21:47:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733082AbgJAVr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Oct 2020 17:47:56 -0400
Received: from mga11.intel.com ([192.55.52.93]:63157 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726855AbgJAVr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Oct 2020 17:47:56 -0400
IronPort-SDR: aGoiDQt2uUn8wAxgPOlP9GEr7EeUBwGtfWEojhUhhZEzLX8zn8MbL+Pic2dlqJ1YLku0mgDwo5
 73VtjbJO1nFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9761"; a="160181029"
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="160181029"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 14:47:55 -0700
IronPort-SDR: gRGsAxEnw3VtLRYwNB8xV+wEHTnXYqNWiVGpDzGYfSz81MyOmsgCWbQfp7E52CnUijnDmVMGSE
 fKyGzc9LFDew==
X-IronPort-AV: E=Sophos;i="5.77,325,1596524400"; 
   d="scan'208";a="515689659"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.4])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2020 14:47:54 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH v2 0/1] teach format.useAutoBase "whenAble" option
Date:   Thu,  1 Oct 2020 14:46:52 -0700
Message-Id: <20201001214653.1609405-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.28.0.497.g54e85e7af1ac
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

This is a v2 of [1] to address comments on the mailing list. Primarily the
change is to remove the option for --base=if-able, since it is not as useful
as the configuration option. If we think it is desirable, adding back a
whenable or whenAble option is easy enough.

Here's the range diff since the v1.

1:  3c7f89213158 !  1:  cb24cf3fe8b5 format-patch: teach format.useAutoBase "whenAble" option
    @@ Commit message
         Teach format.useAutoBase a new mode, "whenAble". This mode will cause
         format-patch to attempt to include a base commit when it can. However,
         if no valid base commit can be found, then format-patch will continue
    -    formatting the patch without a base commit. --base also learns the same
    -    mode using the term "if-able".
    +    formatting the patch without a base commit.
    +
    +    In order to avoid making yet another branch name unusable with --base,
    +    do not teach --base=whenAble or --base=whenable.
    +
    +    Instead, refactor the base_commit option to use a callback, and rely on
    +    the global configuration variable auto_base.
    +
    +    This does mean that a user cannot request this optional base commit
    +    generation from the command line. However, this is likely not too
    +    valuable. If the user requests base information manually, they will be
    +    immediately informed of the failure to acquire a suitable base commit.
    +    This allows the user to make an informed choice about whether to
    +    continue the format.
     
         Add tests to cover the new mode of operation for --base.
     
         Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
    -    Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
      ## Documentation/config/format.txt ##
     @@ Documentation/config/format.txt: format.outputDirectory::
    @@ Documentation/config/format.txt: format.outputDirectory::
      format.useAutoBase::
      	A boolean value which lets you enable the `--base=auto` option of
     -	format-patch by default.
    -+	format-patch by default. Can also be set to "whenAble" to set
    -+	`--base=if-able`. This causes format-patch to include the base
    -+	commit information if it can be determined, but skip it otherwise
    -+	without dying.
    ++	format-patch by default. Can also be set to "whenAble" to allow
    ++	enabling `--base=auto` if a suitable base is available, but to skip
    ++	adding base info otherwise without the format dying.
      
      format.notes::
      	Provides the default value for the `--notes` option to
     
    - ## Documentation/git-format-patch.txt ##
    -@@ Documentation/git-format-patch.txt: you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
    - 	Record the base tree information to identify the state the
    - 	patch series applies to.  See the BASE TREE INFORMATION section
    - 	below for details. If <commit> is "auto", a base commit is
    --	automatically chosen. The `--no-base` option overrides a
    -+	automatically chosen. If <commit> is "if-able", a base commit is
    -+	included if available, however format-patch won't die if it cannot
    -+	find a valid base commit. The `--no-base` option overrides a
    - 	`format.useAutoBase` configuration.
    - 
    - --root::
    -
      ## builtin/log.c ##
     @@ builtin/log.c: enum cover_from_description {
      	COVER_FROM_AUTO
    @@ builtin/log.c: static int git_format_config(const char *var, const char *value,
      		return 0;
      	}
      	if (!strcmp(var, "format.from")) {
    +@@ builtin/log.c: static int from_callback(const struct option *opt, const char *arg, int unset)
    + 	return 0;
    + }
    + 
    ++static int base_callback(const struct option *opt, const char *arg, int unset)
    ++{
    ++	const char **base_commit = opt->value;
    ++
    ++	if (unset) {
    ++		auto_base = AUTO_BASE_NEVER;
    ++		*base_commit = NULL;
    ++	} else if (!strcmp(arg, "auto")) {
    ++		auto_base = AUTO_BASE_ALWAYS;
    ++		*base_commit = NULL;
    ++	} else {
    ++		auto_base = AUTO_BASE_NEVER;
    ++		*base_commit = arg;
    ++	}
    ++	return 0;
    ++}
    ++
    + struct base_tree_info {
    + 	struct object_id base_commit;
    + 	int nr_patch_id, alloc_patch_id;
     @@ builtin/log.c: static struct commit *get_base_commit(const char *base_commit,
      {
      	struct commit *base = NULL;
    @@ builtin/log.c: static struct commit *get_base_commit(const char *base_commit,
     +	int i = 0, rev_nr = 0, auto_select, die_on_failure;
      
     -	if (base_commit && strcmp(base_commit, "auto")) {
    -+	if (!strcmp(base_commit, "auto")) {
    -+		auto_select = 1;
    -+		die_on_failure = 1;
    -+	} else if (!strcmp(base_commit, "if-able")) {
    -+		auto_select = 1;
    -+		die_on_failure = 0;
    -+	} else {
    -+		auto_select = 0;
    -+		die_on_failure = 1;
    ++	switch (auto_base) {
    ++	case AUTO_BASE_NEVER:
    ++		if (base_commit) {
    ++			auto_select = 0;
    ++			die_on_failure = 1;
    ++		} else {
    ++			/* no base information is requested */
    ++			return NULL;
    ++		}
    ++		break;
    ++	case AUTO_BASE_ALWAYS:
    ++	case AUTO_BASE_WHEN_ABLE:
    ++		if (base_commit) {
    ++			BUG("requested automatic base selection but a commit was provided");
    ++		} else {
    ++			auto_select = 1;
    ++			die_on_failure = auto_base == AUTO_BASE_ALWAYS;
    ++		}
    ++		break;
    ++	default:
    ++		BUG("unexpected automatic base selection method");
     +	}
     +
     +	if (!auto_select) {
    @@ builtin/log.c: static struct commit *get_base_commit(const char *base_commit,
      	}
      
      	free(rev);
    +@@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
    + 	char *branch_name = NULL;
    + 	char *base_commit = NULL;
    + 	struct base_tree_info bases;
    ++	struct commit *base;
    + 	int show_progress = 0;
    + 	struct progress *progress = NULL;
    + 	struct oid_array idiff_prev = OID_ARRAY_INIT;
    +@@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
    + 			    PARSE_OPT_OPTARG, thread_callback),
    + 		OPT_STRING(0, "signature", &signature, N_("signature"),
    + 			    N_("add a signature")),
    +-		OPT_STRING(0, "base", &base_commit, N_("base-commit"),
    +-			   N_("add prerequisite tree info to the patch series")),
    ++		OPT_CALLBACK_F(0, "base", &base_commit, N_("base-commit"),
    ++			       N_("add prerequisite tree info to the patch series"),
    ++			       0, base_callback),
    + 		OPT_FILENAME(0, "signature-file", &signature_file,
    + 				N_("add a signature from a file")),
    + 		OPT__QUIET(&quiet, N_("don't print the patch filenames")),
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
      	s_r_opt.def = "HEAD";
      	s_r_opt.revarg_opt = REVARG_COMMITTISH;
      
     -	if (base_auto)
    -+	if (auto_base == AUTO_BASE_ALWAYS)
    - 		base_commit = "auto";
    -+	else if (auto_base == AUTO_BASE_WHEN_ABLE)
    -+		base_commit = "if-able";
    - 
    +-		base_commit = "auto";
    +-
      	if (default_attach) {
      		rev.mime_boundary = default_attach;
    + 		rev.no_inline = 1;
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
    - 	memset(&bases, 0, sizeof(bases));
    - 	if (base_commit) {
    - 		struct commit *base = get_base_commit(base_commit, list, nr);
    --		reset_revision_walk();
    --		clear_object_flags(UNINTERESTING);
    --		prepare_bases(&bases, base, list, nr);
    -+		if (base) {
    -+			reset_revision_walk();
    -+			clear_object_flags(UNINTERESTING);
    -+			prepare_bases(&bases, base, list, nr);
    -+		}
      	}
      
    - 	if (in_reply_to || thread || cover_letter)
    + 	memset(&bases, 0, sizeof(bases));
    +-	if (base_commit) {
    +-		struct commit *base = get_base_commit(base_commit, list, nr);
    ++	base = get_base_commit(base_commit, list, nr);
    ++	if (base) {
    + 		reset_revision_walk();
    + 		clear_object_flags(UNINTERESTING);
    + 		prepare_bases(&bases, base, list, nr);
     
      ## t/t4014-format-patch.sh ##
     @@ t/t4014-format-patch.sh: test_expect_success 'format-patch errors out when history involves criss-cross'
      	test_must_fail 	git format-patch --base=auto -1
      '
      
    -+test_expect_success 'format-patch disable base=if-able when history involves criss-cross' '
    -+	git format-patch --base=if-able -1 >patch &&
    -+	! grep "^base-commit:" patch
    -+'
    -+
     +test_expect_success 'format-patch format.useAutoBase whenAble history involves criss-cross' '
     +	test_config format.useAutoBase whenAble &&
     +	git format-patch -1 >patch &&

Jacob Keller (1):
  format-patch: teach format.useAutoBase "whenAble" option

 Documentation/config/format.txt |   4 +-
 builtin/log.c                   | 130 ++++++++++++++++++++++++++------
 t/t4014-format-patch.sh         |  22 ++++++
 3 files changed, 130 insertions(+), 26 deletions(-)

-- 
2.28.0.497.g54e85e7af1ac

