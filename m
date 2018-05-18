Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51D1B1F51C
	for <e@80x24.org>; Fri, 18 May 2018 22:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752044AbeERW1I (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 18:27:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:46052 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751888AbeERW1H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 18:27:07 -0400
Received: (qmail 31245 invoked by uid 109); 18 May 2018 22:27:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 18 May 2018 22:27:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15016 invoked by uid 111); 18 May 2018 22:27:14 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 May 2018 18:27:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2018 15:27:04 -0700
Date:   Fri, 18 May 2018 15:27:04 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] config: die when --blob is used outside a repository
Message-ID: <20180518222704.GB9623@sigill.intra.peff.net>
References: <20180518222506.GA9527@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518222506.GA9527@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If you run "config --blob" outside of a repository, then we
eventually try to resolve the blob name and hit a BUG().
Let's catch this earlier and provide a useful message.

Note that we could also catch this much lower in the stack,
in git_config_from_blob_ref(). That might cover other
callsites, too, but it's unclear whether those ones would
actually be bugs or not. So let's leave the low-level
functions to assume the caller knows what it's doing (and
BUG() if it turns out it doesn't).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c       | 3 +++
 t/t1307-config-blob.sh | 4 ++++
 2 files changed, 7 insertions(+)

diff --git a/builtin/config.c b/builtin/config.c
index 69e7270356..4155734f4a 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -602,6 +602,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 	if (use_local_config && nongit)
 		die(_("--local can only be used inside a git repository"));
 
+	if (given_config_source.blob && nongit)
+		die(_("--blob can only be used inside a git repository"));
+
 	if (given_config_source.file &&
 			!strcmp(given_config_source.file, "-")) {
 		given_config_source.file = NULL;
diff --git a/t/t1307-config-blob.sh b/t/t1307-config-blob.sh
index eed31ffa30..37dc689d8c 100755
--- a/t/t1307-config-blob.sh
+++ b/t/t1307-config-blob.sh
@@ -73,4 +73,8 @@ test_expect_success 'can parse blob ending with CR' '
 	test_cmp expect actual
 '
 
+test_expect_success 'config --blob outside of a repository is an error' '
+	test_must_fail nongit git config --blob=foo --list
+'
+
 test_done
-- 
2.17.0.1052.g7d69f75dbf
