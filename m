Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01B9D1F453
	for <e@80x24.org>; Mon,  4 Feb 2019 07:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbfBDHZn (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Feb 2019 02:25:43 -0500
Received: from bsmtp7.bon.at ([213.33.87.19]:42408 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727678AbfBDHZn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Feb 2019 02:25:43 -0500
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 43tK4M1cs7z5tlB;
        Mon,  4 Feb 2019 08:25:39 +0100 (CET)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 6706230F;
        Mon,  4 Feb 2019 08:25:38 +0100 (CET)
Subject: Re: [PATCH ps/stash-in-c] strbuf_vinsertf: provide the correct buffer
 size to vsnprintf
From:   Johannes Sixt <j6t@kdbg.org>
To:     Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org>
Message-ID: <5d521649-0b21-04e3-3182-e8714fcbfeac@kdbg.org>
Date:   Mon, 4 Feb 2019 08:25:38 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <896ae9dd-7ac3-182e-6692-c09bc4864de0@kdbg.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 03.02.19 um 17:51 schrieb Johannes Sixt:
> strbuf_vinsertf inserts a formatted string in the middle of an existing
> strbuf value.

Quite frankly, this is a really unusual operation, and I'd prefer to get
rid of it. There is only one call, and it looks like it only wants to be
lazy and save one strbuf variable.

This helper adds way more code than a non-lazy caller would need. There
wouldn't even be a mental burden. Like this (except that strbuf_addstr
doesn't do what I thought it would do...).

diff --git a/builtin/stash.c b/builtin/stash.c
index 74e6ff62b5..95d202aea3 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1101,7 +1101,7 @@ static int stash_working_tree(struct stash_info *info, struct pathspec ps)
 	return ret;
 }
 
-static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
+static int do_create_stash(struct pathspec ps, const char *stash_msg,
 			   int include_untracked, int patch_mode,
 			   struct stash_info *info, struct strbuf *patch,
 			   int quiet)
@@ -1117,6 +1117,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 	struct strbuf msg = STRBUF_INIT;
 	struct strbuf commit_tree_label = STRBUF_INIT;
 	struct strbuf untracked_files = STRBUF_INIT;
+	struct strbuf stash_msg_buf = STRBUF_INIT;
 
 	prepare_fallback_ident("git stash", "git@stash");
 
@@ -1188,10 +1189,12 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 		}
 	}
 
-	if (!stash_msg_buf->len)
-		strbuf_addf(stash_msg_buf, "WIP on %s", msg.buf);
-	else
-		strbuf_insertf(stash_msg_buf, 0, "On %s: ", branch_name);
+	if (!*stash_msg) {
+		strbuf_addf(&stash_msg_buf, "WIP on %s", msg.buf);
+	} else {
+		strbuf_addf(&stash_msg_buf, "On %s: ", branch_name);
+		strbuf_addstr(&stash_msg_buf, stash_msg);
+	}
 
 	/*
 	 * `parents` will be empty after calling `commit_tree()`, so there is
@@ -1206,7 +1209,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 			   &parents);
 	commit_list_insert(head_commit, &parents);
 
-	if (commit_tree(stash_msg_buf->buf, stash_msg_buf->len, &info->w_tree,
+	if (commit_tree(stash_msg_buf.buf, stash_msg_buf.len, &info->w_tree,
 			parents, &info->w_commit, NULL, NULL)) {
 		if (!quiet)
 			fprintf_ln(stderr, _("Cannot record "
@@ -1216,6 +1219,7 @@ static int do_create_stash(struct pathspec ps, struct strbuf *stash_msg_buf,
 	}
 
 done:
+	strbuf_release(&stash_msg_buf);
 	strbuf_release(&commit_tree_label);
 	strbuf_release(&msg);
 	strbuf_release(&untracked_files);
@@ -1236,7 +1240,7 @@ static int create_stash(int argc, const char **argv, const char *prefix)
 	if (!check_changes_tracked_files(ps))
 		return 0;
 
-	if (!(ret = do_create_stash(ps, &stash_msg_buf, 0, 0, &info, NULL, 0)))
+	if (!(ret = do_create_stash(ps, stash_msg_buf.buf, 0, 0, &info, NULL, 0)))
 		printf_ln("%s", oid_to_hex(&info.w_commit));
 
 	strbuf_release(&stash_msg_buf);
@@ -1300,7 +1304,7 @@ static int do_push_stash(struct pathspec ps, const char *stash_msg, int quiet,
 
 	if (stash_msg)
 		strbuf_addstr(&stash_msg_buf, stash_msg);
-	if (do_create_stash(ps, &stash_msg_buf, include_untracked, patch_mode,
+	if (do_create_stash(ps, stash_msg_buf.buf, include_untracked, patch_mode,
 			    &info, &patch, quiet)) {
 		ret = -1;
 		goto done;
