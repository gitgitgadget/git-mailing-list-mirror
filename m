Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEB46C5519F
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 00:29:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E9C423A6B
	for <git@archiver.kernel.org>; Sat, 21 Nov 2020 00:29:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgKUA3W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 19:29:22 -0500
Received: from cloud.peff.net ([104.130.231.41]:37266 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728720AbgKUA3W (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 19:29:22 -0500
Received: (qmail 7533 invoked by uid 109); 21 Nov 2020 00:29:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 21 Nov 2020 00:29:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12756 invoked by uid 111); 21 Nov 2020 00:29:21 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 20 Nov 2020 19:29:21 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 20 Nov 2020 19:29:21 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?5ZSQ5a6H5aWV?= <winglovet@gmail.com>, git@vger.kernel.org
Subject: Re: Bug report: orphaned pack-objects after killing upload-pack on
 [was: (no subject)]
Message-ID: <20201121002921.GC353076@coredump.intra.peff.net>
References: <CAFWsj_UwkQX9y0xPQJE3xguo0z3TMkvKAwei5iryCWXvVP8CjA@mail.gmail.com>
 <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <badf3777-3970-b714-3ad9-67d2f77f94a5@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 20, 2020 at 07:52:45PM +0100, René Scharfe wrote:

> Have you seen this working as you expect in an earlier version?
> 
> I suspect it's a matter of turning on some flags (patch below), but I
> have to admit I don't really know what I'm doing here -- and why this
> hasn't been done already.
> 
> René
> 
> ---
>  upload-pack.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/upload-pack.c b/upload-pack.c
> index 5dc8e1f844..e42dea26fa 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -321,6 +321,8 @@ static void create_pack_file(struct upload_pack_data *pack_data,
>  	pack_objects.in = -1;
>  	pack_objects.out = -1;
>  	pack_objects.err = -1;
> +	pack_objects.clean_on_exit = 1;
> +	pack_objects.wait_after_clean = 1;

Yeah, clean_on_exit seems quite reasonable to me. I suspect nobody ever
really noticed, because as soon as pack-objects starts to write out the
pack, it will get SIGPIPE or EPIPE and die. But there is no point in
letting it chug on expensive object enumeration or delta compression if
upload-pack has already exited.

I don't know that wait_after_clean is necessary. We don't need to wait
for pack-objects to fail.

On the flip side, one of the reasons I added clean_on_exit long ago was
for the similar issue on the push side, which is even worse. Here we
might just waste some CPU, but on the push side we connect pack-objects
directly to the remote socket, so it could actually complete the push
(from the server's perspective) after the local git-push has died. Or at
least I think that was possible at one point; it might not be the case
any more.

I wrote this patch ages ago, and it is still sitting close to the bottom
(if not the bottom) of my todo stack, waiting to be investigated. ;)

-- >8 --
Subject: [PATCH] send-pack: kill pack-objects helper on signal or exit

We spawn an external pack-objects process to actually send
objects to the remote side. If we are killed by a signal
during this process, the pack-objects will keep running and
complete the push, which may surprise the user. We should
take it down when we go down.

Signed-off-by: Jeff King <peff@peff.net>
---
 send-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/send-pack.c b/send-pack.c
index eb4a44270b..d2701bf35c 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -85,6 +85,7 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struc
 	po.in = -1;
 	po.out = args->stateless_rpc ? -1 : fd;
 	po.git_cmd = 1;
+	po.clean_on_exit = 1;
 	if (start_command(&po))
 		die_errno("git pack-objects failed");
 
-- 
2.29.2.730.g3e418f96ba

