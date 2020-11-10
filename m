Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BA1C55ABD
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061C5207D3
	for <git@archiver.kernel.org>; Tue, 10 Nov 2020 21:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731876AbgKJVjE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Nov 2020 16:39:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:53554 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730894AbgKJVh2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Nov 2020 16:37:28 -0500
Received: (qmail 9487 invoked by uid 109); 10 Nov 2020 21:37:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Nov 2020 21:37:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6074 invoked by uid 111); 10 Nov 2020 21:37:27 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Nov 2020 16:37:27 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 10 Nov 2020 16:37:27 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Demi M. Obenour" <athena@invisiblethingslab.com>,
        Git <git@vger.kernel.org>
Subject: [PATCH 1/3] rev-parse: don't accept options after dashdash
Message-ID: <20201110213727.GA788740@coredump.intra.peff.net>
References: <20201110213544.GA3263091@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201110213544.GA3263091@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Because of the order in which we check options in rev-parse, there are a
few options we accept even after a "--". This is wrong, because the
whole point of "--" is to say "everything after here is a path". Let's
move the "did we see a dashdash" check (it's called "as_is" in the code)
to the top of the parsing loop.

Note there is one subtlety here. The options are ordered so that some
are checked before we even see if we're in a repository (they continue
the loop, and if we get past a certain point, then we do the repository
setup). By moving the as_is check higher, it's also in that "before
setup" section, even though it might look at the repository via
verify_filename(). However, this works out: we'd never set as_is until
we parse "--", and we don't parse that until after doing the setup.

An alternative here to avoid the subtlety is to put the as_is check at
the top of the post-setup options. But then every pre-setup option would
have to remember to check "if (!as_is && !strcmp(...))". So while this
is a bit magical, it's harder for future code to get wrong.

Signed-off-by: Jeff King <peff@peff.net>
---
I guess it could also shove them all into an:

  if (!as_is) {
	if (!strcmp("--local-env-vars"))
  }

conditional. I do end up having to do that later for end-of-options
anyway.

 builtin/rev-parse.c            | 11 ++++++-----
 t/t1506-rev-parse-diagnosis.sh |  9 +++++++++
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/builtin/rev-parse.c b/builtin/rev-parse.c
index ed200c8af1..293428fa0d 100644
--- a/builtin/rev-parse.c
+++ b/builtin/rev-parse.c
@@ -622,6 +622,12 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 	for (i = 1; i < argc; i++) {
 		const char *arg = argv[i];
 
+		if (as_is) {
+			if (show_file(arg, output_prefix) && as_is < 2)
+				verify_filename(prefix, arg, 0);
+			continue;
+		}
+
 		if (!strcmp(arg, "--local-env-vars")) {
 			int i;
 			for (i = 0; local_repo_env[i]; i++)
@@ -655,11 +661,6 @@ int cmd_rev_parse(int argc, const char **argv, const char *prefix)
 			i++;
 			continue;
 		}
-		if (as_is) {
-			if (show_file(arg, output_prefix) && as_is < 2)
-				verify_filename(prefix, arg, 0);
-			continue;
-		}
 		if (!strcmp(arg,"-n")) {
 			if (++i >= argc)
 				die("-n requires an argument");
diff --git a/t/t1506-rev-parse-diagnosis.sh b/t/t1506-rev-parse-diagnosis.sh
index 3e657e693b..2ed5d50059 100755
--- a/t/t1506-rev-parse-diagnosis.sh
+++ b/t/t1506-rev-parse-diagnosis.sh
@@ -254,4 +254,13 @@ test_expect_success 'escaped char does not trigger wildcard rule' '
 	test_must_fail git rev-parse "foo\\*bar"
 '
 
+test_expect_success 'arg after dashdash not interpreted as option' '
+	cat >expect <<-\EOF &&
+	--
+	--local-env-vars
+	EOF
+	git rev-parse -- --local-env-vars >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.29.2.640.g9e24689a4c

