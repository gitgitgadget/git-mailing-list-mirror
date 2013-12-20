From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 02/12] Convert starts_with() to skip_prefix() for option
 parsing
Date: Fri, 20 Dec 2013 02:04:49 -0500
Message-ID: <20131220070449.GA29717@sigill.intra.peff.net>
References: <1387378437-20646-1-git-send-email-pclouds@gmail.com>
 <1387378437-20646-3-git-send-email-pclouds@gmail.com>
 <52B3E8D4.1030805@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Dec 20 08:04:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vtu8l-0004KS-Np
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 08:04:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753926Ab3LTHEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Dec 2013 02:04:51 -0500
Received: from cloud.peff.net ([50.56.180.127]:47734 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752622Ab3LTHEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 02:04:51 -0500
Received: (qmail 7087 invoked by uid 102); 20 Dec 2013 07:04:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 20 Dec 2013 01:04:51 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 20 Dec 2013 02:04:49 -0500
Content-Disposition: inline
In-Reply-To: <52B3E8D4.1030805@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239564>

On Fri, Dec 20, 2013 at 07:51:00AM +0100, Johannes Sixt wrote:

> >  	for (i = 1; i < argc && *argv[i] == '-'; i++) {
> >  		const char *arg = argv[i];
> > +		const char *optarg;
> >  
> > -		if (starts_with(arg, "--upload-pack=")) {
> > -			args.uploadpack = arg + 14;
> > +		if ((optarg = skip_prefix(arg, "--upload-pack=")) != NULL) {
> > +			args.uploadpack = optarg;
> 
> Quite frankly, I do not think this is an improvement. The old code is
> *MUCH* easier to understand because "starts_with" is clearly a predicate
> that is either true or false, but the code with "skip_prefix" is much
> heavier on the eye with its extra level of parenthesis. That it removes a
> hard-coded constant does not count much IMHO because it is very clear
> where the value comes from.

Yeah, I agree that is unfortunate. Maybe we could have the best of both
worlds, like:

  if (starts_with(arg, "--upload-pack=", &optarg))
          ... use optarg ...

Probably we do not want to call it just "starts_with", as quite a few
callers to do not care about what comes next, and would just pass NULL.

I cannot seem to think of a good name, though, as the "with" means that
obvious things like "starts_with_value" naturally parse as a single
(nonsensical) sentence.  Something like "parse_prefix" would work, but
it is not as clearly a predicate as "starts_with" (but we have at least
gotten rid of the extra parentheses).

Elsewhere in the thread, the concept was discussed of returning the full
string to mean "did not match", which makes some other idioms simpler
(but IMHO makes the simple cases like this even harder to read). My
proposal splits the "start of string" out parameter from the boolean
return, so it handles both cases naturally:

  /* here we care if we saw the prefix, as above */
  if (parse_prefix(foo, prefix, &the_rest))
      ...

  /*
   * and here we do not care, and just want to optionally strip the
   * prefix, and take the full value otherwise; we just have to ignore
   * the return value in this case.
   */
  parse_prefix(foo, prefix, &foo);

-Peff
