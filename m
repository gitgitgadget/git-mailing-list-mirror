From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v1 1/3] replace: add --graft option
Date: Fri, 23 May 2014 15:51:53 -0400
Message-ID: <20140523195153.GB19088@sigill.intra.peff.net>
References: <20140522211836.27162.80311.chriscool@tuxfamily.org>
 <20140522213307.27162.14455.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri May 23 21:52:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnvVa-0001NA-LW
	for gcvg-git-2@plane.gmane.org; Fri, 23 May 2014 21:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750995AbaEWTv4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 15:51:56 -0400
Received: from cloud.peff.net ([50.56.180.127]:58308 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750923AbaEWTvz (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 15:51:55 -0400
Received: (qmail 1409 invoked by uid 102); 23 May 2014 19:51:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 23 May 2014 14:51:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 23 May 2014 15:51:53 -0400
Content-Disposition: inline
In-Reply-To: <20140522213307.27162.14455.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250020>

On Thu, May 22, 2014 at 11:33:04PM +0200, Christian Couder wrote:

> The usage string for this option is:
> 
> git replace [-f] --graft <commit> [<parent>...]
> 
> First we create a new commit that is the same as <commit>
> except that its parents are [<parents>...]
> 
> Then we create a replace ref that replace <commit> with
> the commit we just created.
> 
> With this new option, it should be straightforward to
> convert grafts to replace refs, with something like:
> 
> cat .git/info/grafts | while read line
> do git replace --graft $line; done

I think this script at the end should end up in the documentation or a
contrib script (probably the former, as it is short enough that somebody
might just cut-and-paste).

The graft file ignores comments and blank lines, so maybe "grep '^[^#]'"
would be in order.

And maybe it's just me, but I think spacing it like:

  grep '^[^#]' .git/info/grafts |
  while read line; do
	git replace --graft $line
  done

is more readable (I think some would even argue for putting the "do" on
a separate line).

> +	/* make sure the commit is not corrupt */
> +	if (parse_commit_buffer(commit, buf.buf, buf.len))
> +		die(_("Could not parse commit: '%s'"), old_ref);

I guess the checks here are sufficient to make...

> +	/* find existing parents */
> +	parent_start = buf.buf;
> +	parent_start += 46; /* "tree " + "hex sha1" + "\n" */
> +	parent_end = parent_start;
> +
> +	while (starts_with(parent_end, "parent "))
> +		parent_end += 48; /* "parent " + "hex sha1" + "\n" */

...this number-based parsing safe, though it would miss removing a stray
parent line elsewhere in the commit. It still feels rather magical to
me, as we are depending on unspoken format guarantees defined inside
parse_commit_buffer. I'd prefer something like the line-based parser I
showed in the other thread, but I suppose it may just be a matter of
preference.

-Peff
