From: Jeff King <peff@peff.net>
Subject: Re: git version statistics
Date: Fri, 1 Jun 2012 05:03:38 -0400
Message-ID: <20120601090337.GC32340@sigill.intra.peff.net>
References: <20120531114801.GA21367@sigill.intra.peff.net>
 <20120531120018.GA24986@sigill.intra.peff.net>
 <7v396g6t53.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 01 11:04:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaNm9-0000MJ-9v
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 11:04:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756547Ab2FAJD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 05:03:57 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:39659
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752190Ab2FAJDm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 05:03:42 -0400
Received: (qmail 31055 invoked by uid 107); 1 Jun 2012 09:03:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Jun 2012 05:03:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Jun 2012 05:03:38 -0400
Content-Disposition: inline
In-Reply-To: <7v396g6t53.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198964>

On Thu, May 31, 2012 at 12:35:20PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> > index 149db88..f3b8422 100644
> > --- a/builtin/fetch-pack.c
> > +++ b/builtin/fetch-pack.c
> > @@ -327,6 +327,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
> >  			if (args.no_progress)   strbuf_addstr(&c, " no-progress");
> >  			if (args.include_tag)   strbuf_addstr(&c, " include-tag");
> >  			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
> > +			strbuf_addf(&c, " agent=git/%s", git_version_string);
> >  			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
> >  			strbuf_release(&c);
> 
> Even though the version string GIT-VERSION-GEN script deduces from
> the repository version is designed to be safe, in general "version"
> file can contain a string with whitespaces.  You may want to be
> careful about that in the above.

Yeah, I agree. I should have been more clear that this patch was an RFC
about the idea, not the implementation.

We could also strip off junk like ".dirty" which is unlikely to be
interesting for statistical reporting. On the other hand, it could be
useful for somebody debugging, and it can always be stripped later.

I don't know if anybody cares about the security or privacy implications
of advertising your client version. Maybe it should be configurable?

> Do we want a similar identifier string on the other side of the
> connection?

We could. I don't see much point, unless you were going to conduct a
similar survey by hitting random IPs looking for git ports (but even
then, you're not likely to turn up much, because you have to know a repo
name before you can convince git to show a capability string). I suppose
it could also help with debugging if your client is having trouble
talking to a server that is not under your control.

Some traditional security advice I have heard is that servers should not
advertise their versions, as it makes it more obvious what holes they
have. Personally, I find that argument to be mostly security through
obscurity. If I have an exploit for version X, it's generally just as
easy to try it as it is to check the version (unless the exploit
requires a lot of effort, like guessing a value that might take
thousands of tries).

-Peff
