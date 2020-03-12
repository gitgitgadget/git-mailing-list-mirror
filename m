Return-Path: <SRS0=YYoh=45=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDD4C10DCE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:26:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C35A206BE
	for <git@archiver.kernel.org>; Thu, 12 Mar 2020 21:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726633AbgCLV0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Mar 2020 17:26:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:38390 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726491AbgCLV0P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Mar 2020 17:26:15 -0400
Received: (qmail 14684 invoked by uid 109); 12 Mar 2020 21:26:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Mar 2020 21:26:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2391 invoked by uid 111); 12 Mar 2020 21:35:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Mar 2020 17:35:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Mar 2020 17:26:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, jonathantanmy@google.com, me@ttaylorr.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH] connected.c: reprepare packs for corner cases
Message-ID: <20200312212613.GB872402@coredump.intra.peff.net>
References: <pull.579.git.1584027403779.gitgitgadget@gmail.com>
 <xmqqzhcle23x.fsf@gitster.c.googlers.com>
 <20200312211638.GA872402@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200312211638.GA872402@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 12, 2020 at 05:16:38PM -0400, Jeff King wrote:

> There we see that same reprepare happen in 882839, which is the child
> fetch-pack. The parent fetch probably needs to reprepare itself after
> fetch-pack completes.

Actually, it's not fetch which is running fetch-pack, but rather the
remote helper itself. So I think the simplest thing is for the
remote-helper layer to do something like this:

diff --git a/transport-helper.c b/transport-helper.c
index 20a7185ec4..25957e9a05 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -14,6 +14,7 @@
 #include "refspec.h"
 #include "transport-internal.h"
 #include "protocol.h"
+#include "packfile.h"
 
 static int debug;
 
@@ -672,6 +673,7 @@ static int fetch(struct transport *transport,
 {
 	struct helper_data *data = transport->data;
 	int i, count;
+	int ret;
 
 	get_helper(transport);
 
@@ -710,13 +712,18 @@ static int fetch(struct transport *transport,
 	if (data->transport_options.negotiation_tips)
 		warning("Ignoring --negotiation-tip because the protocol does not support it.");
 
-	if (data->fetch)
-		return fetch_with_fetch(transport, nr_heads, to_fetch);
+	ret = data->fetch ? fetch_with_fetch(transport, nr_heads, to_fetch) :
+	      data->import ? fetch_with_import(transport, nr_heads, to_fetch) :
+	      -1;
 
-	if (data->import)
-		return fetch_with_import(transport, nr_heads, to_fetch);
+	/*
+	 * We may have just received a pack through the helper sub-process;
+	 * refresh the pack list.
+	 */
+	if (!ret)
+		reprepare_packed_git(the_repository);
 
-	return -1;
+	return ret;
 }
 
 static int push_update_ref_status(struct strbuf *buf,
