Return-Path: <SRS0=jbtA=B7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BB2C433E1
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D833207CD
	for <git@archiver.kernel.org>; Fri, 21 Aug 2020 21:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgHUVsn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Aug 2020 17:48:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:19358 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726187AbgHUVsl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Aug 2020 17:48:41 -0400
IronPort-SDR: yPHBBXXDr1Wku5PmBcR9XYa29m4eUuvjfYsdauwEK5gk191Hhb/w6SjBvLb6RZJCX1hgxt0ZZM
 dMlF1RYu8ZxA==
X-IronPort-AV: E=McAfee;i="6000,8403,9720"; a="135171196"
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="135171196"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 14:48:39 -0700
IronPort-SDR: HDaViU7urkR9ROQmDmoNc7+TsXDqBKwtDFCpqWV6ZV9f9XHc1VqfPjYsphO2vAmqz8VfHej9LR
 u4gFG+IWsSyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,338,1592895600"; 
   d="scan'208";a="498106701"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by fmsmga006.fm.intel.com with ESMTP; 21 Aug 2020 14:48:39 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [PATCH 2/2] refspec: make sure stack refspec_item variables are zeroed
Date:   Fri, 21 Aug 2020 14:48:20 -0700
Message-Id: <20200821214820.757222-3-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.28.0.218.ge27853923b9d.dirty
In-Reply-To: <20200821214820.757222-1-jacob.e.keller@intel.com>
References: <20200821214820.757222-1-jacob.e.keller@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jacob Keller <jacob.keller@gmail.com>

A couple of functions that used struct refspec_item did not zero out the
structure memory. This can result in unexpected behavior, especially if
additional parameters are ever added to refspec_item in the future. Use
memset to ensure that unset structure members are zero.

It may make sense to convert most of these uses of struct refspec_item
to use either struct initializers or refspec_item_init_or_die. However,
other similar code uses memset. Converting all of these uses has been
left as a future exercise.

Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
---
 builtin/remote.c | 1 +
 transport.c      | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index c8240e9fcd58..542f56e3878b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -478,6 +478,7 @@ static int get_head_names(const struct ref *remote_refs, struct ref_states *stat
 	struct ref *fetch_map = NULL, **fetch_map_tail = &fetch_map;
 	struct refspec_item refspec;
 
+	memset(&refspec, 0, sizeof(refspec));
 	refspec.force = 0;
 	refspec.pattern = 1;
 	refspec.src = refspec.dst = "refs/heads/*";
diff --git a/transport.c b/transport.c
index 2d4fd851dc0f..419be0b6ea4b 100644
--- a/transport.c
+++ b/transport.c
@@ -443,6 +443,7 @@ void transport_update_tracking_ref(struct remote *remote, struct ref *ref, int v
 	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
 		return;
 
+	memset(&rs, 0, sizeof(rs));
 	rs.src = ref->name;
 	rs.dst = NULL;
 
-- 
2.28.0.218.ge27853923b9d.dirty

