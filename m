From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] connect: learn to parse capabilities with values
Date: Fri, 10 Aug 2012 17:15:09 -0400
Message-ID: <20120810211509.GB888@sigill.intra.peff.net>
References: <20120810075342.GA30072@sigill.intra.peff.net>
 <20120810075816.GC8399@sigill.intra.peff.net>
 <7v7gt6jz3s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 10 23:15:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzwYF-0007bE-VN
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 23:15:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757704Ab2HJVPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 17:15:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:34032 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753424Ab2HJVPR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 17:15:17 -0400
Received: (qmail 2325 invoked by uid 107); 10 Aug 2012 21:15:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 10 Aug 2012 17:15:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 10 Aug 2012 17:15:09 -0400
Content-Disposition: inline
In-Reply-To: <7v7gt6jz3s.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203262>

On Fri, Aug 10, 2012 at 01:01:11PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +/*
> > + * Parse features of the form "feature=value".  Returns NULL if the feature
> > + * does not exist, the empty string if it exists but does not have an "=", or
> > + * the content to the right of the "=" until the first space (or end of
> > + * string).  The cannot contain literal spaces; double-quoting or similar
> > + * schemes would break compatibility, since older versions of git treat the
> > + * space as a hard-delimiter without any context.
> > + *
> > + * The return value (if non-NULL) is newly allocated on the heap and belongs to
> > + * the caller.
> > + */
> > +char *parse_feature_request_value(const char *feature_list, const char *feature)
> > +{
> > +	const char *start = parse_feature_request(feature_list, feature);
> > +	const char *end;
> > +
> > +	if (!start || prefixcmp(start, feature))
> > +		return NULL;
> > +	start += strlen(feature);
> > +
> > +	if (*start == '=')
> > +		start++;
> > +	end = strchrnul(start, ' ');
> > +
> > +	return xmemdupz(start, end - start);
> > +}
> 
> Having to run strlen(feature) three times in this function (once in
> parse_feature_request() as part of strstr() and the edge check of
> the found string, once as part of prefixcmp() here, and then an
> explicit strlen() to skip it) makes me feel dirty.

I thought about that, but it seems like a quite premature optimization.
It is three extra strlens per network conversation. _If_ you have turned
on double-verbosity in fetch-pack. I considered reusing the existing
parse_feature_request function more valuable from a maintenance
standpoint.

I would think the extra memory allocation would dwarf it, anyway.

> It is not wrong per-se, but it is likely that the caller has a
> constant string as the feature when it called this function, so
> perhaps just changing the function signature of server_supports,
> i.e.
> 
>     const char *server_supports(const char *feature)
>     {
> 	return parse_feature_request(server_capabilities, feature);
>     }
> 
> to return "var=val " would be more than sufficient.

That was in fact my first iteration, but...

> Then the existing callers can keep doing
> 
> 	if (server_supports("thin-pack"))
>         if (!server_supports("quiet"))
> 
> and a new caller can do something like
> 
> 	agent = server_supports("agent");
>         if (!agent || !agent[5])
>         	... no agent ...
> 	else {
>         	int span = strcspn(agent + 6, " \t\n");
>                 printf("I found agent=<%.*s>!\n", span, agent + 6);
> 	}
> 
> which doesn't look too bad.

I didn't want to force callers to have to deal with ad-hoc parsing.

Anyway, do you think this is even worth doing at this point? I'm
lukewarm on the final two patches due to the existence of
GIT_TRACE_PACKET, which is much more likely to be useful.

-Peff
