From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] tag: support configuring --sort via .gitconfig
Date: Fri, 11 Jul 2014 17:06:33 -0400
Message-ID: <20140711210633.GA12546@sigill.intra.peff.net>
References: <1405111895-17451-1-git-send-email-jacob.e.keller@intel.com>
 <1405111895-17451-3-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Jul 11 23:06:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5i1j-0002ki-3q
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 23:06:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbaGKVGi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 17:06:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:60405 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932153AbaGKVGf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 17:06:35 -0400
Received: (qmail 26738 invoked by uid 102); 11 Jul 2014 21:06:35 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 11 Jul 2014 16:06:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 11 Jul 2014 17:06:33 -0400
Content-Disposition: inline
In-Reply-To: <1405111895-17451-3-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253326>

On Fri, Jul 11, 2014 at 01:51:35PM -0700, Jacob Keller wrote:

> +	if (!strcmp(var, "tag.sort")) {
> +		if (!value)
> +			return config_error_nonbool(var);
> +		status = parse_sort_string(value, &tag_sort);
> +		if (status) {
> +			warning("using default lexicographic sort order");
> +			tag_sort = STRCMP_SORT;
> +		}

I think this is a good compromise of the issues we discussed earlier. As
you noted, it should probably be marked for translation. I'm also not
sure the message content is clear in all situations. If I have a broken
tag.sort, I get:

  $ git config tag.sort bogus
  $ git tag >/dev/null
  error: unsupported sort specification bogus
  warning: using default lexicographic sort order

Not too bad, though reminding me that the value "bogus" came from
tag.sort would be nice. But what if I override it:

  $ git tag --sort=v:refname >/dev/null
  error: unsupported sort specification bogus
  warning: using default lexicographic sort order

That's actively wrong, because we are using v:refname from the
command-line. Perhaps we could phrase it like:

  warning: ignoring invalid config option tag.sort

or similar, which helps both cases.

As an aside, I also think the error line could more clearly mark the
literal contents of the variable. E.g., one of:

  error: unsupported sort specification: bogus

or

  error: unsupported sort specification 'bogus'

-Peff
