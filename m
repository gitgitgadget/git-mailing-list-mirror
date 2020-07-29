Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23346C433DF
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:11:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 093122067D
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 20:11:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbgG2ULS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 16:11:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:41498 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2ULS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 16:11:18 -0400
Received: (qmail 8822 invoked by uid 109); 29 Jul 2020 20:11:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 20:11:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7844 invoked by uid 111); 29 Jul 2020 20:11:16 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 16:11:16 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 16:11:16 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Chris Torek <chris.torek@gmail.com>
Subject: [PATCH v2 4/7] doc/git-log: move "Diff Formatting" from
 rev-list-options
Message-ID: <20200729201116.GD2989342@coredump.intra.peff.net>
References: <20200729201002.GA2989059@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200729201002.GA2989059@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our rev-list-options.txt include has a "Diff Formatting" section, but it
is ifndef'd out for all manpages except git-log. And a few bits of the
text are rather out of date.

We say "some of these options are specific to git-rev-list". That's
obviously silly since we (even before this patch) show the content only
for git-log. But moreover, it's not true; each of the listed options is
meaningful for other diff commands.

We also say "...however other diff options may be given. See git-diff-files
for more options." But there's no need to do so; git-log already has a
"Common Diff Options" section which includes diff-options.txt.

So let's move these options over to git-log and put them with the other
diff options, giving a single "diff" section for the git-log
documentation. We'll call it "Diff Formatting" but use the all-caps
top-level header to match its sibling sections. And we'll rewrite the
section intro to remove the useless bits and give a more generic
overview of the section which can be later extended.

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/git-log.txt          | 42 +++++++++++++++++++++++++--
 Documentation/rev-list-options.txt | 46 ------------------------------
 2 files changed, 40 insertions(+), 48 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 20e6d21a74..fb3998d8e0 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -111,8 +111,46 @@ include::rev-list-options.txt[]
 
 include::pretty-formats.txt[]
 
-COMMON DIFF OPTIONS
--------------------
+DIFF FORMATTING
+---------------
+
+By default, `git log` does not generate any diff output. The options
+below can be used to show the changes made by each commit.
+
+-c::
+	With this option, diff output for a merge commit
+	shows the differences from each of the parents to the merge result
+	simultaneously instead of showing pairwise diff between a parent
+	and the result one at a time. Furthermore, it lists only files
+	which were modified from all parents.
+
+--cc::
+	This flag implies the `-c` option and further compresses the
+	patch output by omitting uninteresting hunks whose contents in
+	the parents have only two variants and the merge result picks
+	one of them without modification.
+
+--combined-all-paths::
+	This flag causes combined diffs (used for merge commits) to
+	list the name of the file from all parents.  It thus only has
+	effect when -c or --cc are specified, and is likely only
+	useful if filename changes are detected (i.e. when either
+	rename or copy detection have been requested).
+
+-m::
+--diff-merges::
+	This flag makes the merge commits show the full diff like
+	regular commits; for each merge parent, a separate log entry
+	and diff is generated. An exception is that only diff against
+	the first parent is shown when `--first-parent` option is given;
+	in that case, the output represents the changes the merge
+	brought _into_ the then-current branch.
+
+-r::
+	Show recursive diffs.
+
+-t::
+	Show the tree objects in the diff output. This implies `-r`.
 
 :git-log: 1
 include::diff-options.txt[]
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 0785a0cfe9..398178d72a 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1117,49 +1117,3 @@ ifdef::git-rev-list[]
 	by a tab.
 endif::git-rev-list[]
 endif::git-shortlog[]
-
-ifndef::git-shortlog[]
-ifndef::git-rev-list[]
-Diff Formatting
-~~~~~~~~~~~~~~~
-
-Listed below are options that control the formatting of diff output.
-Some of them are specific to linkgit:git-rev-list[1], however other diff
-options may be given. See linkgit:git-diff-files[1] for more options.
-
--c::
-	With this option, diff output for a merge commit
-	shows the differences from each of the parents to the merge result
-	simultaneously instead of showing pairwise diff between a parent
-	and the result one at a time. Furthermore, it lists only files
-	which were modified from all parents.
-
---cc::
-	This flag implies the `-c` option and further compresses the
-	patch output by omitting uninteresting hunks whose contents in
-	the parents have only two variants and the merge result picks
-	one of them without modification.
-
---combined-all-paths::
-	This flag causes combined diffs (used for merge commits) to
-	list the name of the file from all parents.  It thus only has
-	effect when -c or --cc are specified, and is likely only
-	useful if filename changes are detected (i.e. when either
-	rename or copy detection have been requested).
-
--m::
---diff-merges::
-	This flag makes the merge commits show the full diff like
-	regular commits; for each merge parent, a separate log entry
-	and diff is generated. An exception is that only diff against
-	the first parent is shown when `--first-parent` option is given;
-	in that case, the output represents the changes the merge
-	brought _into_ the then-current branch.
-
--r::
-	Show recursive diffs.
-
--t::
-	Show the tree objects in the diff output. This implies `-r`.
-endif::git-rev-list[]
-endif::git-shortlog[]
-- 
2.28.0.465.gd2839157e3

