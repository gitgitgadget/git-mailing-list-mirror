From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/8] Hiding refs
Date: Tue, 11 Mar 2014 16:36:50 -0400
Message-ID: <20140311203650.GA31173@sigill.intra.peff.net>
References: <5110DF1D.8010505@alum.mit.edu>
 <CACsJy8BhL4qDb8BgOVuaUFF_9GXvgu55urYyKqPuZMZCTCoLwA@mail.gmail.com>
 <7v4nhpckwd.fsf@alter.siamese.dyndns.org>
 <CACBZZX6xLvuMEhPnfYLj8W9pMLwdoS7Zb+mTtn+3DanJPiWfXw@mail.gmail.com>
 <7vmwvh9e3p.fsf@alter.siamese.dyndns.org>
 <CACsJy8Aas3tRoDp9LQw7Nwf6+S3QnvwA7h7s-sHVY+1yFKhTYg@mail.gmail.com>
 <20140311014945.GB12033@sigill.intra.peff.net>
 <xmqqtxb4pm3u.fsf@gitster.dls.corp.google.com>
 <20140311200513.GB29102@sigill.intra.peff.net>
 <xmqq4n34pjnw.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 21:36:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNTQ1-0008HQ-PR
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 21:36:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755753AbaCKUgx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 16:36:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:37621 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755745AbaCKUgw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 16:36:52 -0400
Received: (qmail 28887 invoked by uid 102); 11 Mar 2014 20:36:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Mar 2014 15:36:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Mar 2014 16:36:50 -0400
Content-Disposition: inline
In-Reply-To: <xmqq4n34pjnw.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243896>

On Tue, Mar 11, 2014 at 01:25:23PM -0700, Junio C Hamano wrote:

> > Yeah, good idea. I might be misremembering some complications, but we
> > can probably do it with:
> >
> >   1. Teach the client to send an "advertise-symrefs" flag before the ref
> >      advertisement.
> >
> >   2. Teach the server to include symrefs in the ref advertisement; we
> >      can invent a new syntax because we know the client has asked for
> >      it.
> 
> I was thinking more about the underlying protocol, not advertisement
> in particular, and I think we came to the same conclusion.
> 
> The capability advertisement deserves to have its own separate
> packet message type, when both sides say that they understand it, so
> that we do not have to be limited by the pkt-line length limit.  We
> could do one message per capability, and at the same time can lift
> the traditional "capability hidden after the NUL is purged every
> time, so we need to repeat them if we want to later change it,
> because that is how older clients and servers use that information"
> insanity, for example.

So this may be entering the "more radical changes" realm I mentioned
earlier.

If the client is limited to setting a few flags, then something like
http can get away with:

  GET foo.git/info/refs?service=git-upload-pack&advertise-symrefs&refspec=refs/heads/*

And it does not need to worry about upload-pack2 at all. Either the
server recognizes and acts on them, or it ignores them.

But given that we do not have such a magic out-of-band method for
passing values over ssh and git, maybe it is not worth worrying about.
Http can move to upload-pack2 along with the rest.

One thing that _is_ worth considering for http is how the protocol
starts. We do not want to introduce an extra http round-trip to the
protocol if we can help it. If the initial GET becomes a POST, then it
could pass along the pkt-line of client capabilities with the initial
request, and the server would respond with the ref advertisement as
usual.

-Peff
