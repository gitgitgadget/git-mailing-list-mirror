Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D1D4C4363A
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:37:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE52621D24
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 07:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507826AbgJ0HhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Oct 2020 03:37:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:38320 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387859AbgJ0HhP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Oct 2020 03:37:15 -0400
Received: (qmail 14422 invoked by uid 109); 27 Oct 2020 07:37:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 27 Oct 2020 07:37:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15194 invoked by uid 111); 27 Oct 2020 07:37:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 27 Oct 2020 03:37:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 27 Oct 2020 03:37:14 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/2] checkout-index: propagate errors to exit code
Message-ID: <20201027073714.GB3794137@coredump.intra.peff.net>
References: <20201027073000.GA3651896@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201027073000.GA3651896@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we encounter an error while checking out an explicit path, we print a
message to stderr but do not actually exit with a non-zero code. While
this is a plumbing command and the behavior goes all the way back to
33db5f4d90 (Add a "checkout-cache" command which does what the name
suggests., 2005-04-09), this is almost certainly an oversight:

  - we _do_ return an exit code from checkout_file(); the caller just
    never reads it

  - errors while checking out all paths (with "-a") do result in a
    non-zero exit code.

  - it would be quite unusual not to use the exit code for an error,
    as otherwise the caller has no idea the command failed except by
    scraping stderr

To keep our tests simple and portable, we can use the most obvious
error: asking to checkout a path which is not in the index at all.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/checkout-index.c        |  8 ++++++--
 t/t2004-checkout-cache-temp.sh  |  2 +-
 t/t2006-checkout-index-basic.sh | 11 +++++++++++
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/builtin/checkout-index.c b/builtin/checkout-index.c
index 195165d8bd..4bbfc92dce 100644
--- a/builtin/checkout-index.c
+++ b/builtin/checkout-index.c
@@ -167,6 +167,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 	int prefix_length;
 	int force = 0, quiet = 0, not_new = 0;
 	int index_opt = 0;
+	int err = 0;
 	struct option builtin_checkout_index_options[] = {
 		OPT_BOOL('a', "all", &all,
 			N_("check out all files in the index")),
@@ -231,7 +232,7 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 		if (read_from_stdin)
 			die("git checkout-index: don't mix '--stdin' and explicit filenames");
 		p = prefix_path(prefix, prefix_length, arg);
-		checkout_file(p, prefix);
+		err |= checkout_file(p, prefix);
 		free(p);
 	}
 
@@ -253,13 +254,16 @@ int cmd_checkout_index(int argc, const char **argv, const char *prefix)
 				strbuf_swap(&buf, &unquoted);
 			}
 			p = prefix_path(prefix, prefix_length, buf.buf);
-			checkout_file(p, prefix);
+			err |= checkout_file(p, prefix);
 			free(p);
 		}
 		strbuf_release(&unquoted);
 		strbuf_release(&buf);
 	}
 
+	if (err)
+		return 1;
+
 	if (all)
 		checkout_all(prefix, prefix_length);
 
diff --git a/t/t2004-checkout-cache-temp.sh b/t/t2004-checkout-cache-temp.sh
index 4308d698b9..a9352b08a8 100755
--- a/t/t2004-checkout-cache-temp.sh
+++ b/t/t2004-checkout-cache-temp.sh
@@ -88,7 +88,7 @@ test_expect_success 'checkout all stage 2 to temporary files' '
 	done
 '
 
-test_expect_failure 'checkout all stages of unknown path' '
+test_expect_success 'checkout all stages of unknown path' '
 	rm -f path* .merge_* actual &&
 	test_must_fail git checkout-index --stage=all --temp \
 		-- does-not-exist 2>stderr &&
diff --git a/t/t2006-checkout-index-basic.sh b/t/t2006-checkout-index-basic.sh
index 57cbdfe9bc..8e181dbf01 100755
--- a/t/t2006-checkout-index-basic.sh
+++ b/t/t2006-checkout-index-basic.sh
@@ -21,4 +21,15 @@ test_expect_success 'checkout-index -h in broken repository' '
 	test_i18ngrep "[Uu]sage" broken/usage
 '
 
+test_expect_success 'checkout-index reports errors (cmdline)' '
+	test_must_fail git checkout-index -- does-not-exist 2>stderr &&
+	test_i18ngrep not.in.the.cache stderr
+'
+
+test_expect_success 'checkout-index reports errors (stdin)' '
+	echo does-not-exist |
+	test_must_fail git checkout-index --stdin 2>stderr &&
+	test_i18ngrep not.in.the.cache stderr
+'
+
 test_done
-- 
2.29.1.634.g9e41dc1bf2
