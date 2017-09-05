Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 936D8208E3
	for <e@80x24.org>; Tue,  5 Sep 2017 13:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751435AbdIENEW (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 09:04:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:57310 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751332AbdIENEW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 09:04:22 -0400
Received: (qmail 2079 invoked by uid 109); 5 Sep 2017 13:04:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 13:04:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12789 invoked by uid 111); 5 Sep 2017 13:04:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 05 Sep 2017 09:04:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 05 Sep 2017 09:04:20 -0400
Date:   Tue, 5 Sep 2017 09:04:20 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 05/10] config: plug user_config leak
Message-ID: <20170905130419.q27w6nblsryegldg@sigill.intra.peff.net>
References: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170905130149.agc3zp3s6i6e5aki@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We generate filenames for the user_config ("~/.gitconfig")
and the xdg config ("$XDG_CONFIG_HOME/git/config") and then
decide which to use by looking at the filesystem. But after
selecting one, the unused string is just leaked.

This is a tiny leak, but it creates noise in leak-checker
output.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/config.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index 70ff231e9c..52a4606243 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -518,10 +518,13 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 			die("$HOME not set");
 
 		if (access_or_warn(user_config, R_OK, 0) &&
-		    xdg_config && !access_or_warn(xdg_config, R_OK, 0))
+		    xdg_config && !access_or_warn(xdg_config, R_OK, 0)) {
 			given_config_source.file = xdg_config;
-		else
+			free(user_config);
+		} else {
 			given_config_source.file = user_config;
+			free(xdg_config);
+		}
 	}
 	else if (use_system_config)
 		given_config_source.file = git_etc_gitconfig();
-- 
2.14.1.721.gc5bc1565f1

