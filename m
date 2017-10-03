Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31F1D2036B
	for <e@80x24.org>; Tue,  3 Oct 2017 23:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751238AbdJCXan (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 19:30:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:59750 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751188AbdJCXan (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 19:30:43 -0400
Received: (qmail 26648 invoked by uid 109); 3 Oct 2017 23:30:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 23:30:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12990 invoked by uid 111); 3 Oct 2017 23:30:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Tue, 03 Oct 2017 19:30:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 Oct 2017 19:30:40 -0400
Date:   Tue, 3 Oct 2017 19:30:40 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] path.c: fix uninitialized memory access
Message-ID: <20171003233040.2ws6kny3e4kypfub@sigill.intra.peff.net>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003195713.13395-2-t.gummerer@gmail.com>
 <20171003224501.GD19555@aiede.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171003224501.GD19555@aiede.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 03, 2017 at 03:45:01PM -0700, Jonathan Nieder wrote:

> When I first read the above, I thought it was going to be about a
> NUL-terminated string that was missing a NUL.  But in fact, the issue
> is that strlen(path) can be < 2.
> 
> In other words, an alternative fix would be
> 
> 	if (*path == '.' && path[1] == '/') {
> 		...
> 	}
> 
> which would not require passing in 'len' or switching to index-based
> arithmetic.  I think I prefer it.  What do you think?

Yes, I think that approach is much nicer. I think you could even use
skip_prefix. Unfortunately you have to play a few games with const-ness,
but I think the resulting signature for cleanup_path() is an
improvement:

diff --git a/path.c b/path.c
index 00ec04e7a5..2e09a7bce0 100644
--- a/path.c
+++ b/path.c
@@ -34,11 +34,10 @@ static struct strbuf *get_pathname(void)
 	return sb;
 }
 
-static char *cleanup_path(char *path)
+static const char *cleanup_path(const char *path)
 {
 	/* Clean it up */
-	if (!memcmp(path, "./", 2)) {
-		path += 2;
+	if (skip_prefix(path, "./", &path)) {
 		while (*path == '/')
 			path++;
 	}
@@ -47,7 +46,7 @@ static char *cleanup_path(char *path)
 
 static void strbuf_cleanup_path(struct strbuf *sb)
 {
-	char *path = cleanup_path(sb->buf);
+	const char *path = cleanup_path(sb->buf);
 	if (path > sb->buf)
 		strbuf_remove(sb, 0, path - sb->buf);
 }
@@ -64,7 +63,7 @@ char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 		strlcpy(buf, bad_path, n);
 		return buf;
 	}
-	return cleanup_path(buf);
+	return (char *)cleanup_path(buf);
 }
 
 static int dir_prefix(const char *buf, const char *dir)
