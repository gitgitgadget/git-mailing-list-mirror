Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC8761FF6D
	for <e@80x24.org>; Fri, 16 Dec 2016 02:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759184AbcLPCbE (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Dec 2016 21:31:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:57397 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759174AbcLPCbC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Dec 2016 21:31:02 -0500
Received: (qmail 8761 invoked by uid 109); 16 Dec 2016 02:31:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 16 Dec 2016 02:31:02 +0000
Received: (qmail 8559 invoked by uid 111); 16 Dec 2016 02:31:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 15 Dec 2016 21:31:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Dec 2016 21:30:59 -0500
Date:   Thu, 15 Dec 2016 21:30:59 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 2/3] index-pack: complain when --stdin is used outside of a
 repo
Message-ID: <20161216023058.a2ksbkhb2lwkiglf@sigill.intra.peff.net>
References: <20161216022904.cjang6napnl2vkc6@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161216022904.cjang6napnl2vkc6@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The index-pack builtin is marked as RUN_SETUP_GENTLY,
because it's perfectly fine to index a pack in the
filesystem outside of any repository. However, --stdin mode
will write the result to the object database, which does not
make sense outside of a repository. Doing so creates a bogus
".git" directory with nothing in it except the newly-created
pack and its index.

Instead, let's flag this as an error and abort.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/index-pack.c   |  2 ++
 t/t5300-pack-object.sh | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 0a27bab11b..d450a6ada2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1730,6 +1730,8 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		usage(index_pack_usage);
 	if (fix_thin_pack && !from_stdin)
 		die(_("--fix-thin cannot be used without --stdin"));
+	if (from_stdin && !startup_info->have_repository)
+		die(_("--stdin requires a git repository"));
 	if (!index_name && pack_name)
 		index_name = derive_filename(pack_name, ".idx", &index_name_buf);
 	if (keep_msg && !keep_name && pack_name)
diff --git a/t/t5300-pack-object.sh b/t/t5300-pack-object.sh
index 899e52d50f..43a672c345 100755
--- a/t/t5300-pack-object.sh
+++ b/t/t5300-pack-object.sh
@@ -406,6 +406,21 @@ test_expect_success 'verify resulting packs' '
 	git verify-pack test-11-*.pack
 '
 
+test_expect_success 'set up pack for non-repo tests' '
+	# make sure we have a pack with no matching index file
+	cp test-1-*.pack foo.pack
+'
+
+test_expect_success 'index-pack --stdin complains of non-repo' '
+	nongit test_must_fail git index-pack --stdin <foo.pack &&
+	test_path_is_missing non-repo/.git
+'
+
+test_expect_success 'index-pack <pack> works in non-repo' '
+	nongit git index-pack ../foo.pack &&
+	test_path_is_file foo.idx
+'
+
 #
 # WARNING!
 #
-- 
2.11.0.348.g960a0b554

