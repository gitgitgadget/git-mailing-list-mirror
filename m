Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A24B8C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 04:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384109AbiDUErW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 00:47:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiDUErU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 00:47:20 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E28D63F2
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 21:44:32 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id u15so352151ple.4
        for <git@vger.kernel.org>; Wed, 20 Apr 2022 21:44:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P3zkzdTOHNU6nH/1YIgKo9v7oZWtuLj6EXgc86UMESU=;
        b=Nbzm4cABHpZ+MKXAtLqZuMTx0SDrujoK5FMTBIkXPe55zedvnMGqV2XHG9NknCh7Yc
         xef0TmvzrtyMan/rz0nkd1tvPEYNDyVAOIfOYs8OXpflcP4xQlkKtjuuXBxbtVSoZOo4
         cTXnhLeDQBBQESlfcg1Z4kjKkTmgoempE5w+4a9wUUTT5kDYPhKs+3aQL8+HUErWRtyL
         Inxk+l/muYV0ZmUk67kj9SIdyICdGtQe4Lz/Z4yyEvwRipGyMDcNN4hpHXd8jV3VSeUc
         B4o4K7Wz6DfE6TRj7miA4OPsntwRHMs8K+m3e3+GRW04/4NqhBOF/Pg32eJ3CmdL2dO1
         Carg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3zkzdTOHNU6nH/1YIgKo9v7oZWtuLj6EXgc86UMESU=;
        b=gwc/ze1Wrji54HgAOkllyJ/PaiCjIMn6IoJbYzvtT4LJAYKPasmd0b9QG8VxJIFAe9
         nVf8BGcLen8iGE8+KlokVVa+N9NwBhgvecHV5Zo+cc/Sdp+7/cEF9QmeJNILU/ZWTJsM
         Lv42xCCA1RiSlC0Hb2k9/TawVBLEY7gBZw/oRCDfS1qc1Gs6tyOS3FNS4fAGzbpmttTY
         zHXVSMSO0Q4IyBYokUjnu3gvHEl07wrb1rI9XHh1mJbIP9lFkD2ainNYvtaEzGswpegj
         HjQCxNw5+9QXVejjBrikUK269qQtAaAWxQ2gwcgZqZOVkgNiXP8Xe96BMSaJSBPqQqat
         DQFg==
X-Gm-Message-State: AOAM533hSmj+wU4ptGnZiYvzWyqZp/7FIUP5da3gJmWPd+Mi9H+VZZTa
        ul+su1Kas0VlUJO9IbJjait4AUfU2dg=
X-Google-Smtp-Source: ABdhPJw0Yzwp6kB3/9uua0bzDjAFn6JDlUUxxD8DbkI247ugJmRv2zJFLIP3vgbGZ6T9LuOPRrFuEw==
X-Received: by 2002:a17:90a:ce8d:b0:1d5:1294:67eb with SMTP id g13-20020a17090ace8d00b001d5129467ebmr4804861pju.142.1650516271358;
        Wed, 20 Apr 2022 21:44:31 -0700 (PDT)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id x2-20020aa79182000000b00505a61ec387sm21277009pfa.138.2022.04.20.21.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 21:44:30 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, liu.denton@gmail.com, sunshine@sunshineco.com,
        gitster@pobox.com, avarab@gmail.com, Johannes.Schindelin@gmx.de
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2] rebase: use correct base for --keep-base when a branch is given
Date:   Wed, 20 Apr 2022 22:42:33 -0600
Message-Id: <20220421044233.894255-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220418012716.2683624-1-alexhenrie24@gmail.com>
References: <20220418012716.2683624-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--keep-base rebases onto the merge base of the given upstream and the
current HEAD regardless of whether a branch is given. This is contrary
to the documentation and to the option's intended purpose. Instead,
rebase onto the merge base of the given upstream and the given branch.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v2: clear previous test cruft more efficiently
---
 Documentation/git-rebase.txt     |  5 +--
 builtin/rebase.c                 | 55 ++++++++++++++++----------------
 t/t3416-rebase-onto-threedots.sh | 29 +++++++++++++++++
 3 files changed, 60 insertions(+), 29 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 9da4647061..262fb01aec 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -215,9 +215,10 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 
 --keep-base::
 	Set the starting point at which to create the new commits to the
-	merge base of <upstream> <branch>. Running
+	merge base of <upstream> and <branch>. Running
 	'git rebase --keep-base <upstream> <branch>' is equivalent to
-	running 'git rebase --onto <upstream>... <upstream>'.
+	running
+	'git rebase --onto <upstream>...<branch> <upstream> <branch>'.
 +
 This option is useful in the case where one is developing a feature on
 top of an upstream branch. While the feature is being worked on, the
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 27fde7bf28..7f3bffc0a2 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1583,33 +1583,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		options.upstream_arg = "--root";
 	}
 
-	/* Make sure the branch to rebase onto is valid. */
-	if (keep_base) {
-		strbuf_reset(&buf);
-		strbuf_addstr(&buf, options.upstream_name);
-		strbuf_addstr(&buf, "...");
-		options.onto_name = xstrdup(buf.buf);
-	} else if (!options.onto_name)
-		options.onto_name = options.upstream_name;
-	if (strstr(options.onto_name, "...")) {
-		if (get_oid_mb(options.onto_name, &merge_base) < 0) {
-			if (keep_base)
-				die(_("'%s': need exactly one merge base with branch"),
-				    options.upstream_name);
-			else
-				die(_("'%s': need exactly one merge base"),
-				    options.onto_name);
-		}
-		options.onto = lookup_commit_or_die(&merge_base,
-						    options.onto_name);
-	} else {
-		options.onto =
-			lookup_commit_reference_by_name(options.onto_name);
-		if (!options.onto)
-			die(_("Does not point to a valid commit '%s'"),
-				options.onto_name);
-	}
-
 	/*
 	 * If the branch to rebase is given, that is the branch we will rebase
 	 * branch_name -- branch/commit being rebased, or
@@ -1659,6 +1632,34 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	} else
 		BUG("unexpected number of arguments left to parse");
 
+	/* Make sure the branch to rebase onto is valid. */
+	if (keep_base) {
+		strbuf_reset(&buf);
+		strbuf_addstr(&buf, options.upstream_name);
+		strbuf_addstr(&buf, "...");
+		strbuf_addstr(&buf, branch_name);
+		options.onto_name = xstrdup(buf.buf);
+	} else if (!options.onto_name)
+		options.onto_name = options.upstream_name;
+	if (strstr(options.onto_name, "...")) {
+		if (get_oid_mb(options.onto_name, &merge_base) < 0) {
+			if (keep_base)
+				die(_("'%s': need exactly one merge base with branch"),
+				    options.upstream_name);
+			else
+				die(_("'%s': need exactly one merge base"),
+				    options.onto_name);
+		}
+		options.onto = lookup_commit_or_die(&merge_base,
+						    options.onto_name);
+	} else {
+		options.onto =
+			lookup_commit_reference_by_name(options.onto_name);
+		if (!options.onto)
+			die(_("Does not point to a valid commit '%s'"),
+				options.onto_name);
+	}
+
 	if (options.fork_point > 0) {
 		struct commit *head =
 			lookup_commit_reference(the_repository,
diff --git a/t/t3416-rebase-onto-threedots.sh b/t/t3416-rebase-onto-threedots.sh
index 3716a42e81..3e04802cb0 100755
--- a/t/t3416-rebase-onto-threedots.sh
+++ b/t/t3416-rebase-onto-threedots.sh
@@ -129,6 +129,20 @@ test_expect_success 'rebase --keep-base main from topic' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase --keep-base main topic from main' '
+	git checkout main &&
+	git branch -f topic G &&
+
+	git rebase --keep-base main topic &&
+	git rev-parse C >base.expect &&
+	git merge-base main HEAD >base.actual &&
+	test_cmp base.expect base.actual &&
+
+	git rev-parse HEAD~2 >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rebase --keep-base main from side' '
 	git reset --hard &&
 	git checkout side &&
@@ -153,6 +167,21 @@ test_expect_success 'rebase -i --keep-base main from topic' '
 	test_cmp expect actual
 '
 
+test_expect_success 'rebase -i --keep-base main topic from main' '
+	git checkout main &&
+	git branch -f topic G &&
+
+	set_fake_editor &&
+	EXPECT_COUNT=2 git rebase -i --keep-base main topic &&
+	git rev-parse C >base.expect &&
+	git merge-base main HEAD >base.actual &&
+	test_cmp base.expect base.actual &&
+
+	git rev-parse HEAD~2 >actual &&
+	git rev-parse C^0 >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'rebase -i --keep-base main from side' '
 	git reset --hard &&
 	git checkout side &&
-- 
2.36.0

