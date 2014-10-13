From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] t5304: use helper to report failure of "test foo =
 bar"
Date: Mon, 13 Oct 2014 17:15:25 -0400
Message-ID: <20141013211524.GB15969@peff.net>
References: <20141010060636.GA15057@peff.net>
 <20141010061114.GB15277@peff.net>
 <20141013161022.GA20520@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:15:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xdmxp-00036O-Ic
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 23:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751265AbaJMVP1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 17:15:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:58069 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750877AbaJMVP1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 17:15:27 -0400
Received: (qmail 16723 invoked by uid 102); 13 Oct 2014 21:15:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Oct 2014 16:15:27 -0500
Received: (qmail 28528 invoked by uid 107); 13 Oct 2014 21:15:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 13 Oct 2014 17:15:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 13 Oct 2014 17:15:25 -0400
Content-Disposition: inline
In-Reply-To: <20141013161022.GA20520@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 09:10:22AM -0700, Jonathan Nieder wrote:

> Jeff King wrote:
> 
> > For small outputs, we sometimes use:
> >
> >   test "$(some_cmd)" = "something we expect"
> >
> > instead of a full test_cmp. The downside of this is that
> > when it fails, there is no output at all from the script.
> 
> There's another downside to that construct: it loses the exit
> status from some_cmd.

Yes, although I think in many cases it's not a big deal. For example,
here we lose the exit code of count-objects, but it also is very
unlikely to fail _and_ produce our expected output.

> Alternatively, maybe there could be a helper in the same spirit as
> test_cmp_rev?
> 
> 	test_object_count () {
> 		git count-objects >output &&
> 		sed "s/ .*//" output >count &&
> 		printf "%s\n" "$1" >expect &&
> 		test_cmp expect count
> 	}

One of my goals was to provide a more generic helper so that we don't
have to make little helpers like this for every command. So I'd much
rather something like:

  test_output () {
	printf "%s\n" "$1" >expect &&
	shift &&
	"$@" >output &&
	test_cmp expect output
  }

The "\n" handling there feels a little hacky, but is probably OK in
practice (the few commands that really do generate an output without a
newline can use test_cmp manually). It should probably also "rm" the
files on success to avoid polluting the working tree.

It also doesn't help cases that want to do "test $foo -lt 3" or other
non-equality checks. But those are probably the minority.

I dunno. I am OK with what I posted, but if we feel strongly about
testing the exit code, I can re-roll as test_output as above.

-Peff
