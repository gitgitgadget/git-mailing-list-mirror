From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] read_in_full: always report errors
Date: Thu, 26 May 2011 14:48:40 -0400
Message-ID: <20110526184839.GA6910@sigill.intra.peff.net>
References: <87tych5zrh.fsf@rho.meyering.net>
 <20110526141130.GB18520@sigill.intra.peff.net>
 <87hb8h5y09.fsf@rho.meyering.net>
 <20110526163027.GC4049@sigill.intra.peff.net>
 <7vy61twbqw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jim Meyering <jim@meyering.net>, git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 26 20:48:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPfc8-0004lq-Kl
	for gcvg-git-2@lo.gmane.org; Thu, 26 May 2011 20:48:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758364Ab1EZSsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 May 2011 14:48:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35538
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758357Ab1EZSsm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 May 2011 14:48:42 -0400
Received: (qmail 16345 invoked by uid 107); 26 May 2011 18:48:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 26 May 2011 14:48:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 26 May 2011 14:48:40 -0400
Content-Disposition: inline
In-Reply-To: <7vy61twbqw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174559>

On Thu, May 26, 2011 at 11:35:51AM -0700, Junio C Hamano wrote:

> The caller in index_stream() reads what it could, writes what it read, and
> comes back and makes another call to read_in_full(), at which point either
> it gets an error and the whole thing would error out (i.e. no difference
> from before), or if it was an transient error that interrupted the
> previous read_in_full(), it can keep reading (with this patch it will not
> have a chance to do so).

The problem is that most callers are not careful enough to repeatedly
call read_in_full and find out that there might have been an error in
the previous result. They see a read shorter than what they asked, and
assume it was EOF.

But even if we assume all callers are careful and want to handle these
transient errors, then:

  1. What sort of transient errors are we talking about? We already
     handle retrying after EAGAIN and EINTR via xread.

  2. If we get a non-transient error, are we guaranteed to get the same
     error if we make some other syscalls and then call read() again?
     Otherwise we are masking it.

But really, it just seems like a non-intuitive interface to me (as
evidenced by the number of callers who _didn't_ get it right). If a
caller like index_stream is really interested in reading and processing
some data up to a certain size, shouldn't it just be using xread
directly?

-Peff
