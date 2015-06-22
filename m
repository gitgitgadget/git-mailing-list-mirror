From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/7] cat-file: sort and de-dup output of
 --batch-all-objects
Date: Mon, 22 Jun 2015 19:46:25 -0400
Message-ID: <20150622234624.GA13709@peff.net>
References: <1434705059-2793-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-1-git-send-email-charles@hashpling.org>
 <1434914431-7745-2-git-send-email-charles@hashpling.org>
 <20150622083822.GB12259@peff.net>
 <20150622103321.GB12584@peff.net>
 <20150622110632.GA26436@peff.net>
 <20150622220350.GB18677@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Charles Bailey <charles@hashpling.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 01:46:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7BQ9-0003VG-6j
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 01:46:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752840AbbFVXq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 19:46:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:50307 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752502AbbFVXq1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 19:46:27 -0400
Received: (qmail 18534 invoked by uid 102); 22 Jun 2015 23:46:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 18:46:27 -0500
Received: (qmail 14819 invoked by uid 107); 22 Jun 2015 23:46:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 22 Jun 2015 19:46:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jun 2015 19:46:25 -0400
Content-Disposition: inline
In-Reply-To: <20150622220350.GB18677@hashpling.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272435>

On Mon, Jun 22, 2015 at 11:03:50PM +0100, Charles Bailey wrote:

> > The patch below does the sort/de-dup. I'd probably just squash it into
> > patch 7, though.
> 
> Woah, 8 out of 7! Did you get a chance to measure the performance hit of
> the sort? If not, I may test it out when I next get the chance.

No, that last patch was my "eh, one more thing before bed" patch. ;)

It's easy enough to time, though. Running:

  git cat-file --batch-all-objects \
               --batch-check='%(objectsize) %(objectname)' \
	       --buffer >/dev/null

on linux.git, my best-of-five goes from (no sorting):

  real    0m3.604s
  user    0m3.556s
  sys     0m0.048s

to (with sorting):

  real    0m4.053s
  user    0m4.004s
  sys     0m0.052s

So it does matter, but not too much. We could de-dup with a hash table,
which might be a little faster, but I doubt it would make much
difference.  It's also mostly in sorted order already; it's possible
that a merge sort would behave a little better. I'm not sure how deep
it's worth going into that rabbit hole.

-Peff
