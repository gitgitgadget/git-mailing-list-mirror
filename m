Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402AF1F4B6
	for <e@80x24.org>; Sat, 11 May 2019 23:02:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbfEKXCH (ORCPT <rfc822;e@80x24.org>);
        Sat, 11 May 2019 19:02:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:54948 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726130AbfEKXCH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 May 2019 19:02:07 -0400
Received: (qmail 23994 invoked by uid 109); 11 May 2019 23:02:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 11 May 2019 23:02:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27511 invoked by uid 111); 11 May 2019 23:02:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 11 May 2019 19:02:44 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 11 May 2019 19:02:05 -0400
Date:   Sat, 11 May 2019 19:02:05 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Wong <e@80x24.org>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Antonio Ospite <ao2@ao2.it>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: new segfault in master (6a6c0f10a70a6eb1)
Message-ID: <20190511230204.GA18474@sigill.intra.peff.net>
References: <20190511205711.tdclwrdixaau75zv@dcvr>
 <20190511223120.GA25224@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190511223120.GA25224@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, May 11, 2019 at 06:31:20PM -0400, Jeff King wrote:

> On Sat, May 11, 2019 at 08:57:11PM +0000, Eric Wong wrote:
> 
> > This test-tool submodule segfault seems new.  Noticed it while
> > checking dmesg for other things.
> 
> Yeah, I hadn't seen it before. It's almost certainly the expect_failure
> added in 2b1257e463 (t/helper: add test-submodule-nested-repo-config,
> 2018-10-25), since otherwise we'd be complaining of a test failure.
> 
> I know we don't expect this to do the right thing yet, but it seems like
> there's still a bug, since the test seems to think we should output a
> nice message (and it's possible that the segfault can be triggered from
> non-test-tool code, too).
> 
> +cc the author.

Actually, the plot thickens. That test _used to_ correctly expect
failure (well, sort of -- it greps for the string with %s, which is
wrong!). But then more recently in d9b8b8f896 (submodule-config.c: use
repo_get_oid for reading .gitmodules, 2019-04-16), it started actually
doing the lookup in the correct repo. And that started the segfault,
because nobody has actually loaded the index for the submodule.

I don't think this can be triggered outside of test-tool. There are
four ways to get to config_from_gitmodules():

  - via repo_read_gitmodules(), which explicitly loads the index

  - via print_config_from_gitmodules(). This is called from
    submodule--helper, but only with the_repository as the argument (and
    I _think_ that the_repository->index is never NULL, because we point
    it at the_index).

  - via fetch_config_from_gitmodules(), which always passes
    the_repository

  - via update_clone_config_from_gitmodules(), likewise

But regardless, I think it makes sense to load the index on demand when
we need it here, which makes Antonio's original test pass (like the
patch below).

The segfault ultimately comes from repo_get_oid(); we feed it
":.gitmodules" and it blindly looks at repo->index. It's probably worth
it being a bit more defensive and just returning "no such entry" if
there's no index to look at (it could also load on demand, I guess, but
it seems like too low a level to be making that kind of decision).

I'm out of time for now, but I'll look into cleaning this up and writing
a real commit message later.

---
diff --git a/submodule-config.c b/submodule-config.c
index 4264ee216f..ad2444bcec 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -630,7 +630,8 @@ static void config_from_gitmodules(config_fn_t fn, struct repository *repo, void
 		file = repo_worktree_path(repo, GITMODULES_FILE);
 		if (file_exists(file)) {
 			config_source.file = file;
-		} else if (repo_get_oid(repo, GITMODULES_INDEX, &oid) >= 0 ||
+		} else if ((repo_read_index(repo) >= 0 &&
+			    repo_get_oid(repo, GITMODULES_INDEX, &oid) >= 0) ||
 			   repo_get_oid(repo, GITMODULES_HEAD, &oid) >= 0) {
 			config_source.blob = oidstr = xstrdup(oid_to_hex(&oid));
 			if (repo != the_repository)
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index fcc0fb82d8..ad28e93880 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -243,18 +243,14 @@ test_expect_success 'reading nested submodules config' '
 	)
 '
 
-# When this test eventually passes, before turning it into
-# test_expect_success, remember to replace the test_i18ngrep below with
-# a "test_must_be_empty warning" to be sure that the warning is actually
-# removed from the code.
-test_expect_failure 'reading nested submodules config when .gitmodules is not in the working tree' '
+test_expect_success 'reading nested submodules config when .gitmodules is not in the working tree' '
 	test_when_finished "git -C super/submodule checkout .gitmodules" &&
 	(cd super &&
 		echo "./nested_submodule" >expect &&
 		rm submodule/.gitmodules &&
 		test-tool submodule-nested-repo-config \
 			submodule submodule.nested_submodule.url >actual 2>warning &&
-		test_i18ngrep "nested submodules without %s in the working tree are not supported yet" warning &&
+		test_must_be_empty warning &&
 		test_cmp expect actual
 	)
 '
