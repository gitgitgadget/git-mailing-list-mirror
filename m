From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/4] Only re-encode certain parts in commit object, not
 the whole
Date: Tue, 21 Feb 2012 13:25:59 -0500
Message-ID: <20120221182559.GB32668@sigill.intra.peff.net>
References: <1329834292-2511-1-git-send-email-pclouds@gmail.com>
 <1329834292-2511-4-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 21 19:26:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RzuPg-0004c5-M8
	for gcvg-git-2@plane.gmane.org; Tue, 21 Feb 2012 19:26:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754515Ab2BUS0C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Feb 2012 13:26:02 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45339
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753445Ab2BUS0B (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2012 13:26:01 -0500
Received: (qmail 17788 invoked by uid 107); 21 Feb 2012 18:26:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 21 Feb 2012 13:26:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Feb 2012 13:25:59 -0500
Content-Disposition: inline
In-Reply-To: <1329834292-2511-4-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191175>

On Tue, Feb 21, 2012 at 09:24:52PM +0700, Nguyen Thai Ngoc Duy wrote:

> Commit object has its own format, which happens to be in ascii, but
> not really subject to re-encoding.
> 
> There are only four areas that may be re-encoded: author line,
> committer line, mergetag lines and commit body.  Encoding of tags
> embedded in mergetag lines is not decided by commit encoding, so leave
> it out and consider it binary.

Is this worth the effort? Yes, re-encoding the ASCII bits of the commit
object is unnecessary. But do we actually handle encodings that are not
ASCII supersets? IOW, I could see the point if this is making it
possible to hold utf-16 names and messages in your commits (though why
you would want to do so is beyond me...). But my understanding is that
this is horribly broken anyway by other parts of the code. And even
looking at your code below:

> +static char *reencode_commit(const char *buffer,
> +			     const char *out_enc, const char *in_enc)
> +{
> +	struct strbuf out = STRBUF_INIT;
> +	struct strbuf buf = STRBUF_INIT;
> +	char *reencoded, *s, *e;
> +
> +	strbuf_addstr(&buf, buffer);
> +
> +	s = strstr(buf.buf, "\nauthor ");
> +	assert(s != NULL);

Wouldn't this assert trigger in the presence of encodings which
contain ASCII NUL (e.g., wide encodings like utf-16)?

Is there an encoding you have in mind which would be helped by this?

-Peff
