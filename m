From: Jeff King <peff@peff.net>
Subject: Re: [PATCHv3] gpg-interface: check gpg signature creation status
Date: Tue, 14 Jun 2016 17:50:19 -0400
Message-ID: <20160614215019.GB22334@sigill.intra.peff.net>
References: <26353a3d-e495-075f-4f84-b34a2420a6cf@drmicha.warpmail.net>
 <8e08b63b58302b6e7fe91f0dfb5b476781bfd37d.1465915311.git.git@drmicha.warpmail.net>
 <xmqq60tbaba5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	ZhenTian <loooseleaves@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 14 23:50:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCwE6-0007Ny-1N
	for gcvg-git-2@plane.gmane.org; Tue, 14 Jun 2016 23:50:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751342AbcFNVuW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jun 2016 17:50:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:54895 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751119AbcFNVuW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jun 2016 17:50:22 -0400
Received: (qmail 15525 invoked by uid 102); 14 Jun 2016 21:50:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 17:50:21 -0400
Received: (qmail 680 invoked by uid 107); 14 Jun 2016 21:50:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 14 Jun 2016 17:50:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 14 Jun 2016 17:50:19 -0400
Content-Disposition: inline
In-Reply-To: <xmqq60tbaba5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297339>

On Tue, Jun 14, 2016 at 11:13:54AM -0700, Junio C Hamano wrote:

> Michael J Gruber <git@drmicha.warpmail.net> writes:
> 
> >  	bottom = signature->len;
> > -	len = strbuf_read(signature, gpg.out, 1024);
> > +	strbuf_read(signature, gpg.out, 1024);
> > +	strbuf_read(&err, gpg.err, 0);
> 
> Hmmmm, isn't this asking for a deadlock?  When GPG spews more than
> what would fit in a pipe buffer to its standard error (hence gets
> blocked), its standard output may not complete, and the we would get
> stuck by attempting to read from gpg.out, failing to reach the other
> strbuf_read() that would unblock GPG by reading from gpg.err?

Yeah, it definitely is a deadlock. I think we'd need a select loop to
read into multiple strbufs at once (we can't use "struct async" because
that might happen in another process).

-Peff
