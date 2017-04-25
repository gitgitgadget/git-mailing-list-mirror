Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA09A207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 00:57:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S979541AbdDYA5x (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 20:57:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:39424 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756437AbdDYA5v (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 20:57:51 -0400
Received: (qmail 7940 invoked by uid 109); 25 Apr 2017 00:57:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 25 Apr 2017 00:57:49 +0000
Received: (qmail 28607 invoked by uid 111); 25 Apr 2017 00:58:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 24 Apr 2017 20:58:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Apr 2017 20:57:47 -0400
Date:   Mon, 24 Apr 2017 20:57:47 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: [PATCH] submodule_init: die cleanly on submodules without url defined
Message-ID: <20170425005746.tulvexabonlexah3@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we init a submodule, we try to die when it has no URL
defined:

  url = xstrdup(sub->url);
  if (!url)
	  die(...);

But that's clearly nonsense. xstrdup() will never return
NULL, and if sub->url is NULL, we'll segfault.

These two bits of code need to be flipped, so we check
sub->url before looking at it.

Signed-off-by: Jeff King <peff@peff.net>
---
The bug is from the original submodule--helper, so it first appeared in
v2.9.x.

 builtin/submodule--helper.c | 6 +++---
 t/t7400-submodule-basic.sh  | 8 ++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 36e423182..566a5b6a6 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -376,12 +376,12 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (git_config_get_string(sb.buf, &url)) {
-		url = xstrdup(sub->url);
-
-		if (!url)
+		if (!sub->url)
 			die(_("No url found for submodule path '%s' in .gitmodules"),
 				displaypath);
 
+		url = xstrdup(sub->url);
+
 		/* Possibly a url relative to parent */
 		if (starts_with_dot_dot_slash(url) ||
 		    starts_with_dot_slash(url)) {
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index c2706fe47..1b8f1dbd3 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -38,6 +38,14 @@ test_expect_success 'submodule update aborts on missing .gitmodules file' '
 	test_i18ngrep "Submodule path .sub. not initialized" actual
 '
 
+test_expect_success 'submodule update aborts on missing gitmodules url' '
+	test_when_finished "git update-index --remove sub" &&
+	git update-index --add --cacheinfo 160000,$(git rev-parse HEAD),sub &&
+	test_when_finished "rm -f .gitmodules" &&
+	git config -f .gitmodules submodule.s.path sub &&
+	test_must_fail git submodule init
+'
+
 test_expect_success 'configuration parsing' '
 	test_when_finished "rm -f .gitmodules" &&
 	cat >.gitmodules <<-\EOF &&
-- 
2.13.0.rc0.459.g06dc2b676
