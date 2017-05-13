Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8602201A7
	for <e@80x24.org>; Sat, 13 May 2017 03:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751123AbdEMD3e (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 23:29:34 -0400
Received: from cloud.peff.net ([104.130.231.41]:50647 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751064AbdEMD3e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 23:29:34 -0400
Received: (qmail 6638 invoked by uid 109); 13 May 2017 03:29:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 03:29:34 +0000
Received: (qmail 29096 invoked by uid 111); 13 May 2017 03:30:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 23:30:05 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 23:29:31 -0400
Date:   Fri, 12 May 2017 23:29:31 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Hagins <hagins.josh@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 3/3] config: complain about --local outside of a git repo
Message-ID: <20170513032931.uyvhfw6fgju36ovf@sigill.intra.peff.net>
References: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "--local" option instructs git-config to read or modify
the repository-level config. This doesn't make any sense if
you're not actually in a repository.

Older versions of Git would blindly try to read or write
".git/config". For reading, this would result in a quiet
failure, since there was no config to read (and thus no
matching config value). Writing would generally fail
noisily, since ".git" was unlikely to exist. But since
b1ef400ee (setup_git_env: avoid blind fall-back to ".git",
2016-10-20), we catch this in the call to git_pathdup() and
die with an assertion.

Dying is the right thing to do, but we should catch the
problem early and give a more human-friendly error message.

Note that even without --local, git-config will sometimes
default to using local repository config (e.g., when
writing). These cases are already protected by similar
checks, and covered by a test in t1308.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c       | 3 +++
 t/t1300-repo-config.sh | 2 +-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/config.c b/builtin/config.c
index 3a554ad50..7f6c25d4d 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -496,6 +496,9 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 
+	if (use_local_config && nongit)
+		die(_("--local can only be used inside a git repository"));
+
 	if (given_config_source.file &&
 			!strcmp(given_config_source.file, "-")) {
 		given_config_source.file = NULL;
diff --git a/t/t1300-repo-config.sh b/t/t1300-repo-config.sh
index 867704a64..13b7851f7 100755
--- a/t/t1300-repo-config.sh
+++ b/t/t1300-repo-config.sh
@@ -1539,7 +1539,7 @@ test_expect_success !MINGW '--show-origin blob ref' '
 	test_cmp expect output
 '
 
-test_expect_failure '--local requires a repo' '
+test_expect_success '--local requires a repo' '
 	# we expect 128 to ensure that we do not simply
 	# fail to find anything and return code "1"
 	test_expect_code 128 nongit git config --local foo.bar
-- 
2.13.0.452.g0afc8e12b
