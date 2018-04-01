Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40E1B1F404
	for <e@80x24.org>; Sun,  1 Apr 2018 14:07:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753453AbeDAOHG (ORCPT <rfc822;e@80x24.org>);
        Sun, 1 Apr 2018 10:07:06 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32824 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753400AbeDAOHF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Apr 2018 10:07:05 -0400
Received: by mail-wr0-f196.google.com with SMTP id z73so11457987wrb.0
        for <git@vger.kernel.org>; Sun, 01 Apr 2018 07:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id;
        bh=k5h4AcSZYqBawTffGARwvBVMhn0CHwqefEdhi+6qApw=;
        b=FC+cUX33FMXE7IHGv8InInrOBBqL6Fol6mSdb+MN3g8xdF2IZswRfm9LCRcKqmOeYO
         gJOso3zOvPFwPGzPpGXgbMBwVB7A+0Gd+4MTXnwwUuGX7QCrxMgQu5QYrubLUZqUuwFS
         b+BhUWOPeT1NfIuePAyb80r24888LPcBTm2BVk//GaVyau1ZRTx+ottWSvAVwS+Kt8qA
         mDhlKXr5QV1oJBvzQuRSKXJUWwtB2c/MZAzpS6KvuWFaj8JruI9dq+CC/nE5AZn/aaI5
         xeMAzNaJzWtIobG0exh+mumaWQLumRZEEYJbUB/J5S3bO/cwrvQaD6FzG/hwtFN029qe
         U/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id;
        bh=k5h4AcSZYqBawTffGARwvBVMhn0CHwqefEdhi+6qApw=;
        b=VscUupNXCsnBVU34Exs4SETpsClQVnjrqX8ypDSnlYkCfC8w7jNTrA03M3ztu+SQjT
         lu8qCtUGj3fgGOpjEwBAOBoHYRGvaUfNHGEy4L8wB6nPiPBcfyRDk4bDyTcnTMCcwkfJ
         goUsPE+a1QYCMhpU3NqUHsAOt4Gkoe8tbaahq5R8u7Wa+ZpHtxzZrqPCMEknbXDb0qs9
         njLzOGPmUn9aOitKEroegEcqBifPgJiutG3K7JuupUZume0K4XuJOVWDBMJ0Tq/0rFLO
         XUs3PTHmDEA3X8gTsYmvY0+nzOXsChrOJD7FhE9LX3sg5am+qWuBQeaer8Xtrspszfdz
         64dg==
X-Gm-Message-State: AElRT7EYeby8fwctVrP1EQMeGJ44VRDGRbfE7K3/Ah/Ri0pcjqg3Enlt
        jGNLKjrWAFVoTq1snUZxyTirYw==
X-Google-Smtp-Source: AIpwx48fHFjCnAmsgDcjCS91yRQZ6SsmWRchHhksXBiBxhc9YcIL5rqGcg6wGkfHKJSyKnzGzE0S2w==
X-Received: by 10.223.130.194 with SMTP id 60mr4578585wrc.46.1522591624608;
        Sun, 01 Apr 2018 07:07:04 -0700 (PDT)
Received: from jupiter.home.aloni.org ([176.231.4.11])
        by smtp.gmail.com with ESMTPSA id e27sm27497174wre.86.2018.04.01.07.07.03
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 01 Apr 2018 07:07:03 -0700 (PDT)
From:   Dan Aloni <alonid@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH] builtin/commit.c: prevent bad commits
Date:   Sun,  1 Apr 2018 17:06:50 +0300
Message-Id: <20180401140650.18928-1-alonid@gmail.com>
X-Mailer: git-send-email 2.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These commits which have hashes starting with the hex string 'bad',
always give me the chills. Why should a perfectly good commit be
jinxed?

Statistically, one of 4096 commits may be 'bad'. This change adds a
'--prevent-bad' switch to the commit command in order to prevent such
commit hashes from being generated. Internally, the commit is retried
with a slight commit meta-data modification - a newline is added to the
end of the commit message. The meta-data change results in a different
hash, that if we are lucky enough (4095/4096 chance) may not be 'bad'.

Note that this change does not affect actual software quality maintained
using Git. Thus, it is recommended keep testing all generated versions
regardless of commit hash jinxes.

Signed-off-by: Dan Aloni <alonid@gmail.com>
---
 builtin/commit.c | 34 +++++++++++++++++++++++++++++-----
 1 file changed, 29 insertions(+), 5 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 37fcb55ab0a0..afaa7cefaedf 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -89,6 +89,7 @@ static int edit_flag = -1; /* unspecified */
 static int quiet, verbose, no_verify, allow_empty, dry_run, renew_authorship;
 static int config_commit_verbose = -1; /* unspecified */
 static int no_post_rewrite, allow_empty_message;
+static int prevent_bad;
 static char *untracked_files_arg, *force_date, *ignore_submodule_arg, *ignored_arg;
 static char *sign_commit;
 
@@ -1449,6 +1450,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('z', "null", &s.null_termination,
 			 N_("terminate entries with NUL")),
 		OPT_BOOL(0, "amend", &amend, N_("amend previous commit")),
+		OPT_BOOL(0, "prevent-bad", &prevent_bad, N_("prevent a bad commit")),
 		OPT_BOOL(0, "no-post-rewrite", &no_post_rewrite, N_("bypass post-rewrite hook")),
 		{ OPTION_STRING, 'u', "untracked-files", &untracked_files_arg, N_("mode"), N_("show untracked files, optional modes: all, normal, no. (Default: all)"), PARSE_OPT_OPTARG, NULL, (intptr_t)"all" },
 		/* end commit contents options */
@@ -1583,12 +1585,34 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		append_merge_tag_headers(parents, &tail);
 	}
 
-	if (commit_tree_extended(sb.buf, sb.len, &active_cache_tree->oid,
-				 parents, &oid, author_ident.buf, sign_commit,
-				 extra)) {
-		rollback_index_files();
-		die(_("failed to write commit object"));
+	for (;;) {
+		char *oid_hex;
+		struct commit_list *copy_parents;
+
+		copy_parents = copy_commit_list(parents);
+
+		if (commit_tree_extended(sb.buf, sb.len, &active_cache_tree->oid,
+					 parents, &oid, author_ident.buf, sign_commit,
+					 extra)) {
+			rollback_index_files();
+			die(_("failed to write commit object"));
+		}
+
+		oid_hex = oid_to_hex(&oid);
+		if (prevent_bad &&
+		    oid_hex[0] == 'b' &&
+		    oid_hex[1] == 'a' &&
+		    oid_hex[2] == 'd' )
+		{
+			parents = copy_parents;
+			strbuf_add(&sb, "\n", 1);
+			continue;
+		}
+
+		free_commit_list(copy_parents);
+		break;
 	}
+
 	strbuf_release(&author_ident);
 	free_commit_extra_headers(extra);
 
-- 
2.14.3

