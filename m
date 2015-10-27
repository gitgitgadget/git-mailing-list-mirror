From: Jeff King <peff@peff.net>
Subject: Re: git repack command on larger pack file
Date: Tue, 27 Oct 2015 19:47:52 -0400
Message-ID: <20151027234752.GC4172@sigill.intra.peff.net>
References: <loom.20151026T065553-934@post.gmane.org>
 <xmqq611ujfn0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sivakumar Selvam <gerritcode@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 00:48:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrDyB-0001vj-Bd
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 00:47:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752330AbbJ0Xrz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Oct 2015 19:47:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:48887 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751243AbbJ0Xrz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Oct 2015 19:47:55 -0400
Received: (qmail 9863 invoked by uid 102); 27 Oct 2015 23:47:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Oct 2015 18:47:54 -0500
Received: (qmail 30133 invoked by uid 107); 27 Oct 2015 23:48:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 27 Oct 2015 19:48:18 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Oct 2015 19:47:52 -0400
Content-Disposition: inline
In-Reply-To: <xmqq611ujfn0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280319>

On Sun, Oct 25, 2015 at 11:41:23PM -0700, Junio C Hamano wrote:

> Also it has to write more data to disk (see below), it has to find a
> good place to split, it has to adjust bookkeeping data at the pack
> boundary, in general it has to do more, not less, to produce split
> packs.  It would be surprising if it took less time.

This may go without saying, but the main cost in the write is that we
have to zlib deflate the output. I don't have any numbers at hand, but
when I've benchmarked serving fetches, it is often a balance game
between CPU time spent on a more aggressive delta search and CPU time
that goes into deflating the results of the search. Spending more CPU on
the former may yield more and smaller deltas which pay for themselves in
time spent on the latter.

There's definitely a balance point, and it varies from repo to repo, and
even within repos from fetch to fetch. I wish I had better heuristics to
report, but it's an ongoing thing I'm exploring. :)

-Peff
