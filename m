Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DB7BF1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 20:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730821AbeGRVZE (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 17:25:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:51762 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730096AbeGRVZD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 17:25:03 -0400
Received: (qmail 18271 invoked by uid 109); 18 Jul 2018 20:45:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 18 Jul 2018 20:45:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3476 invoked by uid 111); 18 Jul 2018 20:45:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 18 Jul 2018 16:45:31 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Jul 2018 16:45:25 -0400
Date:   Wed, 18 Jul 2018 16:45:25 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH 3/3] add core.usereplacerefs config option
Message-ID: <20180718204525.GC31816@sigill.intra.peff.net>
References: <20180718204424.GA1483@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718204424.GA1483@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can already disable replace refs using a command line
option or environment variable, but those are awkward to
apply universally. Let's add a config option to do the same
thing.

That raises the question of why one might want to do so
universally. The answer is that replace refs violate the
immutability of objects. For instance, if you wanted to
cache the diff between commit XYZ and its parent, then in
theory that never changes; the hash XYZ represents the total
state. But replace refs violate that; pushing up a new ref
may create a completely new diff.

The obvious "if it hurts, don't do it" answer is not to
create replace refs if you're doing this kind of caching.
But for a site hosting arbitrary repositories, they may want
to allow users to share replace refs with each other, but
not actually respect them on the site (because the caching
is more important than the replace feature).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt | 5 +++++
 config.c                 | 5 +++++
 t/t6050-replace.sh       | 6 ++++++
 3 files changed, 16 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1cc18a828c..92b277d27b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -908,6 +908,11 @@ core.commitGraph::
 	Enable git commit graph feature. Allows reading from the
 	commit-graph file.
 
+core.useReplaceRefs::
+	If set to `false`, behave as if the `--no-replace-objects`
+	option was given on the command line. See linkgit:git[1] and
+	linkgit:git-replace[1] for more information.
+
 core.sparseCheckout::
 	Enable "sparse checkout" feature. See section "Sparse checkout" in
 	linkgit:git-read-tree[1] for more information.
diff --git a/config.c b/config.c
index f4a208a166..49170c4556 100644
--- a/config.c
+++ b/config.c
@@ -1346,6 +1346,11 @@ static int git_default_core_config(const char *var, const char *value)
 					 var, value);
 	}
 
+	if (!strcmp(var, "core.usereplacerefs")) {
+		read_replace_refs = git_config_bool(var, value);
+		return 0;
+	}
+
 	/* Add other config variables here and to Documentation/config.txt. */
 	return 0;
 }
diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
index aa3e249639..86374a9c52 100755
--- a/t/t6050-replace.sh
+++ b/t/t6050-replace.sh
@@ -113,6 +113,12 @@ test_expect_success 'test GIT_NO_REPLACE_OBJECTS env variable' '
      GIT_NO_REPLACE_OBJECTS=1 git show $HASH2 | grep "A U Thor"
 '
 
+test_expect_success 'test core.usereplacerefs config option' '
+	test_config core.usereplacerefs false &&
+	git cat-file commit $HASH2 | grep "author A U Thor" &&
+	git show $HASH2 | grep "A U Thor"
+'
+
 cat >tag.sig <<EOF
 object $HASH2
 type commit
-- 
2.18.0.433.gb9621797ee
