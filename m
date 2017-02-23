Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D158201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 08:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751131AbdBWIOJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 03:14:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:60520 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751156AbdBWIN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 03:13:56 -0500
Received: (qmail 31811 invoked by uid 109); 23 Feb 2017 08:13:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 08:13:55 +0000
Received: (qmail 300 invoked by uid 111); 23 Feb 2017 08:13:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 03:13:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 03:13:53 -0500
Date:   Thu, 23 Feb 2017 03:13:53 -0500
From:   Jeff King <peff@peff.net>
To:     bs.x.ttp@recursor.net
Cc:     git@vger.kernel.org
Subject: [PATCH 2/4] ident: handle NULL email when complaining of empty name
Message-ID: <20170223081353.doi7u77phpbpcbiw@sigill.intra.peff.net>
References: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we see an empty name, we complain about and mention the
matching email in the error message (to give it some
context). However, the "email" pointer may be NULL here if
we were planning to fill it in later from ident_default_email().

This was broken by 59f929596 (fmt_ident: refactor strictness
checks, 2016-02-04). Prior to that commit, we would look up
the default name and email before doing any other actions.
So one solution would be to go back to that.

However, we can't just do so blindly. The logic for handling
the "!email" condition has grown since then. In particular,
looking up the default email can die if getpwuid() fails,
but there are other errors that should take precedence.
Commit 734c7789a (ident: check for useConfigOnly before
auto-detection of name/email, 2016-03-30) reordered the
checks so that we prefer the error message for
useConfigOnly.

Instead, we can observe that while the name-handling depends
on "email" being set, the reverse is not true. So we can
simply set up the email variable first.

This does mean that if both are bogus, we'll complain about
the email before the name. But between the two, there is no
reason to prefer one over the other.

Signed-off-by: Jeff King <peff@peff.net>
---
 ident.c                       | 26 +++++++++++++-------------
 t/t7518-ident-corner-cases.sh | 20 ++++++++++++++++++++
 2 files changed, 33 insertions(+), 13 deletions(-)
 create mode 100755 t/t7518-ident-corner-cases.sh

diff --git a/ident.c b/ident.c
index dde82983a..ea6034581 100644
--- a/ident.c
+++ b/ident.c
@@ -351,6 +351,19 @@ const char *fmt_ident(const char *name, const char *email,
 	int want_date = !(flag & IDENT_NO_DATE);
 	int want_name = !(flag & IDENT_NO_NAME);
 
+	if (!email) {
+		if (strict && ident_use_config_only
+		    && !(ident_config_given & IDENT_MAIL_GIVEN)) {
+			fputs(_(env_hint), stderr);
+			die(_("no email was given and auto-detection is disabled"));
+		}
+		email = ident_default_email();
+		if (strict && default_email_is_bogus) {
+			fputs(_(env_hint), stderr);
+			die(_("unable to auto-detect email address (got '%s')"), email);
+		}
+	}
+
 	if (want_name) {
 		int using_default = 0;
 		if (!name) {
@@ -378,19 +391,6 @@ const char *fmt_ident(const char *name, const char *email,
 		}
 	}
 
-	if (!email) {
-		if (strict && ident_use_config_only
-		    && !(ident_config_given & IDENT_MAIL_GIVEN)) {
-			fputs(_(env_hint), stderr);
-			die(_("no email was given and auto-detection is disabled"));
-		}
-		email = ident_default_email();
-		if (strict && default_email_is_bogus) {
-			fputs(_(env_hint), stderr);
-			die(_("unable to auto-detect email address (got '%s')"), email);
-		}
-	}
-
 	strbuf_reset(&ident);
 	if (want_name) {
 		strbuf_addstr_without_crud(&ident, name);
diff --git a/t/t7518-ident-corner-cases.sh b/t/t7518-ident-corner-cases.sh
new file mode 100755
index 000000000..6c057afc1
--- /dev/null
+++ b/t/t7518-ident-corner-cases.sh
@@ -0,0 +1,20 @@
+#!/bin/sh
+
+test_description='corner cases in ident strings'
+. ./test-lib.sh
+
+# confirm that we do not segfault _and_ that we do not say "(null)", as
+# glibc systems will quietly handle our NULL pointer
+#
+# Note also that we can't use "env" here because we need to unset a variable,
+# and "-u" is not portable.
+test_expect_success 'empty name and missing email' '
+	(
+		sane_unset GIT_AUTHOR_EMAIL &&
+		GIT_AUTHOR_NAME= &&
+		test_must_fail git commit --allow-empty -m foo 2>err &&
+		test_i18ngrep ! null err
+	)
+'
+
+test_done
-- 
2.12.0.rc2.597.g959f68882

