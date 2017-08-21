Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49C271F667
	for <e@80x24.org>; Mon, 21 Aug 2017 10:06:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753007AbdHUKGK (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 06:06:10 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:64305 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752439AbdHUKGJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 06:06:09 -0400
Received: from localhost ([130.75.46.4]) by mrelayeu.kundenserver.de (mreue004
 [212.227.15.167]) with ESMTPSA (Nemesis) id 0MOVOL-1dghKM0hl7-005pAZ; Mon, 21
 Aug 2017 12:06:07 +0200
From:   Michael J Gruber <git@grubix.eu>
To:     git@vger.kernel.org
Cc:     hIpPy <hippy2981@gmail.com>
Subject: [PATCH] merge: save merge state earlier
Date:   Mon, 21 Aug 2017 12:06:02 +0200
Message-Id: <fe681e447791ded6db52ccd84e64e3637c08ffe5.1503309751.git.git@grubix.eu>
X-Mailer: git-send-email 2.14.1.364.ge466dba5f7
In-Reply-To: <d5bc0c8b-900f-456b-55a9-35408187d06c@grubix.eu>
References: <d5bc0c8b-900f-456b-55a9-35408187d06c@grubix.eu>
X-Provags-ID: V03:K0:+7zBKgvOcVM9KjA/kroJy/UqUfakmVzUzRuB8BDChsF5VUkEnuu
 R+dJm9haRvnqX0hk/T0wHizi8BB6wLxpd+P60XIlhzszOlYryt0vwqsVhTffswK60e8LH4s
 90zVwFBYpjNPG04hy1ZDj0N6uge/+1lpSY1WAnsfCkL6dKyi8BNDacdziKXo/QGA1yaaVG7
 szdnkj1ZHlK1mGDfYp4Vg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:B/daytHdxAM=:94HTrHXCC54E5edX6CYpEY
 eer465GQRQfJpinIi9ZyPS4K+QugRj4CYhn5VSu6Y3l78QFtVL6w4Ls9v13KEGxADeCgTDHik
 RsSkOA8hKT3KTTVOay2PVi6Rv96dBof+fNCyIOOo+dN+ylC4WYhguOMvADJ0pOo73XAwdL0FI
 IWh+wMJuXRRCrUcA5/+jjAXWeIDtEOpWGSEb8dATR5g+3TyKOKfAhmPg74rvwMbsISaEGXxKw
 v1rZnNyrjo/dih3C8TVCqvzbYP/qSJv3eSTa11o11UN1aA+VqrReOq2lPFp6YcR4xSFvHNRPz
 8Ri7ARPlfqhDds7UbyvUxTJ0nN6nK6JTheZu4meY54FWeziYRNmPmKJeGOx4+spzcFzUPohRm
 B8OowiUMp/Xvu7oyXnmq0pDgVXsoMwxYyw4ho4HKRGgvLcpB62Eg38kuccwVIjYcPVBpswCIp
 3SXG2jDMirU0C1QLvHEY5CqMqqSqrpu1nhXdxmojwfbRUisoHFzJytf87de65dNVrf1qb1pFK
 4FgUtRkyKihlVzQgmkImh2jZBUR4pajx3B7eK7VQXdiL3bp8fvXgT2mVNL6XVvsZ1hgT+uvG8
 eHCN9/iWNyVBf9AS0PJRAHx7pxl0Fxigi78T8cFn53yahT30SLXjDIKKJ9l9GlxuKay3iC60J
 lVUqs0/XkOk4QFTI4FpQA3HXLsizNKuN3s3zBPMrhqFDsXmPYhRFxAfQ+yB2P8zNWrFn/NMVY
 MsFq0uclInyej9NEjQW+XARHsqzaDUQjs38Azg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If the `git merge` process is killed while waiting for the editor to
finish, the merge state is lost but the prepared merge msg and tree is kept.
So, a subsequent `git commit` creates a squashed merge even when the
user asked for proper merge commit originally.

Save the merge state earlier (in the non-squash case) so that it does
not get lost.

Reported-by: hIpPy <hippy2981@gmail.com>
Signed-off-by: Michael J Gruber <git@grubix.eu>
---
 builtin/merge.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index cc57052993..5379b08824 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -758,6 +758,7 @@ N_("Please enter a commit message to explain why this merge is necessary,\n"
    "Lines starting with '%c' will be ignored, and an empty message aborts\n"
    "the commit.\n");
 
+static void write_merge_heads(struct commit_list *);
 static void prepare_to_commit(struct commit_list *remoteheads)
 {
 	struct strbuf msg = STRBUF_INIT;
@@ -767,6 +768,8 @@ static void prepare_to_commit(struct commit_list *remoteheads)
 		strbuf_commented_addf(&msg, _(merge_editor_comment), comment_line_char);
 	if (signoff)
 		append_signoff(&msg, ignore_non_trailer(msg.buf, msg.len), 0);
+	if (!squash)
+		write_merge_heads(remoteheads);
 	write_file_buf(git_path_merge_msg(), msg.buf, msg.len);
 	if (run_commit_hook(0 < option_edit, get_index_file(), "prepare-commit-msg",
 			    git_path_merge_msg(), "merge", NULL))
@@ -908,7 +911,7 @@ static int setup_with_upstream(const char ***argv)
 	return i;
 }
 
-static void write_merge_state(struct commit_list *remoteheads)
+static void write_merge_heads(struct commit_list *remoteheads)
 {
 	struct commit_list *j;
 	struct strbuf buf = STRBUF_INIT;
@@ -924,8 +927,6 @@ static void write_merge_state(struct commit_list *remoteheads)
 		strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
 	}
 	write_file_buf(git_path_merge_head(), buf.buf, buf.len);
-	strbuf_addch(&merge_msg, '\n');
-	write_file_buf(git_path_merge_msg(), merge_msg.buf, merge_msg.len);
 
 	strbuf_reset(&buf);
 	if (fast_forward == FF_NO)
@@ -933,6 +934,13 @@ static void write_merge_state(struct commit_list *remoteheads)
 	write_file_buf(git_path_merge_mode(), buf.buf, buf.len);
 }
 
+static void write_merge_state(struct commit_list *remoteheads)
+{
+	write_merge_heads(remoteheads);
+	strbuf_addch(&merge_msg, '\n');
+	write_file_buf(git_path_merge_msg(), merge_msg.buf, merge_msg.len);
+}
+
 static int default_edit_option(void)
 {
 	static const char name[] = "GIT_MERGE_AUTOEDIT";
-- 
2.14.1.364.ge466dba5f7

