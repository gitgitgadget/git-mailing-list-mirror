Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 733C2C0015E
	for <git@archiver.kernel.org>; Wed,  9 Aug 2023 17:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjHIRPq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Aug 2023 13:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232820AbjHIRPi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2023 13:15:38 -0400
Received: from bluemchen.kde.org (bluemchen.kde.org [209.51.188.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12211FF7
        for <git@vger.kernel.org>; Wed,  9 Aug 2023 10:15:37 -0700 (PDT)
Received: from ugly.fritz.box (localhost [127.0.0.1])
        by bluemchen.kde.org (Postfix) with ESMTP id 3A35B241A6;
        Wed,  9 Aug 2023 13:15:31 -0400 (EDT)
Received: by ugly.fritz.box (masqmail 0.3.6-dev, from userid 1000)
        id 1qTmmQ-lCf-00; Wed, 09 Aug 2023 19:15:30 +0200
From:   Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] format-patch: add --description-file option
Date:   Wed,  9 Aug 2023 19:15:30 +0200
Message-Id: <20230809171530.2564724-1-oswald.buddenhagen@gmx.de>
X-Mailer: git-send-email 2.40.0.152.g15d061e6df
In-Reply-To: <xmqqttta9h6a.fsf@gitster.g>
References: <xmqqttta9h6a.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch makes it possible to directly feed a branch description to
derive the cover letter from. The use case is formatting dynamically
created temporary commits which are not referenced anywhere.

The most obvious alternative would be creating a temporary branch and
setting a description on it, but that doesn't seem particularly elegant.

One could also post-process the cover letter. This would be conceptually
ugly due to having to make assumptions about its format, and hooking
this into send-email would be *really* ugly.

As a variation of that, one could make it possible to feed a template
for the cover letter, into which the description could be embedded for
the given use case. This would still need to make assumptions about the
template, so while not as fragile, it would be still conceptually ugly,
and simply not a good fit for the given use case.

Signed-off-by: Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
---
v2:
- improve commit message

Cc: Jeff King <peff@peff.net>
Cc: Taylor Blau <me@ttaylorr.com>
Cc: Derrick Stolee <derrickstolee@github.com>
Cc: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-format-patch.txt |  4 ++++
 builtin/log.c                      | 21 ++++++++++++++++++---
 t/t4014-format-patch.sh            | 12 ++++++++++++
 3 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 373b46fc0d..8e515c7dbb 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -215,6 +215,10 @@ is greater than 100 bytes, then the mode will be `message`, otherwise
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
index 1b119eaf0b..9c4738bbde 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1255,7 +1255,15 @@ static void show_diffstat(struct rev_info *rev,
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
@@ -1269,7 +1277,9 @@ static void prepare_cover_text(struct pretty_print_context *pp,
 	if (cover_from_description_mode == COVER_FROM_NONE)
 		goto do_pp;
 
-	if (branch_name && *branch_name)
+	if (description_file && *description_file)
+		read_desc_file(&description_sb, description_file);
+	else if (branch_name && *branch_name)
 		read_branch_desc(&description_sb, branch_name);
 	if (!description_sb.len)
 		goto do_pp;
@@ -1315,6 +1325,7 @@ static void get_notes_args(struct strvec *arg, struct rev_info *rev)
 static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      struct commit *origin,
 			      int nr, struct commit **list,
+			      const char *description_file,
 			      const char *branch_name,
 			      int quiet)
 {
@@ -1354,7 +1365,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 	pp.rev = rev;
 	pp.print_email_subject = 1;
 	pp_user_info(&pp, NULL, &sb, committer, encoding);
-	prepare_cover_text(&pp, branch_name, &sb, encoding, need_8bit_cte);
+	prepare_cover_text(&pp, description_file, branch_name, &sb,
+			   encoding, need_8bit_cte);
 	fprintf(rev->diffopt.file, "%s\n", sb.buf);
 
 	strbuf_release(&sb);
@@ -1895,6 +1907,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	int quiet = 0;
 	const char *reroll_count = NULL;
 	char *cover_from_description_arg = NULL;
+	char *description_file = NULL;
 	char *branch_name = NULL;
 	char *base_commit = NULL;
 	struct base_tree_info bases;
@@ -1938,6 +1951,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "cover-from-description", &cover_from_description_arg,
 			    N_("cover-from-description-mode"),
 			    N_("generate parts of a cover letter based on a branch's description")),
+		OPT_FILENAME(0, "description-file", &description_file,
+			     N_("use branch description from file")),
 		OPT_CALLBACK_F(0, "subject-prefix", &rev, N_("prefix"),
 			    N_("use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback),
@@ -2323,7 +2338,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, !!output_directory,
-				  origin, nr, list, branch_name, quiet);
+				  origin, nr, list, description_file, branch_name, quiet);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(rev.diffopt.file);
 		total++;
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 3cf2b7a7fb..b31401876b 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1991,6 +1991,18 @@ test_expect_success 'cover letter using branch description (6)' '
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

