From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http-push: trim trailing newline from remote symref
Date: Tue, 13 Jan 2015 15:41:40 -0500
Message-ID: <20150113204140.GA16238@peff.net>
References: <20150113022857.GA4087@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 13 21:41:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YB8Hh-0003Um-TZ
	for gcvg-git-2@plane.gmane.org; Tue, 13 Jan 2015 21:41:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752197AbbAMUlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Jan 2015 15:41:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:34062 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751043AbbAMUln (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Jan 2015 15:41:43 -0500
Received: (qmail 15328 invoked by uid 102); 13 Jan 2015 20:41:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jan 2015 14:41:42 -0600
Received: (qmail 30216 invoked by uid 107); 13 Jan 2015 20:42:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Jan 2015 15:42:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Jan 2015 15:41:40 -0500
Content-Disposition: inline
In-Reply-To: <20150113022857.GA4087@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262354>

On Mon, Jan 12, 2015 at 09:28:58PM -0500, Jeff King wrote:

> When we fetch a symbolic ref file from the remote, we get
> the whole string "ref: refs/heads/master\n", recognize it by
> skipping past the "ref: ", and store the rest. We should
> chomp the trailing newline.
> 
> This bug was introduced in ae021d8 (use skip_prefix to avoid
> magic numbers, 2014-06-18), which did not notice that the
> length computation fed to xmemdupz was quietly tweaked by 1
> to account for this.
> 
> We can solve it by explicitly trimming the newline, which is
> more obvious. Note that we use strbuf_rtrim here, which will
> actually cut off any trailing whitespace, not just a single
> newline. This is a good thing, though, as it makes our
> parsing more liberal (and spaces are not valid in refnames
> anyway).

While looking into Kyle's earlier response, I found that there is a
semi-duplicate of this function for the http-walker side:
http_fetch_ref. It already uses strbuf_rtrim, so I feel doubly good
about moving to its use here.

Almost certainly this duplicated functionality could be factored out. I
have very little interest in spending time cleaning up the http-push
code, though.

-Peff
