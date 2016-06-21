Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8504C1FF40
	for <e@80x24.org>; Tue, 21 Jun 2016 16:16:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752236AbcFUQQK (ORCPT <rfc822;e@80x24.org>);
	Tue, 21 Jun 2016 12:16:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:57947 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751804AbcFUQQH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Jun 2016 12:16:07 -0400
Received: (qmail 25667 invoked by uid 102); 21 Jun 2016 16:16:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 12:16:06 -0400
Received: (qmail 26062 invoked by uid 107); 21 Jun 2016 16:16:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Jun 2016 12:16:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Jun 2016 12:16:04 -0400
Date:	Tue, 21 Jun 2016 12:16:04 -0400
From:	Jeff King <peff@peff.net>
To:	git@vger.kernel.org
Cc:	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH 0/2] friendlier handling of overflows in archive-tar
Message-ID: <20160621161604.GA17638@sigill.intra.peff.net>
References: <20160616043523.GA13615@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160616043523.GA13615@sigill.intra.peff.net>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jun 16, 2016 at 12:35:23AM -0400, Jeff King wrote:

> The ustar format has some fixed-length numeric fields, and it's possible
> to generate a git tree that can't be represented (namely file size and
> mtime). Since f2f0267 (archive-tar: use xsnprintf for trivial
> formatting, 2015-09-24), we detect and die() in these cases. But we can
> actually do the friendly (and POSIX-approved) thing, and add extended
> pax headers to represent the correct values.
> 
>   [1/2]: archive-tar: write extended headers for file sizes >= 8GB
>   [2/2]: archive-tar: write extended headers for far-future mtime

And here's a v2 that addresses the smaller comments from René. I punted
on doing something fancy with tests. I'm not opposed to it, but I'm also
not convinced it's all that useful. Either way, I think it can come on
top if we want it.

Junio, this is the jk/big-and-old-archive-tar topic.

The interdiff is:

diff --git a/archive-tar.c b/archive-tar.c
index c7b85fd..ed562d4 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -179,7 +179,7 @@ static size_t get_path_prefix(const char *path, size_t pathlen, size_t maxlen)
 
 static inline unsigned long ustar_size(uintmax_t size)
 {
-	if (size < 077777777777UL)
+	if (size <= 077777777777UL)
 		return size;
 	else
 		return 0;
@@ -187,7 +187,7 @@ static inline unsigned long ustar_size(uintmax_t size)
 
 static inline unsigned long ustar_mtime(time_t mtime)
 {
-	if (mtime < 077777777777UL)
+	if (mtime <= 077777777777UL)
 		return mtime;
 	else
 		return 0;
@@ -299,7 +299,7 @@ static int write_tar_entry(struct archiver_args *args,
 			memcpy(header.linkname, buffer, size);
 	}
 
-	if (ustar_size(size) != size)
+	if (S_ISREG(mode) && ustar_size(size) != size)
 		strbuf_append_ext_header_uint(&ext_header, "size", size);
 	if (ustar_mtime(args->time) != args->time)
 		strbuf_append_ext_header_uint(&ext_header, "mtime", args->time);

