Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C742C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D36D761B98
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 00:00:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbhKRAD2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Nov 2021 19:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241755AbhKRADR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Nov 2021 19:03:17 -0500
Received: from vuizook.err.no (vuizook.err.no [IPv6:2a02:20c8:2640::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB4CC061570
        for <git@vger.kernel.org>; Wed, 17 Nov 2021 16:00:17 -0800 (PST)
Received: from [2400:4160:1877:2b00:29f9:f15d:e50b:8944] (helo=glandium.org)
        by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnUqX-008GNk-HP; Thu, 18 Nov 2021 00:00:10 +0000
Received: from glandium by goemon.lan with local (Exim 4.94.2)
        (envelope-from <mh@glandium.org>)
        id 1mnUqQ-009zMg-An; Thu, 18 Nov 2021 09:00:02 +0900
Date:   Thu, 18 Nov 2021 09:00:02 +0900
From:   Mike Hommey <mh@glandium.org>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v3 18/23] Makefiles: add and use wildcard "mkdir -p"
 template
Message-ID: <20211118000002.wykfbk3qtlt46ab7@glandium.org>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
References: <cover-v2-00.18-00000000000-20211112T214150Z-avarab@gmail.com>
 <cover-v3-00.23-00000000000-20211116T114334Z-avarab@gmail.com>
 <patch-v3-18.23-d61e2b44f68-20211116T114334Z-avarab@gmail.com>
 <20211117025148.awdha4udu5kmzwbe@glandium.org>
 <211117.86wnl76sal.gmgdl@evledraar.gmail.com>
 <20211117093947.ifkrvddmiiu3hg2v@glandium.org>
 <211117.86k0h76lcy.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211117.86k0h76lcy.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 17, 2021 at 12:52:11PM +0100, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Nov 17 2021, Mike Hommey wrote:
> 
> > On Wed, Nov 17, 2021 at 10:26:27AM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> 
> >> On Wed, Nov 17 2021, Mike Hommey wrote:
> >> 
> >> > On Tue, Nov 16, 2021 at 01:00:18PM +0100, Ævar Arnfjörð Bjarmason wrote:
> >> >> Add a template to do the "mkdir -p" of $(@D) (the parent dir of $@)
> >> >> for us, and use it for the "make lint-docs" targets I added in
> >> >> 8650c6298c1 (doc lint: make "lint-docs" non-.PHONY, 2021-10-15).
> >> >> 
> >> >> As seen in 4c64fb5aad9 (Documentation/Makefile: fix lint-docs mkdir
> >> >> dependency, 2021-10-26) maintaining these manual lists of parent
> >> >> directory dependencies is fragile, in addition to being obviously
> >> >> verbose.
> >> >> 
> >> >> I used this pattern at the time because I couldn't find another method
> >> >> than "order-only" prerequisites to avoid doing a "mkdir -p $(@D)" for
> >> >> every file being created, which as noted in [1] would be significantly
> >> >> slower.
> >> >> 
> >> >> But as it turns out we can use this neat trick of only doing a "mkdir
> >> >> -p" if the $(wildcard) macro tells us the path doesn't exist. A re-run
> >> >> of a performance test similar to thatnoted downthread of [1] in [2]
> >> >> shows that this is faster, in addition to being less verbose and more
> >> >> reliable (this uses my "git-hyperfine" thin wrapper for "hyperfine"[3]):
> >> >> 
> >> >>     $ git hyperfine -L rev HEAD~0,HEAD~1 -b 'make -C Documentation lint-docs' -p 'rm -rf Documentation/.build' 'make -C Documentation lint-docs'
> >> >>     Benchmark 1: make -C Documentation lint-docs' in 'HEAD~0
> >> >>       Time (mean ± σ):      2.129 s ±  0.011 s    [User: 1.840 s, System: 0.321 s]
> >> >>       Range (min … max):    2.121 s …  2.158 s    10 runs
> >> >> 
> >> >>     Benchmark 2: make -C Documentation lint-docs' in 'HEAD~1
> >> >>       Time (mean ± σ):      2.659 s ±  0.002 s    [User: 2.306 s, System: 0.397 s]
> >> >>       Range (min … max):    2.657 s …  2.662 s    10 runs
> >> >> 
> >> >>     Summary
> >> >>       'make -C Documentation lint-docs' in 'HEAD~0' ran
> >> >>         1.25 ± 0.01 times faster than 'make -C Documentation lint-docs' in 'HEAD~1'
> >> >> 
> >> >> So let's use that pattern both for the "lint-docs" target, and a few
> >> >> miscellaneous other targets.
> >> >> 
> >> >> This method of creating parent directories is explicitly racy in that
> >> >> we don't know if we're going to say always create a "foo" followed by
> >> >> a "foo/bar" under parallelism, or skip the "foo" because we created
> >> >> "foo/bar" first. In this case it doesn't matter for anything except
> >> >> that we aren't guaranteed to get the same number of rules firing when
> >> >> running make in parallel.
> >> >
> >> > Something else that is racy is that $(wildcard) might be saying the
> >> > directory doesn't exist while there's another make subprocess that has
> >> > already started spawning `mkdir -p` for that directory.
> >> > That doesn't make a huge difference, but you can probably still end up
> >> > with multiple `mkdir -p` runs for the same directory.
> >> >
> >> > I think something like the following could work while avoiding those
> >> > races:
> >> >
> >> > define create_parent_dir_RULE
> >> > $(1): | $(dir $(1)).
> >> > ALL_DIRS += $(dir $(1))
> >> > endef
> >> >
> >> > define create_parent_dir_TARGET
> >> > $(1)/.: $(dir $(1)).
> >> > 	echo mkdir $$(@D)
> >
> > erf, s/echo //
> >
> >> > endef
> >> >
> >> > $(eval $(call create_parent_dir_RULE, first/path/file))
> >> > $(eval $(call create_parent_dir_RULE, second/path/file))
> >> > # ...
> >> >
> >> > $(foreach dir,$(sort $(ALL_DIRS)),$(eval $(call create_parent_dir_TARGET,$(dir:%/=%))))
> >> 
> >> I think the "race" just isn't a problem, and makes managing this much
> >> simpler.
> >> 
> >> I.e. we already rely on "mkdir -p" not failing on an existing directory,
> >> so the case where we redundantly try to create a directory that just got
> >> created by a concurrent process is OK, and as the quoted benchmark shows
> >> is much faster than a similar (but not quite the same as) a
> >> dependency-based implementaiton.
> >> 
> >> I haven't implemented your solution, but it seems to be inherently more
> >> complex.
> >> 
> >> I.e. with the one I've got you just stick the "mkdir if needed"
> >> one-liner in each rule, with yours you'll need to accumulate things in
> >> ALL_DIRS, and have some foreach somewhere or dependency relationship to
> >> create those beforehand if they're nested, no?
> >
> > For each rule, it would also be a oneliner to add above the rule. The rest
> > would be a prelude and a an epilogue to stick somewhere in the Makefile.
> 
> How would that epilogue know to handle cases where we're running "clean"
> or whatever thing doesn't want to create the full set of directories
> we've accumulated in ALL_DIRS while parsing the Makefile?

The epilogue only adds rules like:

dir/subdir/.: dir/.
	mkdir $(@D)

As long as those "clean" or whatever rules don't depend on those,
nothing will happen.
