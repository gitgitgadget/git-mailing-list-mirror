From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Git segmentation faults if submodule path is empty.
Date: Fri, 16 Aug 2013 09:09:58 -0400
Message-ID: <20130816130957.GB20138@sigill.intra.peff.net>
References: <277BEB82-D618-48D9-A276-4B0E76A11A38@eyesopen.com>
 <520DCB4B.6090309@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jharrod LaFon <jlafon@eyesopen.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 16 15:10:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VAJnC-0005ze-Qg
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 15:10:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751397Ab3HPNKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 09:10:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:56437 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751527Ab3HPNKA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 09:10:00 -0400
Received: (qmail 27198 invoked by uid 102); 16 Aug 2013 13:10:00 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Aug 2013 08:10:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Aug 2013 09:09:58 -0400
Content-Disposition: inline
In-Reply-To: <520DCB4B.6090309@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232423>

On Fri, Aug 16, 2013 at 08:48:43AM +0200, Jens Lehmann wrote:

> > This patch addresses the issue by returning from the function if
> > 'value' is null before the call to xstrdup is made.
> 
> Hmm, I'm not sure silently ignoring the misconfiguration is the best
> way to go. A submodule config having a path setting without a value
> is broken (while a submodule setting without a subsection configures
> something else, so the "|| !name" below is fine). So I believe we
> should complain to the user when "value" is NULL.

Yeah, the usual behavior is to catch it and return config_error_nonbool
(because a key without a value is an implicit-true boolean).  Most code
does this via git_config_string, but what the submodule code is doing is
too tricky and custom to use that stock function.

> On the other hand this should only happen for the three options we do
> parse, as some users (e.g. git-submodule.sh) use other configurations
> for which a missing value may be fine. Please see the "lacks value"
> errors in read_merge_config() of ll-merge.c for an example of how to
> deal with that.

Those spots in ll-merge should probably be using config_error_nonbool,
if only for consistency with the rest of the code base.

> > -	if (parse_config_key(var, "submodule", &name, &namelen, &key) < 0 || !name)
> > +	if (parse_config_key(var, "submodule", &name, &namelen, &key) < 0 || !name || !value)
> >  		return 0;

I think this is also the wrong place to make the check, anyway. It is
saying that all values of submodule.X.Y must be non-NULL. But that is
not true. The submodule.X.fetchRecurseSubmodules option can be a
boolean, and:

  [submodule "foo"]
    fetchRecurseSubmodules

is perfectly valid (and is broken by this patch).

-Peff
