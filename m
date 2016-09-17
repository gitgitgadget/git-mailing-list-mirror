Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 925912070F
	for <e@80x24.org>; Sat, 17 Sep 2016 07:22:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754405AbcIQHWI (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Sep 2016 03:22:08 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:41629 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752175AbcIQHWG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Sep 2016 03:22:06 -0400
Received: from mfilter30-d.gandi.net (mfilter30-d.gandi.net [217.70.178.161])
        by relay3-d.mail.gandi.net (Postfix) with ESMTP id 7E6BEA80C2;
        Sat, 17 Sep 2016 09:21:58 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter30-d.gandi.net
Received: from relay3-d.mail.gandi.net ([IPv6:::ffff:217.70.183.195])
        by mfilter30-d.gandi.net (mfilter30-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id I6sF6-WfRO8C; Sat, 17 Sep 2016 09:21:56 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 34FD1A80CB;
        Sat, 17 Sep 2016 09:21:54 +0200 (CEST)
Date:   Sat, 17 Sep 2016 00:21:52 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH v2] format-patch: Add --rfc for the common case of [RFC PATCH]
Message-ID: <b5bf39015fdd20dd0aa4f38eb365bbbd0d07a4ca.1474096535.git-series.josh@joshtriplett.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20160910 (1.7.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This provides a shorter and more convenient alias for
--subject-prefix='RFC PATCH'.

Includes documentation in the format-patch manpage, and a new test
covering --rfc.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
v2:
- Add documentation to the format-patch manpage
- Call subject_prefix_callback rather than reimplementing it
- Update test to move expectations inside

 Documentation/git-format-patch.txt |  8 +++++++-
 builtin/log.c                      |  8 ++++++++
 t/t4014-format-patch.sh            |  9 +++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 9624c84..b9590a5 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -19,7 +19,8 @@ SYNOPSIS
 		   [--start-number <n>] [--numbered-files]
 		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
 		   [--ignore-if-in-upstream]
-		   [--subject-prefix=Subject-Prefix] [(--reroll-count|-v) <n>]
+		   [--rfc] [--subject-prefix=Subject-Prefix]
+		   [(--reroll-count|-v) <n>]
 		   [--to=<email>] [--cc=<email>]
 		   [--[no-]cover-letter] [--quiet] [--notes[=<ref>]]
 		   [<common diff options>]
@@ -172,6 +173,11 @@ will want to ensure that threading is disabled for `git send-email`.
 	allows for useful naming of a patch series, and can be
 	combined with the `--numbered` option.
 
+--rfc::
+	Alias for `--subject-prefix="RFC PATCH"`. Use this when
+	sending an experimental patch for discussion rather than
+	application.
+
 -v <n>::
 --reroll-count=<n>::
 	Mark the series as the <n>-th iteration of the topic. The
diff --git a/builtin/log.c b/builtin/log.c
index 92dc34d..5757d91 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1112,6 +1112,11 @@ static int subject_prefix_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static int rfc_callback(const struct option *opt, const char *arg, int unset)
+{
+	return subject_prefix_callback(opt, "RFC PATCH", unset);
+}
+
 static int numbered_cmdline_opt = 0;
 
 static int numbered_callback(const struct option *opt, const char *arg,
@@ -1419,6 +1424,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			    N_("start numbering patches at <n> instead of 1")),
 		OPT_INTEGER('v', "reroll-count", &reroll_count,
 			    N_("mark the series as Nth re-roll")),
+		{ OPTION_CALLBACK, 0, "rfc", &rev, NULL,
+			    N_("Use [RFC PATCH] instead of [PATCH]"),
+			    PARSE_OPT_NOARG | PARSE_OPT_NONEG, rfc_callback },
 		{ OPTION_CALLBACK, 0, "subject-prefix", &rev, N_("prefix"),
 			    N_("Use [<prefix>] instead of [PATCH]"),
 			    PARSE_OPT_NONEG, subject_prefix_callback },
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index b0579dd..ed4d3c2 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1073,6 +1073,15 @@ test_expect_success 'empty subject prefix does not have extra space' '
 	test_cmp expect actual
 '
 
+test_expect_success '--rfc' '
+	cat >expect <<-\EOF &&
+	Subject: [RFC PATCH 1/1] header with . in it
+	EOF
+	git format-patch -n -1 --stdout --rfc >patch &&
+	grep ^Subject: patch >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success '--from=ident notices bogus ident' '
 	test_must_fail git format-patch -1 --stdout --from=foo >patch
 '

base-commit: 6ebdac1bab966b720d776aa43ca188fe378b1f4b
-- 
git-series 0.8.10
