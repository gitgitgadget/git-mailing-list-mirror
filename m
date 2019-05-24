Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52ED11F462
	for <e@80x24.org>; Fri, 24 May 2019 06:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388580AbfEXGq3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 May 2019 02:46:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:37560 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388359AbfEXGq3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 May 2019 02:46:29 -0400
Received: (qmail 25339 invoked by uid 109); 24 May 2019 06:46:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 24 May 2019 06:46:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6536 invoked by uid 111); 24 May 2019 06:47:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 24 May 2019 02:47:10 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 May 2019 02:46:27 -0400
Date:   Fri, 24 May 2019 02:46:27 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alejandro Sanchez <asanchez1987@gmail.com>, git@vger.kernel.org
Subject: [PATCH v2 4/4] am: fix --interactive HEAD tree resolution
Message-ID: <20190524064626.GE25694@sigill.intra.peff.net>
References: <20190520120636.GA12634@sigill.intra.peff.net>
 <20190520121301.GD11212@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1905230858570.46@tvgsbejvaqbjf.bet>
 <20190524063955.GD25694@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190524063955.GD25694@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In --interactive mode, "git am --resolved" will try to generate a patch
based on what is in the index, so that it can prompt "apply this
patch?". To do so it needs the tree of HEAD, which it tries to get with
get_oid_tree(). However, this doesn't yield a tree object; the "tree"
part just means "if you must disambiguate short oids, then prefer trees"
(and we do not need to disambiguate at all, since we are feeding a ref).

Instead, we must parse the oid as a commit (which should always be true
in a non-corrupt repository), and access its tree pointer manually.

This has been broken since the conversion to C in 7ff2683253
(builtin-am: implement -i/--interactive, 2015-08-04), but there was no
test coverage because of interactive-mode's insistence on having a tty.
That was lifted in the previous commit, so we can now add a test for
this case.

Note that before this patch, the test would result in a BUG() which
comes from 3506dc9445 (has_uncommitted_changes(): fall back to empty
tree, 2018-07-11). But before that, we'd have simply segfaulted (and in
fact this is the exact type of case the BUG() added there was trying to
catch!).

Signed-off-by: Jeff King <peff@peff.net>
---
This addresses points raised in Dscho's review (except for the test_cmp
thing). Since there were no changes to patches 1-3, I didn't bother
re-posting. Diff against v1 below.

  diff --git a/builtin/am.c b/builtin/am.c
  index 33bd7a6eab..78389d08b6 100644
  --- a/builtin/am.c
  +++ b/builtin/am.c
  @@ -1340,14 +1340,7 @@ static void write_index_patch(const struct am_state *state)
   	FILE *fp;
   
   	if (!get_oid("HEAD", &head)) {
  -		struct object *obj;
  -		struct commit *commit;
  -
  -		obj = parse_object_or_die(&head, NULL);
  -		commit = object_as_type(the_repository, obj, OBJ_COMMIT, 0);
  -		if (!commit)
  -			die("unable to parse HEAD as a commit");
  -
  +		struct commit *commit = lookup_commit_or_die(&head, "HEAD");
   		tree = get_commit_tree(commit);
   	} else
   		tree = lookup_tree(the_repository,
  diff --git a/t/t4257-am-interactive.sh b/t/t4257-am-interactive.sh
  index 6989bf7aba..5344bd248a 100755
  --- a/t/t4257-am-interactive.sh
  +++ b/t/t4257-am-interactive.sh
  @@ -23,7 +23,8 @@ test_expect_success 'applying all patches generates conflict' '
   
   test_expect_success 'interactive am can apply a single patch' '
   	git reset --hard base &&
  -	printf "%s\n" y n | git am -i mbox &&
  +	# apply the first, but not the second
  +	test_write_lines y n | git am -i mbox &&
   
   	echo no-conflict >expect &&
   	git log -1 --format=%s >actual &&
  @@ -32,10 +33,12 @@ test_expect_success 'interactive am can apply a single patch' '
   
   test_expect_success 'interactive am can resolve conflict' '
   	git reset --hard base &&
  -	printf "%s\n" y y | test_must_fail git am -i mbox &&
  +	# apply both; the second one will conflict
  +	test_write_lines y y | test_must_fail git am -i mbox &&
   	echo resolved >file &&
   	git add -u &&
  -	printf "%s\n" v y | git am -i --resolved &&
  +	# interactive "--resolved" will ask us if we want to apply the result
  +	echo y | git am -i --resolved &&
   
   	echo conflict-patch >expect &&
   	git log -1 --format=%s >actual &&

 builtin/am.c              |  7 +++---
 t/t4257-am-interactive.sh | 52 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 3 deletions(-)
 create mode 100755 t/t4257-am-interactive.sh

diff --git a/builtin/am.c b/builtin/am.c
index ea16b844f1..78389d08b6 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1339,9 +1339,10 @@ static void write_index_patch(const struct am_state *state)
 	struct rev_info rev_info;
 	FILE *fp;
 
-	if (!get_oid_tree("HEAD", &head))
-		tree = lookup_tree(the_repository, &head);
-	else
+	if (!get_oid("HEAD", &head)) {
+		struct commit *commit = lookup_commit_or_die(&head, "HEAD");
+		tree = get_commit_tree(commit);
+	} else
 		tree = lookup_tree(the_repository,
 				   the_repository->hash_algo->empty_tree);
 
diff --git a/t/t4257-am-interactive.sh b/t/t4257-am-interactive.sh
new file mode 100755
index 0000000000..5344bd248a
--- /dev/null
+++ b/t/t4257-am-interactive.sh
@@ -0,0 +1,52 @@
+#!/bin/sh
+
+test_description='am --interactive tests'
+. ./test-lib.sh
+
+test_expect_success 'set up patches to apply' '
+	test_commit unrelated &&
+	test_commit no-conflict &&
+	test_commit conflict-patch file patch &&
+	git format-patch --stdout -2 >mbox &&
+
+	git reset --hard unrelated &&
+	test_commit conflict-master file master base
+'
+
+# Sanity check our setup.
+test_expect_success 'applying all patches generates conflict' '
+	test_must_fail git am mbox &&
+	echo resolved >file &&
+	git add -u &&
+	git am --resolved
+'
+
+test_expect_success 'interactive am can apply a single patch' '
+	git reset --hard base &&
+	# apply the first, but not the second
+	test_write_lines y n | git am -i mbox &&
+
+	echo no-conflict >expect &&
+	git log -1 --format=%s >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'interactive am can resolve conflict' '
+	git reset --hard base &&
+	# apply both; the second one will conflict
+	test_write_lines y y | test_must_fail git am -i mbox &&
+	echo resolved >file &&
+	git add -u &&
+	# interactive "--resolved" will ask us if we want to apply the result
+	echo y | git am -i --resolved &&
+
+	echo conflict-patch >expect &&
+	git log -1 --format=%s >actual &&
+	test_cmp expect actual &&
+
+	echo resolved >expect &&
+	git cat-file blob HEAD:file >actual &&
+	test_cmp expect actual
+'
+
+test_done
-- 
2.22.0.rc1.549.gadb183c4cb

