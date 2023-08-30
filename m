Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D930EC83F01
	for <git@archiver.kernel.org>; Wed, 30 Aug 2023 18:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbjH3S3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241260AbjH3Gqz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2023 02:46:55 -0400
X-Greylist: delayed 143854 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Aug 2023 23:46:49 PDT
Received: from out-250.mta1.migadu.com (out-250.mta1.migadu.com [95.215.58.250])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22923194
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 23:46:49 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1693378007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZvUG/BCMQMkpbINEiKv/ICZjh1vBKc6jucgIPQlfXFI=;
        b=ZwTPOc+mC9alPGiVJfYHPYfvD6tEDLAXQqvZOCvpfZywetyg7jlugsHLu6UW+ROx+BjgPv
        VuA7JdmPZJLJCWSoyfkUoSj/raokd/aibCMxTWRV/piCORhc7C6XFd2xyl0POPIlZKUGjb
        HqaGJ3uaF/rxTdP3+Tr2zPgksUYsi3N/LipnFUJPbSzW1RBiE5MUUbSD1shVLD12ghTj6h
        GmQktA226cIlimUb6+uwEOMubeehG5/o5u6yux5RHdeQF0cKdyEaRlMl2WHZVUJV5J0ESr
        3DsFYE4DLdobrajBh+jHoOSnlCIyZos5NjCET32rZU1fTMM4ooG7Irj4EGdj+g==
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH v4] format-patch: --rfc honors what --subject-prefix sets
Date:   Wed, 30 Aug 2023 08:43:33 +0200
Message-ID: <20230830064646.30904-1-sir@cmpwn.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rather than replacing the configured subject prefix (either through the
git config or command line) entirely with "RFC PATCH", this change
prepends RFC to whatever subject prefix was already in use.

This is useful, for example, when a user is working on a repository that
has a subject prefix considered to disambiguate patches:

	git config format.subjectPrefix 'PATCH my-project'

Prior to this change, formatting patches with --rfc would lose the
'my-project' information.

Signed-off-by: Drew DeVault <sir@cmpwn.com>
---
v4 refactors --subject-prefix to interact directly with the sbuffer same
as anything else that manipulates the prefix. Thanks for the suggestion,
Junio, this is much better.

Minor correction to the documentation is also included, and a second
test just for good measure which demonstrates that the order of
arguments no longer important.

 Documentation/git-format-patch.txt | 18 +++++++++++------
 builtin/log.c                      | 31 +++++++++++++++---------------
 t/t4014-format-patch.sh            | 22 ++++++++++++++++++++-
 3 files changed, 48 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 373b46fc0d..b96e142a8d 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -217,9 +217,15 @@ populated with placeholder text.
 
 --subject-prefix=<subject prefix>::
 	Instead of the standard '[PATCH]' prefix in the subject
-	line, instead use '[<subject prefix>]'. This
-	allows for useful naming of a patch series, and can be
-	combined with the `--numbered` option.
+	line, instead use '[<subject prefix>]'. This can be used
+	to name a patch series, and can be combined with the
+	`--numbered` option.
++
+The configuration variable `format.subjectPrefix` may also be used
+to to configure a subject prefix to apply to a given repository for
+all patches. This is often useful on mailing lists which receive
+patches for several repositories and can be used to disambiguate
+the patches (with a value of e.g. "PATCH my-project").
 
 --filename-max-length=<n>::
 	Instead of the standard 64 bytes, chomp the generated output
@@ -229,9 +235,9 @@ populated with placeholder text.
 	variable, or 64 if unconfigured.
 
 --rfc::
-	Alias for `--subject-prefix="RFC PATCH"`. RFC means "Request For
-	Comments"; use this when sending an experimental patch for
-	discussion rather than application.
+	Prepends "RFC" to the subject prefix (producing "RFC PATCH" by
+	default). RFC means "Request For Comments"; use this when sending
+	an experimental patch for discussion rather than application.
 
 -v <n>::
 --reroll-count=<n>::
diff --git a/builtin/log.c b/builtin/log.c
index db3a88bfe9..29c86dc798 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1468,19 +1468,16 @@ static int subject_prefix = 0;
 static int subject_prefix_callback(const struct option *opt, const char *arg,
 			    int unset)
 {
+	struct strbuf *sprefix;
+
 	BUG_ON_OPT_NEG(unset);
+	sprefix = (struct strbuf *)opt->value;
 	subject_prefix = 1;
-	((struct rev_info *)opt->value)->subject_prefix = arg;
+	strbuf_reset(sprefix);
+	strbuf_addstr(sprefix, arg);
 	return 0;
 }
 
-static int rfc_callback(const struct option *opt, const char *arg, int unset)
-{
-	BUG_ON_OPT_NEG(unset);
-	BUG_ON_OPT_ARG(arg);
-	return subject_prefix_callback(opt, "RFC PATCH", unset);
-}
-
 static int numbered_cmdline_opt = 0;
 
 static int numbered_callback(const struct option *opt, const char *arg,
@@ -1907,6 +1904,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf rdiff_title = STRBUF_INIT;
 	struct strbuf sprefix = STRBUF_INIT;
 	int creation_factor = -1;
+	int rfc = 0;
 
 	const struct option builtin_format_patch_options[] = {
 		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
@@ -1930,13 +1928,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("mark the series as Nth re-roll")),
 		OPT_INTEGER(0, "filename-max-length", &fmt_patch_name_max,
 			    N_("max length of output filename")),
-		OPT_CALLBACK_F(0, "rfc", &rev, NULL,
-			    N_("use [RFC PATCH] instead of [PATCH]"),
-			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback),
+		OPT_BOOL(0, "rfc", &rfc, N_("use [RFC PATCH] instead of [PATCH]")),
 		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
 			    N_("cover-from-description-mode"),
 			    N_("generate parts of a cover letter based on a branch's description")),
-		OPT_CALLBACK_F(0, "subject-prefix", &rev, N_("prefix"),
+		OPT_CALLBACK_F(0, "subject-prefix", &sprefix, N_("prefix"),
 			    N_("use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback),
 		OPT_CALLBACK_F('o', "output-directory", &output_directory,
@@ -2016,11 +2012,11 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.max_parents = 1;
 	rev.diffopt.flags.recursive = 1;
 	rev.diffopt.no_free = 1;
-	rev.subject_prefix = fmt_patch_subject_prefix;
 	memset(&s_r_opt, 0, sizeof(s_r_opt));
 	s_r_opt.def = "HEAD";
 	s_r_opt.revarg_opt = REVARG_COMMITTISH;
 
+	strbuf_addstr(&sprefix, fmt_patch_subject_prefix);
 	if (format_no_prefix)
 		diff_set_noprefix(&rev.diffopt);
 
@@ -2048,13 +2044,16 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
+	if (rfc)
+		strbuf_insertstr(&sprefix, 0, "RFC ");
+
 	if (reroll_count) {
-		strbuf_addf(&sprefix, "%s v%s",
-			    rev.subject_prefix, reroll_count);
+		strbuf_addf(&sprefix, " v%s", reroll_count);
 		rev.reroll_count = reroll_count;
-		rev.subject_prefix = sprefix.buf;
 	}
 
+	rev.subject_prefix = sprefix.buf;
+
 	for (i = 0; i < extra_hdr.nr; i++) {
 		strbuf_addstr(&buf, extra_hdr.items[i].string);
 		strbuf_addch(&buf, '\n');
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 3cf2b7a7fb..9fa1f3bc7a 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1373,7 +1373,27 @@ test_expect_success '--rfc' '
 	Subject: [RFC PATCH 1/1] header with . in it
 	EOF
 	git format-patch -n -1 --stdout --rfc >patch &&
-	grep ^Subject: patch >actual &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--rfc does not overwrite prefix' '
+	cat >expect <<-\EOF &&
+	Subject: [RFC PATCH foobar 1/1] header with . in it
+	EOF
+	git -c format.subjectPrefix="PATCH foobar" \
+		format-patch -n -1 --stdout --rfc >patch &&
+	grep "^Subject:" patch >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success '--rfc is argument order independent' '
+	cat >expect <<-\EOF &&
+	Subject: [RFC PATCH foobar 1/1] header with . in it
+	EOF
+	git format-patch -n -1 --stdout --rfc \
+		--subject-prefix="PATCH foobar" >patch &&
+	grep "^Subject:" patch >actual &&
 	test_cmp expect actual
 '
 
-- 
2.42.0

