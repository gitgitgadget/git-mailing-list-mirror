From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/2] read_and_strip_branch: fix typo'd address-of operator
Date: Wed, 28 Jan 2015 17:57:56 -0500
Message-ID: <20150128225755.GA15719@peff.net>
References: <20150128175314.GA13362@peff.net>
 <20150128175735.GA8172@peff.net>
 <xmqq1tmehc25.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 29 04:31:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YGfot-00011V-9q
	for gcvg-git-2@plane.gmane.org; Thu, 29 Jan 2015 04:31:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764289AbbA2Daq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Jan 2015 22:30:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:42877 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757460AbbA2Boj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Jan 2015 20:44:39 -0500
Received: (qmail 12754 invoked by uid 102); 28 Jan 2015 22:57:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Jan 2015 16:57:58 -0600
Received: (qmail 13005 invoked by uid 107); 28 Jan 2015 22:58:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 28 Jan 2015 17:58:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 28 Jan 2015 17:57:56 -0500
Content-Disposition: inline
In-Reply-To: <xmqq1tmehc25.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263136>

On Wed, Jan 28, 2015 at 12:42:26PM -0800, Junio C Hamano wrote:

> > This is the most minimal fix, but I kind of wonder if it should just be
> > using strbuf_rtrim (or even strbuf_trim) in the first place.
> 
> Yeah.  Or strbuf_chomp(), which does not exist ;-)

This is not the first time I've seen this chomp/trim distinction come
up. However, the thing that has prevented me from writing strbuf_chomp
is that the trim is almost always a more reasonable choice.

Take this instance. We are opening and reading a whole file. Surely we
need to drop the final newline, which is not interesting. But we are not
just doing that; we are dropping _all_ trailing newlines. So "foo\n\n"
becomes "foo". But "foo\n \n" does not. That doesn't make much sense.

IOW, I would venture to say that chomping like this falls into one of
two categories:

  1. You want to clean up any extraneous cruft. Multiple lines, extra
     whitespace, etc.

  2. You want to read one line, but don't want the trailing newline.

And strbuf_getline already handles case (2).

End mini-rant. :)

> It is tempting to apply this directly to maint and merge up
> immediately, as there is no way this 1-byte change will break things
> (of course that is not necessarily true for random 1-byte changes,
> though).
> 
> It sometimes gets really hard to resist that temptation during the
> pre-release freeze period.

That's part of why I did the simplest fix instead of strbuf_rtrim. To
tempt you. :)

-Peff
