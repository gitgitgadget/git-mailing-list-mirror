From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 11/16] ref-filter: introduce refname_atom_parser()
Date: Thu, 14 Apr 2016 16:43:04 -0400
Message-ID: <20160414204304.GA20875@sigill.intra.peff.net>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
 <1460227515-28437-12-git-send-email-Karthik.188@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, jacob.keller@gmail.com, gitster@pobox.com
To: Karthik Nayak <karthik.188@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 22:43:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqo6b-0003V2-Hb
	for gcvg-git-2@plane.gmane.org; Thu, 14 Apr 2016 22:43:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbcDNUnI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2016 16:43:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:49681 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751249AbcDNUnH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2016 16:43:07 -0400
Received: (qmail 22604 invoked by uid 102); 14 Apr 2016 20:43:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 16:43:06 -0400
Received: (qmail 2837 invoked by uid 107); 14 Apr 2016 20:43:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 Apr 2016 16:43:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2016 16:43:04 -0400
Content-Disposition: inline
In-Reply-To: <1460227515-28437-12-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291564>

On Sun, Apr 10, 2016 at 12:15:10AM +0530, Karthik Nayak wrote:

> +static void refname_atom_parser(struct used_atom *atom, const char *arg)
> +{
> +	if (!arg)
> +		atom->u.refname.option = R_NORMAL;
> +	else if (!strcmp(arg, "short"))
> +		atom->u.refname.option = R_SHORT;
> +	else if (skip_prefix(arg, "strip=", &arg)) {
> +		atom->u.contents.option = R_STRIP;
> +		if (strtoul_ui(arg, 10, &atom->u.refname.strip) ||
> +			atom->u.refname.strip <= 0)
> +			die(_("positive value expected refname:strip=%s"), arg);

That R_STRIP line should be setting atom->u.refname.option, right?

The same mistake happens in a later patch, too, when parsing for R_BASE
and R_DIR is added. And I think the same problem is also present in
objectname_atom_parser.

The compiler doesn't notice because, hey, it's C, and why bother
complaining when somebody assigns the value from one enum to another?
And the tests don't notice because the enum is at the front of each
union member, so the compiler happens to put it in the same place (I
think it _might_ even be guaranteed by the standard's type-punning
rules, but that's really not something we should rely on).

-Peff
