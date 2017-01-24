Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C19C620A17
	for <e@80x24.org>; Tue, 24 Jan 2017 02:11:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbdAXCLA (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jan 2017 21:11:00 -0500
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34330 "EHLO
        mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbdAXCK7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2017 21:10:59 -0500
Received: by mail-vk0-f66.google.com with SMTP id r136so12658798vke.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2017 18:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=SJhMAqR/Wi7z5VVs3FbffQCkIZAGEAVMpxMddivt8CY=;
        b=g218sDyKMIQvDtyK9aLDP5J7gBmtPp8hHzKjyWqcQ1xe3tgoey1XkO0eNIKnvJx8fr
         fSh2/qMiOXonVGaQcLWbnwVhOngI4GggRAUSIT161ucOJAEt43f6BN5bhxuccBihYwvR
         lS6CarUVlcQ+jicOxIRPbKXVcMZup6umYRzevmAK9hkd09foL0ArDjuCpiUkmggsy3Wn
         GRanCns9GS8ryU8NdIsPi8upAMf9ISx/nTOVCzqJWT3RjvOTDIrvb1o4rYJuqcyvfeM4
         JQsDBp5cVn7wEWQRQnu2tKVLXRHAt7p3kZQAq1VhFKJ7puCEQQ03XK/KvSzQDvoxglb0
         O5zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=SJhMAqR/Wi7z5VVs3FbffQCkIZAGEAVMpxMddivt8CY=;
        b=mquBKVZarY++Vy6GkZ8wtSV0FHAmWd3GD5rTMcOeG1G78Utp806DLgTcidx33FFypr
         0JZVxHMq8KGnsGxCauUN7HGDSxyHTqvkKoPZDEjaxwp3OLFGTHxfx46P0Xy6vXkf9vMP
         uJX05w0yESXchK7tB+mGli7so77l+PIGfEYOjFHpIybBUIFXPfBaIZ6xQbhTttmFdTjK
         3cLyzYU8zvPdge+jCjTJY/H2+feI0MlxuQSdZcD+Unft1hCqVA9Dt3XCXQMbz4I3aY+7
         N7n4HE/3u5n1wZN49E+iYuTfX8v4WwoZkZqSxSk9dVrJyW/DI+PHOKraXmzEHM8xgz0c
         pgQg==
X-Gm-Message-State: AIkVDXJKEBasWAMarfZUPq8SJJd3yCj4vnSW3Vo2hIBhkAptNa6E5VA7fOrn6FbT7Aw6UQ==
X-Received: by 10.31.138.9 with SMTP id m9mr12479521vkd.110.1485223858230;
        Mon, 23 Jan 2017 18:10:58 -0800 (PST)
Received: from linuxerio.cabletica.com (ip203-162-64-186.ct.co.cr. [186.64.162.203])
        by smtp.gmail.com with ESMTPSA id l24sm7173240uaf.21.2017.01.23.18.10.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jan 2017 18:10:57 -0800 (PST)
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
To:     git@vger.kernel.org
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: [PATCH] [draft]blame: add --aggregate option
Date:   Mon, 23 Jan 2017 20:10:46 -0600
Message-Id: <20170124021046.30735-1-eantoranz@gmail.com>
X-Mailer: git-send-email 2.11.0.rc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

---
 builtin/blame.c | 78 +++++++++++++++++++++++++++++++++++++--------------------
 1 file changed, 51 insertions(+), 27 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 126b8c9e5..9e8403303 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1884,6 +1884,7 @@ static const char *format_time(unsigned long time, const char *tz_str,
 #define OUTPUT_NO_AUTHOR       0200
 #define OUTPUT_SHOW_EMAIL	0400
 #define OUTPUT_LINE_PORCELAIN 01000
+#define OUTPUT_AGGREGATE      02000
 
 static void emit_porcelain_details(struct origin *suspect, int repeat)
 {
@@ -1931,43 +1932,36 @@ static void emit_porcelain(struct scoreboard *sb, struct blame_entry *ent,
 		putchar('\n');
 }
 
-static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
+/**
+ * Print information about the revision.
+ * This information can be used in either aggregated output
+ * or prepending each line of the content of the file being blamed
+ */
+static void print_revision_info(char* revision_hex, int revision_length, struct blame_entry* ent,
+		struct commit* commit, struct commit_info ci, int opt, int show_raw_time)
 {
-	int cnt;
-	const char *cp;
-	struct origin *suspect = ent->suspect;
-	struct commit_info ci;
-	char hex[GIT_SHA1_HEXSZ + 1];
-	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
-
-	get_commit_info(suspect->commit, &ci, 1);
-	sha1_to_hex_r(hex, suspect->commit->object.oid.hash);
-
-	cp = nth_line(sb, ent->lno);
-	for (cnt = 0; cnt < ent->num_lines; cnt++) {
-		char ch;
-		int length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
-
-		if (suspect->commit->object.flags & UNINTERESTING) {
+	if (opt & OUTPUT_AGGREGATE)
+		printf("\t");
+	int length = revision_length;
+			if (commit->object.flags & UNINTERESTING) {
 			if (blank_boundary)
-				memset(hex, ' ', length);
+				memset(revision_hex, ' ', length);
 			else if (!(opt & OUTPUT_ANNOTATE_COMPAT)) {
 				length--;
 				putchar('^');
 			}
 		}
 
-		printf("%.*s", length, hex);
+		printf("%.*s", length, revision_hex);
 		if (opt & OUTPUT_ANNOTATE_COMPAT) {
 			const char *name;
 			if (opt & OUTPUT_SHOW_EMAIL)
 				name = ci.author_mail.buf;
 			else
 				name = ci.author.buf;
-			printf("\t(%10s\t%10s\t%d)", name,
+			printf("\t(%10s\t%10s\t", name,
 			       format_time(ci.author_time, ci.author_tz.buf,
-					   show_raw_time),
-			       ent->lno + 1 + cnt);
+					   show_raw_time));
 		} else {
 			if (opt & OUTPUT_SHOW_SCORE)
 				printf(" %*d %02d",
@@ -1975,11 +1969,7 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 				       ent->suspect->refcnt);
 			if (opt & OUTPUT_SHOW_NAME)
 				printf(" %-*.*s", longest_file, longest_file,
-				       suspect->path);
-			if (opt & OUTPUT_SHOW_NUMBER)
-				printf(" %*d", max_orig_digits,
-				       ent->s_lno + 1 + cnt);
-
+				       ent->suspect->path);
 			if (!(opt & OUTPUT_NO_AUTHOR)) {
 				const char *name;
 				int pad;
@@ -1994,9 +1984,42 @@ static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
 						   ci.author_tz.buf,
 						   show_raw_time));
 			}
+		}
+		if (opt & OUTPUT_AGGREGATE)
+			printf(")\n");
+}
+
+static void emit_other(struct scoreboard *sb, struct blame_entry *ent, int opt)
+{
+	int cnt;
+	const char *cp;
+	struct origin *suspect = ent->suspect;
+	struct commit_info ci;
+	char hex[GIT_SHA1_HEXSZ + 1];
+	int show_raw_time = !!(opt & OUTPUT_RAW_TIMESTAMP);
+	int revision_length = (opt & OUTPUT_LONG_OBJECT_NAME) ? GIT_SHA1_HEXSZ : abbrev;
+
+	get_commit_info(suspect->commit, &ci, 1);
+	sha1_to_hex_r(hex, suspect->commit->object.oid.hash);
+
+	if (opt & OUTPUT_AGGREGATE)
+		print_revision_info(hex, revision_length, ent, suspect->commit, ci, opt, show_raw_time);
+
+	cp = nth_line(sb, ent->lno);
+	for (cnt = 0; cnt < ent->num_lines; cnt++) {
+		if (!(opt & OUTPUT_AGGREGATE))
+			print_revision_info(hex, revision_length, ent, suspect->commit, ci, opt, show_raw_time);
+		if (opt & OUTPUT_ANNOTATE_COMPAT) {
+			printf("%*d) ",
+			       max_digits, ent->lno + 1 + cnt);
+		} else {
+			if (opt & OUTPUT_SHOW_NUMBER)
+				printf(" %*d ", max_orig_digits,
+				       ent->s_lno + 1 + cnt);
 			printf(" %*d) ",
 			       max_digits, ent->lno + 1 + cnt);
 		}
+		char ch;
 		do {
 			ch = *cp++;
 			putchar(ch);
@@ -2609,6 +2632,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		{ OPTION_CALLBACK, 'C', NULL, &opt, N_("score"), N_("Find line copies within and across files"), PARSE_OPT_OPTARG, blame_copy_callback },
 		{ OPTION_CALLBACK, 'M', NULL, &opt, N_("score"), N_("Find line movements within and across files"), PARSE_OPT_OPTARG, blame_move_callback },
 		OPT_STRING_LIST('L', NULL, &range_list, N_("n,m"), N_("Process only line range n,m, counting from 1")),
+		OPT_BIT(0, "aggregate", &output_option, N_("Aggregate output"), OUTPUT_AGGREGATE),
 		OPT__ABBREV(&abbrev),
 		OPT_END()
 	};
-- 
2.11.0.rc1

