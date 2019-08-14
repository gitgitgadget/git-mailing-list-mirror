Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16EAD1F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 15:59:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfHNP7z (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 11:59:55 -0400
Received: from cloud.peff.net ([104.130.231.41]:43364 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726126AbfHNP7y (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 11:59:54 -0400
Received: (qmail 17264 invoked by uid 109); 14 Aug 2019 15:59:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Aug 2019 15:59:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17420 invoked by uid 111); 14 Aug 2019 16:01:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 14 Aug 2019 12:01:03 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 14 Aug 2019 11:59:53 -0400
From:   Jeff King <peff@peff.net>
To:     "Paolo Pettinato (ppettina)" <ppettina@cisco.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: [PATCH] get_next_submodule(): format error string as an error
Message-ID: <20190814155953.GC12093@sigill.intra.peff.net>
References: <951a0ac4-592f-d71c-df6a-53a806249f7b@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <951a0ac4-592f-d71c-df6a-53a806249f7b@cisco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 14, 2019 at 09:57:50AM +0000, Paolo Pettinato (ppettina) wrote:

> Could not access submodule 'sm' # fails, plus no newline here :P!

This part seems easy enough to fix.

-- >8 --
Subject: get_next_submodule(): format error string as an error

The run_processes_parallel() interface passes its callback functions an
"err" strbuf in which they can accumulate errors. However, this differs
from our usual "err" strbufs in that the result is not simply passed to
error(), like:

  if (frob_repo(&err) < 0)
	error("frobnication failed: %s", err.buf);

Instead, we append the error buffer as-is to a buffer collecting the
sub-process stderr, adding neither a prefix nor a trailing newline. This
gives callbacks more flexibility (e.g., get_next_submodule() adds its
own "Fetching submodule foo" informational lines), but it means they're
also responsible for formatting any errors themselves.

We forgot to do so in the single error message in get_next_submodule(),
meaning that it was output without a trailing newline. While we're
fixing that, let's also give it the usual "error:" prefix and downcase
the start of the message. We can't use error() here, because it always
outputs directly to stderr.

Looking at other users of run_processes_parallel(), there are a few
similar messages in update_clone_task_finished(). But those sites do
correctly add a newline (they don't use an "error" prefix, but it
doesn't make as much sense there).

Signed-off-by: Jeff King <peff@peff.net>
---
 submodule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule.c b/submodule.c
index 0f199c5137..a5ba57ac36 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1478,7 +1478,7 @@ static int get_next_submodule(struct child_process *cp,
 			    !is_empty_dir(ce->name)) {
 				spf->result = 1;
 				strbuf_addf(err,
-					    _("Could not access submodule '%s'"),
+					    _("error: could not access submodule '%s'\n"),
 					    ce->name);
 			}
 		}
-- 
2.23.0.rc2.479.gbd16c8906f

