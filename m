Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E4B121FC44
	for <e@80x24.org>; Tue, 14 Feb 2017 06:08:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752043AbdBNGIM (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 01:08:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:54900 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751324AbdBNGIL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 01:08:11 -0500
Received: (qmail 12134 invoked by uid 109); 14 Feb 2017 06:08:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 06:08:11 +0000
Received: (qmail 781 invoked by uid 111); 14 Feb 2017 06:08:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Feb 2017 01:08:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Feb 2017 01:08:09 -0500
Date:   Tue, 14 Feb 2017 01:08:09 -0500
From:   Jeff King <peff@peff.net>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: [PATCH 7/7] grep: do not diagnose misspelt revs with --no-index
Message-ID: <20170214060809.pgqaxt6rylnsy6d7@sigill.intra.peff.net>
References: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170214060021.einv7372exbxa23z@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we are using --no-index, then our arguments cannot be
revs in the first place. Not only is it pointless to
diagnose them, but if we are not in a repository, we should
not be trying to resolve any names.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/grep.c  | 2 +-
 t/t7810-grep.sh | 5 +++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index c4c632594..1454bef49 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1201,7 +1201,7 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	if (!seen_dashdash) {
 		int j;
 		for (j = i; j < argc; j++)
-			verify_filename(prefix, argv[j], j == i);
+			verify_filename(prefix, argv[j], j == i && use_index);
 	}
 
 	parse_pathspec(&pathspec, 0,
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index c051c7ee8..0ff9f6cae 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -1043,6 +1043,11 @@ test_expect_success 'grep --no-index prefers paths to revs' '
 	test_cmp expect actual
 '
 
+test_expect_success 'grep --no-index does not "diagnose" revs' '
+	test_must_fail git grep --no-index o :1:hello.c 2>err &&
+	test_i18ngrep ! -i "did you mean" err
+'
+
 cat >expected <<EOF
 hello.c:int main(int argc, const char **argv)
 hello.c:	printf("Hello world.\n");
-- 
2.12.0.rc1.471.ga79ec8999
