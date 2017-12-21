Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7007F1F424
	for <e@80x24.org>; Thu, 21 Dec 2017 19:09:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbdLUTJS (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 14:09:18 -0500
Received: from siwi.pair.com ([209.68.5.199]:12625 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752222AbdLUTJR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 14:09:17 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0D9BD844E3;
        Thu, 21 Dec 2017 14:09:17 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 97517844E1;
        Thu, 21 Dec 2017 14:09:16 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v2 0/5] Add --no-ahead-behind to status
Date:   Thu, 21 Dec 2017 19:09:04 +0000
Message-Id: <20171221190909.62995-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is version 2 of my patch series to avoid expensive
ahead/behind calculations in status.  This version addresses
Peff's comments on V1.

This version renames the command line parameter to have
positive sense "--ahead-behind" and avoids confusing double
negatives throughout.  It also changes the config setting
from "status." to "core." in anticipation of use by other
commands (like branch and checkout).

The output for porcelain status formats does change, but
ONLY if the "--no-ahead-behind" option is given on the
command line; porcelain formats DO NOT inherit the config
setting.  The intent here is that only scripts explicitly
requesting the new feature will see any format changes.

This idea was previously discussed in [1].  Working with the
enormous Windows repository, we found that 20+ seconds was being
spent in the ahead/behind computation when the current branch was
150K commits behind the upstream branch.  (Yes, this happens and
only took 3 weeks on the reporter's system.)


I've only modified "git status" in this patch series.  A similar
change could be added to "git branch -vv" and "git checkout" to
avoid delays there too.  I avoided doing it here to keep this
patch series focused.

[1] https://public-inbox.org/git/030bf57c-7a23-3391-4fc0-93efee791543@jeffhostetler.com/T/

Jeff Hostetler (5):
  core.aheadbehind: add new config setting
  stat_tracking_info: return +1 when branches are not equal
  status: add --[no-]ahead-behind to porcelain V2 output
  status: update short status to use --no-ahead-behind
  status: support --no-ahead-behind in long format

 Documentation/config.txt     |  8 ++++++
 Documentation/git-status.txt | 11 ++++++--
 builtin/checkout.c           |  2 +-
 builtin/commit.c             | 19 ++++++++++++++
 cache.h                      |  1 +
 config.c                     |  5 ++++
 environment.c                |  1 +
 ref-filter.c                 |  4 +--
 remote.c                     | 38 ++++++++++++++++++++--------
 remote.h                     | 10 ++++++--
 t/t6040-tracking-info.sh     | 42 +++++++++++++++++++++++++++++++
 t/t7064-wtstatus-pv2.sh      | 60 ++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 34 +++++++++++++++++++------
 wt-status.h                  |  2 ++
 14 files changed, 212 insertions(+), 25 deletions(-)

-- 
2.9.3

