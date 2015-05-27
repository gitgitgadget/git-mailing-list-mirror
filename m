From: Jeff King <peff@peff.net>
Subject: Re: [RFC/WIP PATCH 09/11] transport: get_refs_via_connect exchanges
 capabilities before refs.
Date: Wed, 27 May 2015 03:06:03 -0400
Message-ID: <20150527070603.GH885@peff.net>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
 <1432677675-5118-10-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, pclouds@gmail.com, gitster@pobox.com
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed May 27 09:06:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxVPn-0001Hr-VW
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 09:06:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752582AbbE0HGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 May 2015 03:06:07 -0400
Received: from cloud.peff.net ([50.56.180.127]:36510 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751384AbbE0HGF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 May 2015 03:06:05 -0400
Received: (qmail 514 invoked by uid 102); 27 May 2015 07:06:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 02:06:05 -0500
Received: (qmail 5110 invoked by uid 107); 27 May 2015 07:06:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 27 May 2015 03:06:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 27 May 2015 03:06:03 -0400
Content-Disposition: inline
In-Reply-To: <1432677675-5118-10-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270030>

On Tue, May 26, 2015 at 03:01:13PM -0700, Stefan Beller wrote:

> +	switch (version) {
> +		default: /*
> +			  * Configured a protocol version > 2?
> +			  * Try version 2 as it's the most future proof.
> +			  */
> +			/* fall through */

Same comment here as earlier. If we do a v3, it might not be compatible
with v2. Shouldn't we bail if the user asked for it?

> +		case 2: /* first talk about capabilities, then get the heads */
> +			get_remote_capabilities(data->fd[0], NULL, 0);
> +			request_capabilities(data->fd[1]);
> +			get_remote_heads(data->fd[0], NULL, 0, &refs,
> +					 for_push ? REF_NORMAL : 0,
> +					 &data->extra_have,
> +					 &data->shallow);
> +			break;
> +		case 1: /* configured version 1, fall through */
> +		case 0: /* unconfigured, use first protocol */
> +			get_remote_heads(data->fd[0], NULL, 0, &refs,
> +					 for_push ? REF_NORMAL : 0,
> +					 &data->extra_have,
> +					 &data->shallow);
> +			break;
> +	}

I actually kind of wonder if we should just die("BUG") here on seeing
"0". Is this low level the right place to do the "default to v1"?
Because eventually we're going to want to default to v2, I would think
(after a few years have passed, at least).  It seems like we should be
making that decision centrally when we init the transport options.

-Peff
