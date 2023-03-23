Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC10C76196
	for <git@archiver.kernel.org>; Thu, 23 Mar 2023 16:47:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjCWQrq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Mar 2023 12:47:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbjCWQrE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2023 12:47:04 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [IPv6:2001:470:142:8::100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96628CDE8
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 09:46:33 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 77375241CF
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 12:22:34 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.4, from userid 1000)
        id 1pfNhy-AxJ-00
        for <git@vger.kernel.org>; Thu, 23 Mar 2023 17:22:34 +0100
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Subject: [PATCH] format-patch: add --description-file option
Date:   Thu, 23 Mar 2023 17:22:34 +0100
Message-Id: <20230323162234.995420-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When formatting patches from a detached HEAD, there is no branch
description to derive the cover letter from. While with format-patch
one could post-process the generated file (which would be ugly enough),
scripting that with send-email would be *really* ugly. So add an option
to feed a description directly.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 21 ++++++++++++++++++---
 t/t4014-format-patch.sh            | 12 ++++++++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index dfcc7da4c2..d074cce95f 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -216,6 +216,10 @@ is greater than 100 bytes, then the mode will be `message`, otherwise
 If `<mode>` is `none`, both the cover letter subject and body will be
 populated with placeholder text.
 
+--description-file=<file>::
+	Use the contents of <file> instead of the branch's description
+	for generating the cover letter.
+
 --subject-prefix=<subject prefix>::
 	Instead of the standard '[PATCH]' prefix in the subject
 	line, instead use '[<subject prefix>]'. This
diff --git a/builtin/log.c b/builtin/log.c
index bc204ea76f..3f16379a35 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1230,7 +1230,15 @@ static void show_diffstat(struct rev_info *rev,
 	fprintf(rev->diffopt.file, "\n");
 }
 
+static void read_desc_file(struct strbuf *buf, const char *desc_file)
+{
+	if (strbuf_read_file(buf, desc_file, 2000) < 0)
+		die_errno(_("unable to read branch description file '%s'"),
+			  desc_file);
+}
+
 static void prepare_cover_text(struct pretty_print_context *pp,
+			       const char *description_file,
 			       const char *branch_name,
 			       struct strbuf *sb,
 			       const char *encoding,
@@ -1244,7 +1252,9 @@ static void prepare_cover_text(struct pretty_print_context *pp,
 	if (cover_from_description_mode == COVER_FROM_NONE)
 		goto do_pp;
 
-	if (branch_name && *branch_name)
+	if (description_file && *description_file)
+		read_desc_file(&description_sb, description_file);
+	else if (branch_name && *branch_name)
 		read_branch_desc(&description_sb, branch_name);
 	if (!description_sb.len)
 		goto do_pp;
@@ -1290,6 +1300,7 @@ static void get_notes_args(struct strvec *arg, struct rev_info *rev)
 static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      struct commit *origin,
 			      int nr, struct commit **list,
+			      const char *description_file,
 			      const char *branch_name,
 			      int quiet)
 {
@@ -1328,7 +1339,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	pp.rev = rev;
 	pp.print_email_subject = 1;
 	pp_user_info(&pp, NULL, &sb, committer, encoding);
-	prepare_cover_text(&pp, branch_name, &sb, encoding, need_8bit_cte);
+	prepare_cover_text(&pp, description_file, branch_name, &sb,
+			   encoding, need_8bit_cte);
 	fprintf(rev->diffopt.file, "%s\n", sb.buf);
 
 	strbuf_release(&sb);
@@ -1865,6 +1877,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 	const char *reroll_count = NULL;
 	char *cover_from_description_arg = NULL;
+	char *description_file = NULL;
 	char *branch_name = NULL;
 	char *base_commit = NULL;
 	struct base_tree_info bases;
@@ -1908,6 +1921,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
 			    N_("cover-from-description-mode"),
 			    N_("generate parts of a cover letter based on a branch's description")),
+		OPT_FILENAME(0, "description-file", &description_file,
+			     N_("use branch description from file")),
 		OPT_CALLBACK_F(0, "subject-prefix", &rev, N_("prefix"),
 			    N_("use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback),
@@ -2290,7 +2305,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, !!output_directory,
-				  origin, nr, list, branch_name, quiet);
+				  origin, nr, list, description_file, branch_name, quiet);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(rev.diffopt.file);
 		total++;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index ffc7c60680..e585ab0b23 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1986,6 +1986,18 @@ test_expect_success 'cover letter using branch description (6)' '
 	grep hello actual
 '
 
+test_expect_success 'cover letter with --description-file' '
+	test_when_finished "rm -f description.txt" &&
+	echo "subject from file
+
+body from file" > description.txt &&
+	git checkout rebuild-1 &&
+	git format-patch --stdout --cover-letter --cover-from-description auto \
+		--description-file description.txt main >actual &&
+	grep "^Subject: \[PATCH 0/2\] subject from file$" actual &&
+	grep "^body from file$" actual
+'
+
 test_expect_success 'cover letter with nothing' '
 	git format-patch --stdout --cover-letter >actual &&
 	test_line_count = 0 actual
-- 
2.40.0.152.g15d061e6df

