Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4119E209AB
	for <e@80x24.org>; Fri, 14 Oct 2016 14:14:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757400AbcJNOOt (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 10:14:49 -0400
Received: from a7-17.smtp-out.eu-west-1.amazonses.com ([54.240.7.17]:52100
        "EHLO a7-17.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757311AbcJNOOT (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 10:14:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454455;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=nlDHvF65iBwbhB89HoLPSa5xZEtBm48KMBjmz1a5zhY=;
        b=aESyHJJGiRUEIlk1dOwQqkgXOPZIAZ5z2cgQ51VJmyCDLBF8Nq/WF5BzHFyoetiK
        KIJk/GB8nIAXn/zyDSmOpixjnYdpRRRW1dX9SFR7weZpfORAvdEoSSlHeVFYA8F4HO+
        1XzJuscy3JGoUfnfUcyXCMUcQU9jFVYeEE0G1Gwk=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 01/27] bisect--helper: use OPT_CMDMODE instead of
 OPT_BOOL
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Oct 2016 14:14:15 +0000
X-SES-Outgoing: 2016.10.14-54.240.7.17
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`--next-all` is meant to be used as a subcommand to support multiple
"operation mode" though the current implementation does not contain any
other subcommand along side with `--next-all` but further commits will
include some more subcommands.

Helped-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 3324229..8111c91 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -10,11 +10,11 @@ static const char * const git_bisect_helper_usage[] = {
 
 int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 {
-	int next_all = 0;
+	enum { NEXT_ALL = 1 } cmdmode = 0;
 	int no_checkout = 0;
 	struct option options[] = {
-		OPT_BOOL(0, "next-all", &next_all,
-			 N_("perform 'git bisect next'")),
+		OPT_CMDMODE(0, "next-all", &cmdmode,
+			 N_("perform 'git bisect next'"), NEXT_ALL),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
@@ -23,9 +23,14 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
 
-	if (!next_all)
+	if (!cmdmode)
 		usage_with_options(git_bisect_helper_usage, options);
 
-	/* next-all */
-	return bisect_next_all(prefix, no_checkout);
+	switch (cmdmode) {
+	case NEXT_ALL:
+		return bisect_next_all(prefix, no_checkout);
+	default:
+		die("BUG: unknown subcommand '%d'", cmdmode);
+	}
+	return 0;
 }

--
https://github.com/git/git/pull/287
