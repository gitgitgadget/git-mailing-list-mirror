Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE21AC433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7C2764E07
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 14:58:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbhBPO6T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 09:58:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:34286 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230021AbhBPO6S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 09:58:18 -0500
Received: (qmail 13538 invoked by uid 109); 16 Feb 2021 14:57:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Feb 2021 14:57:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25074 invoked by uid 111); 16 Feb 2021 14:57:37 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Feb 2021 09:57:37 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 16 Feb 2021 09:57:37 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Blake Burkhart <bburky@bburky.com>,
        Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 6/6] mailmap: do not respect symlinks for in-tree .mailmap
Message-ID: <YCvdYTSOK5bLpo5h@coredump.intra.peff.net>
References: <YCvaJg8o882IqNnx@coredump.intra.peff.net>
 <YCvaVZEUuIwAFWxe@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YCvaVZEUuIwAFWxe@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 16, 2021 at 09:44:37AM -0500, Jeff King wrote:

> @@ -225,10 +235,12 @@ int read_mailmap(struct string_list *map)
>  	if (!git_mailmap_blob && is_bare_repository())
>  		git_mailmap_blob = "HEAD:.mailmap";
>  
> -	err |= read_mailmap_file(map, ".mailmap");
> +	err |= read_mailmap_file(map, ".mailmap",
> +				 startup_info->have_repository ?
> +				 MAILMAP_NOFOLLOW : 0);

This conflicts with my jk/mailmap-only-at-root topic currently in
"next", of course. Ditto for the new tests.

The resolution is pretty straight-forward, though:

diff --cc mailmap.c
index 9bb9cf8b30,7ac966107e..0000000000
--- a/mailmap.c
+++ b/mailmap.c
@@@ -225,11 -235,12 +235,13 @@@ int read_mailmap(struct string_list *ma
  	if (!git_mailmap_blob && is_bare_repository())
  		git_mailmap_blob = "HEAD:.mailmap";
  
 -	err |= read_mailmap_file(map, ".mailmap",
 -				 startup_info->have_repository ?
 -				 MAILMAP_NOFOLLOW : 0);
 +	if (!startup_info->have_repository || !is_bare_repository())
- 		err |= read_mailmap_file(map, ".mailmap");
++		err |= read_mailmap_file(map, ".mailmap",
++					 startup_info->have_repository ?
++					 MAILMAP_NOFOLLOW : 0);
  	if (startup_info->have_repository)
  		err |= read_mailmap_blob(map, git_mailmap_blob);
- 	err |= read_mailmap_file(map, git_mailmap_file);
+ 	err |= read_mailmap_file(map, git_mailmap_file, 0);
  	return err;
  }
  
diff --cc t/t4203-mailmap.sh
index 93caf9a46d,96a4e6132f..0000000000
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@@ -889,47 -889,35 +889,78 @@@ test_expect_success 'empty syntax: setu
  	test_cmp expect actual
  '
  
 +test_expect_success 'set up mailmap location tests' '
 +	git init --bare loc-bare &&
 +	git --git-dir=loc-bare --work-tree=. commit \
 +		--allow-empty -m foo --author="Orig <orig@example.com>" &&
 +	echo "New <new@example.com> <orig@example.com>" >loc-bare/.mailmap
 +'
 +
 +test_expect_success 'bare repo with --work-tree finds mailmap at top-level' '
 +	git -C loc-bare --work-tree=. log -1 --format=%aE >actual &&
 +	echo new@example.com >expect &&
 +	test_cmp expect actual
 +'
 +
 +test_expect_success 'bare repo does not look in current directory' '
 +	git -C loc-bare log -1 --format=%aE >actual &&
 +	echo orig@example.com >expect &&
 +	test_cmp expect actual
 +'
 +
 +test_expect_success 'non-git shortlog respects mailmap in current dir' '
 +	git --git-dir=loc-bare log -1 >input &&
 +	nongit cp "$TRASH_DIRECTORY/loc-bare/.mailmap" . &&
 +	nongit git shortlog -s <input >actual &&
 +	echo "     1	New" >expect &&
 +	test_cmp expect actual
 +'
 +
 +test_expect_success 'shortlog on stdin respects mailmap from repo' '
 +	cp loc-bare/.mailmap . &&
 +	git shortlog -s <input >actual &&
 +	echo "     1	New" >expect &&
 +	test_cmp expect actual
 +'
 +
 +test_expect_success 'find top-level mailmap from subdir' '
 +	git clone loc-bare loc-wt &&
 +	cp loc-bare/.mailmap loc-wt &&
 +	mkdir loc-wt/subdir &&
 +	git -C loc-wt/subdir log -1 --format=%aE >actual &&
 +	echo new@example.com >expect &&
 +	test_cmp expect actual
 +'
 +
+ test_expect_success SYMLINKS 'set up symlink tests' '
+ 	git commit --allow-empty -m foo --author="Orig <orig@example.com>" &&
+ 	echo "New <new@example.com> <orig@example.com>" >map &&
+ 	rm -f .mailmap
+ '
+ 
+ test_expect_success SYMLINKS 'symlinks respected in mailmap.file' '
+ 	test_when_finished "rm symlink" &&
+ 	ln -s map symlink &&
+ 	git -c mailmap.file="$(pwd)/symlink" log -1 --format=%aE >actual &&
+ 	echo "new@example.com" >expect &&
+ 	test_cmp expect actual
+ '
+ 
+ test_expect_success SYMLINKS 'symlinks respected in non-repo shortlog' '
+ 	git log -1 >input &&
+ 	test_when_finished "nongit rm .mailmap" &&
+ 	nongit ln -sf "$TRASH_DIRECTORY/map" .mailmap &&
+ 	nongit git shortlog -s <input >actual &&
+ 	echo "     1	New" >expect &&
+ 	test_cmp expect actual
+ '
+ 
+ test_expect_success SYMLINKS 'symlinks not respected in-tree' '
+ 	test_when_finished "rm .mailmap" &&
+ 	ln -s map .mailmap &&
+ 	git log -1 --format=%aE >actual &&
+ 	echo "orig@example.com" >expect&&
+ 	test_cmp expect actual
+ '
+ 
  test_done
