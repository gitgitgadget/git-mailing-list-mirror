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
	by dcvr.yhbt.net (Postfix) with ESMTP id A22431F4BD
	for <e@80x24.org>; Tue,  1 Oct 2019 06:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbfJAG65 (ORCPT <rfc822;e@80x24.org>);
        Tue, 1 Oct 2019 02:58:57 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:37414 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbfJAG64 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Oct 2019 02:58:56 -0400
Received: by mail-pf1-f195.google.com with SMTP id y5so7236360pfo.4
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 23:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ukXDtsoqFmM9izHFSaPejghCijjmavXg2q8IFR+8ebY=;
        b=mDJrcojLFL9ivRYpzuxMZIitkWrkWW7kyDeAXdQ0SvZhGcGzlSg6N0HIt69B2qaaX3
         Ndt0l75AyMI1R5lWSHATtY3KnSG7zZpqUD2dIQsu21iUG1pEdAMyLFGajvqUUdVqRoZ5
         9ANoziRKxhus2DO47P/Okd3in4c/rN7zmzAW1b61UmPKJtPa1IZS+dYjyGZ5UWva2BJi
         UUW07CAzfgfCdL7zgsHV/XiEZrx2QFc1uPXDdTjDwKDsOMW786W0IJ/hbUy/Mbi0YRQe
         3bnmyuB/tUbB6Pu/LRv0KJXW72WG9yANv6lOxsIIrxC0/R+OMNsFHIyQaA9pNDu21Z7Y
         bcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ukXDtsoqFmM9izHFSaPejghCijjmavXg2q8IFR+8ebY=;
        b=WpOyRmEsSXS+93ZCgmW2G3NntI3RA6C9AO48Kj3/dRZMEPB8TtsyPkU0AoCoHE5NNt
         hAhSS2kg+yFp0U7wB8LyYYfF2L8krQ8osPKdjhkobhQnRtmZcNTZSfgyg4SYDeuAAC4Z
         qofZrUKCeB4WfIRYxxfRnlJ40h1gFqchrE9iUYUQcASZm1e9SMUQqc5MsQWC21EfqYzI
         I+5Lg2lnLEn9D6k8oQDplzk2K9aawhqwLrjUWFdzDO5IJcfKHstI7NQfXBXPMNakbfkG
         x23CzMHX0ZalbrnAUmO/UHvQEViq0hlNc7Oc8SBx7t4My/Eue85WLFRUj6ax0dCGcHbl
         xkpA==
X-Gm-Message-State: APjAAAX846lFhyGz1IFBHM1EuS2Lg+iVBzGKGkG74XnrhmC6xuz5skfq
        Jt6JIHBiGP1Rw1T6xGhzWsOmd3ZfpA4=
X-Google-Smtp-Source: APXvYqzo9IbVGUBVQr5hyU/omraLAvNTI72Jcv5nmiutVVoLDRaK6vwEPjjG5bUM/aIzjLS0zV3NeQ==
X-Received: by 2002:a62:170b:: with SMTP id 11mr25219039pfx.243.1569913135094;
        Mon, 30 Sep 2019 23:58:55 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id k5sm21204373pfp.109.2019.09.30.23.58.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 23:58:54 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2] merge-recursive: fix the diff3 common ancestor label for virtual commits
Date:   Mon, 30 Sep 2019 23:58:49 -0700
Message-Id: <20191001065849.29491-1-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.25.g3f4444bfd7
In-Reply-To: <20190930225455.6208-1-newren@gmail.com>
References: <20190930225455.6208-1-newren@gmail.com>
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
label of "merged common ancestors" was also misleading for this case.
Since we have an API that is explicitly about creating fake merge base
commits in merge_recursive_generic(), we should provide a better label
when using that API with one merge base.  So, when
merge_recursive_generic() is called with one merge base, set the label
to:

         "constructed merge base"

Note that callers of merge_recursive_generic() include the builtin
commands git-am (in combination with git apply --build-fake-ancestor),
git-merge-recursive, and git-stash.

Reported-by: Jeff King <peff@peff.net>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
Applies to the top of en/merge-recursive-cleanup, which is in next.

Changes since v1:
  - We only had a problem if the number of fake merge bases was exactly
    one; update the patch to check for that and update the commit message
    accordingly.

Range-diff:
1:  e3b5015985 ! 1:  3f4444bfd7 merge-recursive: fix the diff3 common ancestor label for virtual commits
    @@ Commit message
         Unfortunately, this did not take into account that when we have a single
         merge base, that merge base could be fake or constructed.  In such
         cases, this resulted in a label of "00000000".  Of course, the previous
    -    label of "merged common ancestors" was also misleading for these cases.
    -    Since we have an API that is explicitly about creating fake commits in
    -    merge_recursive_generic(), we should provide a better label when using
    -    that API.  So, when merge_recursive_generic() is called, set the label
    +    label of "merged common ancestors" was also misleading for this case.
    +    Since we have an API that is explicitly about creating fake merge base
    +    commits in merge_recursive_generic(), we should provide a better label
    +    when using that API with one merge base.  So, when
    +    merge_recursive_generic() is called with one merge base, set the label
         to:
     
                  "constructed merge base"
     
    -    Note that users of merge_recursive_generic include the builtin commands
    -    git-am (in combination with git apply --build-fake-ancestor),
    +    Note that callers of merge_recursive_generic() include the builtin
    +    commands git-am (in combination with git apply --build-fake-ancestor),
         git-merge-recursive, and git-stash.
     
         Reported-by: Jeff King <peff@peff.net>
    @@ merge-recursive.c: int merge_recursive_generic(struct merge_options *opt,
      					   oid_to_hex(merge_bases[i]));
      			commit_list_insert(base, &ca);
      		}
    -+		opt->ancestor = "constructed merge base";
    ++		if (num_merge_bases == 1)
    ++			opt->ancestor = "constructed merge base";
      	}
      
      	repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);

 merge-recursive.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/merge-recursive.c b/merge-recursive.c
index b058741f00..e12d91f48a 100644
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
@@ -3741,6 +3744,8 @@ int merge_recursive_generic(struct merge_options *opt,
 					   oid_to_hex(merge_bases[i]));
 			commit_list_insert(base, &ca);
 		}
+		if (num_merge_bases == 1)
+			opt->ancestor = "constructed merge base";
 	}
 
 	repo_hold_locked_index(opt->repo, &lock, LOCK_DIE_ON_ERROR);
-- 
2.23.0.25.ge3b5015985.dirty

