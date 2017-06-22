Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DF15920802
	for <e@80x24.org>; Thu, 22 Jun 2017 20:36:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752075AbdFVUgW (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 16:36:22 -0400
Received: from siwi.pair.com ([209.68.5.199]:33218 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750847AbdFVUgW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 16:36:22 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EFD2A84591;
        Thu, 22 Jun 2017 16:36:20 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 5E8878458F;
        Thu, 22 Jun 2017 16:36:20 -0400 (EDT)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, jonathantanmy@google.com,
        jrnieder@gmail.com, Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH 0/3] WIP list-objects and pack-objects for partial clone
Date:   Thu, 22 Jun 2017 20:36:12 +0000
Message-Id: <20170622203615.34135-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This WIP is a follow up to earlier patches to teach pack-objects
to omit large blobs from packfiles.  This doesn't attempt to solve
the whole end-to-end problem of partial/sparse clone/fetch or that
of the client operating with missing blobs.  This WIP is for now
limited to building the packfile with omitted blobs and hopefully
can mesh nicely with Jonathan Tan's work in [3].

It supports filtering by size while always including blobs associated
with ".git*" paths, something we both proposed in [1] and [3].

The approach here differs from [1] and [3] in that it extends
traverse_commit_list() to allow custom blob filtering using a new
callback provided by pack-objects.  This should make it easier to
do other filters laters.  Part of this based upon Peff's suggestion
about rev-list in [2].  I have not updated the rev-list command,
but rather the routines in list-objects.c that it calls.  Jonathan's
ideas in [3] to build and send the omitted blobs list means that I
think we need pack-objects.c manage the filter-proc used here.

I considered, but omitted from this version, ideas to allow the
filter-proc to know of the process_tree() boundaries which might
let pack-objects filter by sub-tree (think sparse-checkout) as
suggested in [4] and various replies.

[1] https://public-inbox.org/git/1488994685-37403-3-git-send-email-jeffhost@microsoft.com/
[2] https://public-inbox.org/git/20170309073117.g3br5btsfwntcdpe@sigill.intra.peff.net/
[3] https://public-inbox.org/git/cover.1496361873.git.jonathantanmy@google.com/
[4] https://public-inbox.org/git/20170602232508.GA21733@aiede.mtv.corp.google.com/


Jeff Hostetler (3):
  list-objects: add filter_blob to traverse_commit_list
  pack-objects: WIP add max-blob-size filtering
  pack-objects: add t5317 to test max-blob-size

 builtin/pack-objects.c                 | 76 +++++++++++++++++++++++++++++++++-
 list-objects.c                         | 39 +++++++++++++++--
 list-objects.h                         |  8 ++++
 t/t5317-pack-objects-blob-filtering.sh | 68 ++++++++++++++++++++++++++++++
 4 files changed, 186 insertions(+), 5 deletions(-)
 create mode 100644 t/t5317-pack-objects-blob-filtering.sh

-- 
2.9.3

