Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC8AE1F461
	for <e@80x24.org>; Sat, 17 Aug 2019 18:42:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726464AbfHQSm0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 14:42:26 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37961 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfHQSmV (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 14:42:21 -0400
Received: by mail-pf1-f193.google.com with SMTP id o70so4812707pfg.5
        for <git@vger.kernel.org>; Sat, 17 Aug 2019 11:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ce5RPs4QMW6M4OMn98TeAGg3EatRdbceKilb0wk89zQ=;
        b=qEJ2HoN2F9Zi1gTJMK3w3gFf3q23cUAoE74EDh/312L6vxK5+ZE5gsIctmTh79XfX0
         /nJkcJG8ztIy/kX/iLiAUKfUkeeTkRRSyE3PKURIM2yjH1cDq5UcN9nuEYqebAtg5UuT
         0hmPg2R6TmyrYMbCrxXUyo7HJhFWfE32IP5WkwxYv8+QmYtr1c3nKl6nny56Za+4Y2XL
         yzcI7+GXi2fg77SOXq7Y1Ev4pYBxMkGf1C36sw0dMMh7ck4itPY73NmKG2rZYka6Csrb
         cSHgpClPpHu69pQ6pSIIy/qmauzJO+MJZo5usu9pQO+HxVqHtgSKjl1MzVkF4PKOX9iR
         fvKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ce5RPs4QMW6M4OMn98TeAGg3EatRdbceKilb0wk89zQ=;
        b=nFGytezrr04P07iqIUDuVcxqdqa8hDYEhFn9ajpjM62ind9D9NshemvEUZvp1duD35
         8rfYMZs6xB+/yzuoWN7F7ruLqcfaI5YWOA6YU91cu/gSW+uNUD5QFoZvhR/rw3lW8UxP
         5yAhpeBav3Hs09DVoVFOQy4JlBWvqYetnNWGSrIpEyeSAdAmJuRWI9XmG7u0LaXH55ae
         IdB29IPt7g+kYDflr9XgxaI/I2U7bdRtRl6Jk//Pr9mD2Ou/FKmWweWxe9xUWJ1y+ttb
         IlJZ6KouKh/L52FPlzv6hSVYixAf/r8KtV/Zn90d6DPlggd6G7atDjQjd0JSSfqw9xoF
         aVtA==
X-Gm-Message-State: APjAAAVmC0US85M9F+LeW54UC7+Wn0hRlOBRGv7pNfS0kgNRaep5ZnT5
        ULXlaGU/jpHQVV/sq+EJ/eEWvWzk
X-Google-Smtp-Source: APXvYqxNyS6xJ1c1e61Hm6aWETBndD7tHGAcoiRWIYYJepxKpd4Cxwfoob3ntGwjURr2EVO7/p3Peg==
X-Received: by 2002:a17:90a:e2d2:: with SMTP id fr18mr3421258pjb.98.1566067340916;
        Sat, 17 Aug 2019 11:42:20 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id j15sm9990422pfr.146.2019.08.17.11.42.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Aug 2019 11:42:20 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v4 20/24] merge-recursive: avoid losing output and leaking memory holding that output
Date:   Sat, 17 Aug 2019 11:41:40 -0700
Message-Id: <20190817184144.32179-21-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.rc2.28.g5f89f15d7b.dirty
In-Reply-To: <20190817184144.32179-1-newren@gmail.com>
References: <20190815214053.16594-1-newren@gmail.com>
 <20190817184144.32179-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If opt->buffer_output is less than 2, then merge_trees(),
merge_recursive(), and merge_recursive_generic() are all supposed to
flush the opt->obuf output buffer to stdout and release any memory it
holds.  merge_trees() did not do this.  Move the logic that handles this
for merge_recursive_internal() to merge_finalize() so that all three
methods handle this requirement.

Note that this bug didn't cause any problems currently, because there
are only two callers of merge_trees() right now (a git grep for
'merge_trees(' is misleading because builtin/merge-tree.c also defines a
'merge_tree' function that is unrelated), and only one of those is
called with buffer_output less than 2 (builtin/checkout.c), but it set
opt->verbosity to 0, for which there is only currently one non-error
message that would be shown: "Already up to date!".  However, that one
message can only occur when the merge is utterly trivial (the merge base
tree exactly matches the merge tree), and builtin/checkout.c already
attempts a trivial merge via unpack_trees() before falling back to
merge_trees().

Also, if opt->buffer_output is 2, then the caller is responsible to
handle showing any output in opt->obuf and for free'ing it.  This
requirement might be easy to overlook, so add a comment to
merge-recursive.h pointing it out.  (There are currently two callers
that set buffer_output to 2, both in sequencer.c, and both of which
handle this correctly.)

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-recursive.c | 6 +++---
 merge-recursive.h | 3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index 43dec3307e..262db8bebb 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3598,9 +3598,6 @@ static int merge_recursive_internal(struct merge_options *opt,
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-	flush_output(opt);
-	if (!opt->call_depth && opt->buffer_output < 2)
-		strbuf_release(&opt->obuf);
 	return clean;
 }
 
@@ -3620,6 +3617,9 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 
 static void merge_finalize(struct merge_options *opt)
 {
+	flush_output(opt);
+	if (!opt->call_depth && opt->buffer_output < 2)
+		strbuf_release(&opt->obuf);
 	if (show(opt, 2))
 		diff_warn_rename_limit("merge.renamelimit",
 				       opt->needed_rename_limit, 0);
diff --git a/merge-recursive.h b/merge-recursive.h
index 9e040608fe..933d6e7642 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -38,7 +38,8 @@ struct merge_options {
 	/* console output related options */
 	int verbosity;
 	unsigned buffer_output; /* 1: output at end, 2: keep buffered */
-	struct strbuf obuf;     /* output buffer */
+	struct strbuf obuf;     /* output buffer; if buffer_output == 2, caller
+				 * must handle and call strbuf_release */
 
 	/* miscellaneous control options */
 	const char *subtree_shift;
-- 
2.23.0.rc2.28.g5f89f15d7b.dirty

