Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AAE01F406
	for <e@80x24.org>; Tue,  9 Jan 2018 18:50:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934939AbeAISua (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 13:50:30 -0500
Received: from siwi.pair.com ([209.68.5.199]:52943 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932279AbeAISu3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 13:50:29 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EB2BB844E7;
        Tue,  9 Jan 2018 13:50:28 -0500 (EST)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 83490844DA;
        Tue,  9 Jan 2018 13:50:28 -0500 (EST)
From:   Jeff Hostetler <git@jeffhostetler.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v5 0/4] Add --no-ahead-behind to status
Date:   Tue,  9 Jan 2018 18:50:14 +0000
Message-Id: <20180109185018.69164-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

This is version 5 of my patch series to avoid expensive ahead/behind
calculations in status.  This version completely removes the config
setting and is just the --[no-]ahead-behind command line argument.

Internally (inside MSFT) we have had further discussions in this
area and identified 2 somewhat independent needs:

[1] The first is to just be able to turn off the a/b calculation when
    the invoker does not need the result at all.

[2] The second is to greatly speed up or limit the a/b calculation on
    extremely large repositories.

    In earlier versions of this patch series, there were several
    discussions of a limited mode that would look for no more than n
    commits or milliseconds.  Also discussed were some problems that
    such limiting will have and it was decided to be not worth the effort.

    We have been discussing some ways to speed up the calculation on the
    client and have tentatively scheduled this shortly.  Hopefully, this
    will eliminate the performance problems and reduce the likelyhood
    that anyone would need to set a config setting to change the default
    behavior (in either porcelain or non-porcelain) formats.

So with that in mind, this version elimates the config setting so that
we have don't to carry forward a soon-to-be-obsolete setting.

All that remains in this version is the command line argument to turn
on/off the a/b calculation.

Jeff Hostetler (4):
  stat_tracking_info: return +1 when branches not equal
  status: add --[no-]ahead-behind to status and commit for V2 format.
  status: update short status to respect --no-ahead-behind
  status: support --no-ahead-behind in long format

 Documentation/git-status.txt |  5 ++++
 builtin/checkout.c           |  2 +-
 builtin/commit.c             |  7 +++++
 ref-filter.c                 |  8 +++---
 remote.c                     | 50 +++++++++++++++++++++++------------
 remote.h                     | 12 +++++++--
 t/t6040-tracking-info.sh     | 42 ++++++++++++++++++++++++++++++
 t/t7064-wtstatus-pv2.sh      | 62 ++++++++++++++++++++++++++++++++++++++++++++
 wt-status.c                  | 41 ++++++++++++++++++++---------
 wt-status.h                  |  2 ++
 10 files changed, 196 insertions(+), 35 deletions(-)

-- 
2.9.3

