From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v7 1/3] tests: Adjust the configuration for Apache 2.2
Date: Mon, 9 May 2016 04:03:16 -0400
Message-ID: <20160509080315.GA14383@sigill.intra.peff.net>
References: <cover.1462342213.git.johannes.schindelin@gmx.de>
 <cover.1462774709.git.johannes.schindelin@gmx.de>
 <4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lars Schneider <larsxschneider@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon May 09 10:03:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1azgAA-0007DE-HI
	for gcvg-git-2@plane.gmane.org; Mon, 09 May 2016 10:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751207AbcEIIDZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 May 2016 04:03:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:36143 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751270AbcEIIDU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 May 2016 04:03:20 -0400
Received: (qmail 22722 invoked by uid 102); 9 May 2016 08:03:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 04:03:19 -0400
Received: (qmail 16965 invoked by uid 107); 9 May 2016 08:03:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 May 2016 04:03:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 May 2016 04:03:16 -0400
Content-Disposition: inline
In-Reply-To: <4a15c4e6c35cfb425da568d87e8b20b984e5325c.1462774709.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293990>

On Mon, May 09, 2016 at 08:18:52AM +0200, Johannes Schindelin wrote:

> +# Apache 2.2 does not understand <RequireAll>, so we use RewriteCond.
> +# And as RewriteCond unfortunately lacks "not equal" matching, we use this
> +# ugly trick to fail *unless* the two headers are present.
> +RewriteCond %{HTTP:x-magic-one} =abra
> +RewriteCond %{HTTP:x-magic-two} =cadabra
> +RewriteRule ^/smart_headers/.* - [L]
> +RewriteRule ^/smart_headers/.* - [F]
> +

Thanks, this is the magic that eluded me earlier. I had to look up the
flags, so for any observers in the same boat, this works because:

  - the '[L]' flag says "stop doing any more rewrite rules"; it triggers
    only when the RewriteConds above match

  - the '[F]' flag says "return 403 Forbidden"; it triggers always,
    because after a RewriteRule, all RewriteConds are reset

I'm sure that is all apparent to somebody who is familiar with Apache
config, but I think that does not include most people on this project. I
dunno if it is worth a comment here or in the commit message.

-Peff
