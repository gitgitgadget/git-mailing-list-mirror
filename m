Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88B8E201A9
	for <e@80x24.org>; Thu, 23 Feb 2017 08:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751245AbdBWIRN (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 03:17:13 -0500
Received: from cloud.peff.net ([104.130.231.41]:60530 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751082AbdBWIRL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 03:17:11 -0500
Received: (qmail 32062 invoked by uid 109); 23 Feb 2017 08:17:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 08:17:10 +0000
Received: (qmail 16927 invoked by uid 111); 23 Feb 2017 08:17:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 03:17:14 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 03:17:08 -0500
Date:   Thu, 23 Feb 2017 03:17:08 -0500
From:   Jeff King <peff@peff.net>
To:     bs.x.ttp@recursor.net
Cc:     git@vger.kernel.org
Subject: [PATCH 4/4] ident: do not ignore empty config name/email
Message-ID: <20170223081708.ge34zjkmpsolocqx@sigill.intra.peff.net>
References: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170223081157.hwfn3msfux5udmng@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we read user.name and user.email from a config file,
they go into strbufs. When a caller asks ident_default_name()
for the value, we fallback to auto-detecting if the strbuf
is empty.

That means that explicitly setting an empty string in the
config is identical to not setting it at all. This is
potentially confusing, as we usually accept a configured
value as the final value.

Signed-off-by: Jeff King <peff@peff.net>
---
This one is perhaps questionable. Maybe somebody is relying on setting a
per-repo user.name to override a ~/.gitconfig value and enforce
auto-detection?

 ident.c                       |  4 ++--
 t/t7518-ident-corner-cases.sh | 11 +++++++++++
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/ident.c b/ident.c
index ead09ff7f..c0364fe3a 100644
--- a/ident.c
+++ b/ident.c
@@ -153,7 +153,7 @@ static void copy_email(const struct passwd *pw, struct strbuf *email,
 
 const char *ident_default_name(void)
 {
-	if (!git_default_name.len) {
+	if (!(ident_config_given & IDENT_NAME_GIVEN) && !git_default_name.len) {
 		copy_gecos(xgetpwuid_self(&default_name_is_bogus), &git_default_name);
 		strbuf_trim(&git_default_name);
 	}
@@ -162,7 +162,7 @@ const char *ident_default_name(void)
 
 const char *ident_default_email(void)
 {
-	if (!git_default_email.len) {
+	if (!(ident_config_given & IDENT_MAIL_GIVEN) && !git_default_email.len) {
 		const char *email = getenv("EMAIL");
 
 		if (email && email[0]) {
diff --git a/t/t7518-ident-corner-cases.sh b/t/t7518-ident-corner-cases.sh
index 3d2560c3c..ef570ac62 100755
--- a/t/t7518-ident-corner-cases.sh
+++ b/t/t7518-ident-corner-cases.sh
@@ -22,4 +22,15 @@ test_expect_success 'commit rejects all-crud name' '
 		git commit --allow-empty -m foo
 '
 
+# We must test the actual error message here, as an unwanted
+# auto-detection could fail for other reasons.
+test_expect_success 'empty configured name does not auto-detect' '
+	(
+		sane_unset GIT_AUTHOR_NAME &&
+		test_must_fail \
+			git -c user.name= commit --allow-empty -m foo 2>err &&
+		test_i18ngrep "empty ident name" err
+	)
+'
+
 test_done
-- 
2.12.0.rc2.597.g959f68882
