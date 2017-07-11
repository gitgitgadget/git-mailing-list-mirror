Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 24B602035A
	for <e@80x24.org>; Tue, 11 Jul 2017 17:53:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756007AbdGKRxp (ORCPT <rfc822;e@80x24.org>);
        Tue, 11 Jul 2017 13:53:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:37286 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755938AbdGKRxo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jul 2017 13:53:44 -0400
Received: (qmail 22861 invoked by uid 109); 11 Jul 2017 17:53:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 17:53:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18331 invoked by uid 111); 11 Jul 2017 17:53:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 11 Jul 2017 13:53:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Jul 2017 13:53:42 -0400
Date:   Tue, 11 Jul 2017 13:53:42 -0400
From:   Jeff King <peff@peff.net>
To:     Peter Krefting <peter@softwolves.pp.se>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git config --help not functional on bad config
Message-ID: <20170711175342.mllx7efdsqlzv5lo@sigill.intra.peff.net>
References: <alpine.DEB.2.00.1707111541150.18163@ds9.cixit.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1707111541150.18163@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 11, 2017 at 03:49:21PM +0100, Peter Krefting wrote:

> That's fine. However, when trying to look for help, it is not that useful:
> 
>   $ git config --help
>   error: malformed value for branch.autosetuprebase
>   fatal: bad config variable 'branch.autosetuprebase' in file '.git/config' at line 24
> 
> Perhaps it should allow "--help" to go through even if the configuration is
> bad?

Yes, I agree the current behavior is poor. What's happening under the
hood is that "--help" for any command runs "git help config", which in
turn looks at the config to pick up things like help.format.

But it also loads git_default_config(), which I suspect isn't actually
useful. It goes all the way back to 70087cdbd (git-help: add
"help.format" config variable., 2007-12-15), and it looks like it was
probably added just to match other config callbacks.

So I think we could probably just do this:

diff --git a/builtin/help.c b/builtin/help.c
index 334a8494a..c42dfc9e9 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -273,7 +273,7 @@ static int git_help_config(const char *var, const char *value, void *cb)
 	if (starts_with(var, "man."))
 		return add_man_viewer_info(var, value);
 
-	return git_default_config(var, value, cb);
+	return 0;
 }
 
 static struct cmdnames main_cmds, other_cmds;

which makes your case work.

-Peff
