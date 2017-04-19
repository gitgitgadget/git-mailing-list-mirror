Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7DEE1FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 09:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1761557AbdDSJI1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 05:08:27 -0400
Received: from mga02.intel.com ([134.134.136.20]:59461 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761457AbdDSJIY (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 05:08:24 -0400
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Apr 2017 02:08:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,220,1488873600"; 
   d="scan'208";a="76169624"
Received: from jekeller-desk.amr.corp.intel.com (HELO jekeller-desk.jekeller.internal) ([10.166.35.158])
  by orsmga002.jf.intel.com with ESMTP; 19 Apr 2017 02:08:22 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Jacob Keller <jacob.keller@gmail.com>
Subject: [RFC PATCH] parse-options: disallow double-negations of options starting with no-
Date:   Wed, 19 Apr 2017 02:08:20 -0700
Message-Id: <20170419090820.20279-1-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.12.2.882.g942b4cedeff1.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

Many options can be negated by prefixing the option with "no-", for
example "--3way" can be prefixed with "--no-3way" to disable it. Since
0f1930c58754 ("parse-options: allow positivation of options
starting, with no-", 2012-02-25) we have also had support to negate
options which start with "no-" by using the positive wording.

This leads to the confusing (and non-documented) case that you can still
prefix options beginning with "no-" by a second "no-" to negate them.
That is, we allow "no-no-hardlinks" to negate the "no-hardlinks" option.

This can be confusing to the user so lets just disallow the
double-negative forms. If the long_name begins with "no-" then we simply
don't allow the regular negation format, and only allow the option to be
negated by the positive form.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
I started going about implementing an OPT_NEGBOOL as suggested by Peff,
but realized this might just be simpler, and we already support the
positive format for the negation, so we don't lose expressiveness. We
*might* want to tie this to an option flag instead so that it only kicks
in if the option specifically requests it. Thoughts?

 parse-options.c          | 3 +++
 t/t0040-parse-options.sh | 5 ++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/parse-options.c b/parse-options.c
index a23a1e67f04f..8e024c569f52 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -299,6 +299,9 @@ static int parse_long_opt(struct parse_opt_ctx_t *p, const char *arg,
 				}
 				continue;
 			}
+			/* avoid double-negate on long_name */
+			if (starts_with(long_name, "no-"))
+				continue;
 			flags |= OPT_UNSET;
 			if (!skip_prefix(arg + 3, long_name, &rest)) {
 				/* abbreviated and negated? */
diff --git a/t/t0040-parse-options.sh b/t/t0040-parse-options.sh
index 74d2cd76fe56..abccfa5f265f 100755
--- a/t/t0040-parse-options.sh
+++ b/t/t0040-parse-options.sh
@@ -88,7 +88,6 @@ test_expect_success 'OPT_BOOL() is idempotent #1' 'check boolean: 1 --yes --yes'
 test_expect_success 'OPT_BOOL() is idempotent #2' 'check boolean: 1 -DB'
 
 test_expect_success 'OPT_BOOL() negation #1' 'check boolean: 0 -D --no-yes'
-test_expect_success 'OPT_BOOL() negation #2' 'check boolean: 0 -D --no-no-doubt'
 
 test_expect_success 'OPT_BOOL() no negation #1' 'check_unknown_i18n --fear'
 test_expect_success 'OPT_BOOL() no negation #2' 'check_unknown_i18n --no-no-fear'
@@ -392,4 +391,8 @@ test_expect_success '--no-verbose resets multiple verbose to 0' '
 	test-parse-options --expect="verbose: 0" -v -v -v --no-verbose
 '
 
+test_expect_success 'double negation not accepted' '
+	test_must_fail test-parse-options --expect="boolean: 0" --no-no-doubt
+'
+
 test_done
-- 
2.12.2.882.g942b4cedeff1.dirty

