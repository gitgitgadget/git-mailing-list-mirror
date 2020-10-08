Return-Path: <SRS0=Rj9+=DP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DCC8C433E7
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 16:20:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E1B3221FC
	for <git@archiver.kernel.org>; Thu,  8 Oct 2020 16:20:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="UIAh5fUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbgJHQUe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Oct 2020 12:20:34 -0400
Received: from mout02.posteo.de ([185.67.36.66]:48053 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729824AbgJHQUe (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Oct 2020 12:20:34 -0400
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 7FD1F2400FB
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 18:20:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1602174031; bh=MSHx5Ci35R/XkrOQwImAAMi7GOExWqfm9tyjTZUff9Q=;
        h=From:To:Subject:Date:From;
        b=UIAh5fUmmFuEz9pcw69yWNFdnLvJZ6YVPC9OnigDCXGtRtSaEarJJoD5fw7R6fObm
         to5XWoQGI344nxPUmSyNBNr66rzLREwwuwxnyEcDW65prnyUwqIt1GXbGzFBjJ3bo3
         GQhfiDmwF+bETNnMXbXee+ks6dKyhJGK/L5G7KOthf11toykswYG0M/odq8eph4Y/1
         xKWxaQu3VCVLQ8Qq2kuVK1FdOXqSuUmFue2U38+0wibSZnghQPSY2nIEwpqjii5DI9
         yLrjdZ+ENLKzYR/oET483PURryfUXS2aQirW3ZCXPMWJODB+004RlWumYtkwKbYYZK
         AJxlZqTzn1u9w==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4C6bz30CQjz6tmf
        for <git@vger.kernel.org>; Thu,  8 Oct 2020 18:20:30 +0200 (CEST)
From:   Robert Karszniewicz <avoidr@posteo.de>
To:     git@vger.kernel.org
Subject: [RFC PATCH] log: add log.showStat configuration variable
Date:   Thu,  8 Oct 2020 18:20:15 +0200
Message-Id: <20201008162015.23898-1-avoidr@posteo.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes default behaviour of `git log` and `git show` when no
command-line options are given. Doesn't affect behaviour otherwise (same
behaviour as with stash.showStat).
---
I've wanted to have `show` and `log` show --stat by default, and I
couldn't find any better solution for it. And I've discovered that there
is stash.showStat, which is exactly what I want. So I wanted to bring
stash.showStat to `show` and `log`.

So far, setting log.showStat affects behaviour as described in the
commit message.
But it does so for `show` and `log` at the same time. I think they
should be configurable separately. (log.showStat and show.showStat)

Before I do all the work, please tell me if this is the right approach
so far, and if the feature - when ready - would be accepted. (I'm aware
that documentation and tests are missing.)

 builtin/log.c | 22 ++++++++++++++++++----
 revision.h    |  1 +
 2 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 0a7ed4bef9..225252f0b4 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -45,6 +45,7 @@ static int default_abbrev_commit;
 static int default_show_root = 1;
 static int default_follow;
 static int default_show_signature;
+static int default_show_stat;
 static int default_encode_email_headers = 1;
 static int decoration_style;
 static int decoration_given;
@@ -151,6 +152,7 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 	rev->show_root_diff = default_show_root;
 	rev->subject_prefix = fmt_patch_subject_prefix;
 	rev->show_signature = default_show_signature;
+	rev->show_stat = default_show_stat;
 	rev->encode_email_headers = default_encode_email_headers;
 	rev->diffopt.flags.allow_textconv = 1;
 
@@ -488,6 +490,10 @@ static int git_log_config(const char *var, const char *value, void *cb)
 		default_show_signature = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "log.showstat")) {
+		default_show_stat = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (grep_config(var, value, cb) < 0)
 		return -1;
@@ -607,8 +613,11 @@ static void show_setup_revisions_tweak(struct rev_info *rev,
 			rev->dense_combined_merges = 1;
 		}
 	}
-	if (!rev->diffopt.output_format)
+	if (!rev->diffopt.output_format) {
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
+		if (rev->show_stat)
+			rev->diffopt.output_format |= DIFF_FORMAT_DIFFSTAT;
+	}
 }
 
 int cmd_show(int argc, const char **argv, const char *prefix)
@@ -727,9 +736,14 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 	    rev->prune_data.nr == 1)
 		rev->diffopt.flags.follow_renames = 1;
 
-	/* Turn --cc/-c into -p --cc/-c when -p was not given */
-	if (!rev->diffopt.output_format && rev->combine_merges)
-		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
+	if (!rev->diffopt.output_format) {
+		/* Turn --cc/-c into -p --cc/-c when -p was not given */
+		if (rev->combine_merges)
+			rev->diffopt.output_format = DIFF_FORMAT_PATCH;
+
+		if (rev->show_stat)
+			rev->diffopt.output_format |= DIFF_FORMAT_DIFFSTAT;
+	}
 
 	if (rev->first_parent_only && rev->ignore_merges < 0)
 		rev->ignore_merges = 0;
diff --git a/revision.h b/revision.h
index f6bf860d19..e402c519d8 100644
--- a/revision.h
+++ b/revision.h
@@ -204,6 +204,7 @@ struct rev_info {
 			show_merge:1,
 			show_notes_given:1,
 			show_signature:1,
+			show_stat:1,
 			pretty_given:1,
 			abbrev_commit:1,
 			abbrev_commit_given:1,
-- 
2.28.0

