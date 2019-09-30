Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF7161F463
	for <e@80x24.org>; Mon, 30 Sep 2019 22:55:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbfI3WzC (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 18:55:02 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:44116 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726425AbfI3WzB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 18:55:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id q21so6435601pfn.11
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 15:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4ccdx2lOL1PNlnSHz4HITfKhP3n2xAGd8ECJg4IFCZw=;
        b=oWfbO6BJeGDTcr4edVMzMWUMn8GR5oBezFX5DyFsd1DMbDjaru205YLa1/9qo6rVAv
         GvKptWDt5hYD53w61Hm8UtYqTOhfGax08OWM7q0q9LtpbD35gISwoHBC62bBbxj9/XK4
         fzgp77YOUBORzerCZpZL6RuzQmObMiSU2P1EiFkTsg7z6rDT7KN5WrRt09Eqis5lraGi
         XDfGQ9v4MusRIbov0hts+VKkhuzNttDtTqGN7uREHVblOiEMp5gGRjuXpcICO9Xw2+dy
         vnO7ufwPUQyob4iQgMdybLSCGw9bdrtsbVY43LwQSXhgYHjWK25B9HtKxz9vwUXHpq+J
         lFmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4ccdx2lOL1PNlnSHz4HITfKhP3n2xAGd8ECJg4IFCZw=;
        b=JBo9hCvC+CYx8zBwtRewkNge35h7nzXCNmNP0wP9U7khbhe96foTsjGXRzKZlsj3qG
         63Dq6RdvR6PCjZrqbto23cmQ0nECF2zNWSyVAgzqAKuQzm4YBoxkwNlFyGo+q3K39dsm
         x5XmymQ22XCkWGLtU63kKLFtqDK6445Aql8fgthmuwWELCzE2tyw9WDL2M1QtE3OUQzz
         nZtgH40nwPoQpWG1Zn3g4HpBnnYfEWMnEZln1OKPjXc1ORlcZycaexunot5aiwW9gkVj
         4UMCUd/gcSjC8Qosq6dKR18Oveq4MyeHanzEIUU97e4KumJPWktl7mgTviT/shPBscYh
         Wtlg==
X-Gm-Message-State: APjAAAX9IplBq/Hz+IzBfhnyWBC8YIQiSsJyIpkQlhI/DRTJ8DrAF7Fo
        j8dj/QokFpjjk3/1c/zERy7ddrqcT94=
X-Google-Smtp-Source: APXvYqwwyM3yemP+wOscCaBLFFQIEMGM53fV+1eEBD/jptWBTSPUbNpkRmynrcjwNo3drqqtookLSg==
X-Received: by 2002:a17:90a:9d86:: with SMTP id k6mr1779800pjp.105.1569884100598;
        Mon, 30 Sep 2019 15:55:00 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id s5sm546595pjn.24.2019.09.30.15.54.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 15:55:00 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH] merge-recursive: fix the diff3 common ancestor label for virtual commits
Date:   Mon, 30 Sep 2019 15:54:55 -0700
Message-Id: <20190930225455.6208-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.25.ge3b5015985
In-Reply-To: <20190930211437.GA28110@sigill.intra.peff.net>
References: <20190930211437.GA28110@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In commit 743474cbfa8b ("merge-recursive: provide a better label for
diff3 common ancestor", 2019-08-17), the label for the common ancestor
was changed from always being

         "merged common ancestors"

to instead be based on the number of merge bases:

    >=2: "merged common ancestors"
      1: <abbreviated commit hash>
      0: "<empty tree>"

Unfortunately, this did not take into account that when we have a single
merge base, that merge base could be fake or constructed.  In such
cases, this resulted in a label of "00000000".  Of course, the previous
label of "merged common ancestors" was also misleading for these cases.
Since we have an API that is explicitly about creating fake commits in
merge_recursive_generic(), we should provide a better label when using
that API.  So, when merge_recursive_generic() is called, set the label
to:

         "constructed merge base"

Note that users of merge_recursive_generic include the builtin commands
git-am (in combination with git apply --build-fake-ancestor),
git-merge-recursive, and git-stash.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
Applies to the top of en/merge-recursive-cleanup, which is in next.

 merge-recursive.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b058741f00..2b7722e350 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3550,6 +3550,8 @@ static int merge_recursive_internal(struct merge_options *opt,
 		merged_merge_bases = make_virtual_commit(opt->repo, tree,
 							 "ancestor");
 		ancestor_name = "empty tree";
+	} else if (opt->ancestor) {
+		ancestor_name = opt->ancestor;
 	} else if (merge_bases) {
 		ancestor_name = "merged common ancestors";
 	} else {
@@ -3689,7 +3691,8 @@ int merge_recursive(struct merge_options *opt,
 {
 	int clean;
 
-	assert(opt->ancestor == NULL);
+	assert(opt->ancestor == NULL ||
+	       !strcmp(opt->ancestor, "constructed merge base"));
 
 	if (merge_start(opt, repo_get_commit_tree(opt->repo, h1)))
 		return -1;
@@ -3741,6 +3744,7 @@ int merge_recursive_generic(struct merge_options *opt,
 					   oid_to_hex(merge_bases[i]));
 			commit_list_insert(base, &ca);
 		}
+		opt->ancestor = "constructed merge base";
 	}
 
 	repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
-- 
2.23.0.25.ge3b5015985

