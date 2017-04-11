Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3ECD220970
	for <e@80x24.org>; Tue, 11 Apr 2017 23:49:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753483AbdDKXtv (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Apr 2017 19:49:51 -0400
Received: from mail-pg0-f42.google.com ([74.125.83.42]:35657 "EHLO
        mail-pg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752663AbdDKXtt (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2017 19:49:49 -0400
Received: by mail-pg0-f42.google.com with SMTP id 81so5729664pgh.2
        for <git@vger.kernel.org>; Tue, 11 Apr 2017 16:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=lOollX37VqVec/F2/6KKtGNxnxISwH6JFkpWTE48ENM=;
        b=RLxvgyr7gp3mQAQxrrXZzeqwNlcElq1STKgW9ZKNWYRYgRXKPp0DPiQmGFOsrbBJo8
         Jb1aUWSsjogR3SIJ2/c5/wd+zQqeXBkKpc0ataMqDiBt9EIMK34x7QlzZ+P6Gpvgi7bo
         5GE8r/3/m/jdD490Pf5kMpgE4caPMz74XH9WIWF5yQWNoncSZ5Om6l5wZ27MIZ13abf9
         /CyKO92wBX0h20Bct7wYn+B6NSg8KtVWqb5JC6Mnz+mwZyEmx/x5EaJv3SFcwsVqN3/1
         6dDVSwJxlQOmEiyYNOyOaR7BtZMg0d/RVcgnsATVcOFr9etR9YOmZyoS2WtarRbB4nG9
         Dygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=lOollX37VqVec/F2/6KKtGNxnxISwH6JFkpWTE48ENM=;
        b=BpEU5gz3vaaBD9/HF0kxq+z/dmZQ4lkVQ+YWaIfKlu6T8a5WNETqPVo/zZ+C/8ZaTc
         6Vk1wYhVW08fqjUlpVkq9vyg2s9zqmQSlPPjJAa5ZIagR+J75qhWgB6NrK9jycxCIQ3u
         /w2eOfa+xMfO2E9Zd8UxQ8yHlmFx6iwuGM2rrMkRFJQ/s4jF3X5S3epPj7xMzLszGkAh
         KpD0MXGmOBh+jcndhI/NofwCZ8wYJmotzV1DK7P2ZimzQLXWgqyjj6reFwbxKEqmtKbs
         VI255IXILItPLKwEYRFqUFQTVNUPTchAnkAE6JBc4U3TkBFgj8mXgAjG5HGN9TQ9i7iE
         uF2A==
X-Gm-Message-State: AN3rC/5RmmH+96rt3ioQezG4bLpggs1smTBfh0ubUm26toPKYtST+t6ev++sLlfdcJ4u8xOW
X-Received: by 10.98.17.204 with SMTP id 73mr20391849pfr.267.1491954588322;
        Tue, 11 Apr 2017 16:49:48 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:118b:650f:9c66:86dd])
        by smtp.gmail.com with ESMTPSA id d3sm32578952pfd.57.2017.04.11.16.49.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 11 Apr 2017 16:49:47 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     bmwill@google.com
Cc:     git@vger.kernel.org, jrnieder@gmail.com, gitster@pobox.com,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/4] entry.c: submodule recursing: respect force flag correctly
Date:   Tue, 11 Apr 2017 16:49:20 -0700
Message-Id: <20170411234923.1860-2-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.603.g7b28dc31ba
In-Reply-To: <20170411234923.1860-1-sbeller@google.com>
References: <20170411234923.1860-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In case of a non-forced worktree update, the submodule movement is tested
in a dry run first, such that it doesn't matter if the actual update is
done via the force flag. However for correctness, we want to give the
flag is specified by the user. All callers have been inspected and updated
if needed.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 entry.c        | 8 ++++----
 unpack-trees.c | 7 ++++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/entry.c b/entry.c
index d2b512da90..d6b263f78e 100644
--- a/entry.c
+++ b/entry.c
@@ -208,7 +208,8 @@ static int write_entry(struct cache_entry *ce,
 		sub = submodule_from_ce(ce);
 		if (sub)
 			return submodule_move_head(ce->name,
-				NULL, oid_to_hex(&ce->oid), SUBMODULE_MOVE_HEAD_FORCE);
+				NULL, oid_to_hex(&ce->oid),
+				state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		break;
 	default:
 		return error("unknown file mode for %s in index", path);
@@ -282,12 +283,11 @@ int checkout_entry(struct cache_entry *ce,
 					unlink_or_warn(ce->name);
 
 				return submodule_move_head(ce->name,
-					NULL, oid_to_hex(&ce->oid),
-					SUBMODULE_MOVE_HEAD_FORCE);
+					NULL, oid_to_hex(&ce->oid), 0);
 			} else
 				return submodule_move_head(ce->name,
 					"HEAD", oid_to_hex(&ce->oid),
-					SUBMODULE_MOVE_HEAD_FORCE);
+					state->force ? SUBMODULE_MOVE_HEAD_FORCE : 0);
 		}
 
 		if (!changed)
diff --git a/unpack-trees.c b/unpack-trees.c
index 8333da2cc9..7316ca99c2 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -252,14 +252,18 @@ static int check_submodule_move_head(const struct cache_entry *ce,
 				     const char *new_id,
 				     struct unpack_trees_options *o)
 {
+	unsigned flags = SUBMODULE_MOVE_HEAD_DRY_RUN;
 	const struct submodule *sub = submodule_from_ce(ce);
 	if (!sub)
 		return 0;
 
+	if (o->reset)
+		flags |= SUBMODULE_MOVE_HEAD_FORCE;
+
 	switch (sub->update_strategy.type) {
 	case SM_UPDATE_UNSPECIFIED:
 	case SM_UPDATE_CHECKOUT:
-		if (submodule_move_head(ce->name, old_id, new_id, SUBMODULE_MOVE_HEAD_DRY_RUN))
+		if (submodule_move_head(ce->name, old_id, new_id, flags))
 			return o->gently ? -1 :
 				add_rejected_path(o, ERROR_WOULD_LOSE_SUBMODULE, ce->name);
 		return 0;
@@ -308,6 +312,7 @@ static void unlink_entry(const struct cache_entry *ce)
 		case SM_UPDATE_CHECKOUT:
 		case SM_UPDATE_REBASE:
 		case SM_UPDATE_MERGE:
+			/* state.force is set at the caller. */
 			submodule_move_head(ce->name, "HEAD", NULL,
 					    SUBMODULE_MOVE_HEAD_FORCE);
 			break;
-- 
2.12.2.603.g7b28dc31ba

