From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] log --decorate: do not leak "commit" color into the next
 item
Date: Sat, 21 Feb 2015 01:23:10 -0500
Message-ID: <20150221062310.GB29665@peff.net>
References: <xmqqzj8b0w6t.fsf@gitster.dls.corp.google.com>
 <xmqqpp9628tl.fsf@gitster.dls.corp.google.com>
 <20150218230728.GA17302@peff.net>
 <xmqqvbixzsnv.fsf@gitster.dls.corp.google.com>
 <20150220014230.GA16124@peff.net>
 <xmqqwq3cxjwg.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 21 07:24:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YP3UE-0007fa-O3
	for gcvg-git-2@plane.gmane.org; Sat, 21 Feb 2015 07:24:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751288AbbBUGXN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Feb 2015 01:23:13 -0500
Received: from cloud.peff.net ([50.56.180.127]:51908 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751133AbbBUGXN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Feb 2015 01:23:13 -0500
Received: (qmail 6223 invoked by uid 102); 21 Feb 2015 06:23:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Feb 2015 00:23:13 -0600
Received: (qmail 10830 invoked by uid 107); 21 Feb 2015 06:23:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 21 Feb 2015 01:23:12 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 21 Feb 2015 01:23:10 -0500
Content-Disposition: inline
In-Reply-To: <xmqqwq3cxjwg.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264210>

On Fri, Feb 20, 2015 at 03:06:39PM -0800, Junio C Hamano wrote:

> -- >8 --
> Subject: config.txt: spell out how certain typed values are written
> 
> Many variables have values that are not arbitrary strings and there
> are ways to spell these values of certain types.  The way to spell
> colors was described in a section for color.branch.<slot> and other
> variables refered to that section, which was technically wrong, but
> was a bit awkward.

Did you mean "not technically" here?

I think this patch is certainly an improvement with respect to the
colors. And I like that it organizes the types into one place using a
list, which is easier to scan when you are looking at a manpage. But...

> +Values
> +~~~~~~
> +
> +Values of many variables are treated as a simple string, but there
> +are variables that take values of specific types and there are rules
> +as to how to spell them.
> +
> +boolean::
> +	When a variable is said to take a boolean value, many
> +	synonyms are accepted for 'true' and 'false'.
> +	true;; Boolean true can be spelled as `yes`, `on`, `true`,
> +	    or `1`.  Also, a variable defined without `= <value>`
> +	    is taken as true.
> +	false;; Boolean false can be spelled as `no`, `off`,
> +	    `false`, or `0`.

This information is redundant with what is in the `Syntax` section:

  The values following the equals sign in variable assign are all either
  a string, an integer, or a boolean.  Boolean values may be given as
  yes/no, 1/0, true/false or on/off.  Case is not significant in boolean
  values, when converting value to the canonical form using '--bool'
  type specifier; 'git config' will ensure that the output is "true" or
  "false".

I think that paragraph can go away in favor of what you've written. We
should mention case-insensitivity there. And the final sentence about
`git-config` should go in the section `--bool` description of
`git-config`.

Immediately after that paragraph we discuss string values and quoting.
Technically those quoting rules apply to all values (e.g., colors, which
are just strings with special meaning), but I it may make sense to put
them in a "strong::" bullet here.

> +integer::
> +	The value for many variables that specify various sizes can
> +	be suffixed with `k`, `M`,... to mean "scale the number by
> +	1024", "by 1024x1024", etc.

I had a feeling we only did this for ulong's, but I checked the code and
we do indeed handle handle unit sizes everywhere. Is it worth mentioning
range limits here? I think since c7c377d83f4 it is probably not a big
deal. "git config --int" uses 64-bit integers everywhere. Internally we
use "unsigned long" for big things. There are still some uses of "int"
internally, but only for things that should obviously be small. And in
any case we complain if there is overflow. So probably it is not
something users need to think about.

-Peff
