Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A2AC433F5
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 02:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A98661B73
	for <git@archiver.kernel.org>; Wed, 17 Nov 2021 02:52:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbhKQCy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Nov 2021 21:54:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbhKQCy6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Nov 2021 21:54:58 -0500
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48A71C061570
        for <git@vger.kernel.org>; Tue, 16 Nov 2021 18:52:00 -0800 (PST)
Received: from [2400:4160:1877:2b00:29f9:f15d:e50b:8944] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnB3C-005VYt-FK; Wed, 17 Nov 2021 02:51:54 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnB36-009hBd-Qa; Wed, 17 Nov 2021 11:51:48 +0900
Date:   Wed, 17 Nov 2021 11:51:48 +0900
From:   Mike Hommey <mh@glandium.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 18/23] Makefiles: add and use wildcard "mkdir -p"
 template
Message-ID: <20211117025148.awdha4udu5kmzwbe@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
 <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
 <patch-v3-18.23-d61e2b44f68-20211116T114334Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v3-18.23-d61e2b44f68-20211116T114334Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 16, 2021 at 01:00:18PM +0100, Ævar Arnfjörð Bjarmason wrote:
> Add a template to do the "mkdir -p" of $(@D) (the parent dir of $@)
> for us, and use it for the "make lint-docs" targets I added in
> 8650c6298c1 (doc lint: make "lint-docs" non-.PHONY, 2021-10-15).
> 
> As seen in 4c64fb5aad9 (Documentation/Makefile: fix lint-docs mkdir
> dependency, 2021-10-26) maintaining these manual lists of parent
> directory dependencies is fragile, in addition to being obviously
> verbose.
> 
> I used this pattern at the time because I couldn't find another method
> than "order-only" prerequisites to avoid doing a "mkdir -p $(@D)" for
> every file being created, which as noted in [1] would be significantly
> slower.
> 
> But as it turns out we can use this neat trick of only doing a "mkdir
> -p" if the $(wildcard) macro tells us the path doesn't exist. A re-run
> of a performance test similar to thatnoted downthread of [1] in [2]
> shows that this is faster, in addition to being less verbose and more
> reliable (this uses my "git-hyperfine" thin wrapper for "hyperfine"[3]):
> 
>     $ git hyperfine -L rev HEAD~0,HEAD~1 -b 'make -C Documentation lint-docs' -p 'rm -rf Documentation/.build' 'make -C Documentation lint-docs'
>     Benchmark 1: make -C Documentation lint-docs' in 'HEAD~0
>       Time (mean ± σ):      2.129 s ±  0.011 s    [User: 1.840 s, System: 0.321 s]
>       Range (min … max):    2.121 s …  2.158 s    10 runs
> 
>     Benchmark 2: make -C Documentation lint-docs' in 'HEAD~1
>       Time (mean ± σ):      2.659 s ±  0.002 s    [User: 2.306 s, System: 0.397 s]
>       Range (min … max):    2.657 s …  2.662 s    10 runs
> 
>     Summary
>       'make -C Documentation lint-docs' in 'HEAD~0' ran
>         1.25 ± 0.01 times faster than 'make -C Documentation lint-docs' in 'HEAD~1'
> 
> So let's use that pattern both for the "lint-docs" target, and a few
> miscellaneous other targets.
> 
> This method of creating parent directories is explicitly racy in that
> we don't know if we're going to say always create a "foo" followed by
> a "foo/bar" under parallelism, or skip the "foo" because we created
> "foo/bar" first. In this case it doesn't matter for anything except
> that we aren't guaranteed to get the same number of rules firing when
> running make in parallel.

Something else that is racy is that $(wildcard) might be saying the
directory doesn't exist while there's another make subprocess that has
already started spawning `mkdir -p` for that directory.
That doesn't make a huge difference, but you can probably still end up
with multiple `mkdir -p` runs for the same directory.

I think something like the following could work while avoiding those
races:

define create_parent_dir_RULE
$(1): | $(dir $(1)).
ALL_DIRS += $(dir $(1))
endef

define create_parent_dir_TARGET
$(1)/.: $(dir $(1)).
	echo mkdir $$(@D)
endef

$(eval $(call create_parent_dir_RULE, first/path/file))
$(eval $(call create_parent_dir_RULE, second/path/file))
# ...

$(foreach dir,$(sort $(ALL_DIRS)),$(eval $(call create_parent_dir_TARGET,$(dir:%/=%))))

Mike
