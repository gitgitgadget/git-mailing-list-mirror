From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Revert "retry request without query when info/refs?query
 fails"
Date: Thu, 20 Sep 2012 12:24:56 -0400
Message-ID: <20120920162456.GA25418@sigill.intra.peff.net>
References: <CAJo=hJvXtSBO3QEzhZCFfhk9OF_e0B10k8tjCUWMHZvGKt599Q@mail.gmail.com>
 <1348120680-24788-1-git-send-email-spearce@spearce.org>
 <7vlig5cilt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 18:25:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEjYs-00083P-9I
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 18:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129Ab2ITQY7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2012 12:24:59 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:51524 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750969Ab2ITQY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2012 12:24:59 -0400
Received: (qmail 16980 invoked by uid 107); 20 Sep 2012 16:25:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 20 Sep 2012 12:25:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Sep 2012 12:24:56 -0400
Content-Disposition: inline
In-Reply-To: <7vlig5cilt.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206051>

On Wed, Sep 19, 2012 at 11:29:34PM -0700, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > This reverts commit 703e6e76a14825e5b0c960d525f34e607154b4f7.
> >
> > Retrying without the query parameter was added as a workaround
> > for a single broken HTTP server at git.debian.org[1]. The server
> > was misconfigured to route every request with a query parameter
> > into gitweb.cgi. Admins fixed the server's configuration within
> > 16 hours of the bug report to the Git mailing list, but we still
> > patched Git with this fallback and have been paying for it since.
> 
> As the consequence of the above, the only two things we know about
> the servers in the wild are (1) a misconfiguration that requires
> this retry was once made, so it is not very unlikely others did the
> same misconfiguration, and (2) those unknown number of servers have
> been happily serving the current clients because the workaround
> patch have been hiding the misconfiguration ever since.

The misconfiguration was pretty wild in this case. I'd be much more
worried about stupidly non-compliant servers that will not serve
"foo/bar" when asked for "foo/bar?key=value".

> But as long as the failure diagnosis from updated clients that
> revert this workaround is sufficient to allow such misconfigured
> servers, I think it is OK.  We might see a large number of small
> people having to run around and fix the configuration as a fallout,
> though.

I think Shawn's revert is the right thing to do. But it is not complete
without the manual workaround. I'm putting that patch together now and
should have it out in a few minutes.

> > Most Git hosting services configure the smart HTTP protocol and the
> > retry logic confuses users when there is a transient HTTP error as
> > Git dropped the real error from the smart HTTP request. Removing the
> > retry makes root causes easier to identify.
> 
> Does that hold true also for dumb only small people installations?
> They are the ones that need more help than the large installations
> staffed sufficiently and run smart http gateway.

For the most part, yes. They will get a useful error out of the smart
request if there is a transient error, the repo does not exist, etc.
The real fallout is the people who are hitting a broken or misconfigured
server and may get a confusing error code (in the one case we know
about, it was a 404, but it really could be anything, depending on the
exact nature of the misconfiguration).

-Peff
