Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D06C433F1
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAED12074F
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 16:39:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731713AbgG1QjC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 12:39:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:39914 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731617AbgG1QjB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 12:39:01 -0400
Received: (qmail 27722 invoked by uid 109); 28 Jul 2020 16:39:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 28 Jul 2020 16:39:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26531 invoked by uid 111); 28 Jul 2020 16:39:00 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 28 Jul 2020 12:39:00 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 28 Jul 2020 12:39:00 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/3] log: enable "-m" automatically with "--first-parent"
Message-ID: <20200728163900.GC2650252@coredump.intra.peff.net>
References: <20200728163617.GA2649887@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200728163617.GA2649887@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When using "--first-parent" to consider history as a single line of
commits, git-log still defaults to treating merges specially, even
though they could be considered as single commits in the linearized
history (that just introduce all of the changes from the second and
higher parents).

Let's instead have "--first-parent" imply "-m", which makes something
like:

  git log --first-parent -p

do what you'd expect. Likewise:

  git log --first-parent -Sfoo

will find "foo" in merge commits.

No new test is needed; we'll tweak the output of the existing
"--first-parent -p" test, which now matches the "-m --first-parent -p"
test. The unchanged existing test for "--ignore-merges" confirms that
the user can get the old behavior if they want.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/log.c                             |  3 +++
 t/t4013/diff.log_-p_--first-parent_master | 22 ++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 39b3d773a9..83b147c23a 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -731,6 +731,9 @@ static void log_setup_revisions_tweak(struct rev_info *rev,
 	/* Turn --cc/-c into -p --cc/-c when -p was not given */
 	if (!rev->diffopt.output_format && rev->combine_merges)
 		rev->diffopt.output_format = DIFF_FORMAT_PATCH;
+
+	if (rev->first_parent_only && rev->ignore_merges < 0)
+		rev->ignore_merges = 0;
 }
 
 int cmd_log(int argc, const char **argv, const char *prefix)
diff --git a/t/t4013/diff.log_-p_--first-parent_master b/t/t4013/diff.log_-p_--first-parent_master
index c6a5876d80..fe044399f0 100644
--- a/t/t4013/diff.log_-p_--first-parent_master
+++ b/t/t4013/diff.log_-p_--first-parent_master
@@ -6,6 +6,28 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side' into master
 
+diff --git a/dir/sub b/dir/sub
+index cead32e..992913c 100644
+--- a/dir/sub
++++ b/dir/sub
+@@ -4,3 +4,5 @@ C
+ D
+ E
+ F
++1
++2
+diff --git a/file0 b/file0
+index b414108..10a8a9f 100644
+--- a/file0
++++ b/file0
+@@ -4,3 +4,6 @@
+ 4
+ 5
+ 6
++A
++B
++C
+
 commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
-- 
2.28.0.rc2.475.g53c7e1c7f4
