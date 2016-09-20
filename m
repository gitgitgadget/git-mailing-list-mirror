Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 716061F4F8
	for <e@80x24.org>; Tue, 20 Sep 2016 04:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751211AbcITEXe (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Sep 2016 00:23:34 -0400
Received: from relay4-d.mail.gandi.net ([217.70.183.196]:53680 "EHLO
        relay4-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751105AbcITEXd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Sep 2016 00:23:33 -0400
Received: from mfilter20-d.gandi.net (mfilter20-d.gandi.net [217.70.178.148])
        by relay4-d.mail.gandi.net (Postfix) with ESMTP id 620CB1720A5;
        Tue, 20 Sep 2016 06:23:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at mfilter20-d.gandi.net
Received: from relay4-d.mail.gandi.net ([IPv6:::ffff:217.70.183.196])
        by mfilter20-d.gandi.net (mfilter20-d.gandi.net [::ffff:10.0.15.180]) (amavisd-new, port 10024)
        with ESMTP id Bw8u3DdC6xzl; Tue, 20 Sep 2016 06:23:28 +0200 (CEST)
X-Originating-IP: 50.39.163.18
Received: from x (50-39-163-18.bvtn.or.frontiernet.net [50.39.163.18])
        (Authenticated sender: josh@joshtriplett.org)
        by relay4-d.mail.gandi.net (Postfix) with ESMTPSA id A2C3D17209D;
        Tue, 20 Sep 2016 06:23:27 +0200 (CEST)
Date:   Mon, 19 Sep 2016 21:23:25 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     git@vger.kernel.org
Cc:     Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH v3] format-patch: Add --rfc for the common case of [RFC PATCH]
Message-ID: <501a6bfb2a70f44f080b2f119e4503ccbf88f639.1474330487.git-series.josh@joshtriplett.org>
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
v3:
- Fix an error message referring to --subject-prefix
- Expand the acronym "RFC"
v2:
- Add documentation to the format-patch manpage
- Call subject_prefix_callback rather than reimplementing it
- Update test to move expectations inside

 Documentation/git-format-patch.txt |  8 +++++++-
 builtin/log.c                      | 10 +++++++++-
 t/t4014-format-patch.sh            |  9 +++++++++
 3 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 9624c84..9b200b3 100644
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
+	Alias for `--subject-prefix="RFC PATCH"`. RFC means "Request For
+	Comments"; use this when sending an experimental patch for
+	discussion rather than application.
+
 -v <n>::
 --reroll-count=<n>::
 	Mark the series as the <n>-th iteration of the topic. The
diff --git a/builtin/log.c b/builtin/log.c
index 92dc34d..c657900 100644
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
@@ -1557,7 +1565,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	if (numbered && keep_subject)
 		die (_("-n and -k are mutually exclusive."));
 	if (keep_subject && subject_prefix)
-		die (_("--subject-prefix and -k are mutually exclusive."));
+		die (_("--subject-prefix/--rfc and -k are mutually exclusive."));
 	rev.preserve_subject = keep_subject;
 
 	argc = setup_revisions(argc, argv, &rev, &s_r_opt);
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
