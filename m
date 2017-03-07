Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA5A51FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 13:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755113AbdCGNmr (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 08:42:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:39709 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751579AbdCGNmm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 08:42:42 -0500
Received: (qmail 19738 invoked by uid 109); 7 Mar 2017 13:35:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 13:35:36 +0000
Received: (qmail 25607 invoked by uid 111); 7 Mar 2017 13:35:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Mar 2017 08:35:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Mar 2017 08:35:34 -0500
Date:   Tue, 7 Mar 2017 08:35:34 -0500
From:   Jeff King <peff@peff.net>
To:     Horst Schirmeier <horst@schirmeier.com>
Cc:     git@vger.kernel.org
Subject: [PATCH 1/6] receive-pack: fix deadlock when we cannot create tmpdir
Message-ID: <20170307133534.bgar57ojq52snns3@sigill.intra.peff.net>
References: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170307133437.qee2jtynbiwf6uzr@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The err_fd descriptor passed to the unpack() function is
intended to be handed off to the child index-pack, and our
async muxer will read until it gets EOF. However, if we
encounter an error before handing off the descriptor, we
must manually close(err_fd). Otherwise we will be waiting
for our muxer to finish, while the muxer is waiting for EOF
on err_fd.

We fixed an identical deadlock already in 49ecfa13f
(receive-pack: close sideband fd on early pack errors,
2013-04-19). But since then, the function grew a new
early-return in 722ff7f87 (receive-pack: quarantine objects
until pre-receive accepts, 2016-10-03), when we fail to
create a temporary directory. This return needs the same
treatment.

Reported-by: Horst Schirmeier <horst@schirmeier.com>
Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/receive-pack.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 9ed8fbbfa..f2c6953a3 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1667,8 +1667,11 @@ static const char *unpack(int err_fd, struct shallow_info *si)
 	}
 
 	tmp_objdir = tmp_objdir_create();
-	if (!tmp_objdir)
+	if (!tmp_objdir) {
+		if (err_fd > 0)
+			close(err_fd);
 		return "unable to create temporary object directory";
+	}
 	child.env = tmp_objdir_env(tmp_objdir);
 
 	/*
-- 
2.12.0.429.gde83c8049

