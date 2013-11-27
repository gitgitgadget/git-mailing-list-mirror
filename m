From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Wed, 27 Nov 2013 14:03:19 -0500
Message-ID: <20131127190319.GA3540@sigill.intra.peff.net>
References: <20131120222805.GC26468@kitenet.net>
 <20131121114157.GA7171@sigill.intra.peff.net>
 <20131121160426.GA21843@kitenet.net>
 <20131122020911.GA12042@sigill.intra.peff.net>
 <20131122172859.GA703@kitenet.net>
 <20131124084444.GA23238@sigill.intra.peff.net>
 <20131124090743.GA495@sigill.intra.peff.net>
 <xmqq7gbwz5w8.fsf@gitster.dls.corp.google.com>
 <20131127093043.GA23429@sigill.intra.peff.net>
 <xmqqeh61u0z9.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Joey Hess <joey@kitenet.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 27 20:03:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VlkOh-0005zf-1U
	for gcvg-git-2@plane.gmane.org; Wed, 27 Nov 2013 20:03:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753051Ab3K0TDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Nov 2013 14:03:22 -0500
Received: from cloud.peff.net ([50.56.180.127]:46738 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752003Ab3K0TDV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Nov 2013 14:03:21 -0500
Received: (qmail 13060 invoked by uid 102); 27 Nov 2013 19:03:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 27 Nov 2013 13:03:21 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 Nov 2013 14:03:19 -0500
Content-Disposition: inline
In-Reply-To: <xmqqeh61u0z9.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238452>

On Wed, Nov 27, 2013 at 10:57:14AM -0800, Junio C Hamano wrote:

> > Yes, I think it is a reasonable addition to the streaming API. However,
> > I do not think there are any callsites which would currently want it.
> > All of the current users of stream_blob_to_fd use read_sha1_file as
> > their alternative, and not parse_object. So we are not verifying the
> > sha1 in either case (we may want to change that, of course, but that is
> > a bigger decision than just trying to bring streaming and non-streaming
> > code-paths into parity).
> 
> True. I am not offhand sure if we want to make read_sha1_file() to
> rehash, but I agree that it is a question different from what we are
> asking in this discussion.

I'm torn on that. Having git verify everything all the time is kind of
cool. But it _does_ have a performance impact, and the vast majority of
the time nothing got corrupted since the last time we looked at the
object. It seems like periodically running "git fsck" is a smarter way
of doing periodic checks.

We already are careful when objects are coming into the repository, and
I think that is a sensible boundary (and I am increasingly of the
opinion that running with transfer.fsckobjects off is not a good idea).

The checks in parse_object seem hack-ish to me, because they catch some
random subset of the times we access objects (e.g., calling parse_object
on a commit sha1 will check, but calling parse_commit on an unparsed
commit struct will not). If anything, I'd suggest moving the checking
down to read_sha1_file, which would add it fairly consistently
everywhere, and then tying it to a config option (off for high
performance, on for slower-but-meticulous).

-Peff
