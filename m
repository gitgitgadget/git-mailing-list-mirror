From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] add a flag to supress errors in git_config_parse_key()
Date: Wed, 18 Feb 2015 14:02:15 -0500
Message-ID: <20150218190215.GD7257@peff.net>
References: <20150206124528.GA18859@inner.h.apk.li>
 <20150206193313.GA4220@peff.net>
 <xmqqbnl6hljt.fsf@gitster.dls.corp.google.com>
 <20150206203902.GB10857@peff.net>
 <54DA5FC1.9010707@gmail.com>
 <20150211002754.GC30561@peff.net>
 <xmqq386cuvxl.fsf@gitster.dls.corp.google.com>
 <54E1A30F.5010303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Krey <a.krey@gmx.de>,
	git@vger.kernel.org
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:02:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YO9t9-0003kX-Eo
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 20:02:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753587AbbBRTCT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 14:02:19 -0500
Received: from cloud.peff.net ([50.56.180.127]:50631 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753418AbbBRTCR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2015 14:02:17 -0500
Received: (qmail 4078 invoked by uid 102); 18 Feb 2015 19:02:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 13:02:17 -0600
Received: (qmail 19823 invoked by uid 107); 18 Feb 2015 19:02:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 18 Feb 2015 14:02:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 18 Feb 2015 14:02:15 -0500
Content-Disposition: inline
In-Reply-To: <54E1A30F.5010303@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264045>

On Mon, Feb 16, 2015 at 01:28:07PM +0530, Tanay Abhra wrote:

> I went through Junio's config guideline patch series
> and the whole thread of underscore bug report and I also think
> that pager.*.command is the right path to go.
> 
> If you want to relax the syntactic requirement (such as add '_' to
> the current set of allowed chacters), I can work upon it but most of the
> comments point that moving towards pager.*.command would be better.

No, as silly as I find the "_" restriction, it is not worth doing. One,
it would not cover all cases (it is one common case, so it makes the
problem more rare but does not eliminate it). And two, there are other
parsers of git's config format. Technically we do not need to care about
them and they can follow our lead, but we do not need to make things
harder on them than is necessary.

>  	if (last_dot == NULL || last_dot == key) {
> -		error("key does not contain a section: %s", key);
> +		if (!flags)
> +			error("key does not contain a section: %s", key);

The intent of the flag variable is that you would check:

  if (!(flags & CONFIG_ERROR_QUIET))

here. I know that there are no other flags yet, so the two are
equivalent. But when somebody adds a new flag later, you would not want
them to have to tweak each of these sites.

-Peff
