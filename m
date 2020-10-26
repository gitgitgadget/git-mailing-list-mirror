Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCDBDC4363A
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:36:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972152085B
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:36:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1785716AbgJZTgr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:36:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:37658 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1785697AbgJZTgq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:36:46 -0400
Received: (qmail 9237 invoked by uid 109); 26 Oct 2020 19:36:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 26 Oct 2020 19:36:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10328 invoked by uid 111); 26 Oct 2020 19:36:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 26 Oct 2020 15:36:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 26 Oct 2020 15:36:44 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Subject: Re: git-receive-pack doesn't seem to respect gpg.program config
Message-ID: <20201026193644.GA16150@coredump.intra.peff.net>
References: <20201026181625.c6f5y44ydndkniul@chatter.i7.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201026181625.c6f5y44ydndkniul@chatter.i7.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 26, 2020 at 02:16:25PM -0400, Konstantin Ryabitsev wrote:

> While trying to configure signed pushes, I found out that no mater where 
> I set gpg.program=/opt/gnupg22/bin/gpg (in-repo config, ~/.gitconfig, 
> /etc/gitconfig), git-receive-pack didn't appear to be paying any 
> attention to that setting and always used the "gpg" command in the PATH.
> 
> Not sure if that's intentional or not, but seems like it should be 
> paying attention at least to /etc/gitconfig.

I suspect it just needs:

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index bb9909c52e..2a41b24e5a 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -248,6 +248,10 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	status = git_gpg_config(var, value, cb);
+	if (status)
+		return status;
+
 	return git_default_config(var, value, cb);
 }
 

but didn't test or look further than that.

-Peff
