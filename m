Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 242F020450
	for <e@80x24.org>; Fri,  3 Nov 2017 19:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbdKCTNO (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Nov 2017 15:13:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:45806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751415AbdKCTNN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Nov 2017 15:13:13 -0400
Received: (qmail 1310 invoked by uid 109); 3 Nov 2017 19:13:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Nov 2017 19:13:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4060 invoked by uid 111); 3 Nov 2017 19:13:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 03 Nov 2017 15:13:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Nov 2017 15:13:10 -0400
Date:   Fri, 3 Nov 2017 15:13:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Simon Ruderich <simon@ruderich.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: factor out rewrite_file()
Message-ID: <20171103191309.sth4zjokgcupvk2e@sigill.intra.peff.net>
References: <6150c80b-cb0e-06d4-63a7-a4f4a9107ab2@web.de>
 <20171101194732.fn4n46wppl35e2z2@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1711012240500.6482@virtualbox>
 <20171101221618.4ioog7jlp7n2nd53@sigill.intra.peff.net>
 <20171103103248.4p45r4klojk5cf2g@ruderich.org>
 <xmqqpo8zpjdj.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqpo8zpjdj.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 03, 2017 at 10:44:08PM +0900, Junio C Hamano wrote:

> Simon Ruderich <simon@ruderich.org> writes:
> 
> > I tried looking into this by adding a new write_file_buf_gently()
> > (or maybe renaming write_file_buf to write_file_buf_or_die) and
> > using it from write_file_buf() but I don't know the proper way to
> > handle the error-case in write_file_buf(). Just calling
> > die("write_file_buf") feels ugly, as the real error was already
> > printed on screen by error_errno() and I didn't find any function
> > to just exit without writing a message (which still respects
> > die_routine). Suggestions welcome.
> 
> How about *not* printing the error at the place where you notice the
> error, and instead return an error code to the caller to be noticed
> which dies with an error message?

That ends up giving less-specific errors. It might be an OK tradeoff
here.

I think we've been gravitating towards error strbufs, which would make
it something like:

diff --git a/wrapper.c b/wrapper.c
index 61aba0b5c1..08eb5d1cb8 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -649,13 +649,34 @@ int xsnprintf(char *dst, size_t max, const char *fmt, ...)
 	return len;
 }
 
+int write_file_buf_gently(const char *path, const char *buf, size_t len,
+			  struct strbuf *err)
+{
+	int fd = open(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
+	if (fd < 0) {
+		strbuf_addf(err, _("could not open '%s' for writing: %s"),
+			    path, strerror(errno));
+		return -1;
+	}
+	if (write_in_full(fd, buf, len) < 0) {
+		strbuf_addf(err, _("could not write to %s: %s"),
+			    path, strerror(errno));
+		close(fd);
+		return -1;
+	}
+	if (close(fd)) {
+		strbuf_addf(err, _("could not close %s: %s"),
+			    path, strerror(errno));
+		return -1;
+	}
+	return 0;
+}
+
 void write_file_buf(const char *path, const char *buf, size_t len)
 {
-	int fd = xopen(path, O_WRONLY | O_CREAT | O_TRUNC, 0666);
-	if (write_in_full(fd, buf, len) < 0)
-		die_errno(_("could not write to %s"), path);
-	if (close(fd))
-		die_errno(_("could not close %s"), path);
+	struct strbuf err = STRBUF_INIT;
+	if (write_file_buf_gently(path, buf, len, &err) < 0)
+		die("%s", err.buf);
 }
 
 void write_file(const char *path, const char *fmt, ...)


I'm not excited that the amount of error-handling code is now double the
amount of code that actually does something useful. Maybe this function
simply isn't large/complex enough to merit flexible error handling, and
we should simply go with René's original near-duplicate.

OTOH, if we went all-in on flexible error handling contexts, you could
imagine this function becoming:

  void write_file_buf(const char *path, const char *buf, size_t len,
                      struct error_context *err)
  {
	int fd = xopen(path, err, O_WRONLY | O_CREAT | O_TRUNC, 0666);
	if (fd < 0)
		return -1;
	if (write_in_full(fd, buf, len, err) < 0)
		return -1;
	if (xclose(fd, err) < 0)
		return -1;
	return 0;
  }

Kind of gross, in that we're adding a layer on top of all system calls.
But if used consistently, it makes error-reporting a lot more pleasant,
and makes all of our "whoops, we forgot to save errno" bugs go away.

-Peff
