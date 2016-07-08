Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C6202023C
	for <e@80x24.org>; Fri,  8 Jul 2016 09:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932373AbcGHJns (ORCPT <rfc822;e@80x24.org>);
	Fri, 8 Jul 2016 05:43:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:41918 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754426AbcGHJhh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Jul 2016 05:37:37 -0400
Received: (qmail 6263 invoked by uid 102); 8 Jul 2016 09:37:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:37:38 -0400
Received: (qmail 12231 invoked by uid 107); 8 Jul 2016 09:37:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 08 Jul 2016 05:37:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Jul 2016 05:37:33 -0400
Date:	Fri, 8 Jul 2016 05:37:33 -0400
From:	Jeff King <peff@peff.net>
To:	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:	Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] notes-merge: use O_EXCL to avoid overwriting existing
 files
Message-ID: <20160708093733.GA20528@sigill.intra.peff.net>
References: <577EB6BE.6090504@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <577EB6BE.6090504@web.de>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 07, 2016 at 10:08:30PM +0200, René Scharfe wrote:

> diff --git a/notes-merge.c b/notes-merge.c
> index b7814c9..2b29fc4 100644
> --- a/notes-merge.c
> +++ b/notes-merge.c
> @@ -298,12 +298,8 @@ static void write_buf_to_worktree(const unsigned char *obj,
>  	char *path = git_pathdup(NOTES_MERGE_WORKTREE "/%s", sha1_to_hex(obj));
>  	if (safe_create_leading_directories_const(path))
>  		die_errno("unable to create directory for '%s'", path);
> -	if (file_exists(path))
> -		die("found existing file at '%s'", path);
>  
> -	fd = open(path, O_WRONLY | O_TRUNC | O_CREAT, 0666);
> -	if (fd < 0)
> -		die_errno("failed to open '%s'", path);
> +	fd = xopen(path, O_WRONLY | O_EXCL | O_CREAT, 0666);

While working on write_file_buf() elsewhere, I wondered if this was a
good candidate for conversion. But it's not because of the O_EXCL.

I was tempted by something like:

  write_file_buf(path, O_EXCL, buf, len);

but I think that just makes the interface more cluttered for the other
callers. If you are doing something clever with O_EXCL, you probably
should just do it by hand.

However, we can make the loop less painful, as below (on top of your
patch).

-- >8 --
Subject: [PATCH] notes-merge: use write_or_die()

This output loop is overkill. For one thing, we do not need
to loop on write_in_full(); it's entire purpose is to avoid
looping, and it even includes the "disk full?" check itself.

Secondly, the check for EPIPE is pointless. We know this is
an on-disk file that we just opened, so short of somebody
sneaking a FIFO into our notes-merge working tree, it will
not be a pipe. And even if it is, we would generally die of
SIGPIPE before hitting this code. And even if we somehow
ignored SIGPIPE, dying (rather than silently ignoring the
error) seems like the only sensible action anyway.

So what we're left with is calling write_in_full() and dying
if it fails. And that's exactly what write_or_die() does.

Signed-off-by: Jeff King <peff@peff.net>
---
 notes-merge.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/notes-merge.c b/notes-merge.c
index 2b29fc4..a659a62 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -300,21 +300,7 @@ static void write_buf_to_worktree(const unsigned char *obj,
 		die_errno("unable to create directory for '%s'", path);
 
 	fd = xopen(path, O_WRONLY | O_EXCL | O_CREAT, 0666);
-
-	while (size > 0) {
-		long ret = write_in_full(fd, buf, size);
-		if (ret < 0) {
-			/* Ignore epipe */
-			if (errno == EPIPE)
-				break;
-			die_errno("notes-merge");
-		} else if (!ret) {
-			die("notes-merge: disk full?");
-		}
-		size -= ret;
-		buf += ret;
-	}
-
+	write_or_die(fd, buf, size);
 	close(fd);
 	free(path);
 }
-- 
2.9.0.393.g704e522

