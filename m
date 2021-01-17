Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCA2C433DB
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 12:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32DE2226A
	for <git@archiver.kernel.org>; Sun, 17 Jan 2021 12:07:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbhAQMHG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 17 Jan 2021 07:07:06 -0500
Received: from mail2.pdinc.us ([67.90.184.28]:39340 "EHLO mail2.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728271AbhAQMHE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Jan 2021 07:07:04 -0500
X-Greylist: delayed 3688 seconds by postgrey-1.27 at vger.kernel.org; Sun, 17 Jan 2021 07:06:43 EST
Received: from kyle-ppc64le.internal.gigabyteproductions.net (cpe-173-88-170-197.neo.res.rr.com [173.88.170.197])
        (authenticated bits=0)
        by mail2.pdinc.us (8.14.4/8.14.4) with ESMTP id 10HB3bab002017
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
        Sun, 17 Jan 2021 06:03:38 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mail2.pdinc.us 10HB3bab002017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pdinc.us; s=default;
        t=1610881418; bh=ArTbmNuMsZRhoFb5qwdcJlkG9EwQCB1JDa8DmbWmLws=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oPToooYG/EFpNoi13WigLgOX8IoNW92cbDeZwn6suwBFEy4SIjWILCDTmoEG6WXwy
         xYBCz4isSK4D27iBk6IhIShC5wWqsa7+MzazVzSG3OWGjNVIWe6kamQwbG+4V1MRRS
         zxPBzSoG9tob22ouuGFmeNgALoWLsyutQHlgxChvodgoPcgeyeZhV4yZR41bbAdvVD
         2k10ansoGVyHVevquMGLJ1GfqIQ5r/hvmGgF80iybyaKlFA75GR5PPBj/rKqcMXDuG
         p12sxJXW0qgscwdsp9GcTjL3tP2iOgclobx3yyAtK3tj12tHLbE+0JSLRBkYiNW6rZ
         glbvBg5+KP1og==
From:   Kyle Marek <kmarek@pdinc.us>
To:     Jason Pyeron <jpyeron@pdinc.us>, git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>
Subject: [PATCH 0/2] Option to modify revision mark for root commits
Date:   Sun, 17 Jan 2021 06:03:35 -0500
Message-Id: <20210117110337.429994-1-kmarek@pdinc.us>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <196101d6eab6$20714550$6153cff0$@pdinc.us>
References: <196101d6eab6$20714550$6153cff0$@pdinc.us>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series allows --show-linear-break to be used with --graph,
allowing for the revision mark to be changed for root commits.

Feel free to squash away PATCH 1, or maybe even discard PATCH 2.

Jason: tested against Cygwin x86_64/release/git/git-2.30.0-1-src.tar.xz

Note: PATCH 2 revision.c:2410 makes a second copy of optarg. This may
not be necessary.

Background:

The use case is --graph --oneline with unrelated histories. For example,
in a hypothetical repository with an orphaned "prebuilt" branch
containing builds of the master branch, the history may look like:

kmarek@kyle-ppc64le /tmp/somerepo
$ git log --graph --all --oneline
* 02190b6 (prebuilt) add aarch64
* 7b873f6 add x86_64
* 26cc783 add ppc64le
* 5b7186e (HEAD -> master) add Makefile
* ea69093 implement cmdline parsing
* a65df8a add main.c
* 7727eb3 Initial commit

At first sight, the above log implies that 26cc783's parent is 5b7186e,
or that master is an ancestor to prebuilt, but 26cc783 is the start of a
new history:

kmarek@kyle-ppc64le /tmp/somerepo
$ git log --graph --oneline master
* 5b7186e (HEAD -> master) add Makefile
* ea69093 implement cmdline parsing
* a65df8a add main.c
* 7727eb3 Initial commit

kmarek@kyle-ppc64le /tmp/somerepo
$ git log --graph --oneline prebuilt
* 02190b6 (prebuilt) add aarch64
* 7b873f6 add x86_64
* 26cc783 add ppc64le

To identify the start of a new history:

kmarek@kyle-ppc64le /tmp/somerepo
$ git log --graph --all --oneline --show-linear-break
* 02190b6 (prebuilt) add aarch64
* 7b873f6 add x86_64
# 26cc783 add ppc64le
* 5b7186e (HEAD -> master) add Makefile
* ea69093 implement cmdline parsing
* a65df8a add main.c
# 7727eb3 Initial commit

kmarek@kyle-ppc64le /tmp/somerepo
$ git log --graph --all --oneline --show-linear-break=I
* 02190b6 (prebuilt) add aarch64
* 7b873f6 add x86_64
I 26cc783 add ppc64le
* 5b7186e (HEAD -> master) add Makefile
* ea69093 implement cmdline parsing
* a65df8a add main.c
I 7727eb3 Initial commit

Kyle Marek (2):
  revision: Denote root commits with '#'
  revision: implement --show-linear-break for --graph

 Documentation/rev-list-options.txt |  7 +++++++
 log-tree.c                         |  2 +-
 revision.c                         | 10 ++++++----
 revision.h                         |  1 +
 4 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.29.2

