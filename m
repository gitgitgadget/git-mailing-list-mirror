Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA59A2047F
	for <e@80x24.org>; Sat, 29 Jul 2017 12:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753803AbdG2Mlm (ORCPT <rfc822;e@80x24.org>);
        Sat, 29 Jul 2017 08:41:42 -0400
Received: from a7-11.smtp-out.eu-west-1.amazonses.com ([54.240.7.11]:49082
        "EHLO a7-11.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753800AbdG2Mll (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 29 Jul 2017 08:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1501332100;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=+uXfE+rFlPiO1qP8xDU2Mtet/i9B8E8UZGaJBypBaMI=;
        b=VsxLzrXFrmVXzWTl3MnsAoTKRgu7T0pu3d2MLe+3YmaSJGsEcQQ1DgrRLsafvHw5
        joWhO4ACB51SXWHzT4qZfODAukorxcULXyoehH57gShe1daL67K6EoqneGPahfdNZjt
        TWkTL9O3hPtzhXwXuRYrCwfb3BVypzt/PtT1WrqE=
From:   Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015d8e5dd2c8-be70b5d5-8a65-4366-8cac-84a0f31ba744-000000@eu-west-1.amazonses.com>
In-Reply-To: <1501330390.2001.1.camel@gmail.com>
References: <1501330390.2001.1.camel@gmail.com>
Subject: [PATCH] setup: update error message to be more meaningful
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Sat, 29 Jul 2017 12:41:39 +0000
X-SES-Outgoing: 2017.07.29-54.240.7.11
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The error message shown when a flag is found when expecting a
filename wasn't clear as it didn't communicate what was wrong
using the 'suitable' words in *all* cases.

        $ git ls-files
        README.md
        test-file

Correct case,

        $ git rev-parse README.md --flags
        README.md
        --flags
        fatal: bad flag '--flags' used after filename

Incorrect case,

        $ git grep "some random regex" -n
        fatal: bad flag '-n' used after filename

The above case is incorrect as "some random regex" isn't a filename
in this case.

Change the error message to be general and communicative. This results
in the following output,

        $ git rev-parse README.md --flags
        README.md
        --flags
        fatal: option '--flags' must come before non-option arguments

        $ git grep "some random regex" -n
        fatal: option '-n' must come before non-option arguments

Signed-off-by: Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
---
 setup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 860507e1fdb2d..09c79328247dd 100644
--- a/setup.c
+++ b/setup.c
@@ -230,7 +230,7 @@ void verify_filename(const char *prefix,
 		     int diagnose_misspelt_rev)
 {
 	if (*arg == '-')
-		die("bad flag '%s' used after filename", arg);
+		die("option '%s' must come before non-option arguments", arg);
 	if (looks_like_pathspec(arg) || check_filename(prefix, arg))
 		return;
 	die_verify_filename(prefix, arg, diagnose_misspelt_rev);

--
https://github.com/git/git/pull/393
