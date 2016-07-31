Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6EC21F855
	for <e@80x24.org>; Sun, 31 Jul 2016 10:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753389AbcGaKIt (ORCPT <rfc822;e@80x24.org>);
	Sun, 31 Jul 2016 06:08:49 -0400
Received: from a7-19.smtp-out.eu-west-1.amazonses.com ([54.240.7.19]:50463
	"EHLO a7-19.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751332AbcGaKIs (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 31 Jul 2016 06:08:48 -0400
X-Greylist: delayed 2801 seconds by postgrey-1.27 at vger.kernel.org; Sun, 31 Jul 2016 06:08:47 EDT
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1469956897;
	h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
	bh=VT2DlicQjTvErGhr5el335+wKXDd/oBfP15PuW/8eA0=;
	b=OzP6bB5SVeet/5CnP4TbY3yNj9k9qzLtYX660j6C+im+SZwdC6pjEhJUOW/kLwzs
	58ndIRINrQtSjo0R6p518Yms1JEFvn6JtqEnXmBl7NVpvsKE+ERb9Ro0I7P2yuMVNMy
	+8w4XEGgiKeKk10yYkl3X5i8nBOCA41H5sw3Gykc=
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Message-ID: <0102015640423c26-2060fd70-c90d-4de3-ae8c-1801ad160b1c-000000@eu-west-1.amazonses.com>
In-Reply-To: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
References: <010201560a4781be-e8418d6a-5996-45cd-b11b-ca25894ad7f2-000000@eu-west-1.amazonses.com>
Subject: [RFC/PATCH v11 01/13] bisect--helper: use OPT_CMDMODE instead of
 OPT_BOOL
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:	Sun, 31 Jul 2016 09:21:37 +0000
X-SES-Outgoing:	2016.07.31-54.240.7.19
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

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
https://github.com/git/git/pull/281
