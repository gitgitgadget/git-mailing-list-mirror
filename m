Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957B6C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:22:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B9682255F
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 18:22:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731400AbgLOSWI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 13:22:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:33384 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731155AbgLOSWB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 13:22:01 -0500
Received: (qmail 17107 invoked by uid 109); 15 Dec 2020 18:21:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 15 Dec 2020 18:21:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17165 invoked by uid 111); 15 Dec 2020 18:21:18 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 15 Dec 2020 13:21:18 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 15 Dec 2020 13:21:18 -0500
From:   Jeff King <peff@peff.net>
To:     "Daniel C. Klauer" <daniel.c.klauer@web.de>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>, git@vger.kernel.org
Subject: Re: bug report: "git pack-redundant --all" crash in minimize()
Message-ID: <X9j+nuzjiYyw/vQx@coredump.intra.peff.net>
References: <dc410ef1-fc05-162e-ed4e-c843e0bc285d@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc410ef1-fc05-162e-ed4e-c843e0bc285d@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 15, 2020 at 06:34:53PM +0100, Daniel C. Klauer wrote:

> I'm getting the following crash from "git pack-redundant --all" (output
> from valgrind):
> 
> ==14070== Invalid read of size 8
> ==14070==    at 0x18F165: minimize (pack-redundant.c:399)
> ==14070==    by 0x18F165: cmd_pack_redundant (pack-redundant.c:622)
> ==14070==    by 0x1242D3: run_builtin (git.c:444)
> ==14070==    by 0x1242D3: handle_builtin (git.c:674)
> ==14070==    by 0x125393: run_argv (git.c:741)
> ==14070==    by 0x125393: cmd_main (git.c:872)
> ==14070==    by 0x123E7D: main (common-main.c:52)
> ==14070==  Address 0x10 is not stack'd, malloc'd or (recently) free'd
> 
> Commands to reproduce:
> 
> mkdir new
> cd new
> git init
> touch foo.txt
> git add foo.txt
> git commit -m "first commit"
> git gc
> git pack-redundant --all

Thanks for an easy reproduction. This bisects to 3011177640
(pack-redundant: delay creation of unique_objects, 2019-02-02).

I suspect the fix is just:

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index 3e70f2a4c1..68afcfeb7b 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -396,7 +396,7 @@ static void minimize(struct pack_list **min)
 
 	pl = local_packs;
 	while (pl) {
-		if (pl->unique_objects->size)
+		if (pl->unique_objects && pl->unique_objects->size)
 			pack_list_insert(&unique, pl);
 		else
 			pack_list_insert(&non_unique, pl);

but I didn't look closely (author cc'd).

> The reason this showed up is that Yocto's build tool, bitbake, sometimes
> invokes this git command on some of the repositories it downloaded. This
> issue was apparently also reported here:
> https://bugzilla.redhat.com/show_bug.cgi?id=1803506

We had a discussion not too long ago[1] about whether we should
deprecate and remove pack-redundant, as it's not generally useful. I'm
curious if you have any more context on why it's used in that tool.

-Peff

[1] https://lore.kernel.org/git/20200825172214.GC1414394@coredump.intra.peff.net/
