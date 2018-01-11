Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A73D1F406
	for <e@80x24.org>; Thu, 11 Jan 2018 06:31:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754303AbeAKGbO (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jan 2018 01:31:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:40846 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932145AbeAKGbM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jan 2018 01:31:12 -0500
Received: (qmail 17048 invoked by uid 109); 11 Jan 2018 06:31:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Jan 2018 06:31:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21271 invoked by uid 111); 11 Jan 2018 06:31:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 11 Jan 2018 01:31:45 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 Jan 2018 01:31:10 -0500
Date:   Thu, 11 Jan 2018 01:31:10 -0500
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'git mailing list' <git@vger.kernel.org>
Subject: Re: [PATCH] Replaced read with xread in transport-helper.c to fix
 SSIZE_MAX overun in t5509
Message-ID: <20180111063110.GB31213@sigill.intra.peff.net>
References: <010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <010f01d38a9e$a5c4f290$f14ed7b0$@nexbridge.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 11, 2018 at 12:40:05AM -0500, Randall S. Becker wrote:

> diff --git a/transport-helper.c b/transport-helper.c
> index 3640804..68a4e30 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -1202,7 +1202,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
>                 return 0;       /* No space for more. */
> 
>         transfer_debug("%s is readable", t->src_name);
> -       bytes = read(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
> +       bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
>         if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
>                 errno != EINTR) {
>                 error_errno("read(%s) failed", t->src_name);

After this patch, I don't think we can ever see any of those errno
values again, as xread() will automatically retry in such a case.

I think that's OK. In the code before your patch, udt_do_read() would
return 0 in such a case, giving the caller the opportunity to do
something besides simply retry the read. But the only caller is
udt_copy_task_routine(), which would just loop anyway.  It may be worth
mentioning that in the commit message.

So your patch is OK.  But we should probably clean up on top, like the
patch below (on top of yours; though note your patch was whitespace
corrupted; the tabs were converted to spaces).

-- >8 --
Subject: [PATCH] transport-helper: drop read/write errno checks

Since we use xread() and xwrite() here, EINTR, EAGAIN, and
EWOULDBLOCK retries are already handled for us, and we will
never see these errno values ourselves. We can drop these
conditions entirely, making the code easier to follow.

Signed-off-by: Jeff King <peff@peff.net>
---
 transport-helper.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index d48be722a5..fc49567ac4 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1208,8 +1208,7 @@ static int udt_do_read(struct unidirectional_transfer *t)
 
 	transfer_debug("%s is readable", t->src_name);
 	bytes = xread(t->src, t->buf + t->bufuse, BUFFERSIZE - t->bufuse);
-	if (bytes < 0 && errno != EWOULDBLOCK && errno != EAGAIN &&
-		errno != EINTR) {
+	if (bytes < 0) {
 		error_errno("read(%s) failed", t->src_name);
 		return -1;
 	} else if (bytes == 0) {
@@ -1236,7 +1235,7 @@ static int udt_do_write(struct unidirectional_transfer *t)
 
 	transfer_debug("%s is writable", t->dest_name);
 	bytes = xwrite(t->dest, t->buf, t->bufuse);
-	if (bytes < 0 && errno != EWOULDBLOCK) {
+	if (bytes < 0) {
 		error_errno("write(%s) failed", t->dest_name);
 		return -1;
 	} else if (bytes > 0) {
-- 
2.16.0.rc1.446.g4cb7d89c69

