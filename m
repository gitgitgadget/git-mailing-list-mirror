Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82F811F955
	for <e@80x24.org>; Fri, 29 Jul 2016 18:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753487AbcG2SZu (ORCPT <rfc822;e@80x24.org>);
	Fri, 29 Jul 2016 14:25:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:51242 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753364AbcG2SZt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Jul 2016 14:25:49 -0400
Received: (qmail 6616 invoked by uid 102); 29 Jul 2016 18:25:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 14:25:48 -0400
Received: (qmail 4204 invoked by uid 107); 29 Jul 2016 18:26:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 Jul 2016 14:26:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Jul 2016 14:25:45 -0400
Date:	Fri, 29 Jul 2016 14:25:45 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Linus Torvalds <torvalds@linux-foundation.org>,
	Paul Tan <pyokagan@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] reset cached ident date before creating objects
Message-ID: <20160729182545.GE14953@sigill.intra.peff.net>
References: <CA+55aFxaia7_VkKKF3JiQt76+z5goz3vCpmWi-wTyBH=iaw5ew@mail.gmail.com>
 <CAPc5daX=MoqEXkV7DdpT+J=4K_qNdo0aNu_XgUs+9yggyrMXbQ@mail.gmail.com>
 <20160729002902.GD9646@sigill.intra.peff.net>
 <CA+55aFzRBQNU80ukcAk2JjbeWTvo8jHxejBeWWPjrHHuX7ygSQ@mail.gmail.com>
 <20160729155012.GA29773@sigill.intra.peff.net>
 <xmqq7fc4pdqp.fsf@gitster.mtv.corp.google.com>
 <20160729180517.GA14953@sigill.intra.peff.net>
 <xmqqeg6cnwdw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeg6cnwdw.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Fri, Jul 29, 2016 at 11:15:39AM -0700, Junio C Hamano wrote:

> > It does feel a little backwards to cache by default, and then try to
> > catch all the places that want to reset. Another way of thinking about
> > it would be to almost _never_ cache, but let a few callsites like (the
> > commit object creation) explicitly ask for a stable timestamp between
> > the author and committer.
> 
> ... and the reflog?

I left that part out. I can't decide if it is a bug or a feature that
the reflog retains the same timestamp.

I.e., I'm not sure it would be wrong to do:

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 12290d2..465cfc5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2886,6 +2886,8 @@ static int log_ref_write_1(const char *refname, const unsigned char *old_sha1,
 	logfd = open(logfile->buf, oflags);
 	if (logfd < 0)
 		return 0;
+
+	reset_ident_date();
 	result = log_ref_write_fd(logfd, old_sha1, new_sha1,
 				  git_committer_info(0), msg);
 	if (result) {

on top. If somebody writes a lot of refs without updating any commit
objects, should those all have a stable timestamp or not?

On the one hand, moving the timestamp reflects reality.

On the other, I have done dirty things in the past like "undoing" the
results of somebody's mistaken:

  git clone ...
  git push --mirror ;# oops, this deletes everything except master!

by grouping ref updates according to their reflog mtimes.

So I kind of punted by not changing it but also not making any claims
either way. :)

-Peff
