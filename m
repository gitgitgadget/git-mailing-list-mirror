From: Jeff King <peff@peff.net>
Subject: Re: RFC GSoC idea: new "git config" features
Date: Fri, 14 Mar 2014 00:43:26 -0400
Message-ID: <20140314044326.GE31906@sigill.intra.peff.net>
References: <53108650.2020708@alum.mit.edu>
 <xmqqwqgft3bj.fsf@gitster.dls.corp.google.com>
 <53112794.2070007@alum.mit.edu>
 <20140301075247.GF20397@sigill.intra.peff.net>
 <vpq38j2tc6f.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	git discussion list <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 14 05:43:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOJy0-00079m-Qu
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 05:43:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559AbaCNEn3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 00:43:29 -0400
Received: from cloud.peff.net ([50.56.180.127]:39252 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750786AbaCNEn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 00:43:28 -0400
Received: (qmail 1732 invoked by uid 102); 14 Mar 2014 04:43:28 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 13 Mar 2014 23:43:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Mar 2014 00:43:26 -0400
Content-Disposition: inline
In-Reply-To: <vpq38j2tc6f.fsf@anie.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244080>

On Sat, Mar 01, 2014 at 12:01:44PM +0100, Matthieu Moy wrote:

> Jeff King <peff@peff.net> writes:
> 
> > If we had the keys in-memory, we could reverse this: config code asks
> > for keys it cares about, and we can do an optimized lookup (binary
> > search, hash, etc).
> 
> I'm actually dreaming of a system where a configuration variable could
> be "declared" in Git's source code, with associated type (list/single
> value, boolean/string/path/...), default value and documentation (and
> then Documentation/config.txt could become a generated file). One could
> imagine a lot of possibilities like

Yes, I think something like that would be very nice. I am not a big
fan of code generation, but if we had config queries like
"config_get_bool", then I think it would be reasonably pleasant to take
a spec like:

  Key: help.browser
  Type: string
  Description: Specify the browser for help...

and turn it into:

  const char *config_get_help_browser(void)
  {
          return config_get_string("help.browser");
  }

So technically code generation, but all the heavy lifting is done behind
the scenes. We're not saving lines in the result so much as avoiding
repeating ourselves (that is, the generated code is only mapping the
config-type from the spec into a C type and function name that gives us
extra compile-time safety).

However, I skimmed through config.txt looking for a key to use in my
example above, and there are a surprising number of one-off semantics
(e.g., things that are mostly bool, but can be "auto" or take some other
special value). We may find that the "Type" field has a surprising
number of variants that makes a technique like this annoying. But I'd
reserve judgement until somebody actually tries encoding a significant
chunk of the config keys and we see what it looks like.

> Migrating the whole code to such system would take time, but creating
> the system and applying it to a few examples might be feasible as a GSoC
> project.

Agreed, as long as we have enough examples to feel confident that the
infrastructure is sufficient.

-Peff
