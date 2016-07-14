Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BE5A20196
	for <e@80x24.org>; Thu, 14 Jul 2016 15:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbcGNPaX (ORCPT <rfc822;e@80x24.org>);
	Thu, 14 Jul 2016 11:30:23 -0400
Received: from mout.gmx.net ([212.227.17.21]:60454 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751241AbcGNPaV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2016 11:30:21 -0400
Received: from virtualbox ([37.24.141.198]) by mail.gmx.com (mrgmx101) with
 ESMTPSA (Nemesis) id 0Lubnw-1bEogo3Vxo-00zkjv; Thu, 14 Jul 2016 17:30:15
 +0200
Date:	Thu, 14 Jul 2016 17:30:10 +0200 (CEST)
From:	Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:	git@vger.kernel.org
cc:	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 0/3] Teach `git fsck` a new option: `--name-objects`
Message-ID: <cover.1468510191.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:NwBdbmVX+yeiIHLz0kT1egs6IL6L98iMuxCoId+EXudw9nWBpLu
 PRUIG/vLsi/Ya+Qy3S26yrjdW4AwL0YAPC8eO965siuRutnc+lTDGW+x07AAqh1hnc0dCQR
 uTOmlNd8MrIQ7Lts7TA/BhNeNNCj6X63yOssEMeW0QjyrHxLMKZ05zqJcQjh+rLB2b8zSRM
 VWCn2u2QhnT2zOSISP5ag==
X-UI-Out-Filterresults:	notjunk:1;V01:K0:AxaReNRg4r8=:6L+MXW3dlwNGA0PR6CDmyU
 tGgDUreVMvrRezdK+5vj1lxhuzSYjL3Xuritcg5V5f6yzuIJSfOAdMKjMejVS1Du8j4t1zpUE
 mYx6ilxizcsrLgQHmg7LcfYyZXLz0UuZRuDi+GgNLRiWEVjjF3DAdUwO0v6SF3MEGK02Z4q6O
 7ekWOLwNLcTieE6N/4NDUnXvgF/hdr249P5WYBL0nWyIW7U1wOPg2jsr2iC42e8uwE5awe7dz
 3B/pKfOeapK5rS67+LrwIl4t4TWmc4K3RV2NkdOCW9O3qt6WnASebVhsltooOon9WeHweKMkX
 vbLcrWCoKDqTgEzya+nri3ODc8iDP6bmIdhtADcFJRJhnAo/Q6rCT7nzZfmxjwn4A9DHeEi7b
 iUIoNQshlLlsr345iqpJYyES84TAitaVm43eRNVl7bMdgNh5vgdVH3vYxy+Lw0leLS2pKdsib
 Y84VcYSTS5lCvJTadnVW/aBbhUlwIixwPfT7JocDsd+VDP7Kz343t32b1p3r9Wb1E9gc2SZyo
 7O0wiAA9hqv1geS4HCi2MhefyXKQ4DdcRHGfEYNKyuXueo4//CAQ+CGE41GyGiIhinTIsOXZi
 Xiv7oJmv2s2TjCcZLeG8uJFQ721a1G6UF92baHmug/nmIdhCuzGrF7D9esFWLiCzhIjneDUMb
 DvjAurIJ9kyuYWXF9lZbqRTSaEWMbqZRC9oZl7TUR7I1oeCwsbqhFHlZLMWJIjPN2Kmq52TvY
 QPQ8d207i+BmKlnsPtVsNqP5reoMjGz5BjvqLKzjFMpM5KuFDoP+wW9FedWJdMm6kuc0FuH6P
 wZMJQXr
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

When using experimental features (such as worktrees), it is quite
possible to end up with a repository that is a little bit corrupted. In
this developer's case, the auto gc run during interactive rebases in
worktrees completely messed up the reflogs.

The symptoms are broken links between commits/trees/blobs.

Trying to work around such problems can be a real challenge: while
several tools will report when objects are missing, all of them simply
state the SHA-1. This is not useful when the user has to kiss the
offending reflog good-bye, but does not even know which one.

This patch series introduces a new option to `git fsck`: --name-objects.
With this option, the fsck command will report not only the SHA-1 of
missing objects, but also a name by which this object is supposed to be
reachable.

Example output:

	...
	broken link from    tree b5eb6ff...  (refs/stash@{<date>}~37:)
		      to    blob ec5cf80...

Originally, I intended to teach name-rev a new mode where it would also
name objects other than commits and tags, but since the objects in
question were lost to a garbage collection, and therefore there would
not have been any objects to call names to begin with, I had to abandon
said quest.


Johannes Schindelin (3):
  fsck: refactor how to describe objects
  fsck_walk(): optionally name objects on the go
  fsck: optionally show more helpful info for broken links

 Documentation/git-fsck.txt |  9 +++++-
 builtin/fsck.c             | 77 ++++++++++++++++++++++++++++++++++++----------
 fsck.c                     | 72 +++++++++++++++++++++++++++++++++++++++++++
 fsck.h                     |  1 +
 t/t1450-fsck.sh            | 22 +++++++++++++
 5 files changed, 163 insertions(+), 18 deletions(-)

Published-As: https://github.com/dscho/git/releases/tag/fsck-name-objects-v1
-- 
2.9.0.278.g1caae67

base-commit: 79ed43c28f626a4e805f350a77c54968b59be6e9
