Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AACD1F45F
	for <e@80x24.org>; Tue,  7 May 2019 21:47:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbfEGVrB (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 17:47:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:50952 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726650AbfEGVrA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 17:47:00 -0400
Received: (qmail 14318 invoked by uid 109); 7 May 2019 21:47:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 07 May 2019 21:47:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17088 invoked by uid 111); 7 May 2019 21:47:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 07 May 2019 17:47:37 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 May 2019 17:46:58 -0400
Date:   Tue, 7 May 2019 17:46:58 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Mike Hommey <mh@glandium.org>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH] Make fread/fwrite-like functions in http.c more like
 fread/fwrite.
Message-ID: <20190507214658.GC19955@sigill.intra.peff.net>
References: <20190501085635.7125-1-mh@glandium.org>
 <20190507145832.GN14763@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190507145832.GN14763@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 07, 2019 at 04:58:32PM +0200, SZEDER Gábor wrote:

> On Wed, May 01, 2019 at 05:56:35PM +0900, Mike Hommey wrote:
> > The fread/fwrite-like functions in http.c, namely fread_buffer,
> > fwrite_buffer, fwrite_null, fwrite_sha1_file all return the
> > multiplication of the size and number of items they are being given.
> > 
> > Practically speaking, it doesn't matter, because in all contexts where
> > those functions are used, size is 1.
> > 
> > But those functions being similar to fread and fwrite (the curl API is
> > designed around being able to use fread and fwrite directly), it might
> > be preferable to make them behave like fread and fwrite, which, from
> > the fread/fwrite manual page, is:
> >    On  success, fread() and fwrite() return the number of items read
> >    or written.  This number equals the number of bytes transferred
> >    only when size is 1.  If an error occurs, or the end of the file
> >    is reached, the return value is a short item count (or zero).
> 
> This patch breaks the test 'push to remote repository with packed
> refs' in 't5540-http-push-webdav.sh':
> 
>   https://travis-ci.org/git/git/jobs/529223857#L2603
> 
> That test makes Apache spin like crazy at 100% CPU usage for about
> 30secs, after which, according to 'error.log':
> 
>   [Tue May 07 14:50:55.555166 2019] [mpm_prefork:notice] [pid 12638]
> AH00169: caught SIGTERM, shutting down

Yeah, this reproduces easily. The problem is that fread_buffer()
modifies "size" (if there are not enough bytes in the buffer to read),
so we cannot just assume it is "eltsize * nmemb" anymore.

I.e., we need to squash in:

diff --git a/http.c b/http.c
index 8dbc91f607..27aa0a3192 100644
--- a/http.c
+++ b/http.c
@@ -176,7 +176,7 @@ size_t fread_buffer(char *ptr, size_t eltsize, size_t nmemb, void *buffer_)
 	memcpy(ptr, buffer->buf.buf + buffer->posn, size);
 	buffer->posn += size;
 
-	return nmemb;
+	return size / eltsize;
 }
 
 #ifndef NO_CURL_IOCTL

The other conversions all look correct (there's a similar case in
fwrite_sha1_file, but it already does the division correctly).

-Peff
