From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3 v5] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 13:46:28 -0400
Message-ID: <20140711174628.GC7856@sigill.intra.peff.net>
References: <1405099447-27555-1-git-send-email-jacob.e.keller@intel.com>
 <1405099447-27555-3-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 19:46:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5eu3-0000mX-MN
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 19:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751879AbaGKRqb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 13:46:31 -0400
Received: from cloud.peff.net ([50.56.180.127]:60269 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751345AbaGKRqa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 13:46:30 -0400
Received: (qmail 13583 invoked by uid 102); 11 Jul 2014 17:46:30 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 12:46:30 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 13:46:28 -0400
Content-Disposition: inline
In-Reply-To: <1405099447-27555-3-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253302>

On Fri, Jul 11, 2014 at 10:24:07AM -0700, Jacob Keller wrote:

> Updated to include changes due to Junio's feedback. This has not resolved
> whether we should fail on a configuration error or simply warn. It appears that
> we actually seem to error out more than warn, so I am unsure what the correct
> action is here.

Yeah, we're quite inconsistent there. In some cases we silently ignore
something unknown (e.g., a color.diff.* slot that we do not understand),
but in most cases if it is a config key we understand but a value we do
not, we complain and die.

It's probably user-unfriendly to be silent for those cases, though. The
user gets no feedback on why their config value is doing nothing.

I tend to think that warning is not much better than erroring out. It is
helpful if you are running a single-shot of an old version (which is
something that I do a lot when testing old versions), but would quickly
become irritating if you were actually using an old version of git
day-to-day.

I dunno. Maybe it is worth making life easier for people in the former
category.

> +static int parse_sort_string(const char *arg, int *sort)
> +{
> +	int type = 0, flags = 0;
> +
> +	if (skip_prefix(arg, "-", &arg))
> +		flags |= REVERSE_SORT;
> +
> +	if (skip_prefix(arg, "version:", &arg) || skip_prefix(arg, "v:", &arg))
> +		type = VERCMP_SORT;
> +	else
> +		type = STRCMP_SORT;
> +
> +	if (strcmp(arg, "refname"))
> +		return error(_("unsupported sort specification %s"), arg);
> +
> +	*sort = (type | flags);
> +
> +	return 0;
> +}

Regardless of how we handle the error, I think this version that
assembles the final bitfield at the end is easier to read than the
original.

-Peff
