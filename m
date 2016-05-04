From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 1/2] Documentation: fix linkgit references
Date: Wed, 4 May 2016 15:25:16 -0400
Message-ID: <20160504192516.GD21259@sigill.intra.peff.net>
References: <E4A56B4E-6F2E-44E3-870B-D1D3A71B2869@gmail.com>
 <1462351116-19308-1-git-send-email-larsxschneider@gmail.com>
 <1462351116-19308-2-git-send-email-larsxschneider@gmail.com>
 <F6210682-2FCA-423D-B6D3-06938C95D497@gmail.com>
 <5729DF25.7030503@ramsayjones.plus.com>
 <xmqqd1p1ivfw.fsf@gitster.mtv.corp.google.com>
 <xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Schneider <larsxschneider@gmail.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	git@vger.kernel.org, Matthieu.Moy@grenoble-inp.fr,
	sbeller@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 04 21:25:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ay2QP-0000Gf-Ee
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 21:25:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752873AbcEDTZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 15:25:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:34133 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753613AbcEDTZU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 15:25:20 -0400
Received: (qmail 30733 invoked by uid 102); 4 May 2016 19:25:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 15:25:19 -0400
Received: (qmail 13117 invoked by uid 107); 4 May 2016 19:25:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 15:25:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2016 15:25:16 -0400
Content-Disposition: inline
In-Reply-To: <xmqqvb2thczf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293574>

On Wed, May 04, 2016 at 11:52:52AM -0700, Junio C Hamano wrote:

> > I do not think there is any false positive above, so perhaps the
> > checker script below can be used as the link checker we discussed?
> 
> -- >8 --
> Subject: [PATCH] ci: validate "gitlink:" in documentation
> 
> It is easy to add incorrect "linkgit:<page>[<section>]" references
> to our documentation suite.  Catch these common classes of errors:
> 
>  * Referring to Documentation/<page>.txt that does not exist.
> 
>  * Referring to a <page> outside the Git suite.  In general, <page>
>    must begin with "git".
> 
>  * Listing the manual <section> incorrectly.  The first line of the
>    Documentation/<page>.txt must end with "(<section>)".
> 
> with a new script ci/lint-gitlink.sh.

It seems like this is something we _should_ be able to do while asciidoc
is actually expanding the macro, rather than as a separate step. But:

  1. I don't think stock asciidoc has this much flexibility in its
     macros.

  2. There are some ordering questions (e.g., while building "foo.1",
     "bar.1" may not be built yet, so we still have to massage requests
     for "bar.1" into "bar.txt".

Likewise, I think we could build the whole HTML source and then actually
just look for broken links in it. But that script would probably end up
looking similar to this one, with s/linkgit/href/. But it does more
directly measure what we want, which is that the rendered doc is usable;
it would catch something like using "--" instead of "{litdd}".

> +#!/bin/sh
> +
> +git grep -l linkgit: Documentation/ |
> +while read path
> +do
> +	perl -e '

Is it worth just making this a perl script, rather than a shell script
with a giant inline perl script? Perl is actually really good at doing
that "grep" as it reads the file. :)

Besides being slightly more efficient (reading the files only once
rather than filtering once via grep and then re-reading via perl). But
more importantly, it avoids a layer of quoting, which makes it less
likely to make a mistake by using single-quote in the perl script (I do
not see any errors in what you wrote, though).

-Peff
