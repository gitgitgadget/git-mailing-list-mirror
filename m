Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47B3F1F576
	for <e@80x24.org>; Mon, 26 Feb 2018 09:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752259AbeBZJEi (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 04:04:38 -0500
Received: from cloud.peff.net ([104.130.231.41]:36920 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752199AbeBZJEf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 04:04:35 -0500
Received: (qmail 32684 invoked by uid 109); 26 Feb 2018 09:04:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 26 Feb 2018 09:04:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10870 invoked by uid 111); 26 Feb 2018 09:05:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 26 Feb 2018 04:05:24 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 26 Feb 2018 04:04:33 -0500
Date:   Mon, 26 Feb 2018 04:04:33 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] strbuf_read_file(): preserve errno across close() call
Message-ID: <20180226090433.GB30343@sigill.intra.peff.net>
References: <6b58885c-b0f6-1687-3f2d-4594aacff9ac@web.de>
 <20180223064952.GB19791@sigill.intra.peff.net>
 <20180223070053.GC19791@sigill.intra.peff.net>
 <f134c6bf-c147-4201-1217-b59bfb9f2288@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f134c6bf-c147-4201-1217-b59bfb9f2288@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 10:00:24PM +0100, René Scharfe wrote:

> How about adding a stealthy close_no_errno(), or do something like the
> following to get shorter and more readable code?  (We could also keep
> a single close() call, but would then set errno even on success.)
> [...]
> @@ -391,7 +393,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
>  
>  		if (got < 0) {
>  			if (oldalloc == 0)
> -				strbuf_release(sb);
> +				IGNORE_ERROR(strbuf_release(sb));
>  			else
>  				strbuf_setlen(sb, oldlen);
>  			return -1;

I dunno, that may be crossing the line of "too magical".

I had envisioned something like:

diff --git a/strbuf.c b/strbuf.c
index 5f138ed3c8..0790dd7bcb 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -365,6 +365,14 @@ void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *src)
 	}
 }
 
+/* release, but preserve errno */
+static void strbuf_release_careful(struct strbuf *sb)
+{
+	int saved_errno = errno;
+	strbuf_release(sb);
+	errno = saved_errno;
+}
+
 size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
 {
 	size_t res;
@@ -375,7 +383,7 @@ size_t strbuf_fread(struct strbuf *sb, size_t size, FILE *f)
 	if (res > 0)
 		strbuf_setlen(sb, sb->len + res);
 	else if (oldalloc == 0)
-		strbuf_release(sb);
+		strbuf_release_careful(sb);
 	return res;
 }
 
@@ -391,7 +399,7 @@ ssize_t strbuf_read(struct strbuf *sb, int fd, size_t hint)
 
 		if (got < 0) {
 			if (oldalloc == 0)
-				strbuf_release(sb);
+				strbuf_release_careful(sb);
 			else
 				strbuf_setlen(sb, oldlen);
 			return -1;
@@ -416,7 +424,7 @@ ssize_t strbuf_read_once(struct strbuf *sb, int fd, size_t hint)
 	if (cnt > 0)
 		strbuf_setlen(sb, sb->len + cnt);
 	else if (oldalloc == 0)
-		strbuf_release(sb);
+		strbuf_release_careful(sb);
 	return cnt;
 }
 
@@ -482,7 +490,7 @@ int strbuf_getcwd(struct strbuf *sb)
 			break;
 	}
 	if (oldalloc == 0)
-		strbuf_release(sb);
+		strbuf_release_careful(sb);
 	else
 		strbuf_reset(sb);
 	return -1;


but that solution is definitely very specific to these cases. I also had
a feeling I should be able to shove the "oldalloc" logic into the
helper, too, but there are too many different behaviors in the "else"
block.

-Peff
