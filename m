Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382BDC48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DE0E6109F
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbhFTPPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 11:15:10 -0400
Received: from mx.kolabnow.com ([95.128.36.40]:21580 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230059AbhFTPOr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 11:14:47 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 7E42A4112C
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :message-id:date:date:subject:subject:from:from:received
        :received:received; s=dkim20160331; t=1624201952; x=1626016353;
         bh=JUXrODa0ozC/XEAws5fQquQbZpv+rVpvh6VHkm9OWtc=; b=RGMRcHgE75tM
        2jrmwirfto7o7kkVQnfThwCYn5gECnrm743NgGBgAZh0XhyS/jvBizH7i3awX52x
        b7Y/2CbsSLkwLEXTuGFWVuvJqgRYeVSpP9MFClegY1xQAdsFEzz/q6jNwSSpG6Z8
        p21iqp7t/rKY6r1tyHOraoNayyE3FPav7V/QHO6Way5bZVF+du9OcQtD8fTvTDbr
        wgrPFoWyPZU+RJ02xcuvOigN1TnZ3RwwW/o5uGlx6Uemqft1bz8p4PTpb7914h4l
        6l8YiMeDIvDDtZ9PQUcSenS65iktbUbEbHWPTTV3BPPo6lfR8rmqPsTGjCKTbQaE
        N15BQZSwenj+QwNUAAbS73ZyFHTODTadhUvXY4ABD9+zTVQ5MuVv3KQrkvWDs3xD
        x/v1/PNhEQXpMSmJSVbC3J85Jmixz1PWJzgBtG6Gmxk/46AcLlIJKGXzt38Gcyum
        qqhkdNjxISK+RatWmCGurBWfP1XrBlLaUdTIWNIDqBQyC+bz/4arSECXSZ6LaI9z
        lppAOm9lLNJaTF/qFl/0D2dofLrOantR6pzfXe8g4b0P/Q26qHjt+TPl1qxH+2y0
        5c0425LPm+RyfeBjo5k+iVI0CREdgQ8vV54z33tXk8izmRqLHUyyc3dZzLrkx2t1
        Ev0b7tNPsydLbr3lVoKqlMAmVi7t0e8=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id CrazIsYKBBht for <git@vger.kernel.org>;
        Sun, 20 Jun 2021 17:12:32 +0200 (CEST)
Received: from int-mx001.mykolab.com (unknown [10.9.13.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id D3D9B407B7
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:31 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx001.mykolab.com (Postfix) with ESMTPS id 4396F34B;
        Sun, 20 Jun 2021 17:12:30 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org
Subject: [PATCH 11/12] builtin/rebase: fix options.strategy memory lifecycle
Date:   Sun, 20 Jun 2021 17:12:03 +0200
Message-Id: <20210620151204.19260-12-andrzej@ahunt.org>
In-Reply-To: <20210620151204.19260-1-andrzej@ahunt.org>
References: <20210620151204.19260-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <ajrhunt@google.com>

This change:
- xstrdup()'s all string being used for replace_opts.strategy, to
  guarantee that replace_opts owns these strings. This is needed because
  sequencer_remove_state() will free replace_opts.strategy, and it's
  usually called as part of the usage of replace_opts.
- Removes xstrdup()'s being used to populate options.strategy in
  cmd_rebase(), which avoids leaking options.strategy, even in the
  case where strategy is never moved/copied into replace_opts.

These changes are needed because:
- We would always create a new string for options.strategy if we either
  get a strategy via options (OPT_STRING(...strategy...), or via
  GIT_TEST_MERGE_ALGORITHM.
- But only sometimes is this string copied into replace_opts - in which
  case it did get free()'d in sequencer_remove_state().
- The rest of the time, the newly allocated string would remain unused,
  causing a leak. But we can't just add a free because that can result
  in a double-free in those cases where replace_opts was populated.

An alternative approach would be to set options.strategy to NULL when
moving the pointer to replace_opts.strategy, combined with always
free()'ing options.strategy, but that seems like a more
complicated and wasteful approach.

This was first seen when running t0021 with LSAN, but t2012 helped catch
the fact that we can't just free(options.strategy) at the end of
cmd_rebase (as that can cause a double-free). LSAN output from t0021:

LSAN output from t0021:

Direct leak of 4 byte(s) in 1 object(s) allocated from:
    #0 0x486804 in strdup ../projects/compiler-rt/lib/asan/asan_interceptors.cpp:452:3
    #1 0xa71eb8 in xstrdup wrapper.c:29:14
    #2 0x61b1cc in cmd_rebase builtin/rebase.c:1779:22
    #3 0x4ce83e in run_builtin git.c:475:11
    #4 0x4ccafe in handle_builtin git.c:729:3
    #5 0x4cb01c in run_argv git.c:818:4
    #6 0x4cb01c in cmd_main git.c:949:19
    #7 0x6b3fad in main common-main.c:52:11
    #8 0x7f267b512349 in __libc_start_main (/lib64/libc.so.6+0x24349)

SUMMARY: AddressSanitizer: 4 byte(s) leaked in 1 allocation(s).

Signed-off-by: Andrzej Hunt <andrzej@ahunt.org>
---
 builtin/rebase.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 12f093121d..9d81db0f3a 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -139,7 +139,7 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	replay.ignore_date = opts->ignore_date;
 	replay.gpg_sign = xstrdup_or_null(opts->gpg_sign_opt);
 	if (opts->strategy)
-		replay.strategy = opts->strategy;
+		replay.strategy = xstrdup_or_null(opts->strategy);
 	else if (!replay.strategy && replay.default_strategy) {
 		replay.strategy = replay.default_strategy;
 		replay.default_strategy = NULL;
@@ -1723,7 +1723,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	}
 
 	if (options.strategy) {
-		options.strategy = xstrdup(options.strategy);
 		switch (options.type) {
 		case REBASE_APPLY:
 			die(_("--strategy requires --merge or --interactive"));
@@ -1776,7 +1775,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 	if (options.type == REBASE_MERGE &&
 	    !options.strategy &&
 	    getenv("GIT_TEST_MERGE_ALGORITHM"))
-		options.strategy = xstrdup(getenv("GIT_TEST_MERGE_ALGORITHM"));
+		options.strategy = getenv("GIT_TEST_MERGE_ALGORITHM");
 
 	switch (options.type) {
 	case REBASE_MERGE:
-- 
2.26.2

