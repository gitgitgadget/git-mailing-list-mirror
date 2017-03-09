Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 679D320311
	for <e@80x24.org>; Thu,  9 Mar 2017 03:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750824AbdCIDbT (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 Mar 2017 22:31:19 -0500
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:52018
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750739AbdCIDbS (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Mar 2017 22:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1489030275;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=c5ulDRXJqpYvlEukTxxABMn19Hd8QZxAMVcBMrzYgTA=;
        b=LHExJPODPNyIYk1/Fh2d1lcadJrl7j640pwEWFa611iWx5oDlIV+ApbVMfChtho6
        0WBBpfJ0klvEvpWzVzT8OyHSP0J6ssbziH7mcZk37Nj8UOFZzIROtKfvCCfdhSg0uqb
        3le8TqiN59OUZFIjb+ojgabznUKLtdj8TJ8fMiwk=
From:   Shuyang Shi <shuyang790@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015ab11ee091-f9f11bb5-559a-4c92-b5f6-9f7755e8f4b9-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015ab11e8237-01e52ffe-882f-4589-8886-2c0b231ac3c6-000000@eu-west-1.amazonses.com>
References: <0102015ab11e8237-01e52ffe-882f-4589-8886-2c0b231ac3c6-000000@eu-west-1.amazonses.com>
Subject: [PATCH GSoC] Allow "-" as a short-hand for "@{-1}" in branch
 deletions
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Thu, 9 Mar 2017 03:31:15 +0000
X-SES-Outgoing: 2017.03.09-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "-" shorthand that stands for "the branch we were previously on",
like we did for "git merge -" sometime after we introduced "git checkout -".
Now I am introducing this shorthand to branch delete, i.e.
"git branch -d -".

More reference:
  https://public-inbox.org/git/7vppuewl6h.fsf@alter.siamese.dyndns.org/

And this has been tested:

	Ivan:git Ivan$ (cd t; prove --timer --jobs 1 ./t3200-branch.sh)
	[00:21:26] ./t3200-branch.sh .. ok    12293 ms ( 0.04 usr  0.01 sys +
	5.97 cusr  2.52 csys =  8.54 CPU)
	[00:21:39]
	All tests successful.
	Files=1, Tests=113, 13 wallclock secs ( 0.07 usr  0.02 sys +
	5.97 cusr  2.52 csys =  8.58 CPU)
	Result: PASS

Signed-off-by: Shuyang Shi <shuyang790@gmail.com>
---
 builtin/branch.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 94f7de7f..1b72d80 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -215,8 +215,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
 	for (i = 0; i < argc; i++, strbuf_release(&bname)) {
 		char *target = NULL;
 		int flags = 0;
+		const char *arg = argv[i];
 
-		strbuf_branchname(&bname, argv[i]);
+		if (!strcmp(arg, "-"))
+			arg = "@{-1}";
+
+		strbuf_branchname(&bname, arg);
 		free(name);
 		name = mkpathdup(fmt, bname.buf);
 

--
https://github.com/git/git/pull/337
