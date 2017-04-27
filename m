Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 11C40207EB
	for <e@80x24.org>; Thu, 27 Apr 2017 20:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1422977AbdD0U7y (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Apr 2017 16:59:54 -0400
Received: from [192.252.130.194] ([192.252.130.194]:15475 "EHLO
        cubert.xiplink.com" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S968935AbdD0U7a (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2017 16:59:30 -0400
Received: from xiplink.com (rincewind.xiplink.com [10.10.1.32])
        by cubert.xiplink.com (Postfix) with ESMTP id 2D4D3617C2;
        Thu, 27 Apr 2017 16:50:37 -0400 (EDT)
From:   Marc Branchaud <marcnarc@xiplink.com>
To:     git@vger.kernel.org
Cc:     Michael Haggerty <mhagger@alum.mit.edu>, Jeff King <peff@peff.net>
Subject: [PATCH 0/2] Make diff plumbing commands respect the indentHeuristic.
Date:   Thu, 27 Apr 2017 16:50:35 -0400
Message-Id: <20170427205037.1787-1-marcnarc@xiplink.com>
X-Mailer: git-send-email 2.13.0.rc1.15.g7dbea34e1.dirty
In-Reply-To: <19607a03-71e0-440b-7213-64d25f6fa8da@xiplink.com>
References: <19607a03-71e0-440b-7213-64d25f6fa8da@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

So here's my attempt at fixing this.

The thing I was missing is that init_revisions() calls diff_setup(), which
sets the xdl options.  It's therefore necessary to have the
diff_indent_heuristic flag set before calling init_revisions().

A naive way to get the indentHeuristic config option respected in the
diff-* plumbing commands is to make them use the git_diff_heuristic_config()
callback right at the start of their main cmd functions.

But I did not like that for two reasons:

* It would make these commands invoke git_config() twice.

* It doesn't avoid the problem if/when someone creates a new diff-something
  plumbing command, and forgets to set the diff_indent_heuristic flag before
  calling init_revisions().

So instead I chose to make the indentHeuristic option part of diff's basic
configuration, and in each of the diff plumbing commands I moved the call to
git_config() before the call to init_revisions().

This still doesn't really future-proof things for possible new diff plumbing
commands, because someone could still invoke init_revisions() before setting
up diff's basic configuration.  But I don't see an obvious way of ensuring
that the diff_indent_heuristic flag is respected regardless of when
diff_setup() is invoked.

		M.

Marc Branchaud (2):
  Make the indent heuristic part of diff's basic configuration.
  Have the diff-* builtins configure diff before initializing revisions.

 builtin/diff-files.c | 2 +-
 builtin/diff-index.c | 2 +-
 builtin/diff-tree.c  | 2 +-
 diff.c               | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)
