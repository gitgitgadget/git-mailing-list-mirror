From: Jeff King <peff@peff.net>
Subject: Re: [RFC] fast-import: invalidate pack_id references after loosening
Date: Thu, 26 May 2016 10:16:45 -0400
Message-ID: <20160526141644.GA15836@sigill.intra.peff.net>
References: <20160513103621.GA12329@dcvr.yhbt.net>
 <xmqqpospap8g.fsf@gitster.mtv.corp.google.com>
 <4830D469-3885-4010-9A04-D809F0C6159D@gmail.com>
 <xmqq37pk8q0h.fsf@gitster.mtv.corp.google.com>
 <5E7631C9-DD59-4358-B907-D7C7AEA1739C@gmail.com>
 <20160517121330.GA7346@sigill.intra.peff.net>
 <20160525224907.GA18894@dcvr.yhbt.net>
 <20160525225402.GB18894@dcvr.yhbt.net>
 <20160525230913.GB2634@sigill.intra.peff.net>
 <20160526080236.GA27652@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Luke Diamand <luke@diamand.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Eric Wong <e@80x24.org>
X-From: git-owner@vger.kernel.org Thu May 26 16:17:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5w5o-00067h-Jl
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 16:16:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932076AbcEZOQt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2016 10:16:49 -0400
Received: from cloud.peff.net ([50.56.180.127]:44600 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753813AbcEZOQs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2016 10:16:48 -0400
Received: (qmail 31582 invoked by uid 102); 26 May 2016 14:16:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 10:16:47 -0400
Received: (qmail 19304 invoked by uid 107); 26 May 2016 14:16:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 26 May 2016 10:16:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2016 10:16:45 -0400
Content-Disposition: inline
In-Reply-To: <20160526080236.GA27652@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295655>

On Thu, May 26, 2016 at 08:02:36AM +0000, Eric Wong wrote:

> > That's probably OK in practice, as I think the actual pack-write already
> > does a linear walk of the object table to generate the pack index. So
> > presumably nobody checkpoints often enough for it to be a problem. And
> > the solution would be to keep a separate list of pointers to objects for
> > the current pack-id, which would trivially fix both this case and the
> > one in create_index().  So we can punt on it until somebody actually
> > runs into it, I think.
> 
> I might checkpoint that much and run into the problem soon :)
> Too tired now; maybe in a day or two I'll be able to make sense
> of C again :x

In theory the list of objects in the allocation pool are contiguous for
a particular pack. So you could break out of the double-loop at the
first non-matching object you see:

diff --git a/fast-import.c b/fast-import.c
index 83558dc..f214bd3 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -900,10 +900,13 @@ static const char *create_index(void)
 	c = idx;
 	for (o = blocks; o; o = o->next_pool)
 		for (e = o->next_free; e-- != o->entries;)
 			if (pack_id == e->pack_id)
 				*c++ = &e->idx;
+			else
+				goto done;
+done:
 	last = idx + object_count;
 	if (c != last)
 		die("internal consistency error creating the index");
 
 	tmpfile = write_idx_file(NULL, idx, object_count, &pack_idx_opts, pack_data->sha1);

But that seems to break some of the tests, so I think there is some case
which does not match my theory. :)

Another strategy is to note that we cross-check against object_count
here. So you could simply break out of the loop when we have found
object_count matches.

We don't keep similar counters for branches/tags (which have a similar
quadratic problem, though presumably much smaller "n"), but it would be
easy to keep an offset in start_packfile() and just start the iteration
there.

-Peff
