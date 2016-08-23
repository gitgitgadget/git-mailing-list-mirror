Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03BDF1F6C1
	for <e@80x24.org>; Tue, 23 Aug 2016 12:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932497AbcHWMA4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Aug 2016 08:00:56 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:51935
        "EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1758009AbcHWMAv (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 23 Aug 2016 08:00:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1471953233;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=4Zf1aGF0tKx4RtAz5u3lEYTa3X/GipJoReTiowUhyww=;
        b=DnN6IAPup6+9QpMDn3ndidzJNw43jtzhtLW60TFWrcg2jk0n5Q7/UAolchy3OQIl
        PmFF8PbrGrTWHJ8irQplHe5Yh6At2KfWFVqF3PGNxrdQy2oUcJg2798mqzynTmbs6dl
        71y0z2wgyd50rR9bZaP0iwij78FfeJEYZG195j18=
From:   Pranit Bauva <pranit.bauva@gmail.com>
To:     git@vger.kernel.org
Message-ID: <01020156b73fe6e4-d45cf1f7-03a3-4566-95d1-73788c5ab2f9-000000@eu-west-1.amazonses.com>
In-Reply-To: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
References: <01020156b73fe5b4-5dc768ab-b73b-4a21-ab92-018e2a7aa6f7-000000@eu-west-1.amazonses.com>
Subject: [PATCH v14 27/27] bisect--helper: remove the dequote in
 bisect_start()
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 23 Aug 2016 11:53:53 +0000
X-SES-Outgoing: 2016.08.23-54.240.7.19
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
 builtin/bisect--helper.c | 59 ++++++++++++++++--------------------------------
 1 file changed, 20 insertions(+), 39 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 7577b69e..8bf495c 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -541,67 +541,48 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
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
+		commit_id = xstrfmt("%s^{commit}", argv[i]);
 		if (!strcmp(argv[i], "--")) {
 			has_double_dash = 1;
 			break;
-		} else if (!strcmp(arg, "--no-checkout"))
+		} else if (!strcmp(argv[i], "--no-checkout"))
 			no_checkout = 1;
-		else if (!strcmp(arg, "--term-good") ||
-			 !strcmp(arg, "--term-old")) {
-			const char *next_arg;
-			if (starts_with(argv[++i], "'"))
-				next_arg = sq_dequote(xstrdup(argv[i]));
-			else
-				next_arg = argv[i];
+		else if (!strcmp(argv[i], "--term-good") ||
+			 !strcmp(argv[i], "--term-old")) {
 			must_write_terms = 1;
 			strbuf_reset(&terms->term_good);
-			strbuf_addstr(&terms->term_good, next_arg);
-		} else if (skip_prefix(arg, "--term-good=", &arg)) {
+			strbuf_addstr(&terms->term_good, argv[++i]);
+		} else if (skip_prefix(argv[i], "--term-good=", &argv[i])) {
 			must_write_terms = 1;
 			strbuf_reset(&terms->term_good);
-			strbuf_addstr(&terms->term_good, arg);
-		} else if (skip_prefix(arg, "--term-old=", &arg)) {
+			strbuf_addstr(&terms->term_good, argv[i]);
+		} else if (skip_prefix(argv[i], "--term-old=", &argv[i])) {
 			must_write_terms = 1;
 			strbuf_reset(&terms->term_good);
-			strbuf_addstr(&terms->term_good, arg);
-		} else if (!strcmp(arg, "--term-bad") ||
-			 !strcmp(arg, "--term-new")) {
-			const char *next_arg;
-			if (starts_with(argv[++i], "'"))
-				next_arg = sq_dequote(xstrdup(argv[i]));
-			else
-				next_arg = argv[i];
+			strbuf_addstr(&terms->term_good, argv[i]);
+		} else if (!strcmp(argv[i], "--term-bad") ||
+			 !strcmp(argv[i], "--term-new")) {
 			must_write_terms = 1;
 			strbuf_reset(&terms->term_bad);
-			strbuf_addstr(&terms->term_bad, next_arg);
-		} else if (skip_prefix(arg, "--term-bad=", &arg)) {
+			strbuf_addstr(&terms->term_bad, argv[++i]);
+		} else if (skip_prefix(argv[i], "--term-bad=", &argv[i])) {
 			must_write_terms = 1;
 			strbuf_reset(&terms->term_bad);
-			strbuf_addstr(&terms->term_bad, arg);
-		} else if (skip_prefix(arg, "--term-new=", &arg)) {
+			strbuf_addstr(&terms->term_bad, argv[i]);
+		} else if (skip_prefix(argv[i], "--term-new=", &argv[i])) {
 			must_write_terms = 1;
 			strbuf_reset(&terms->term_good);
-			strbuf_addstr(&terms->term_good, arg);
-		} else if (starts_with(arg, "--") &&
-			 !one_of(arg, "--term-good", "--term-bad", NULL)) {
+			strbuf_addstr(&terms->term_good, argv[i]);
+		} else if (starts_with(argv[i], "--") &&
+			 !one_of(argv[i], "--term-good", "--term-bad", NULL)) {
 			string_list_clear(&revs, 0);
 			string_list_clear(&states, 0);
 			die(_("unrecognised option: '%s'"), argv[i]);

--
https://github.com/git/git/pull/287
