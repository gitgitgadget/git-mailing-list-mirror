Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0007D1F744
	for <e@80x24.org>; Tue, 21 Jun 2016 10:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752105AbcFUKk4 (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 06:40:56 -0400
Received: from mout.gmx.net ([212.227.15.19]:56756 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751644AbcFUKgC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 06:36:02 -0400
Received: from virtualbox ([37.24.143.194]) by mail.gmx.com (mrgmx001) with
 ESMTPSA (Nemesis) id 0Lz3nU-1bSjEu2Dmi-014ASQ; Tue, 21 Jun 2016 12:34:56
 +0200
Date:	Tue, 21 Jun 2016 12:34:54 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Paul Tan <pyokagan@gmail.com>
Subject: [PATCH v3 2/9] Disallow diffopt.close_file when using the log_tree
 machinery
In-Reply-To: <cover.1466505222.git.johannes.schindelin@gmx.de>
Message-ID: <973f9f676225aa98377f607ced1ff474f39b863f.1466505222.git.johannes.schindelin@gmx.de>
References: <cover.1466420060.git.johannes.schindelin@gmx.de> <cover.1466505222.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:bzMvJ2FTkB5FnOECOViqOyazJNAjvE4egcGfKGTtuzl7uC5a8Uy
 YU8Mrt4X7EicburjpT54vNon4zhbSnA+83WsCs11syoeMvh8LbyOyKR0+OuzG8/EQitbr80
 Q8oDk5XFi8CETnKF0FTRPIkaAb4a/MnvPEcFZhUk9Bzp//2HJ+gyVUyUnWH7HC6f107Jy6c
 sKnm8HJz8ZfFL+MF/3NiA==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:E22Wg5O0FrE=:oiJ3P9TEby5OQmHrXVOwhP
 A6nxAu9PNuxsZ3p3l64lfsMuKugZCqADKdtKX2q5nO76t5PdSUA9lSf1aTNHcfdzHcJXF9feD
 K5fC1bwzmKc+0YTsVO+JdDV1f4vOB6PFOh/rvSKXkWcXTo/77eSl80VvBn0Q52Q1rYz+wjniY
 1FNHYRNEZuybcJPUFVQYgn9fh1kt/UEeeSOGH20u5S1zMAp8BMSDnjNysNAPwIjutRocPI+05
 DhJP/bcX5ECRQCbFHplkqq2i4zUJOsDW7oEc2z7Uxc64l1IETZSUf+aHuSX2/ifgxzcK++X4F
 78FU0OUbObTnhilQ4p7eaLJy0L0p3LW4YwscKR2N0SAMJ5Q+iykspxnmAeFE5taL5jmrUH4dr
 j5JbXIEgoRHy1ZWV80hr66xbeykzUAXPVdFnYa6JjdNDoy0CDPzgDovVdgkCQjTfUhBNb1ZbC
 7ZsyNH06FZmDB8n/WVAELdVS0a0v8kjgCHEvymPS4dnxuAWiGwpL9g7OW7JjwQZxPqIHVGNgZ
 x46+uJJILSe7gEaeQprmJr/uxPf65NeSmKrKnokez+QC2ieiqY0BL/WCn0v4ABd1UgrNWeKAM
 OwqJ6V2v0360nq12/BGFblDpazYhAh+raYktrikTdIOmJwCXejEl2MZK2RTHbkvkMoc3Aim46
 KQIc2KC56a9LnJBIVXprF7Qfv7mylWCWOWgY/qyDVjfE9owdbnRQ6Cf0+BR/HUHP5iZo45s3f
 8GFRJwOV/ST6GmFrVGBg93wcAwrXZaHb8+v2cn4Dt/v8VO4hytcokjDqX6RT8wr3/2uOXgzcY
 7UBwlsw
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

We are about to teach the log_tree machinery to reuse the diffopt.file
setting to output to a file stream different from stdout.

This means that builtin am can no longer ask the diff machinery to
close the file when actually calling the log_tree machinery (which
wants to flush the very same file stream that would then already be
closed).

To stave off similar problems in the future, report it as a bug if
log_tree_commit() is called with a non-zero diffopt.close_file.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/am.c | 6 ++++--
 log-tree.c   | 3 +++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 0e28a62..47d78aa 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1437,6 +1437,7 @@ static int write_commit_patch(const struct am_state *state, struct commit *commi
 {
 	struct rev_info rev_info;
 	FILE *fp;
+	int res;
 
 	fp = fopen(am_path(state, "patch"), "w");
 	if (!fp)
@@ -1453,10 +1454,11 @@ static int write_commit_patch(const struct am_state *state, struct commit *commi
 	DIFF_OPT_SET(&rev_info.diffopt, FULL_INDEX);
 	rev_info.diffopt.use_color = 0;
 	rev_info.diffopt.file = fp;
-	rev_info.diffopt.close_file = 1;
 	add_pending_object(&rev_info, &commit->object, "");
 	diff_setup_done(&rev_info.diffopt);
-	return log_tree_commit(&rev_info, commit);
+	res = log_tree_commit(&rev_info, commit);
+	fclose(fp);
+	return res;
 }
 
 /**
diff --git a/log-tree.c b/log-tree.c
index 78a5381..dc0180d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -864,6 +864,9 @@ int log_tree_commit(struct rev_info *opt, struct commit *commit)
 	struct log_info log;
 	int shown;
 
+	if (opt->diffopt.close_file)
+		die("BUG: close_file is incompatible with log_tree_commit()");
+
 	log.commit = commit;
 	log.parent = NULL;
 	opt->loginfo = &log;
-- 
2.9.0.118.g0e1a633


