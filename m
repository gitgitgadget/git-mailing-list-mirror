Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5516AC6FA8F
	for <git@archiver.kernel.org>; Tue, 29 Aug 2023 15:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237291AbjH2PfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Aug 2023 11:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237286AbjH2PfR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Aug 2023 11:35:17 -0400
Received: from out-242.mta1.migadu.com (out-242.mta1.migadu.com [IPv6:2001:41d0:203:375::f2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90961B7
        for <git@vger.kernel.org>; Tue, 29 Aug 2023 08:35:13 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cmpwn.com; s=key1;
        t=1693323311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=XSjWFWiPl09LtZ2LpTOCU/MGy+kjBXZOwOFyfctDK0g=;
        b=QdUMbBBs+yba0qZzOZcWO9AuHAYo9gtTL7aSDUJUlVclUIfBM481GTYTE5MG8ak6cQPv+o
        ZyPl3l5UQn30qvbSHUmQLHIFfDw5EGNqxz5sqJMi4NNouMVoM9A73EHH9CayzzmwdEDiR8
        QMSAqrMYqoCxlFUrry2TlOof6K8tIK5xZ/9sTxpc7lwepHQNHydb4C5PyKHyBrS5w8UfTE
        AlLc/JIOgy+MMvjgx3kIuuNVzA0TzJXojYhSO7RUmGzZRyDo0HCNFEkL5zCBrfhtNYsbJf
        gx7jbfkAvswnmuIa+j1GP4lgnGCQXHiofWnKdfWcD8F0L1mfLfcxFuD9KnSFfw==
From:   Drew DeVault <sir@cmpwn.com>
To:     git@vger.kernel.org
Cc:     Drew DeVault <sir@cmpwn.com>
Subject: [PATCH git v3] builtin/log.c: prepend "RFC" on --rfc
Date:   Tue, 29 Aug 2023 17:34:42 +0200
Message-ID: <20230829153509.27164-1-sir@cmpwn.com>
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
v3 rewrites the --rfc handler to use OPT_BOOL and track the RFC status
separately from the subject prefix as a whole, and updates the tests and
documentation per Junio's feedback.

 Documentation/git-format-patch.txt | 18 ++++++++++++------
 builtin/log.c                      | 24 +++++++++++-------------
 t/t4014-format-patch.sh            | 12 +++++++++++-
 3 files changed, 34 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 373b46fc0d..698c197213 100644
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
+The config option format.subjectPrefix may also be used to to configure
+a subject prefix to apply to a given repository for all patches. This
+is often useful on mailing lists which receive patches for several
+repositories and can be used to disambiguate the patches (with a value
+of e.g. "PATCH my-project").
 
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
index db3a88bfe9..16f4343852 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1474,13 +1474,6 @@ static int subject_prefix_callback(const struct option *opt, const char *arg,
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
@@ -1907,6 +1900,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf rdiff_title = STRBUF_INIT;
 	struct strbuf sprefix = STRBUF_INIT;
 	int creation_factor = -1;
+	int rfc = 0;
 
 	const struct option builtin_format_patch_options[] = {
 		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
@@ -1930,9 +1924,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
@@ -2048,13 +2040,19 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (cover_from_description_arg)
 		cover_from_description_mode = parse_cover_from_description(cover_from_description_arg);
 
+	if (rfc) {
+		strbuf_addf(&sprefix, "RFC %s", rev.subject_prefix);
+	} else {
+		strbuf_addstr(&sprefix, rev.subject_prefix);
+	}
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
index 3cf2b7a7fb..5d5bc21fd1 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1373,7 +1373,17 @@ test_expect_success '--rfc' '
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
 	test_cmp expect actual
 '
 
-- 
2.42.0

