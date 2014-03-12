From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] general style: replaces memcmp() with proper
 starts_with()
Date: Wed, 12 Mar 2014 15:49:44 -0400
Message-ID: <20140312194943.GA2912@sigill.intra.peff.net>
References: <1394635434-44979-1-git-send-email-quintus.public@gmail.com>
 <20140312175624.GA7982@sigill.intra.peff.net>
 <xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Quint Guvernator <quintus.public@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:49:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNp9y-00027Z-Ve
	for gcvg-git-2@plane.gmane.org; Wed, 12 Mar 2014 20:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbaCLTtq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2014 15:49:46 -0400
Received: from cloud.peff.net ([50.56.180.127]:38280 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751101AbaCLTtp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2014 15:49:45 -0400
Received: (qmail 30428 invoked by uid 102); 12 Mar 2014 19:49:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 12 Mar 2014 14:49:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 12 Mar 2014 15:49:44 -0400
Content-Disposition: inline
In-Reply-To: <xmqqiorjky0a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243973>

On Wed, Mar 12, 2014 at 12:39:01PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >>  static inline int standard_header_field(const char *field, size_t len)
> >>  {
> >> -	return ((len == 4 && !memcmp(field, "tree ", 5)) ||
> >> -		(len == 6 && !memcmp(field, "parent ", 7)) ||
> >> -		(len == 6 && !memcmp(field, "author ", 7)) ||
> >> -		(len == 9 && !memcmp(field, "committer ", 10)) ||
> >> -		(len == 8 && !memcmp(field, "encoding ", 9)));
> >> +	return ((len == 4 && starts_with(field, "tree ")) ||
> >> +		(len == 6 && starts_with(field, "parent ")) ||
> >> +		(len == 6 && starts_with(field, "author ")) ||
> >> +		(len == 9 && starts_with(field, "committer ")) ||
> >> +		(len == 8 && starts_with(field, "encoding ")));
> >
> > These extra "len" checks are interesting.  They look like an attempt to
> > optimize lookup, since the caller will already have scanned forward to
> > the space.
> 
> If one really wants to remove the magic constants from this, then
> one must take advantage of the pattern
> 
> 	len == strlen(S) - 1 && !memcmp(field, S, strlen(S))
> 
> that appears here, and come up with a simple abstraction to express
> that we are only using the string S (e.g. "tree "), length len and
> location field of the counted string.
> 
> Blindly replacing starts_with() with !memcmp() in the above part is
> a readability regression otherwise.

I actually think the right solution is:

  static inline int standard_header_field(const char *field, size_t len)
  {
          return mem_equals(field, len, "tree ") ||
                 mem_equals(field, len, "parent ") ||
                 ...;
  }

and the caller should tell us it's OK to look at field[len]:

  standard_header_field(line, eof - line + 1)

We could also omit the space from the standard_header_field. The caller
just ran strchr() looking for the space, so we know that either it is
there, or we are at the end of the line/buffer. Arguably a string like
"parent\n" should be "a parent header with no data" (but right now it is
not matched by this function). I'm not aware of an implementation that
writes such a thing, but it seems to fall in the "be liberal in what you
accept" category.

-Peff
