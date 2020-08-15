Return-Path: <SRS0=NddV=BZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB3ABC433E1
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 00:25:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C04BA2074D
	for <git@archiver.kernel.org>; Sat, 15 Aug 2020 00:25:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727938AbgHOAZb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Aug 2020 20:25:31 -0400
Received: from mga01.intel.com ([192.55.52.88]:29193 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726651AbgHOAZb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Aug 2020 20:25:31 -0400
IronPort-SDR: jdr67+5P6sxg1nqZsosSxD94GOsi3Gc9AZNVsUtZ+pCyP9iL7k0wGjszU/h4eObLDoydXuxMn4
 xAHV+lK/udDw==
X-IronPort-AV: E=McAfee;i="6000,8403,9713"; a="172554198"
X-IronPort-AV: E=Sophos;i="5.76,314,1592895600"; 
   d="scan'208";a="172554198"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2020 17:25:31 -0700
IronPort-SDR: 1SlnmSD6/SS22Xce1XkUHnZeIx4cfO1uPZ/sX4C4PPwbzvfpdLwxSvIfvvkbq92u655Gevu5tz
 5+L2D4lAzlhQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,314,1592895600"; 
   d="scan'208";a="325861565"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.33])
  by orsmga008.jf.intel.com with ESMTP; 14 Aug 2020 17:25:30 -0700
From:   Jacob Keller <jacob.e.keller@intel.com>
To:     git@vger.kernel.org, Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>
Subject: [RFC 2/3] refspec: make sure stack refspec_item variables are zeroed
Date:   Fri, 14 Aug 2020 17:25:08 -0700
Message-Id: <20200815002509.2467645-2-jacob.e.keller@intel.com>
X-Mailer: git-send-email 2.28.0.163.g6104cc2f0b60
In-Reply-To: <20200815002509.2467645-1-jacob.e.keller@intel.com>
References: <20200815002509.2467645-1-jacob.e.keller@intel.com>
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
2.28.0.163.g6104cc2f0b60

