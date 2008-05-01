From: Jeff King <peff@peff.net>
Subject: Re: detecting rename->commit->modify->commit
Date: Thu, 1 May 2008 19:09:25 -0400
Message-ID: <20080501230925.GC21731@sigill.intra.peff.net>
References: <4819CF50.2020509@tikalk.com> <20080501144524.GA10876@sigill.intra.peff.net> <4819DCF1.7090504@tikalk.com> <20080501152035.GB11145@sigill.intra.peff.net> <20080501203940.GA3524@mithlond.arda.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Ittay Dror <ittayd@tikalk.com>,
	git@vger.kernel.org
To: Teemu Likonen <tlikonen@iki.fi>
X-From: git-owner@vger.kernel.org Fri May 02 01:10:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jrhv7-0003Oc-VX
	for gcvg-git-2@gmane.org; Fri, 02 May 2008 01:10:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933689AbYEAXJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 May 2008 19:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933615AbYEAXJ1
	(ORCPT <rfc822;git-outgoing>); Thu, 1 May 2008 19:09:27 -0400
Received: from peff.net ([208.65.91.99]:1637 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933513AbYEAXJ0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 May 2008 19:09:26 -0400
Received: (qmail 11155 invoked by uid 111); 1 May 2008 23:09:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 01 May 2008 19:09:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 May 2008 19:09:25 -0400
Content-Disposition: inline
In-Reply-To: <20080501203940.GA3524@mithlond.arda.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80945>

[cc'd Junio for comments on this rename optimization]

On Thu, May 01, 2008 at 11:39:40PM +0300, Teemu Likonen wrote:

> > Hmm, looking at the code, though, 50% is supposed to be the default
> > minimum. So there might actually be a bug.
> 
> I did some testing... A file, containing 10 lines (about 200 bytes),
> renamed and then modified (similarity index being a bit over 50%). Git

Ah, OK. The problem comes because the toy example is so tiny. It hits
this code chunk:

  if (base_size * (MAX_SCORE-minimum_score) < delta_size * MAX_SCORE)
          return 0;

where base_size is the size of the smaller file in bytes, and delta_size
is the difference between the size of the two files. This is an
optimization so that we don't even have to look at the contents.

But it is basing the percentage off of the smaller file, so even though
file B ("hello\nworld\n") is 50% made up of file A ("hello\n"), we
actually end up saying "there must be at least as much content added to
make B as there is in A already". IOW, the "percentage similarity" is
based off of the smaller file for this optimization.

Obviously this is a toy case, but I wonder if there are other larger
cases where you end up with a file which has substantial copied content,
but also _grows_ a lot (not just changes). For example, consider the
file:

  1
  2
  3
  4
  5
  6
  7
  8
  9

that is, ten lines each with a number. Now rename it, and start adding
more numbers. We detect the addition of 10, 11, 12. But adding 13 means
we no longer match. So even with only 4 lines added, we fail to match.

But again, this is a bit of a toy case. It relies on the line length
being a significant factor compared to number of lines.

-Peff
