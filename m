Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9A9C2036B
	for <e@80x24.org>; Wed,  4 Oct 2017 05:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751342AbdJDFVy (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Oct 2017 01:21:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:60024 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750909AbdJDFVy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Oct 2017 01:21:54 -0400
Received: (qmail 9117 invoked by uid 109); 4 Oct 2017 05:21:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 05:21:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14918 invoked by uid 111); 4 Oct 2017 05:21:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Wed, 04 Oct 2017 01:21:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 Oct 2017 01:21:52 -0400
Date:   Wed, 4 Oct 2017 01:21:52 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/3] path.c: fix uninitialized memory access
Message-ID: <20171004052151.4ntqmqe7wdbkbvx7@sigill.intra.peff.net>
References: <20171003195713.13395-1-t.gummerer@gmail.com>
 <20171003195713.13395-2-t.gummerer@gmail.com>
 <20171003224501.GD19555@aiede.mtv.corp.google.com>
 <20171003233040.2ws6kny3e4kypfub@sigill.intra.peff.net>
 <20171003233706.GH19555@aiede.mtv.corp.google.com>
 <xmqqfuazecym.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfuazecym.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 04, 2017 at 01:47:29PM +0900, Junio C Hamano wrote:

> Jonathan Nieder <jrnieder@gmail.com> writes:
> 
> > Jeff King wrote:
> >> On Tue, Oct 03, 2017 at 03:45:01PM -0700, Jonathan Nieder wrote:
> >
> >>> In other words, an alternative fix would be
> >>> 
> >>> 	if (*path == '.' && path[1] == '/') {
> >>> 		...
> >>> 	}
> >>> 
> >>> which would not require passing in 'len' or switching to index-based
> >>> arithmetic.  I think I prefer it.  What do you think?
> >>
> >> Yes, I think that approach is much nicer. I think you could even use
> >> skip_prefix. Unfortunately you have to play a few games with const-ness,
> >> but I think the resulting signature for cleanup_path() is an
> >> improvement:
> 
> To tie the loose end, here is what I'll queue.

Thank you, I was planning to get to this later tonight, but now I don't
have to. :)

FWIW, I wondered if we could get rid of the extra cast by switching
cleanup_path() to return an offset rather than a string (which also
makes its interface more foolproof, since it's clear that the return
value is a subset of the original string).

But it ends up being a bit clunky I think (patch below for reference).

I guess it's possible that `cleanup_path` could learn to do other
cleanup, too (e.g., to clean up doubled slashes in the middle of the
path), in which case it really would want a non-const buffer. But since
it has remained unchanged since 26c8a533af (Add "mkpath()" helper
function, 2005-07-08), I'm happy to assume it will remain so for another
12 years.

All of which is to say:

> -- >8 --
> From: Jeff King <peff@peff.net>
> Date: Tue, 3 Oct 2017 19:30:40 -0400
> Subject: [PATCH] path.c: fix uninitialized memory access

Looks good to me.

-Peff

-- >8 --
diff --git a/path.c b/path.c
index 5aa9244eb2..eaeb9d9a17 100644
--- a/path.c
+++ b/path.c
@@ -34,22 +34,24 @@ static struct strbuf *get_pathname(void)
 	return sb;
 }
 
-static char *cleanup_path(char *path)
+static size_t cleanup_path(const char *path)
 {
-	/* Clean it up */
-	if (!memcmp(path, "./", 2)) {
-		path += 2;
-		while (*path == '/')
-			path++;
-	}
-	return path;
+	const char *clean;
+
+	if (!skip_prefix(path, "./", &clean))
+		return 0;
+
+	while (*clean == '/')
+		clean++;
+
+	return clean - path;
 }
 
 static void strbuf_cleanup_path(struct strbuf *sb)
 {
-	char *path = cleanup_path(sb->buf);
-	if (path > sb->buf)
-		strbuf_remove(sb, 0, path - sb->buf);
+	size_t s = cleanup_path(sb->buf);
+	if (s)
+		strbuf_remove(sb, 0, s);
 }
 
 char *mksnpath(char *buf, size_t n, const char *fmt, ...)
@@ -64,7 +66,7 @@ char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 		strlcpy(buf, bad_path, n);
 		return buf;
 	}
-	return cleanup_path(buf);
+	return buf + cleanup_path(buf);
 }
 
 static int dir_prefix(const char *buf, const char *dir)
