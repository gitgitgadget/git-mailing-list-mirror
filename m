Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D05011F4F8
	for <e@80x24.org>; Fri, 14 Oct 2016 16:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752909AbcJNQes (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Oct 2016 12:34:48 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:60965
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751532AbcJNQeq (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 14 Oct 2016 12:34:46 -0400
X-Greylist: delayed 7338 seconds by postgrey-1.27 at vger.kernel.org; Fri, 14 Oct 2016 12:34:46 EDT
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1476454456;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=jcHs9ftWy3/aMhZZDgQVUED54EJMF57p4mScdLFBbkU=;
        b=GIyUdazS0DljSFhY8uzuQ66nsVWczXYj/A64DZP4WRWhhYjlEp4GUb2Xo/p59+yk
        1OrPtfG1+h6oPhC+Ram47aGq8lruDBeQ3p1Ejb2DpBhh8cMj0DcqmdKoS3oFNtuKxV5
        pFfPXpKau6Pbk7NOaQKN+CU5v5KY7C9xIaalidts=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020157c38b1b58-947a88c6-2da5-4b64-8802-94127516cb6b-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
References: <01020157c38b19e0-81123fa5-5d9d-4f64-8f1b-ff336e83ebe4-000000@eu-west-1.amazonses.com>
Subject: [PATCH v15 27/27] bisect--helper: remove the dequote in
 bisect_start()
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Fri, 14 Oct 2016 14:14:16 +0000
X-SES-Outgoing: 2016.10.14-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dequoting the arguments was introduced in 25b48b5c to port the function
`bisect_next()` but after the `bisect_replay()` porting, the dequoting
is carried out itself when it passes the arguments to `bisect_start()`
in a simpler way thus dequoting again isn't required. So remove the
extra "deqouting" code introduced by the commit 25b48b5c.

Mentored-by: Lars Schneider <larsxschneider@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Pranit Bauva <pranit.bauva@gmail.com>
---
 builtin/bisect--helper.c | 26 ++++++--------------------
 1 file changed, 6 insertions(+), 20 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d6c2efc..8cd6527 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -561,24 +561,16 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 		no_checkout = 1;
 
 	for (i = 0; i < argc; i++) {
-		const char *arg;
-		if (starts_with(argv[i], "'"))
-			arg = sq_dequote(xstrdup(argv[i]));
-		else
-			arg = argv[i];
-		if (!strcmp(arg, "--")) {
+		if (!strcmp(argv[i], "--")) {
 			has_double_dash = 1;
 			break;
 		}
 	}
 
 	for (i = 0; i < argc; i++) {
-		const char *arg, *commit_id;
-		if (starts_with(argv[i], "'"))
-			arg = sq_dequote(xstrdup(argv[i]));
-		else
-			arg = argv[i];
-		commit_id = xstrfmt("%s^{commit}", arg);
+		const char  *commit_id;
+		const char *arg = argv[i];
+		commit_id = xstrfmt("%s^{commit}", argv[i]);
 		if (!strcmp(argv[i], "--")) {
 			has_double_dash = 1;
 			break;
@@ -586,11 +578,8 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			no_checkout = 1;
 		} else if (!strcmp(arg, "--term-good") ||
 			 !strcmp(arg, "--term-old")) {
-			if (starts_with(argv[++i], "'"))
-				terms->term_good = sq_dequote(xstrdup(argv[i]));
-			else
-				terms->term_good = xstrdup(argv[i]);
 			must_write_terms = 1;
+			terms->term_good = xstrdup(argv[++i]);
 		} else if (skip_prefix(arg, "--term-good=", &arg)) {
 			must_write_terms = 1;
 			terms->term_good = arg;
@@ -599,10 +588,7 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			terms->term_good = arg;
 		} else if (!strcmp(arg, "--term-bad") ||
 			 !strcmp(arg, "--term-new")) {
-			if (starts_with(argv[++i], "'"))
-				terms->term_bad = sq_dequote(xstrdup(argv[i]));
-			else
-				terms->term_bad = xstrdup(argv[i]);
+			terms->term_bad = xstrdup(argv[++i]);
 			must_write_terms = 1;
 		} else if (skip_prefix(arg, "--term-bad=", &arg)) {
 			must_write_terms = 1;

--
https://github.com/git/git/pull/287
