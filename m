Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 506A120248
	for <e@80x24.org>; Thu, 28 Feb 2019 23:05:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729874AbfB1XFJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 18:05:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:33628 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729750AbfB1XFI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 18:05:08 -0500
Received: (qmail 32219 invoked by uid 109); 28 Feb 2019 23:05:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 28 Feb 2019 23:05:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24598 invoked by uid 111); 28 Feb 2019 23:05:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 28 Feb 2019 18:05:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 28 Feb 2019 18:05:06 -0500
Date:   Thu, 28 Feb 2019 18:05:06 -0500
From:   Jeff King <peff@peff.net>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [BUG] completion.commands does not remove multiple commands
Message-ID: <20190228230506.GA20625@sigill.intra.peff.net>
References: <20190228223123.GZ16125@zaya.teonanacatl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190228223123.GZ16125@zaya.teonanacatl.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 28, 2019 at 05:31:23PM -0500, Todd Zullinger wrote:

> Hi,
> 
> I was playing with the completion.commands config added in
> 6532f3740b ("completion: allow to customize the completable
> command list", 2018-05-20) and noticed an issue removing
> multiple commands.
> 
> I wanted to remove completion for cherry and mergetool, so I
> added them both to the config:
> 
>     git config completion.commands "-cherry -mergetool"
> 
> But git still completes cherry in this case, only removing
> mergetool.  Swapping the items in the config yields the
> opposite result (cherry is removed and mergetool is not).

I can reproduce your problem, though the test you included passes for me
even with the current tip of master. I suspect this is the problem:

diff --git a/help.c b/help.c
index 520c9080e8..026f881715 100644
--- a/help.c
+++ b/help.c
@@ -393,8 +393,8 @@ void list_cmds_by_config(struct string_list *list)
 		const char *p = strchrnul(cmd_list, ' ');
 
 		strbuf_add(&sb, cmd_list, p - cmd_list);
-		if (*cmd_list == '-')
-			string_list_remove(list, cmd_list + 1, 0);
+		if (sb.buf[0] == '-')
+			string_list_remove(list, sb.buf + 1, 0);
 		else
 			string_list_insert(list, sb.buf);
 		strbuf_release(&sb);

though I can't help but wonder if the whole thing would be simpler using
string_list_split().

-Peff
