Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C421C1F462
	for <e@80x24.org>; Fri, 26 Jul 2019 15:53:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387807AbfGZPxY (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jul 2019 11:53:24 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44916 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbfGZPxW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jul 2019 11:53:22 -0400
Received: by mail-pl1-f193.google.com with SMTP id t14so24888530plr.11
        for <git@vger.kernel.org>; Fri, 26 Jul 2019 08:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z/e+7XtjTTBo60kW3wuP7FQLWxjFuMNMvLv6Z3cedZM=;
        b=OZeLvwI05hKoUvx0wW5Q5na8/pNp/2RXee3zohr7tK7uiaCk03NqnrW5oBnBj6yGf0
         VNw6D4N2bBp51gq7aaKdkZ3mUVHkvA0E1PvtKYQiVKxxb+BRykZZv3EdFM8UVTUcv+dz
         we0L13fX37XxghHgLEDiRN6Tj5I33PwmJPmMdCe+C5C/5xB0vttmJjKvIwlhijA7njtK
         O8hk7v8DsrTa0Mn0HPxifqw6GQJGjpQBVu9irAjIDYvwEyj63zs/wNrQo4gx9zLXgilh
         k0t52X9+8t/TkkSIwdSj4LR0z7NDaZbTjKRP6PIX7G4PaIDxOPmDYjfNbaD4EGNO7nLE
         ItLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z/e+7XtjTTBo60kW3wuP7FQLWxjFuMNMvLv6Z3cedZM=;
        b=I9qdC0BSH7EsmY9baNpcQBeN5M3MI1Z/BCDr4+Wjz2Tt3n0quLgyisWF23ZH4mB5ou
         rwoEIgOyPVlyAN9PTMof5RcpjmcAvpkEeabR6ZZekjfAT50ze2nn6AYWV9rDEay3v/jO
         kAbgT5a+WpS/E57ZTaUllmDj05L3/Nyms+rcQuZkTV3QCL1/xvPBXKpF7GZQDYggyxgn
         g3WB1kdnFmxTOy/ciT5GmjlEtaO4aGHVxilyuPnkHSLNBEJ8MyueDsrOeJdzNoRyo4JP
         UXrGbqfxNcwAvrKPCc5T+ojE4s/anqbid7lCelUgP5I9Q4jlF5HShAor9Iv0kFsRzzDt
         m6hw==
X-Gm-Message-State: APjAAAXJV5Djz4wJ9/Vr9U2612Bd69NOo0UI90gPYNxvYZ+r8THlSgLa
        0Vc56/mcFmL2ZlFacX41NPooHzk+
X-Google-Smtp-Source: APXvYqz8SuNaKGonr147h1tPtpDkMhR2WIYf59OSAvMUBWQRgJqRga0H8Q3OkC/UiuzinML6Evwcxg==
X-Received: by 2002:a17:902:8490:: with SMTP id c16mr99010434plo.1.1564156401657;
        Fri, 26 Jul 2019 08:53:21 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id f27sm36669638pgm.60.2019.07.26.08.53.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 26 Jul 2019 08:53:20 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 15/20] merge-recursive: avoid losing output and leaking memory holding that output
Date:   Fri, 26 Jul 2019 08:52:53 -0700
Message-Id: <20190726155258.28561-16-newren@gmail.com>
X-Mailer: git-send-email 2.22.0.550.g71c37a0928.dirty
In-Reply-To: <20190726155258.28561-1-newren@gmail.com>
References: <20190725174611.14802-1-newren@gmail.com>
 <20190726155258.28561-1-newren@gmail.com>
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
index a8e4a6a531..49c7de0379 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3592,9 +3592,6 @@ static int merge_recursive_internal(struct merge_options *opt,
 		commit_list_insert(h1, &(*result)->parents);
 		commit_list_insert(h2, &(*result)->parents->next);
 	}
-	flush_output(opt);
-	if (!opt->call_depth && opt->buffer_output < 2)
-		strbuf_release(&opt->obuf);
 	return clean;
 }
 
@@ -3616,6 +3613,9 @@ static int merge_start(struct merge_options *opt, struct tree *head)
 
 static void merge_finalize(struct merge_options *opt)
 {
+	flush_output(opt);
+	if (!opt->call_depth && opt->buffer_output < 2)
+		strbuf_release(&opt->obuf);
 	if (show(opt, 2))
 		diff_warn_rename_limit("merge.renamelimit",
 				       opt->needed_rename_limit, 0);
diff --git a/merge-recursive.h b/merge-recursive.h
index b6d420960b..12249258ef 100644
--- a/merge-recursive.h
+++ b/merge-recursive.h
@@ -34,7 +34,8 @@ struct merge_options {
 	/* console output related options */
 	int verbosity;
 	unsigned buffer_output; /* 1: output at end, 2: keep buffered */
-	struct strbuf obuf;     /* output buffer */
+	struct strbuf obuf;     /* output buffer; if buffer_output == 2, caller
+				 * must handle and call strbuf_release */
 
 	/* miscellaneous control options */
 	const char *subtree_shift;
-- 
2.22.0.550.g71c37a0928.dirty

