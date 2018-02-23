Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33CD71F576
	for <e@80x24.org>; Fri, 23 Feb 2018 07:00:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751475AbeBWHA5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Feb 2018 02:00:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:33708 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751353AbeBWHA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Feb 2018 02:00:56 -0500
Received: (qmail 27891 invoked by uid 109); 23 Feb 2018 07:00:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 23 Feb 2018 07:00:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11852 invoked by uid 111); 23 Feb 2018 07:01:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 23 Feb 2018 02:01:43 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 Feb 2018 02:00:54 -0500
Date:   Fri, 23 Feb 2018 02:00:54 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] strbuf_read_file(): preserve errno across close() call
Message-ID: <20180223070053.GC19791@sigill.intra.peff.net>
References: <6b58885c-b0f6-1687-3f2d-4594aacff9ac@web.de>
 <20180223064952.GB19791@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180223064952.GB19791@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 23, 2018 at 01:49:52AM -0500, Jeff King wrote:

> > +static ssize_t strbuf_read_file_or_whine(struct strbuf *sb, const char *path)
> > +{
> > +	int fd;
> > +	ssize_t len;
> > +
> > +	fd = open(path, O_RDONLY);
> > +	if (fd < 0)
> > +		return error_errno(_("could not open '%s'"), path);
> > +	len = strbuf_read(sb, fd, 0);
> > +	close(fd);
> > +	if (len < 0)
> > +		return error(_("could not read '%s'."), path);
> > +	return len;
> > +}
> 
> If we were to use error_errno() in the second conditional here, we
> should take care not to clobber errno during the close(). I think
> strbuf_read_file() actually has the same problem, which might be worth
> fixing.

Here's a patch, while I'm thinking about it.

I notice that quite a few strbuf error paths may call strbuf_release(),
too.  Technically free() may clobber errno, too. I don't know if it's
worth protecting against (IIRC POSIX is being amended to disallow this,
but I have no idea how common it is in existing platforms).

-- >8 --
Subject: [PATCH] strbuf_read_file(): preserve errno across close() call

If we encounter a read error, the user may want to report it
by looking at errno. However, our close() call may clobber
errno, leading to confusing results. Let's save and restore
it in the error case.

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/strbuf.c b/strbuf.c
index 1df674e919..5f138ed3c8 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -612,14 +612,18 @@ ssize_t strbuf_read_file(struct strbuf *sb, const char *path, size_t hint)
 {
 	int fd;
 	ssize_t len;
+	int saved_errno;
 
 	fd = open(path, O_RDONLY);
 	if (fd < 0)
 		return -1;
 	len = strbuf_read(sb, fd, hint);
+	saved_errno = errno;
 	close(fd);
-	if (len < 0)
+	if (len < 0) {
+		errno = saved_errno;
 		return -1;
+	}
 
 	return len;
 }
-- 
2.16.2.580.g96c83ce8ea

