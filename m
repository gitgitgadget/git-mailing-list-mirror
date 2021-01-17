Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C3D4C433E0
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 12:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1689422262
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 12:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbhAQMH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 07:07:28 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:39340 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728713AbhAQMH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 07:07:26 -0500
X-Greylist: delayed 3688 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jan 2021 07:06:43 EST
Received: from kyle-ppc64le.internal.gigabyteproductions.net (cpe-173-88-170-197.neo.res.rr.com [173.88.170.197])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10HB3bad002017
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 17 Jan 2021 06:03:39 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10HB3bad002017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1610881420; bh=rpipuMfZQHtJiAEgl8IwHQmlA1Xg0W7tpoKd5qy2dAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cX7At3tzK5M2YEbdDxZuTjj5MxM8ng+QUHX9DeNsqAm0/ZgkYJmxE+sytdpmQlcMD
         pZALK9yx+g/4dlhUh1gql4IDm02v4J4SFinbOyzWUWelRfClpfvv8N8iq+mCSwG+Eo
         d/VWNTy32MKmRuMZVxENYfojCT1VZp8nMdscWe47Pxo1C3DZKjbB5XWJ2+d8BAEOle
         /j3ugL3CI500ju45BtBguX1RnMH7DTrsJH0x+gXu4OZjexjGu2rCVcRjemSCNVC5xW
         GubB6QGoVXB76/Z5tvV8ES0CeB2nvkwBpGYqbsAUdVJIfa4uWenFgS5TdDYtgcrAan
         3DEe6wqGfpwng==
From:   Kyle Marek <kmarek@pdinc.us>
To:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH 2/2] revision: implement --show-linear-break for --graph
Date:   Sun, 17 Jan 2021 06:03:37 -0500
Message-Id: <20210117110337.429994-3-kmarek@pdinc.us>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210117110337.429994-1-kmarek@pdinc.us>
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
 <20210117110337.429994-1-kmarek@pdinc.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

where <barrier> sets rev_info.break_revision_mark, the revision mark
used for root commits.

Signed-off-by: Kyle Marek <kmarek@pdinc.us>
---
 Documentation/rev-list-options.txt | 7 +++++++
 log-tree.c                         | 2 +-
 revision.c                         | 8 ++++----
 revision.h                         | 1 +
 4 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 002379056a..93adb77c19 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -1104,6 +1104,13 @@ This implies the `--topo-order` option by default, but the
 	do not belong to a linear branch. This option puts a barrier
 	in between them in that case. If `<barrier>` is specified, it
 	is the string that will be shown instead of the default one.
++
+When --graph is used with --oneline, there is usually no vertical
+space between commits, so the graph edge is not drawn. This can make
+it hard to see that a history may end at one commit, while an
+unrelated history starts at the next commit. This option changes the
+revision mark for root commits. If `<barrier>` is specified, it is
+used as the new revision mark instead of the default one.
 
 ifdef::git-rev-list[]
 --count::
diff --git a/log-tree.c b/log-tree.c
index fd0dde97ec..f62300e404 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -962,7 +962,7 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	if (opt->line_level_traverse)
 		return line_log_print(opt, commit);
 
-	if (opt->track_linear && !opt->linear && !opt->reverse_output_stage)
+	if (!opt->graph && opt->track_linear && !opt->linear && !opt->reverse_output_stage)
 		fprintf(opt->diffopt.file, "\n%s\n", opt->break_bar);
 	shown = log_tree_diff(opt, commit, &log);
 	if (!shown && opt->loginfo && opt->always_show_header) {
diff --git a/revision.c b/revision.c
index 8556923de8..51deab2326 100644
--- a/revision.c
+++ b/revision.c
@@ -2402,10 +2402,12 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->show_signature = 0;
 	} else if (!strcmp(arg, "--show-linear-break")) {
 		revs->break_bar = "                    ..........";
+		revs->break_revision_mark = "#";
 		revs->track_linear = 1;
 		revs->track_first_time = 1;
 	} else if (skip_prefix(arg, "--show-linear-break=", &optarg)) {
 		revs->break_bar = xstrdup(optarg);
+		revs->break_revision_mark = xstrdup(optarg);
 		revs->track_linear = 1;
 		revs->track_first_time = 1;
 	} else if (skip_prefix(arg, "--show-notes=", &optarg) ||
@@ -2530,8 +2532,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 			unkv[(*unkc)++] = arg;
 		return opts;
 	}
-	if (revs->graph && revs->track_linear)
-		die("--show-linear-break and --graph are incompatible");
 
 	return 1;
 }
@@ -4192,8 +4192,8 @@ const char *get_revision_mark(const struct rev_info *revs, const struct commit *
 		else
 			return ">";
 	} else if (revs->graph) {
-		if (!commit->parents)
-			return "#";
+		if (revs->break_revision_mark && !commit->parents)
+			return revs->break_revision_mark;
 		return "*";
 	} else if (revs->cherry_mark)
 		return "+";
diff --git a/revision.h b/revision.h
index 086ff10280..83b2ecef56 100644
--- a/revision.h
+++ b/revision.h
@@ -297,6 +297,7 @@ struct rev_info {
 
 	struct commit_list *previous_parents;
 	const char *break_bar;
+	const char *break_revision_mark;
 
 	struct revision_sources *sources;
 
-- 
2.29.2

