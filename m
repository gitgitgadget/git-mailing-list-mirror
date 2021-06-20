Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4976AC48BDF
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 229DD6109F
	for <git@archiver.kernel.org>; Sun, 20 Jun 2021 15:12:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbhFTPOY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Jun 2021 11:14:24 -0400
Received: from mx.kolabnow.com ([95.128.36.41]:15334 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229650AbhFTPOX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Jun 2021 11:14:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTP id E52D312FC
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-transfer-encoding:mime-version:message-id:date:date
        :subject:subject:from:from:received:received:received; s=
        dkim20160331; t=1624201927; x=1626016328; bh=J9zpU/Fxm8vxNGbCpoK
        tbRtYxLBp+BYd8fh/8I29EyM=; b=v24IFL7wRSSvh1FBQgSPTn+0745Xss1KKoC
        BR3/6OO2HkxsUgg59HJ5pOuGFIRsQb4339ZMClVFhbGd0Ctr+1uV9utBB2UxgscI
        nBN5APxZBZtMnsDdpnOEjn4HIiM7kT3YnzWHpNZsyU+5+b5rCByNWeQm8W8JKtnL
        Xa4QjT9u3NqIRFcfbekPmfhrxSetADTphTsXo9jj6Vcsg/NiDPPYP1haHdeMF386
        olUlUdZWoyg9aGKxCa1QNiPmfdTnlgwh0yuEXZuZ07Qipa5EbQ14Da+HX1w0lsac
        AYwg9+pXEViZpl+8wAWxD6kzqz2+iWqDZbqIRiOahIViu01kkBxYr0fl8znXCUV6
        Cz793uq5u/wcqJC1FbVlLlT5wj9pxrma5hVosanSoFS11y4U7XOUAX3VNpFTeso+
        P+GhGxdseRegbatlQXUq3CJhHARGQjrj+xw5LnRNdAWNQLgNN2YQdptuyTduFPrh
        BHZVcuWiwJWycqnkxi7TT91Uvx00NK22y+TL6lJ91vrHRDvDEpHpcIAevS6KzwJG
        UjIuqDikS5cAJX0e6+PvXvnjj2E52SAO1rcAdAB600iGkvcq/qGtA4QOHij+X/qk
        9CCZrUzQvU4v4vQY75TbRbRvHc7hGig7XLQBYlVhIiQLVBJrp4qpPSeeWQzthgvI
        Ipfweg98=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out002.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mJLE1Y58O4bu for <git@vger.kernel.org>;
        Sun, 20 Jun 2021 17:12:07 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out002.mykolab.com (Postfix) with ESMTPS id 3F9385C1
        for <git@vger.kernel.org>; Sun, 20 Jun 2021 17:12:06 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id B13C6A2E;
        Sun, 20 Jun 2021 17:12:05 +0200 (CEST)
From:   andrzej@ahunt.org
To:     git@vger.kernel.org
Cc:     andrzej@ahunt.org
Subject: [PATCH 00/12] Fix all leaks in tests t0002-t0099: Part 2
Date:   Sun, 20 Jun 2021 17:11:52 +0200
Message-Id: <20210620151204.19260-1-andrzej@ahunt.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andrzej Hunt <andrzej@ahunt.org>

This series plugs more of the leaks that were found while running
t0002-t0099 with LSAN.

See also the first series (already merged) at [1]. I'm currently
expecting at least another 2 series before t0002-t0099 run leak free.
I'm not being particularly systematic about the order of patches -
although I am trying to send out "real" (if mostly small) leaks first,
before sending out the more boring patches that add free()/UNLEAK() to
cmd_* and direct helpers thereof.

ATB,

Andrzej

[1] https://lore.kernel.org/git/pull.929.git.1617994052.gitgitgadget@gmail.com/

Andrzej Hunt (12):
  fmt-merge-msg: free newly allocated temporary strings when done
  environment: move strbuf into block to plug leak
  builtin/submodule--helper: release unused strbuf to avoid leak
  for-each-repo: remove unnecessary argv copy to plug leak
  diffcore-rename: move old_dir/new_dir definition to plug leak
  ref-filter: also free head for ATOM_HEAD to avoid leak
  read-cache: call diff_setup_done to avoid leak
  convert: release strbuf to avoid leak
  builtin/mv: free or UNLEAK multiple pointers at end of cmd_mv
  builtin/merge: free found_ref when done
  builtin/rebase: fix options.strategy memory lifecycle
  reset: clear_unpack_trees_porcelain to plug leak

 builtin/for-each-repo.c     | 14 ++++----------
 builtin/merge.c             |  3 ++-
 builtin/mv.c                |  5 +++++
 builtin/rebase.c            |  5 ++---
 builtin/submodule--helper.c |  6 ++++--
 convert.c                   |  2 ++
 diffcore-rename.c           | 10 +++++++---
 environment.c               |  7 +++----
 fmt-merge-msg.c             |  6 ++++--
 read-cache.c                |  1 +
 ref-filter.c                |  8 ++++++--
 reset.c                     |  4 ++--
 12 files changed, 42 insertions(+), 29 deletions(-)

-- 
2.26.2

