From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] teach fast-export an --anonymize option
Date: Thu, 21 Aug 2014 18:41:50 -0400
Message-ID: <20140821224150.GA21105@peff.net>
References: <20140821070130.GA15930@peff.net>
 <xmqqmwaxr44x.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 22 00:42:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XKb3O-0007wE-CW
	for gcvg-git-2@plane.gmane.org; Fri, 22 Aug 2014 00:41:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754890AbaHUWlx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Aug 2014 18:41:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:56426 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754744AbaHUWlx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Aug 2014 18:41:53 -0400
Received: (qmail 16897 invoked by uid 102); 21 Aug 2014 22:41:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 21 Aug 2014 17:41:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 21 Aug 2014 18:41:50 -0400
Content-Disposition: inline
In-Reply-To: <xmqqmwaxr44x.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255644>

On Thu, Aug 21, 2014 at 01:15:10PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +/*
> > + * We anonymize each component of a path individually,
> > + * so that paths a/b and a/c will share a common root.
> > + * The paths are cached via anonymize_mem so that repeated
> > + * lookups for "a" will yield the same value.
> > + */
> > +static void anonymize_path(struct strbuf *out, const char *path,
> > +			   struct hashmap *map,
> > +			   char *(*generate)(const char *, size_t *))
> > +{
> > +	while (*path) {
> > +		const char *end_of_component = strchrnul(path, '/');
> > +		size_t len = end_of_component - path;
> > +		const char *c = anonymize_mem(map, generate, path, &len);
> > +		strbuf_add(out, c, len);
> > +		path = end_of_component;
> > +		if (*path)
> > +			strbuf_addch(out, *path++);
> > +	}
> > +}
> 
> Do two paths sort the same way before and after anonymisation?  For
> example, if generate() works as a simple substitution, it should map
> a character that sorts before (or after) '/' with another that also
> sorts before (or after) '/' for us to be able to diagnose an error
> that comes from D/F sort order confusion.

No, the sort order is totally lost. I'd be afraid that a general scheme
would end up leaking information about what was in the filenames. It
might be acceptable to leak some information here, though, if it adds to
the realism of the result.

I tried here to lay the basic infrastructure and do the simplest thing
that might work, so we could evaluate proposals like that independently
(and also because I didn't come up with a clever enough algorithm to do
what you're asking).  Patches welcome on top. :)

-Peff
