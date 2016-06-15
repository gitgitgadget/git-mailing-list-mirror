From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] gpg-interface: check gpg signature creation status
Date: Tue, 14 Jun 2016 23:28:04 -0400
Message-ID: <20160615032804.GA2249@sigill.intra.peff.net>
References: <26353a3d-e495-075f-4f84-b34a2420a6cf@drmicha.warpmail.net>
 <8e08b63b58302b6e7fe91f0dfb5b476781bfd37d.1465915311.git.git@drmicha.warpmail.net>
 <xmqq60tbaba5.fsf@gitster.mtv.corp.google.com>
 <20160614215019.GB22334@sigill.intra.peff.net>
 <20160614222633.GA32020@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	ZhenTian <loooseleaves@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 15 05:33:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bD1aN-0001u2-9Y
	for gcvg-git-2@plane.gmane.org; Wed, 15 Jun 2016 05:33:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161023AbcFOD2O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 23:28:14 -0400
Received: from cloud.peff.net ([50.56.180.127]:55000 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161017AbcFOD2N (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 23:28:13 -0400
Received: (qmail 29769 invoked by uid 102); 15 Jun 2016 03:28:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 23:28:07 -0400
Received: (qmail 2738 invoked by uid 107); 15 Jun 2016 03:28:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 23:28:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 23:28:04 -0400
Content-Disposition: inline
In-Reply-To: <20160614222633.GA32020@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297350>

On Tue, Jun 14, 2016 at 06:26:33PM -0400, Jeff King wrote:

> > > >  	bottom = signature->len;
> > > > -	len = strbuf_read(signature, gpg.out, 1024);
> > > > +	strbuf_read(signature, gpg.out, 1024);
> > > > +	strbuf_read(&err, gpg.err, 0);
> > > 
> > > Hmmmm, isn't this asking for a deadlock?  When GPG spews more than
> > > what would fit in a pipe buffer to its standard error (hence gets
> > > blocked), its standard output may not complete, and the we would get
> > > stuck by attempting to read from gpg.out, failing to reach the other
> > > strbuf_read() that would unblock GPG by reading from gpg.err?
> > 
> > Yeah, it definitely is a deadlock. I think we'd need a select loop to
> > read into multiple strbufs at once (we can't use "struct async" because
> > that might happen in another process).
> 
> Something like this on top of Michael's patch (only lightly tested).

I wondered if this is something we might run into in other places, but
just haven't in practice. After grepping existing calls to strbuf_read(),
I think the only other case is the one in verify_signed_buffer(), which
reads all of stderr before trying to read stdout. I suspect that _could_
deadlock but doesn't tend to in practice.

Interestingly, it also writes in full to gpg's stdin before reading
anything. If gpg buffers all of its input before writing, that's fine,
but in theory it does not have to. I have no idea if it's possible for
it to be a problem in practice.

That can be solved in the same select loop, though obviously it's not
just strbuf_read_parallel() at that point, but rather a kind of a
feed_and_capture_command().

-Peff
