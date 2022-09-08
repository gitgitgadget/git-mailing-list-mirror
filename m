Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF812C54EE9
	for <git@archiver.kernel.org>; Thu,  8 Sep 2022 19:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbiIHT0N (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Sep 2022 15:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbiIHT0M (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2022 15:26:12 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE37CA6C54
        for <git@vger.kernel.org>; Thu,  8 Sep 2022 12:26:10 -0700 (PDT)
Received: (qmail 28616 invoked by uid 109); 8 Sep 2022 19:26:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 08 Sep 2022 19:26:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23843 invoked by uid 111); 8 Sep 2022 19:26:10 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 08 Sep 2022 15:26:10 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 8 Sep 2022 15:26:09 -0400
From:   Jeff King <peff@peff.net>
To:     Lana Deere <lana.deere@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, git@vger.kernel.org
Subject: [PATCH 2/2] fetch: add branch.*.merge to default ref-prefix extension
Message-ID: <YxpB0dbFTKp5L94k@coredump.intra.peff.net>
References: <YxpBMaIckimFJYEi@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YxpBMaIckimFJYEi@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When running "git pull" with no arguments, we'll do a default "git
fetch" and then try to merge the branch specified by the branch.*.merge
config. There's code in get_ref_map() to treat that "merge" branch as
something we want to fetch, even if it is not otherwise covered by the
default refspec.

This works fine with the v0 protocol, as the server tells us about all
of the refs, and get_ref_map() is the ultimate decider of what we fetch.

But in the v2 protocol, we send the ref-prefix extension to the server,
asking it to limit the ref advertisement. And we only tell it about the
default refspec for the remote; we don't mention the branch.*.merge
config at all.

This usually doesn't matter, because the default refspec matches
"refs/heads/*", which covers all branches. But if you explicitly use a
narrow refspec, then "git pull" on some branches may fail. The server
doesn't advertise the branch, so we don't fetch it, and "git pull"
thinks that it went away upstream.

We can fix this by including any branch.*.merge entries for the current
branch in the list of ref-prefixes we pass to the server. This only
needs to happen when using the default configured refspec (since
command-line refspecs are already added, and take precedence in deciding
what we fetch). We don't otherwise need to replicate any of the "what to
fetch" logic in get_ref_map(). These ref-prefixes are an optimization,
so it's OK if we tell the server to advertise the branch.*.merge ref,
even if we're not going to pull it. We'll just choose not to fetch it.

The test here is based on one constructed by Johannes. I modified the
branch names to trigger the ref-prefix issue (and be more descriptive),
and to confirm that "git pull" actually updated the local ref, which
should be more robust than just checking stderr.

Reported-by: Lana Deere <lana.deere@gmail.com>
Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch.c | 18 +++++++++++++++---
 t/t5520-pull.sh | 17 +++++++++++++++++
 2 files changed, 32 insertions(+), 3 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f78146ca81..d4bbef6695 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1616,9 +1616,21 @@ static int do_fetch(struct transport *transport,
 				break;
 			}
 		}
-	} else if (transport->remote->fetch.nr)
-		refspec_ref_prefixes(&transport->remote->fetch,
-				     &transport_ls_refs_options.ref_prefixes);
+	} else {
+		struct branch *branch = branch_get(NULL);
+
+		if (transport->remote->fetch.nr)
+			refspec_ref_prefixes(&transport->remote->fetch,
+					     &transport_ls_refs_options.ref_prefixes);
+		if (branch_has_merge_config(branch) &&
+		    !strcmp(branch->remote_name, transport->remote->name)) {
+			int i;
+			for (i = 0; i < branch->merge_nr; i++) {
+				strvec_push(&transport_ls_refs_options.ref_prefixes,
+					    branch->merge[i]->src);
+			}
+		}
+	}
 
 	if (tags == TAGS_SET || tags == TAGS_DEFAULT) {
 		must_list_refs = 1;
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 081808009b..0b72112fb1 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -218,6 +218,23 @@ test_expect_success 'fail if upstream branch does not exist' '
 	test_cmp expect file
 '
 
+test_expect_success 'fetch upstream branch even if refspec excludes it' '
+	# the branch names are not important here except that
+	# the first one must not be a prefix of the second,
+	# since otherwise the ref-prefix protocol extension
+	# would match both
+	git branch in-refspec HEAD^ &&
+	git branch not-in-refspec HEAD &&
+	git init -b in-refspec downstream &&
+	git -C downstream remote add -t in-refspec origin "file://$(pwd)/.git" &&
+	git -C downstream config branch.in-refspec.remote origin &&
+	git -C downstream config branch.in-refspec.merge refs/heads/not-in-refspec &&
+	git -C downstream pull &&
+	git rev-parse --verify not-in-refspec >expect &&
+	git -C downstream rev-parse --verify HEAD >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'fail if the index has unresolved entries' '
 	git checkout -b third second^ &&
 	test_when_finished "git checkout -f copy && git branch -D third" &&
-- 
2.37.3.1164.gb600acaa9f
