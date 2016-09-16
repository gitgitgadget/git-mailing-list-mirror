Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8DCD1207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 17:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965105AbcIPR1w (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 13:27:52 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48642 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933711AbcIPR1u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 13:27:50 -0400
Received: from x (unknown [IPv6:2620:15c:f:fd00:c069:9ab4:c274:dfa7])
        (Authenticated sender: josh@joshtriplett.org)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 40D7EA80D0;
        Fri, 16 Sep 2016 19:27:46 +0200 (CEST)
Date:   Fri, 16 Sep 2016 10:27:45 -0700
From:   Josh Triplett <josh@joshtriplett.org>
To:     git@vger.kernel.org
Cc:     Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Subject: [PATCH] format-patch: Add --rfc for the common case of [RFC PATCH]
Message-ID: <28c5d2c59851279858df22e844c6ff7c09f33199.1474046573.git-series.josh@joshtriplett.org>
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

Add a test covering --rfc.

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---

By far, the most common subject-prefix I've seen other than "PATCH" is
"RFC PATCH" (or occasionally "PATCH RFC").  Seems worth optimizing for
the common case, to avoid having to spell it out the long way as
--subject-prefix='RFC PATCH'.

 builtin/log.c           | 10 ++++++++++
 t/t4014-format-patch.sh |  9 +++++++++
 2 files changed, 19 insertions(+), 0 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 92dc34d..48d6a38 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1112,6 +1112,13 @@ static int subject_prefix_callback(const struct option *opt, const char *arg,
 	return 0;
 }
 
+static int rfc_callback(const struct option *opt, const char *arg, int unset)
+{
+	subject_prefix = 1;
+	((struct rev_info *)opt->value)->subject_prefix = xstrdup("RFC PATCH");
+	return 0;
+}
+
 static int numbered_cmdline_opt = 0;
 
 static int numbered_callback(const struct option *opt, const char *arg,
@@ -1419,6 +1426,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
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
index b0579dd..81b0498 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -1073,6 +1073,15 @@ test_expect_success 'empty subject prefix does not have extra space' '
 	test_cmp expect actual
 '
 
+cat >expect <<'EOF'
+Subject: [RFC PATCH 1/1] header with . in it
+EOF
+test_expect_success '--rfc' '
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
