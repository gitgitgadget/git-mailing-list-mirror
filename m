Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1FF0C55186
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 10:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBD7D20781
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 10:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726853AbgDVKao (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 06:30:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:35646 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730840AbgDVKaM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 06:30:12 -0400
Received: (qmail 5682 invoked by uid 109); 22 Apr 2020 10:30:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Apr 2020 10:30:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28978 invoked by uid 111); 22 Apr 2020 10:41:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2020 06:41:18 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Apr 2020 06:30:11 -0400
From:   Jeff King <peff@peff.net>
To:     Lubomir Rintel <lkundrak@v3.sk>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: Re: Git 2.26 fetches many times more objects than it should, wasting
 gigabytes
Message-ID: <20200422103011.GA545254@coredump.intra.peff.net>
References: <20200422084254.GA27502@furthur.local>
 <20200422095702.GA475060@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422095702.GA475060@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 05:57:02AM -0400, Jeff King wrote:

> I'm attaching for-each-ref output before and after the xo fetch. That
> should be sufficient to recreate the situation synthetically even once
> these repos have moved on.
> 
> I have GIT_TRACE_PACKET output showing the whole negotiation, but it's
> pretty hard to look at. I _think_ a lot more is said in the v0
> conversation, but it's difficult to sort out because there's a lot of
> extra packet framing as we shuttle bits back and forth between
> remote-curl and fetch-pack.

Here's what I did manage to pull out if it. In both versions we send a
bunch of "have" lines, and get a bunch of NAKs back. Which makes sense.
We have a bunch of refs that the other side doesn't know about.

In the v0 http session, we finally get an ACK on
8f3d9f354286745c751374f5f1fcafee6b3f3136, which is Linus's 5.7-rc1. We
send that commit as a "have" in the 9th batch.

In the v2 session, we never get an ACK at all (which unsurprisingly
leads to the other side sending the full history). But that commit id is
nowhere to be found in the trace! We appear to give up after 5 rounds.

So it really just seems like v2 does not try hard enough. I think the
culprit is the MAX_IN_VAIN setting. If I do this:

diff --git a/fetch-pack.c b/fetch-pack.c
index 1734a573b0..016a413d49 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -46,7 +46,7 @@ static struct strbuf fsck_msg_types = STRBUF_INIT;
  * After sending this many "have"s if we do not get any new ACK , we
  * give up traversing our history.
  */
-#define MAX_IN_VAIN 256
+#define MAX_IN_VAIN 20000
 
 static int multi_ack, use_sideband;
 /* Allow specifying sha1 if it is a ref tip. */

then I get that same 48k objects, 23MB fetch that v0 does.

-Peff
