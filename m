Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A01F92055E
	for <e@80x24.org>; Thu,  2 Nov 2017 20:31:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934539AbdKBUb6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Nov 2017 16:31:58 -0400
Received: from siwi.pair.com ([209.68.5.199]:14636 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934531AbdKBUb4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Nov 2017 16:31:56 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 4D8CD845AE;
        Thu,  2 Nov 2017 16:31:56 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id AF0DD845AC;
        Thu,  2 Nov 2017 16:31:55 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 13/14] fetch-pack: restore save_commit_buffer after use
Date:   Thu,  2 Nov 2017 20:31:28 +0000
Message-Id: <20171102203129.59417-14-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20171102203129.59417-1-git@jeffhostetler.com>
References: <20171102203129.59417-1-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jonathan Tan <jonathantanmy@google.com>

In fetch-pack, the global variable save_commit_buffer is set to 0, but
not restored to its original value after use.

In particular, if show_log() (in log-tree.c) is invoked after
fetch_pack() in the same process, show_log() will return before printing
out the commit message (because the invocation to
get_cached_commit_buffer() returns NULL, because the commit buffer was
not saved). I discovered this when attempting to run "git log -S" in a
partial clone, triggering the case where revision walking lazily loads
missing objects.

Therefore, restore save_commit_buffer to its original value after use.

An alternative to solve the problem I had is to replace
get_cached_commit_buffer() with get_commit_buffer(). That invocation was
introduced in commit a97934d ("use get_cached_commit_buffer where
appropriate", 2014-06-13) to replace "commit->buffer" introduced in
commit 3131b71 ("Add "--show-all" revision walker flag for debugging",
2008-02-13). In the latter commit, the commit author seems to be
deciding between not showing an unparsed commit at all and showing an
unparsed commit without the message (which is what the commit does), and
did not mention parsing the unparsed commit, so I prefer to preserve the
existing behavior.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 fetch-pack.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 895e8f9..121f03e 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -717,6 +717,7 @@ static int everything_local(struct fetch_pack_args *args,
 {
 	struct ref *ref;
 	int retval;
+	int old_save_commit_buffer = save_commit_buffer;
 	timestamp_t cutoff = 0;
 
 	save_commit_buffer = 0;
@@ -784,6 +785,9 @@ static int everything_local(struct fetch_pack_args *args,
 		print_verbose(args, _("already have %s (%s)"), oid_to_hex(remote),
 			      ref->name);
 	}
+
+	save_commit_buffer = old_save_commit_buffer;
+
 	return retval;
 }
 
-- 
2.9.3

